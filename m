Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8065ECC
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 57A9373146
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 18B9573150
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] inet: Add '__connman_inet_rtnl_recv'.
Date: Thu, 14 Dec 2023 09:27:11 -0800
Message-ID: <20231214172712.2083929-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214172712.2083929-1-gerickson@nuovations.com>
References: <20231214172712.2083929-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the private, file-scope interface 'inet_rtnl_recv' into
a separate semi-public, project-scope interface
'__connman_inet_rtnl_recv'.

Currently, 'inet_rtnl_recv' is intended to be used as a glib runloop
helper in conjunction with '__connman_inet_rtnl_talk' for longer or
multi-phase Routing Netlink (rtnl) interactions.

However, for short, concise open/send/recv/close Routing Netlink
(rtnl) interactions in which there is a single request/response phase
or the complexity of an asynchronous run loop interaction is not
needed, there is not an appropriate 'recv' interface to peer with
open/send/close.

With this change, the core of 'inet_rtnl_recv' is factored out into
that missing 'recv' interface, '__connman_inet_rtnl_recv' with
'inet_rtnl_recv' invoking it.
---
 src/connman.h |  3 ++-
 src/inet.c    | 53 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index d179374e2247..24e667d8e1f4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -244,7 +244,8 @@ int __connman_inet_rtnl_send(struct __connman_inet_rtnl_handle *rtnl,
 {
 	return __connman_inet_rtnl_talk(rtnl, n, 0, NULL, NULL);
 }
-
+int __connman_inet_rtnl_recv(const struct __connman_inet_rtnl_handle *rtnl,
+			struct nlmsghdr **n);
 void __connman_inet_rtnl_close(struct __connman_inet_rtnl_handle *rth);
 int __connman_inet_rtnl_addattr_l(struct nlmsghdr *n, size_t max_length,
 			int type, const void *data, size_t data_length);
diff --git a/src/inet.c b/src/inet.c
index 779ed7b2b995..5b938cbade13 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -2574,33 +2574,34 @@ static gboolean inet_rtnl_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 
-static int inet_rtnl_recv(GIOChannel *chan, struct inet_rtnl_cb_data *rtnl_data)
+int __connman_inet_rtnl_recv(const struct __connman_inet_rtnl_handle *rtnl,
+	struct nlmsghdr **n)
 {
-	struct __connman_inet_rtnl_handle *rth = rtnl_data->rtnl;
 	struct nlmsghdr *h = NULL;
 	struct sockaddr_nl nladdr;
 	socklen_t addr_len = sizeof(nladdr);
 	unsigned char buf[4096];
 	void *ptr = buf;
 	gsize len;
-	int status, fd;
+	int status;
+
+	if (!rtnl)
+		return -EINVAL;
 
 	memset(buf, 0, sizeof(buf));
 	memset(&nladdr, 0, sizeof(nladdr));
 
-	fd = g_io_channel_unix_get_fd(chan);
-
-	status = recvfrom(fd, buf, sizeof(buf), 0,
+	status = recvfrom(rtnl->fd, buf, sizeof(buf), 0,
                        (struct sockaddr *) &nladdr, &addr_len);
 	if (status < 0) {
 		if (errno == EINTR || errno == EAGAIN)
 			return 0;
 
-		return -1;
+		return -errno;
 	}
 
 	if (status == 0)
-		return -1;
+		return -ECONNRESET;
 
 	if (nladdr.nl_pid != 0) { /* not sent by kernel, ignore */
 		DBG("Received msg from %u, ignoring it", nladdr.nl_pid);
@@ -2615,11 +2616,11 @@ static int inet_rtnl_recv(GIOChannel *chan, struct inet_rtnl_cb_data *rtnl_data)
 		h = ptr;
 
 		if (!NLMSG_OK(h, len))
-			return -1;
+			return -EBADMSG;
 
-		if (h->nlmsg_seq != rth->seq) {
+		if (h->nlmsg_seq != rtnl->seq) {
 			/* Skip this msg */
-			DBG("skip %d/%d len %d", rth->seq,
+			DBG("skip %d/%d len %d", rtnl->seq,
 				h->nlmsg_seq, h->nlmsg_len);
 
 			len -= h->nlmsg_len;
@@ -2630,18 +2631,42 @@ static int inet_rtnl_recv(GIOChannel *chan, struct inet_rtnl_cb_data *rtnl_data)
 		switch (h->nlmsg_type) {
 		case NLMSG_NOOP:
 		case NLMSG_OVERRUN:
-			return -1;
+			return -EBADMSG;
 
 		case NLMSG_ERROR:
 			err = (struct nlmsgerr *)NLMSG_DATA(h);
-			connman_error("RTNETLINK answers %s (%d)",
-				strerror(-err->error), -err->error);
+			if (err->error != 0)
+				DBG("RTNETLINK answers %s (%d)",
+					strerror(-err->error), -err->error);
 			return err->error;
 		}
 
 		break;
 	}
 
+	if (h && n)
+		*n = h;
+
+	return 0;
+}
+
+static int inet_rtnl_recv(GIOChannel *chan, struct inet_rtnl_cb_data *rtnl_data)
+{
+	struct __connman_inet_rtnl_handle *rth = rtnl_data->rtnl;
+	struct nlmsghdr *h = NULL;
+	int status;
+
+	/*
+	 * Both the chan and rth contain the socket descriptor and should
+	 * be identical. __connman_inet_rtnl_recv uses rth; consequently,
+	 * chan goes unused here.
+	 */
+	(void)chan;
+
+	status = __connman_inet_rtnl_recv(rth, &h);
+	if (status < 0)
+		return status;
+
 	if (h->nlmsg_seq == rth->seq) {
 		DBG("received %d seq %d", h->nlmsg_len, h->nlmsg_seq);
 
-- 
2.42.0


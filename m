Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57C2FB3
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 07:49:48 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 6E74250068A;
	Tue, 22 Jun 2021 09:49:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 1402C50065D;
	Tue, 22 Jun 2021 09:49:40 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 2/2] vpn-rtnl: Fix netlink message alignment
Date: Tue, 22 Jun 2021 09:49:33 +0200
Message-Id: <20210622074933.5406-3-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622074933.5406-1-wagi@monom.org>
References: <20210622074933.5406-1-wagi@monom.org>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent versions of gcc complain with outside of bounds access.

Between the netlink header and the message there is padding. Refactor
the code and open code the message generation.
---
 vpn/vpn-rtnl.c | 125 ++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 63 deletions(-)

diff --git a/vpn/vpn-rtnl.c b/vpn/vpn-rtnl.c
index 295c05ce5363..5a02d779a0ab 100644
--- a/vpn/vpn-rtnl.c
+++ b/vpn/vpn-rtnl.c
@@ -797,75 +797,71 @@ static const char *type2string(uint16_t type)
 
 static GIOChannel *channel = NULL;
 
-struct rtnl_request {
-	struct nlmsghdr hdr;
-	struct rtgenmsg msg;
-};
-#define RTNL_REQUEST_SIZE  (sizeof(struct nlmsghdr) + sizeof(struct rtgenmsg))
+#define RTNL_REQUEST_SIZE (NLMSG_HDRLEN + NLMSG_ALIGN(sizeof(struct rtgenmsg)))
 
 static GSList *request_list = NULL;
 static guint32 request_seq = 0;
 
-static struct rtnl_request *find_request(guint32 seq)
+static struct nlmsghdr *find_request(guint32 seq)
 {
 	GSList *list;
 
 	for (list = request_list; list; list = list->next) {
-		struct rtnl_request *req = list->data;
+		struct nlmsghdr *hdr = list->data;
 
-		if (req->hdr.nlmsg_seq == seq)
-			return req;
+		if (hdr->nlmsg_seq == seq)
+			return hdr;
 	}
 
 	return NULL;
 }
 
-static int send_request(struct rtnl_request *req)
+static int send_request(struct nlmsghdr *hdr)
 {
 	struct sockaddr_nl addr;
 	int sk;
 
 	debug("%s len %d type %d flags 0x%04x seq %d",
-				type2string(req->hdr.nlmsg_type),
-				req->hdr.nlmsg_len, req->hdr.nlmsg_type,
-				req->hdr.nlmsg_flags, req->hdr.nlmsg_seq);
+				type2string(hdr->nlmsg_type),
+				hdr->nlmsg_len, hdr->nlmsg_type,
+				hdr->nlmsg_flags, hdr->nlmsg_seq);
 
 	sk = g_io_channel_unix_get_fd(channel);
 
 	memset(&addr, 0, sizeof(addr));
 	addr.nl_family = AF_NETLINK;
 
-	return sendto(sk, req, req->hdr.nlmsg_len, 0,
+	return sendto(sk, hdr, hdr->nlmsg_len, 0,
 				(struct sockaddr *) &addr, sizeof(addr));
 }
 
-static int queue_request(struct rtnl_request *req)
+static int queue_request(struct nlmsghdr *hdr)
 {
-	request_list = g_slist_append(request_list, req);
+	request_list = g_slist_append(request_list, hdr);
 
 	if (g_slist_length(request_list) > 1)
 		return 0;
 
-	return send_request(req);
+	return send_request(hdr);
 }
 
 static int process_response(guint32 seq)
 {
-	struct rtnl_request *req;
+	struct nlmsghdr *hdr;
 
 	debug("seq %d", seq);
 
-	req = find_request(seq);
-	if (req) {
-		request_list = g_slist_remove(request_list, req);
-		g_free(req);
+	hdr = find_request(seq);
+	if (hdr) {
+		request_list = g_slist_remove(request_list, hdr);
+		g_free(hdr);
 	}
 
-	req = g_slist_nth_data(request_list, 0);
-	if (!req)
+	hdr = g_slist_nth_data(request_list, 0);
+	if (!hdr)
 		return 0;
 
-	return send_request(req);
+	return send_request(hdr);
 }
 
 static void rtnl_message(void *buf, size_t len)
@@ -960,62 +956,65 @@ static gboolean netlink_event(GIOChannel *chan, GIOCondition cond, gpointer data
 
 static int send_getlink(void)
 {
-	struct rtnl_request *req;
+	struct nlmsghdr *hdr;
+	struct rtgenmsg *msg;
 
 	debug("");
 
-	req = g_try_malloc0(RTNL_REQUEST_SIZE);
-	if (!req)
-		return -ENOMEM;
+	hdr = g_malloc0(RTNL_REQUEST_SIZE);
+
+	hdr->nlmsg_len = RTNL_REQUEST_SIZE;
+	hdr->nlmsg_type = RTM_GETLINK;
+	hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	hdr->nlmsg_pid = 0;
+	hdr->nlmsg_seq = request_seq++;
 
-	req->hdr.nlmsg_len = RTNL_REQUEST_SIZE;
-	req->hdr.nlmsg_type = RTM_GETLINK;
-	req->hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	req->hdr.nlmsg_pid = 0;
-	req->hdr.nlmsg_seq = request_seq++;
-	req->msg.rtgen_family = AF_INET;
+	msg = (struct rtgenmsg *) NLMSG_DATA(hdr);
+	msg->rtgen_family = AF_INET;
 
-	return queue_request(req);
+	return queue_request(hdr);
 }
 
 static int send_getaddr(void)
 {
-	struct rtnl_request *req;
+	struct nlmsghdr *hdr;
+	struct rtgenmsg *msg;
 
 	debug("");
 
-	req = g_try_malloc0(RTNL_REQUEST_SIZE);
-	if (!req)
-		return -ENOMEM;
+	hdr = g_malloc0(RTNL_REQUEST_SIZE);
 
-	req->hdr.nlmsg_len = RTNL_REQUEST_SIZE;
-	req->hdr.nlmsg_type = RTM_GETADDR;
-	req->hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	req->hdr.nlmsg_pid = 0;
-	req->hdr.nlmsg_seq = request_seq++;
-	req->msg.rtgen_family = AF_INET;
+	hdr->nlmsg_len = RTNL_REQUEST_SIZE;
+	hdr->nlmsg_type = RTM_GETADDR;
+	hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	hdr->nlmsg_pid = 0;
+	hdr->nlmsg_seq = request_seq++;
 
-	return queue_request(req);
+	msg = (struct rtgenmsg *) NLMSG_DATA(hdr);
+	msg->rtgen_family = AF_INET;
+
+	return queue_request(hdr);
 }
 
 static int send_getroute(void)
 {
-	struct rtnl_request *req;
+	struct nlmsghdr *hdr;
+	struct rtgenmsg *msg;
 
 	debug("");
 
-	req = g_try_malloc0(RTNL_REQUEST_SIZE);
-	if (!req)
-		return -ENOMEM;
+	hdr = g_malloc0(RTNL_REQUEST_SIZE);
+
+	hdr->nlmsg_len = RTNL_REQUEST_SIZE;
+	hdr->nlmsg_type = RTM_GETROUTE;
+	hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	hdr->nlmsg_pid = 0;
+	hdr->nlmsg_seq = request_seq++;
 
-	req->hdr.nlmsg_len = RTNL_REQUEST_SIZE;
-	req->hdr.nlmsg_type = RTM_GETROUTE;
-	req->hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	req->hdr.nlmsg_pid = 0;
-	req->hdr.nlmsg_seq = request_seq++;
-	req->msg.rtgen_family = AF_INET;
+	msg = (struct rtgenmsg *) NLMSG_DATA(hdr);
+	msg->rtgen_family = AF_INET;
 
-	return queue_request(req);
+	return queue_request(hdr);
 }
 
 static gboolean update_timeout_cb(gpointer user_data)
@@ -1158,14 +1157,14 @@ void __vpn_rtnl_cleanup(void)
 	update_list = NULL;
 
 	for (list = request_list; list; list = list->next) {
-		struct rtnl_request *req = list->data;
+		struct nlmsghdr *hdr = list->data;
 
 		debug("%s len %d type %d flags 0x%04x seq %d",
-				type2string(req->hdr.nlmsg_type),
-				req->hdr.nlmsg_len, req->hdr.nlmsg_type,
-				req->hdr.nlmsg_flags, req->hdr.nlmsg_seq);
+				type2string(hdr->nlmsg_type),
+				hdr->nlmsg_len, hdr->nlmsg_type,
+				hdr->nlmsg_flags, hdr->nlmsg_seq);
 
-		g_free(req);
+		g_free(hdr);
 		list->data = NULL;
 	}
 
-- 
2.32.0

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457555;
	b=34hARxG9SajHXv9Ut7Dc5UNNh6NB1qPFDRE20FIRwes5Y5AJ8n8b9L7xJbg5QwRYpBhq
	 njDGeFZy6jp1zK1UKh5CGcYNdrBBGOntU5peh7uoyjybBem1WK5qABkVuAeEkXZkeHdvb
	 EHcoGhzq5mA5zMO9sNDfII8aO9tyy1qp8BZnUvA5BjOJuyKj8U6sLfQzMNCawnwjlYRfP
	 J1l6ZpAEgw0UEAgMfVoW2wJsQgrAlFC/ezEs764FvmMw7Qo3DlqFHuBoqGstXzV8pQxhB
	 C976/eax3AZ65UdiFBdaNQAxRvq8TilXSBF1YNctIGkAUIMIHZsJriUXU9eJoTKO2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457555;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=qw7r50j67qZQJ7Cg1oGbezBj9pqqYts8VVfbbpqX9S4=;
	b=QrEbeJ0oUJps6nA++qoaUUGekoRvlRWyuGLC0LL49tq+j7y1YpulKcQvqMS7oI9QnGOH
	 3YDWX3GuYTkOfq4z99b5eQ/cF1qFqRp7SEUA5xm61DHIWud18I9oI7WsRkJjzCkA2bBez
	 q45NEFpuLQqOzwXGPYj6lLJaQxrABpqYAgT9YuNEYJUBIxfNzNaIWkVfXiwO+79j++P07
	 KGwIhdMtg+lgVKJuZnrxJm9XSRMMFjhQUL5yIdbHzfk5Z/F2zpq2tdnPEk5JeiHhhOklr
	 I0ssSdYWxV86ncUBy+aY1TRcvIaETGNitTqCQyTDmVw9kVp1qAn5tY1C6pvdl4fADbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=kHyrTSVS;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2598606A321
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2598606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=kHyrTSVS
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 64B9016028F;
	Wed, 11 Nov 2026 23:25:53 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EFAD1124BF7;
	Wed, 11 Nov 2026 23:25:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 1/5] gweb: Report transport creation errors accurately
Date: Wed, 11 Nov 2026 20:25:47 -0800
Message-ID: <20261112042551.1613107-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112042551.1613107-1-gerickson@nuovations.com>
References: <20261112042551.1613107-1-gerickson@nuovations.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=qw7r50j67qZQJ7Cg1oGbezBj9pqqYts8VVfbbpqX9S4=; b=kHyrTSVScqSoR/sMBNw79u92sCRv2u+QWjaL67C4xqFPl29Zda23XejXMcN8XNRyvx9e6it+h5CTMJBQUBqm2XlGSdC6udHkGkBPh2htf8jpR+51/zSYfh1H+EK8JDOkuEvvj83euRkEl6tjFPJ3Qfu3K8eLTJNK6YOcvGxlNlVvKgyk6qTeisImQwIJai6xRPC0fjkjOQKcjReuIVWhgjZigwXUbAEoUJFS6bnoYMePiML7VG1Pn61enievErqFyyXDuQGAqVVMa8tsMLPAmL8+VOSkae04K+NDz8FZSQWyztaUZjhKBa+k2meRbRhXZSTTsc/HA8MgH76hpxgS9w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When the transport for a web session cannot be created,
handle_resolved_address passes the negated POSIX error returned by
create_transport directly to g_io_error_from_errno and g_strerror.
Both expect a positive error, so every such failure was reported as
G_IO_ERROR_FAILED with a message of "Unknown error -5".

In addition, connect_session_transport collapsed every socket(),
bind and connect() failure into -EIO, discarding the actual error. A
connect() that fails immediately because, for example, there is no
route to the peer (ENETUNREACH) or a policy rule prohibits it
(EACCES) was indistinguishable from any other failure.

Return the negated errno from each of those failure points and negate
it again before passing it to g_io_error_from_errno and g_strerror,
so that a failed online check is reported with, for example,
"Network is unreachable" rather than "Unknown error -5".
---
 gweb/gweb.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0a87da648a9c..e3a2d2eecb7e 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1587,12 +1587,15 @@ static inline int bind_socket(int sk, int index, int family)
  *                                      network stack.
  *
  *  @retval  0        If successful.
- *  @retval  -EIO     If a socket could not be created for the specified
- *                    session address family, the socket could not be
- *                    bound to the specified session network
- *                    interface, or the socket could not connect to
- *                    the specified session peer address.
  *  @retval  -ENOMEM  If a GLib transport channel could not be created.
+ *  @retval  -errno   The negated POSIX error from socket(), from
+ *                    binding the socket to the specified session
+ *                    network interface, or from connect(), if a
+ *                    socket could not be created for the specified
+ *                    session address family, could not be bound to
+ *                    the specified session network interface, or
+ *                    could not start connecting to the specified
+ *                    session peer address, respectively.
  *
  *  @sa close_session_transport
  *
@@ -1602,18 +1605,23 @@ static int connect_session_transport(struct web_session *session,
 {
 	GIOFlags flags;
 	int sk;
+	int err;
 
 	sk = socket(session->addr->ai_family, SOCK_STREAM | SOCK_CLOEXEC,
 			IPPROTO_TCP);
-	if (sk < 0)
-		return -EIO;
+	if (sk < 0) {
+		err = -errno;
+		debug(session->web, "socket() %s", strerror(-err));
+		return err;
+	}
 
 	if (session->web->index > 0) {
 		if (bind_socket(sk, session->web->index,
 					session->addr->ai_family) < 0) {
-			debug(session->web, "bind() %s", strerror(errno));
+			err = -errno;
+			debug(session->web, "bind() %s", strerror(-err));
 			close(sk);
-			return -EIO;
+			return err;
 		}
 	}
 
@@ -1643,8 +1651,9 @@ static int connect_session_transport(struct web_session *session,
 	if (connect(sk, session->addr->ai_addr,
 			session->addr->ai_addrlen) < 0) {
 		if (errno != EINPROGRESS) {
-			debug(session->web, "connect() %s", strerror(errno));
-			return -EIO;
+			err = -errno;
+			debug(session->web, "connect() %s", strerror(-err));
+			return err;
 		}
 	}
 
@@ -2530,11 +2539,15 @@ static void handle_resolved_address(struct web_session *session)
 
 	call_route_func(session);
 
+	/*
+	 * create_transport returns a negated POSIX error; both
+	 * g_io_error_from_errno and g_strerror require a positive one.
+	 */
 	ret = create_transport(session);
 	if (ret < 0) {
 		local_error = g_error_new_literal(G_IO_ERROR,
-						g_io_error_from_errno(ret),
-						g_strerror(ret));
+						g_io_error_from_errno(-ret),
+						g_strerror(-ret));
 
 		call_result_func_failure(session, local_error);
 	}
-- 
2.52.0


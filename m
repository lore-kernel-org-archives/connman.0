Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B817C7C
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984476; cv=none; b=W4YIQNnpQYaV2lMuRwKpWvWjJK3HfEwaGQqe2Ivz4ok5o+cxb4yt8KhhAuapdi3IJQqJTK3k3WZetejJINroenbO3nlrcvDg/I/L56me3Cl1Q/sWprx62/FDYgi8ipquFwCLYuhwazO2K/kVz4fieaJoa7hen1qZCMkxLRCdAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984476; c=relaxed/simple;
	bh=3yvuyhKeVbTDTnFJiogZW6VfexDpsUP3CPEm3QJX6x0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YVIweJc4ipzNJMUhkwTUo6HmP0uNQmig6z300kjaYT6Lerslhbj3g1D7UwymxaUf3o3NxICfJQ2vzekIjsG08vyn50aJtsmuxW1fN4lNDpVl84SbxWMYqK11TrQuK4HnAVIA7+kKUHQRWEFGtG0tbkHfPkeQB/1r48ui90cTBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c58UjCQ0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c58UjCQ0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso241021b3a.2
        for <connman@lists.linux.dev>; Wed, 24 Apr 2024 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984474; x=1714589274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhqzRNgsYzCKD5cwMmDdUf08Kg08jBcbe/9PPsozLRc=;
        b=c58UjCQ06zdoFWFNMyuf3ZnkvFQbeLZG6vau2OK2coiKbqNjiBDDy4vP0lLuTj9ePy
         V6+1JwrxwrZoepO8f0mV8gPYw/e6gaSfjYqnAGy2zAn6rkG1Ajk7/TARAsoPBhVPrJFk
         JkFpboUMnK0DQZJB42OzrLYdvei6fjs6pz0/hqzbY9A6katAga7NGVMUlIRQ0YEIhdre
         jKGfiN7hczSVom8AWyT6d63lqwJyShwjL9KyhE8iJNpQWdV+YvjCm3IHlaziZVuZIFKY
         O96csUd1JXP0d5VrIaHFIZBFb23Wnjt9ZfneWzjlmJl+Gr81+hDhdK1Hg55UOebmPiRk
         fssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984474; x=1714589274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhqzRNgsYzCKD5cwMmDdUf08Kg08jBcbe/9PPsozLRc=;
        b=mwum49npshe/zB8s0Mj4EKHNfPdOumRjlEV5Bpix4iqXd5R2cUHrFFyR8QR6lONy6z
         5op8cS/u3faKFHbQHqh/Q5jpsJHKjWV5KJWfmQ9uAbIVr3igoEx8b9WY62xs+GcjUQ1h
         bCBuHvfIZksDlL0n4KuN/j5by3oBPEwS2fKKZKYKsqtWBpXVLhWt7WislzjjrmRAjk3i
         DPNqr+wv4cw/yBuwas8pbnNoZZTyXJw8qTwPFqStYvhpu+WgpEcDD41Rktwga7Lq1xyl
         7VZqrLKZscmHHfhmUgqrxIJT8pVxPcdmZh4rnl+SpkA6q+lPofUIlVnEj3n7ZZOSYMJa
         grTg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+woHTMvfLAyi7OIFJUZH7PQGd61MlipW5ofzbS00bJ+7uHHxcZP3YfDkePpXddGTeFkC5sBoJ1g+f1JjmdOAyPxlsonrTQ==
X-Gm-Message-State: AOJu0Yz9m8vs7KaRhHk9Ew5W23boXCMgs0LQNrv9Vc1PElCvcU5pKVUa
	sKUJd/2uAKL2yy6LRjTOolsPKPXyToAx0Hth6Gn283c1QrYrLCf6
X-Google-Smtp-Source: AGHT+IEHUHhg+/xDD+FU17K9q4A3SFKLLihDUE368MfMVoihL5jILQbkcF6qZwZGLu5Ph9yESVVgEg==
X-Received: by 2002:a05:6a00:3a07:b0:6ec:db05:36d2 with SMTP id fj7-20020a056a003a0700b006ecdb0536d2mr4682425pfb.4.1713984474357;
        Wed, 24 Apr 2024 11:47:54 -0700 (PDT)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id l1-20020a63da41000000b005f0bc6d04adsm11565680pgj.46.2024.04.24.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:47:54 -0700 (PDT)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH] dnsproxy: fix coverity issues
Date: Wed, 24 Apr 2024 11:47:51 -0700
Message-Id: <20240424184751.130804-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a handful of coverity issues found in dnsproxy.c.
---
 src/dnsproxy.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index a32755d5..4564d137 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -623,8 +623,11 @@ static gboolean request_timeout(gpointer user_data)
 		 * "not found" result), so send that back to client instead
 		 * of more fatal server failed error.
 		 */
-		sendto(sk, req->resp, req->resplen, MSG_NOSIGNAL,
-			sa, req->sa_len);
+		if (sendto(sk, req->resp, req->resplen, MSG_NOSIGNAL,
+			sa, req->sa_len) < 0) {
+				connman_error("Failed to send response %d: %s",
+					sk, strerror(errno));
+			}
 
 	} else if (req->request) {
 		/*
@@ -1876,7 +1879,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		} else if (dns_type == DNS_TYPE_A || dns_type == DNS_TYPE_AAAA) {
 			dlen = uptr[-2] << 8 | uptr[-1];
 
-			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
+			if (dlen > (end - ptr) || dlen > (uncomp_end - uptr)) {
 				debug("data len %d too long", dlen);
 				return NULL;
 			}
@@ -3463,7 +3466,7 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 	}
 
 	len = recvfrom(client_sk, client->buf + client->buf_end,
-			TCP_MAX_BUF_LEN - client->buf_end, 0,
+			TCP_MAX_BUF_LEN - client->buf_end - 1, 0,
 			client_addr, client_addr_len);
 	if (len < 0) {
 		if (errno == EAGAIN || errno == EWOULDBLOCK)
@@ -3476,6 +3479,8 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 		return FALSE;
 	}
 
+	client->buf[client->buf_end + len] = '\0';
+
 	return read_tcp_data(client, client_addr, *client_addr_len, len);
 }
 
@@ -3662,7 +3667,7 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 				struct listener_data *ifdata, int family,
 				guint *listener_watch)
 {
-	unsigned char buf[768];
+	unsigned char buf[769];
 	char query[512];
 	struct request_data *req = NULL;
 	struct domain_hdr *hdr = NULL;
@@ -3691,10 +3696,12 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 
 	memset(client_addr, 0, *client_addr_len);
 	sk = g_io_channel_unix_get_fd(channel);
-	len = recvfrom(sk, buf, sizeof(buf), 0, client_addr, client_addr_len);
+	len = recvfrom(sk, buf, sizeof(buf) - 1, 0, client_addr, client_addr_len);
 	if (len < 2)
 		return true;
 
+	buf[len] = '\0';
+
 	debug("Received %d bytes (id 0x%04x)", len, buf[0] | buf[1] << 8);
 
 	err = parse_request(buf, len, query, sizeof(query));
@@ -3847,7 +3854,12 @@ static GIOChannel *get_listener(int family, int protocol, int index)
 			return NULL;
 		}
 
-		fcntl(sk, F_SETFL, O_NONBLOCK);
+		if (fcntl(sk, F_SETFL, O_NONBLOCK) < 0) {
+			connman_error("Failed to set TCP listener socket to non-blocking %d/%s",
+				-errno, strerror(errno));
+			close(sk);
+			return NULL;
+		}
 	}
 
 	channel = g_io_channel_unix_new(sk);
-- 
2.34.1


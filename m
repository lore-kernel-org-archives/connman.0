Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421992CAB
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06C805D1A3;
	Tue, 25 Jan 2022 10:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101231; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lt3AOzUtaYOv7p9+m+Gy/CgibBOyPOfgs/jSVbMWUB8=;
	b=fp2yO5ckGy3gsxY/VGItOPmNvnVh8Nl5gZysEAZfXjais1R2cOuS4fsIxiOr8htpNoVQzk
	1casRrJwztlyutu+LLEGchXv8LWEvI93u9btFQ+5PtIyv5dECx3KobB4FW5655cIlXmlro
	1Hk9DARU9sS0toXeGay6sT9FDvMLjBh7dUbOsPLg0zIOvEAcojC3Z4cMhUChUAclSr3mXc
	MXc/RakNmr1mwz3fSOhtrWG0cQAORFfGm2cJoySb6YAUvpKNlbJmfe5g0SQeY/5gIbxTDb
	RH+HyxVouRQjWNCjpAxREna+1q2kRKxZagJfAu4rMGSGnsD7gzNiXLJQb5AP4g==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 3/5] dnsproxy: Validate input data before using them
Date: Tue, 25 Jan 2022 10:00:24 +0100
Message-Id: <20220125090026.5108-4-wagi@monom.org>
In-Reply-To: <20220125090026.5108-1-wagi@monom.org>
References: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

dnsproxy is not validating various input data. Add a bunch of checks.

Fixes: CVE-2022-23097
Fixes: CVE-2022-23096
---
 src/dnsproxy.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index cdfafbc292f2..c027bcb972c4 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1951,6 +1951,12 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 
 	if (offset < 0)
 		return offset;
+	if (reply_len < 0)
+		return -EINVAL;
+	if (reply_len < offset + 1)
+		return -EINVAL;
+	if ((size_t)reply_len < sizeof(struct domain_hdr))
+		return -EINVAL;
 
 	hdr = (void *)(reply + offset);
 	dns_id = reply[offset] | reply[offset + 1] << 8;
@@ -1986,23 +1992,31 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 		 */
 		if (req->append_domain && ntohs(hdr->qdcount) == 1) {
 			uint16_t domain_len = 0;
-			uint16_t header_len;
+			uint16_t header_len, payload_len;
 			uint16_t dns_type, dns_class;
 			uint8_t host_len, dns_type_pos;
 			char uncompressed[NS_MAXDNAME], *uptr;
 			char *ptr, *eom = (char *)reply + reply_len;
+			char *domain;
 
 			/*
 			 * ptr points to the first char of the hostname.
 			 * ->hostname.domain.net
 			 */
 			header_len = offset + sizeof(struct domain_hdr);
+			if (reply_len < header_len)
+				return -EINVAL;
+			payload_len = reply_len - header_len;
+
 			ptr = (char *)reply + header_len;
 
 			host_len = *ptr;
+			domain = ptr + 1 + host_len;
+			if (domain > eom)
+				return -EINVAL;
+
 			if (host_len > 0)
-				domain_len = strnlen(ptr + 1 + host_len,
-						reply_len - header_len);
+				domain_len = strnlen(domain, eom - domain);
 
 			/*
 			 * If the query type is anything other than A or AAAA,
@@ -2011,6 +2025,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 			 */
 			dns_type_pos = host_len + 1 + domain_len + 1;
 
+			if (ptr + (dns_type_pos + 3) > eom)
+				return -EINVAL;
 			dns_type = ptr[dns_type_pos] << 8 |
 							ptr[dns_type_pos + 1];
 			dns_class = ptr[dns_type_pos + 2] << 8 |
@@ -2040,6 +2056,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				int new_len, fixed_len;
 				char *answers;
 
+				if (len > payload_len)
+					return -EINVAL;
 				/*
 				 * First copy host (without domain name) into
 				 * tmp buffer.
@@ -2054,6 +2072,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				 * Copy type and class fields of the question.
 				 */
 				ptr += len + domain_len + 1;
+				if (ptr + NS_QFIXEDSZ > eom)
+					return -EINVAL;
 				memcpy(uptr, ptr, NS_QFIXEDSZ);
 
 				/*
@@ -2063,6 +2083,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				uptr += NS_QFIXEDSZ;
 				answers = uptr;
 				fixed_len = answers - uncompressed;
+				if (ptr + offset > eom)
+					return -EINVAL;
 
 				/*
 				 * We then uncompress the result to buffer
@@ -2257,8 +2279,7 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 
 	len = recv(sk, buf, sizeof(buf), 0);
 
-	if (len >= 12)
-		forward_dns_reply(buf, len, IPPROTO_UDP, data);
+	forward_dns_reply(buf, len, IPPROTO_UDP, data);
 
 	return TRUE;
 }
-- 
2.34.1


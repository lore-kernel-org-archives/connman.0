Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.232.154.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480739;
	b=FjixT2hKODzskYpHNAWJJi5gjXnwxf4JTCoMmkCE721LSHSwsxpyIU1SmqdMyofiU63v
	 4n7K+l4IYsOa4mNV2A1dP/fFLMSe4+3AxFxnk/40dF3NLfX1t9VAp0POlaYQTlNFlJw/b
	 utdnVC6xn3WTVLxzTY1UQfUG9KtVNrs1zjDYSai/NJmZbDp1C4KSjdMtunJeMa7N6xWSm
	 HDLKj/zKxdhsRBSwDOArScsbI6Qn3LvSUtgkAZLatZ74TxnE089CsgcncPfMPgSxUdbYV
	 hkY39GeIiDr3VVa9FXHkEcCiOW7esxkQbNgpvz8QXKjyG9HvjoI1EhJxF65jGBxlxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480739;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Rspam-Score:
	 X-Rspam-Report;
	bh=qL5sdEK8BCI3eHVYl+Pm491w9hWYPWW79F/empgTZtg=;
	b=Q0JXu9aNIAQ7OGJr0erFB2wDqmh6si6kUNvJ0hvOST08pyW5PPY9zCmLuJbzeowPAIYQ
	 C33pl5hs05jeWXSd9Tuuvp2rd1DZ8sk+ouBvbLLK2XkMqBb0z1PmosH/LzioieIr1s6kB
	 v5mPmIkDu75OYm/qh5/8tSniua1F2tZLj8zTDFNcWCXVROF/j0RK7jEWmEf+9mS+6syyH
	 JK0ctnMgO1dl9qMLO4fi82WKRrsNmFWjwiq62bcJ+ddBbTLp2oa35xeMPmNsocmMs14i1
	 KjZwSnXbGAfyrgd9QXKYjGn4nrZcTcZq/hz06QhwjucT0hvv8+CG7ebKM51gnr2bIGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=jolla.com;
	spf=pass smtp.mailfrom=kapsi.fi;
	dkim=pass header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=Oq1u0c9v;
	arc=none smtp.remote-ip=91.232.154.24
Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4C606A88E
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 10:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E4C606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=Oq1u0c9v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qL5sdEK8BCI3eHVYl+Pm491w9hWYPWW79F/empgTZtg=; b=Oq1u0c9vfS3dzpiJaR1ZpE0p+T
	ysauYMFYiS0fXSphQ5/Prn1pkVH7a9U+8Z1Yffwm9sS1GeUkJAmWboPjtIY7g2rOZGcdM9JAp8ajZ
	l/gHWO/XGOEnsHuQr3Y3IzTfFlnQCPzAi9wFRq2pzmILLaQphBy/tsaME1YV4lLNED0TGja5cPZPz
	e+3zQP5Nyfk3HIxkZngPs6aALoVg5q6ULB7x6tKrPpwK0tty6ggI4EsWTTo/OYVummtLL+TXwAAna
	0DCsNrJFBXsUAiaNa+avZFLMi3qzCvymE8Y7iUXPFr19gD67X6amZfiB454on0O83BXDb0k/lhMCA
	591DM41A==;
Received: from [2a10:a5c0:37:6500:ca01:7f40:aaa4:8908] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1xRSPW-004CfD-07
	for connman@lists.linux.dev;
	Thu, 12 Nov 2026 12:52:10 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] inet: Use in6_rtmsg instead of rtentry for IPv6 gw interface set/clear
Date: Thu, 12 Nov 2026 12:51:53 +0200
Message-ID: <20261112105159.163730-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
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
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: URIBL_BLOCKED(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: URIBL_BLOCKED(0.00); URIBL.com: query refused, likely due to policy/overusage [jl-x230.local:helo]
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20261112105159.163730-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

For IPv6 it is preferred to use the defined structs when communicating
with kernel. Use the proper in6_rtmsg in both set and clear interface as
it was already used in clear gateway address.

Keep the interface name check but use connman_inet_ifname() to ensure
that the interface is up before trying to set/clear gw route for the
interface.
---
 src/inet.c | 76 +++++++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index 54c283ff..0d459ef9 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -2310,43 +2310,35 @@ out:
 
 int connman_inet_set_ipv6_gateway_interface(int index)
 {
-	struct ifreq ifr;
-	struct rtentry rt;
-	struct sockaddr_in6 addr;
+	struct in6_rtmsg rt = { 0 };
 	const struct in6_addr any = IN6ADDR_ANY_INIT;
+	char *ifname;
 	int sk, err = 0;
 
 	DBG("index %d", index);
 
-	sk = socket(PF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
-	if (sk < 0) {
+	ifname = connman_inet_ifname(index);
+	if (!ifname) {
 		err = -errno;
 		goto out;
 	}
 
-	memset(&ifr, 0, sizeof(ifr));
-	ifr.ifr_ifindex = index;
+	DBG("ifname %s", ifname);
+	g_free(ifname);
 
-	if (ioctl(sk, SIOCGIFNAME, &ifr) < 0) {
+	sk = socket(PF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (sk < 0) {
 		err = -errno;
-		close(sk);
 		goto out;
 	}
 
-	DBG("ifname %s", ifr.ifr_name);
-
-	memset(&rt, 0, sizeof(rt));
-	rt.rt_flags = RTF_UP;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sin6_family = AF_INET6;
-	addr.sin6_addr = any;
-
-	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
-	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
-	memcpy(&rt.rt_gateway, &addr, sizeof(rt.rt_gateway));
-
-	rt.rt_dev = ifr.ifr_name;
+	rt.rtmsg_dst = any;
+	rt.rtmsg_src = any;
+	rt.rtmsg_gateway = any;
+	rt.rtmsg_dst_len = 0;
+	rt.rtmsg_src_len = 0;
+	rt.rtmsg_flags = RTF_UP;
+	rt.rtmsg_ifindex = index;
 
 	if (ioctl(sk, SIOCADDRT, &rt) < 0 && errno != EEXIST)
 		err = -errno;
@@ -2472,43 +2464,35 @@ out:
 
 int connman_inet_clear_ipv6_gateway_interface(int index)
 {
-	struct ifreq ifr;
-	struct rtentry rt;
-	struct sockaddr_in6 addr;
+	struct in6_rtmsg rt = { 0 };
 	const struct in6_addr any = IN6ADDR_ANY_INIT;
+	char *ifname;
 	int sk, err = 0;
 
 	DBG("index %d", index);
 
-	sk = socket(PF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
-	if (sk < 0) {
+	ifname = connman_inet_ifname(index);
+	if (!ifname) {
 		err = -errno;
 		goto out;
 	}
 
-	memset(&ifr, 0, sizeof(ifr));
-	ifr.ifr_ifindex = index;
+	DBG("ifname %s", ifname);
+	g_free(ifname);
 
-	if (ioctl(sk, SIOCGIFNAME, &ifr) < 0) {
+	sk = socket(PF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (sk < 0) {
 		err = -errno;
-		close(sk);
 		goto out;
 	}
 
-	DBG("ifname %s", ifr.ifr_name);
-
-	memset(&rt, 0, sizeof(rt));
-	rt.rt_flags = RTF_UP;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sin6_family = AF_INET6;
-	addr.sin6_addr = any;
-
-	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
-	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
-	memcpy(&rt.rt_gateway, &addr, sizeof(rt.rt_gateway));
-
-	rt.rt_dev = ifr.ifr_name;
+	rt.rtmsg_dst = any;
+	rt.rtmsg_src = any;
+	rt.rtmsg_gateway = any;
+	rt.rtmsg_dst_len = 0;
+	rt.rtmsg_src_len = 0;
+	rt.rtmsg_flags = RTF_UP;
+	rt.rtmsg_ifindex = index;
 
 	if (ioctl(sk, SIOCDELRT, &rt) < 0 && errno != ESRCH)
 		err = -errno;
-- 
2.47.3


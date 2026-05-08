Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED273D6471
	for <connman@lists.linux.dev>; Fri,  8 May 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256398; cv=none; b=cwcj6ZbbD6fqUUZVHdKbVTUluEGZocsZ0MO3rskuXE1Zuy97pBMflqh1c47AhB7oOZylsp8sL40+0x22ByhlTUQjluXZigvQhXIOWbjXIC/zb5JJFBNEqEUm3+Sea8Nb2dy7FIP8hwwsva8ESMdH8NNr7KKdBgM5ON0ZzoHzCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256398; c=relaxed/simple;
	bh=7Ml9tAuu/82Q6cNp0I8um5Xbi8ier7lldqZO/sE4LLY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjsbqhLi0r3JZZbZbHRZ/HtnZXO/DO47SlZ85oEesY+KXMGJW05PiqACcEknFaHSfGWkNadC8e3whZe3h8ufl8T+/eLoRNwui9XyKn1mJJhU9sHkLDDZsUtUyU5+7MJ71dHnOqXGzemeZMPoox2g5lNfJPnRKeqrrx8PK9M+H6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=YkzG+ZDb; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="YkzG+ZDb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pMQkv/J/jJGmWixp2BuuVyY2EKU8AlfUF65oFE1OUhQ=; b=YkzG+ZDb7jOoa6LfaUvCPHBnf+
	TX9LeHfNsOvpAwTq8iKD1aeEUSCYkaIUdB9annmbOaH0a9YR4aTsHe73Eoi0n5I3pQVaR+Rj3dpph
	XIjQJJOo5RZ6jNj/nj3zw5CTOymxMJDiwtRP26UiBdSolagj64bJIkIk/RNsUHI2fJwT6zdF/oLtr
	sWJH2SNgHQ+VXo+47WVc9agIHzFtJM8WO9NRHmIkKETgF+HNEYSsIkDrCKIBvXk1R4Hk2T/E1ADRM
	ab28Dq1lx+OdZFaCgirvQcu3Up8pwKSbdiDXHdU/Dbm9ICSBUb6R2H5yxxOX69IVTPkPYhSbAgQVA
	9nBDZA3A==;
Received: from [2a10:a5c0:37:6500:11f6:3d14:7c4:afac] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLNie-00CcPv-30
	for connman@lists.linux.dev;
	Fri, 08 May 2026 19:06:29 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/5] dns: Use compile time defined DNS for listener
Date: Fri,  8 May 2026 19:05:38 +0300
Message-ID: <20260508160620.214218-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
References: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
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
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260508160620.214218-5-jussi.laakkonen@jolla.com

Drop use of hardcoded DNSs with listener and use ones defined in
compile time to fully work with systemd-resolved.
---
 src/shared/dns.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/shared/dns.c b/src/shared/dns.c
index 930234fc..8f806536 100644
--- a/src/shared/dns.c
+++ b/src/shared/dns.c
@@ -2336,11 +2336,20 @@ static int create_listener(struct dns_listener_data *ifdata,
 
 	index = connman_inet_ifindex("lo");
 	if (ifdata->index == index && !ifdata->lo_exclude) {
+#ifdef SYSTEMD_RESOLVED_DNS_BACKEND
+		if (((err & IPv6_FAILED) != IPv6_FAILED) ||
+					((err & IPv4_FAILED) != IPv4_FAILED))
+			__connman_resolvfile_append(index, NULL,
+								DNS_BACKEND_V4);
+#else
 		if ((err & IPv6_FAILED) != IPv6_FAILED)
-			__connman_resolvfile_append(index, NULL, "::1");
+			__connman_resolvfile_append(index, NULL,
+								DNS_BACKEND_V6);
 
 		if ((err & IPv4_FAILED) != IPv4_FAILED)
-			__connman_resolvfile_append(index, NULL, "127.0.0.1");
+			__connman_resolvfile_append(index, NULL,
+								DNS_BACKEND_V4);
+#endif
 	}
 
 	return 0;
@@ -2351,8 +2360,13 @@ static void destroy_listener(struct dns_listener_data *ifdata)
 	int index = connman_inet_ifindex("lo");
 
 	if (ifdata->index == index && !ifdata->lo_exclude) {
-		__connman_resolvfile_remove(index, NULL, "127.0.0.1");
-		__connman_resolvfile_remove(index, NULL, "::1");
+
+		__connman_resolvfile_remove(index, NULL, DNS_BACKEND_V4);
+
+// With internal DNS this is defined, with systemd-resolved it is not.
+#ifndef SYSTEMD_RESOLVED_DNS_BACKEND
+		__connman_resolvfile_remove(index, NULL, DNS_BACKEND_V6);
+#endif
 	}
 
 	for (GSList *list = request_list; list; list = list->next) {
-- 
2.47.3


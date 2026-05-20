Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D6296BDC
	for <connman@lists.linux.dev>; Wed, 20 May 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288607; cv=none; b=lG/X0xdhNRO0CJ8XU46UsIq9DWff4IHi6xe5qGbT4O7W6EirggbVERrSSjnkY777NP7B7FaF6X5RFiseNx7LYfSBUOAa72sIFZp2193THq9Xuuyr8D/0Efkj5389JmsvYznY9j6DC61dVWap3NVGLmhBdGNzA0immzmK8S/Wgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288607; c=relaxed/simple;
	bh=MqB9lY1K+DlyYo0tm0k3EfjGH8G8YmgVd7Mtft/6bbM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfbo98a61brS0R7zqsbxwX57fC3d6pYRLQswyXHkAX4RRdwmj5EUziFgFr7zNpjVxRR1UcoaMmCyTSHUW+RnUm3XcrtfYV+hzXaDd/7JA4/33zAPO7EHRWq58PdtbcbHbI6XJY/QuCIqHhGPVxr0Bc4j+KQgPaFmSzSAuzx9cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=QqL/fDFi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="QqL/fDFi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bXOfS6uZSXAVZOzyh4jTvsOVCPV8VDvbxRiwMM2bEj8=; b=QqL/fDFitDRJZJ1aCbSWRLtZVJ
	ryfBK98XcYIO04hlGGCanL7qDZYLK0K6+dIVje2iUeKrh0HfHxGqbFHUNA715aHeZjpZHWfwTKRoZ
	YkUIHbXixcYpli0I+LrEEiKqY3bCW525Dsgd0YDkXo/Kfl1M6iKSu9jMq0AiT3OBDbklIYNNy1f/c
	DQoSWxk6PJQX82y+iiPEkWCMEXzpvABQf6YFW54qu+xC0rVvhTlLWsg+B60UTn20X+/vHND5rO+aB
	liR6y3/L1TUuBvo1FZEK0uyM+FhtA2SK4LLABOe7lMrSGW6vgxT1jlFBxIEeV3lZQpP7l50HRlj9p
	fZ/qu3IQ==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGk-002WBi-1U
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:30 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 7/9] wispr: Change online check urls to const char*
Date: Wed, 20 May 2026 16:47:11 +0300
Message-ID: <20260520134720.981315-8-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
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
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.959]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-8-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

The struct connman_wispr_portal_context already has these as const, and
the changed connman_setting_get_string() returns a const char*, so
change these as well.
---
 src/wispr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index a40cf353..77d1e11f 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -142,8 +142,8 @@ static bool wispr_portal_web_result(const GError *error, GWebResult *result, gpo
  */
 static GHashTable *wispr_portal_hash = NULL;
 
-static char *online_check_ipv4_url = NULL;
-static char *online_check_ipv6_url = NULL;
+static const char *online_check_ipv4_url = NULL;
+static const char *online_check_ipv6_url = NULL;
 
 static const struct wispr_portal_context_route_ops
 	ipv4_wispr_portal_context_route_ops = {
-- 
2.47.3


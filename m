Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864238;
	b=ZCe3VWTDnaq3e0wX6WXZsZXKWtkx1+ZinK6nvjxxm7tAj+Ka2WQWzwZS9I3S5RwVIxYO
	 zIDAl2BH8c2JmMiIVdSw54D++gG1qJbKkOEzeZ/w3BMsQxMo49rZKs3geXoZ7/r+9GR9J
	 JYHg1GQXd31LoWvV89RDHjro9qJcirSOjd+Hcw7bgmrP3eDmWIARBpQ/SUfsNfLxCZi0s
	 9RjhNDxAJ44H0Tky+yM0xRkNA8VP4ZNX+GIQOhKo6TL5U7NqsLLC0u6zvf38dUOeFYR7i
	 w7AonfZsE+LWC0R+ITsTE6YEcO7yFAIa337DJulHvrI/MalzGdw1CQQVwsJt7/Okvlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864238;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=1x+4w46vjz7ZgMw8kz7shhX2McMgM0dzT5tMWzcgwp8=;
	b=QkvcXxpPRxpH7M6aeI5u0rmNla/ymkQoMJExVYOgksgNRbMDHFPLRu9NyShbs1pJahAN
	 6xDkiTLuAXLBip92epEYwAV651i1HOWvZQS534OPjg+fXpkIYhhKhn6c3XeioTjWCd7nr
	 1kMCmAlL+y0PeUh18LECh7DY7wXu/8WdEo24bk/6x5JdniCcYyhi5WDpaAetSGdzToKnB
	 CJTSY6qfpPjiQkX/2fudAqJVskQhS2WCGtFWBIP0QSxt0pJ1RUIRDVoKxxYg4QqhsVUES
	 pYWmg2L/jeCFgn57hsBSva+bEnNzbYKuDV039WiUqwF9o22nPjiUcb/Pt2oL+plYqhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=V2kIfMNb;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3271606A31D
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 17:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3271606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=V2kIfMNb
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 14F5F160085;
	Sat, 24 Oct 2026 13:50:37 -0400 (EDT)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 98107124C5F;
	Sat, 24 Oct 2026 13:50:36 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: [PATCH 2/2] technology: Make 'connman_technology_regdom_notify' alias-safe.
Date: Sat, 24 Oct 2026 10:50:33 -0700
Message-ID: <c4da48a5c03be72373c450b36c4bc917c444b288.1792863816.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792863816.git.gerickson@nuovations.com>
References: <cover.1792863816.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=1x+4w46vjz7ZgMw8kz7shhX2McMgM0dzT5tMWzcgwp8=; b=V2kIfMNbv4+XquLVnIMxJ+ANskOLPHwss6SDs18xX/CdGvn6HWa8t/wQVAK5nBC3OdJ4uKAdAqdAlhShmkZQ+T3iw65sqD0V7NU7fZiihxp1BPW8t55rUsHbPWWhAiMSRpz4EA9Ap1xBGSViq20AMuI5tNBx0z0ibc9+rX2LQ7vTrbOmZgQiGWxClYwAHtCTMVvlLJZbfySA60rf+SFs48tT/7tLpAiP6R0Qnscl+wj/HN/mi1X+p+TgLiDPES5C85ZZDNaKcd/ioQdOsQarDKVnlLOKUCwO5Cy3HgznfcQ7Pi/aB+m1kyP3RiVS1jpGTY+TnmY3ZWl9gshnj8WQEA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'connman_technology_regdom_notify' freed 'technology->regdom' and then
duplicated 'alpha2' into it. When 'alpha2' is 'technology->regdom'
itself, the duplication reads the string just freed.

Since fe9307c987a0 ("device: Setup regdom when powering up to maintain
consistency"), that is the argument it received, by way of the
gsupplicant 'Country' set callback, whenever a Wi-Fi device was
powered on again after its technology had stored a regulatory domain.
With gsupplicant now handing its callbacks a copy of its own, that
path no longer aliases, but nothing in the function's contract rules
such a caller out.

Duplicate 'alpha2' before freeing the old value, so that the function
is correct for any 'alpha2', including the technology's own.

Fixes: fe9307c987a0 ("device: Setup regdom when powering up to maintain consistency")
---
 src/technology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/technology.c b/src/technology.c
index 933070f0578a..1fa97949d662 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -289,6 +289,8 @@ static int set_tethering(struct connman_technology *technology,
 void connman_technology_regdom_notify(struct connman_technology *technology,
 							const char *alpha2)
 {
+	char *regdom;
+
 	DBG("");
 
 	if (!alpha2)
@@ -296,8 +298,13 @@ void connman_technology_regdom_notify(struct connman_technology *technology,
 	else
 		DBG("Regulatory domain set to %s", alpha2);
 
+	/*
+	 * alpha2 may be technology->regdom itself, so copy it before
+	 * freeing the old value.
+	 */
+	regdom = g_strdup(alpha2);
 	g_free(technology->regdom);
-	technology->regdom = g_strdup(alpha2);
+	technology->regdom = regdom;
 }
 
 static int set_regdom_by_device(struct connman_technology *technology,
-- 
2.52.0


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9B2E7BD8
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=NHxDO2D1MDXlM/iALFJ1KnkEuqYV8pgT3Dkzc8fQKEBoCX+RHh+JgtQU9MChGMIIDaOpTmA0h6zCfLP/uzAKVyxWMIFu9eGJkaRBbeHEDH/BHIci746bheXKN6UDm8XUnU/SfsYiXS9Df0Wb/Q/+NlBkGx7YTmY1jj53XS+WEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=QMsDpTeoNfmQvinLDpS/QFchKMxlNk0d1lxDyj8YAlQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdBrJLgTW+gEpOOuhLEuuwShfwQ3LAlKm0DSqxce3d38axtsyEP4dXnlIDYJpZadSoNu8s2UCGfgfv0Jy6fkoiBz+29USdDatE0WRS6bvHoQrPZdC9SzcrUKBf+1cz+lUTMx6SfB+KNy46hjDkjgG7SpbEK0y+PgKad5LLHfOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=xtYBvLgi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xtYBvLgi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0SpdjgPz12uWxZ/NXvkmWJ+ck0rF/W4F/b9XVUkMCZg=; b=xtYBvLgiBNTiU+RcMLBPgykYfa
	dkGbDWzPBQZoObYbCKmgNqSJ1JUcqpBe3n2b4OyznBrFc3HACfdMRMQYlx+mV6Xn4fkhB0VS2pzpn
	/VEaQ+8+XjKrd3XHC5vn7ksTF63hoCrMxZ0m6BNqJl39pgWucV5qdyin4/XLTkUe849uHP2fObgD1
	hAKJDLzXC0jcIMg5h9z5ZrylboLErAU5isxFwM2f+Xi/AVyEPZAUWVOfQ3TWqbBG+YgjPcjwRgwvK
	uel3eRCCu7EeZK8n/3lCOnJNPIQYioTKOtFUdY0VwN7PmLa3Ads5xY1uSjowPsgc1SGcoeJ54iatG
	zhf22MEg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-2b
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 23/45] util: Add address family set/get/reset helpers
Date: Fri, 11 Jul 2025 17:27:14 +0300
Message-Id: <20250711142736.1757060-24-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

[util] Add address family set/get/reset helpers. JB#62713

Add address family (af) helper functions to be used with a boolean array
defining which address families a provider has. Supports AF_INET and
AF_INET6 as set/get parameters. The array must be of AF_ARRAY_LENGTH
size.
---
 src/shared/util.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bda2d2b3..22114029 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -128,3 +128,43 @@ char *util_timeval_to_iso8601(struct timeval *time)
 
 	return g_strdup(buf);
 }
+
+void util_set_afs(bool *afs, int family)
+{
+	if (!afs)
+		return;
+
+	switch (family) {
+	case AF_INET:
+		afs[AF_INET_POS] = true;
+		break;
+	case AF_INET6:
+		afs[AF_INET6_POS] = true;
+		break;
+	default:
+		break;
+	}
+}
+
+bool util_get_afs(bool *afs, int family)
+{
+	if (!afs)
+		return false;
+
+	switch (family) {
+	case AF_INET:
+		return afs[AF_INET_POS];
+	case AF_INET6:
+		return afs[AF_INET6_POS];
+	default:
+		return false;
+	}
+}
+
+void util_reset_afs(bool *afs)
+{
+	if (!afs)
+		return;
+
+	afs[AF_INET_POS] = afs[AF_INET6_POS] = false;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 430b821f..c5a763c4 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -24,6 +24,13 @@
 #include <sys/time.h>
 
 #include <glib.h>
+#include <stdbool.h>
+#include <inet.h>
+#include <arpa/inet.h>
+
+#define AF_INET_POS 0
+#define AF_INET6_POS 1
+#define AF_ARRAY_LENGTH 2
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
@@ -53,3 +60,7 @@ static inline struct cb_data *cb_data_new(void *cb, void *user_data)
 
 void util_iso8601_to_timeval(char *str, struct timeval *time);
 char *util_timeval_to_iso8601(struct timeval *time);
+
+void util_set_afs(bool *afs, int family);
+bool util_get_afs(bool *afs, int family);
+void util_reset_afs(bool *afs);
-- 
2.39.5


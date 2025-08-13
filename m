Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918127FB05
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100782; cv=none; b=O+wgZtefT/yyIIC61yDkLDx3F69pA+2EczFyaVUDKRhlYDQB7+kLkJQZyZnDVP20nJsr2vo3ZQSH0LQGMHf0405jczXNbphlttSHdgEZW0GaDSA6WV4IYzoorITWbMkiPqW9P79WhzfHXqEH/fKF3qq8rQY3B6UrLSSTWli6d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100782; c=relaxed/simple;
	bh=mXxFMm6KEKt/6cykW5KGWa/gslv7CMsk+iAlmKUKKDc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2g3Y8B0Z35Dek8QqNrvTmd71JrFcnwe4PLkkm4RUKA1wVphc71ezRY+wGbrrlX0qE361y7s3Y+gAgB+7ra9v6/vXY/JL2QSQfQIevNMPMrNDpI5clIbcMMgJ956QctwtYKNdbNnfnVE1Pl8fTLeJpMBK/qyGClqeBoL8WaeD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ibKbvehF; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ibKbvehF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5mhJfBKIA2LL41kY8mOtta3Sl/bywSxLA2jnFGEM2OE=; b=ibKbvehFBm0YULpwHy0secFzNs
	ftvgNPUaRywdWWLrH1/vCO0DqzU1CV5Y68o11h0v+zj39aMGzLCcl7VZdmk37DX4mc7PK9D3OUG5g
	G4PbV0ZtFOTdc9dJp1bzKx8WQ7UqKz33kCAs3Qp2WHVfDjqgHsZdfef759wbdsByechzsGf6ZCJQN
	E1P46Yjxj5k5s7xt9ZEPlrHzlPqcurZP8QN1tUEV/GoZ8HwgDKkJA0/y8CYdenNyEGIJ26I6vSWWg
	GrmYOk2K+YBtFusLdRkOYd3REi058NgWBhAaTkJ0aSxFs2um/9Ht8teENEgZrfIjGvF5BCS+WVC2c
	SoRXR7Pw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2w
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 21/42] util: Add address family set/get/reset helpers
Date: Wed, 13 Aug 2025 18:01:53 +0300
Message-Id: <20250813150214.189282-22-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Add address family (af) helper functions to be used for defining which
address families a provider has. Supports AF_INET and AF_INET6 as
set/get parameters.
---
 src/shared/util.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bda2d2b3..0bfce5d5 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -128,3 +128,43 @@ char *util_timeval_to_iso8601(struct timeval *time)
 
 	return g_strdup(buf);
 }
+
+void util_set_afs(struct supported_afs *afs, int family)
+{
+	if (!afs)
+		return;
+
+	switch (family) {
+	case AF_INET:
+		afs->af_inet = true;
+		break;
+	case AF_INET6:
+		afs->af_inet6 = true;
+		break;
+	default:
+		break;
+	}
+}
+
+bool util_get_afs(struct supported_afs *afs, int family)
+{
+	if (!afs)
+		return false;
+
+	switch (family) {
+	case AF_INET:
+		return afs->af_inet;
+	case AF_INET6:
+		return afs->af_inet6;
+	default:
+		return false;
+	}
+}
+
+void util_reset_afs(struct supported_afs *afs)
+{
+	if (!afs)
+		return;
+
+	afs->af_inet = afs->af_inet6 = false;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 430b821f..baaca31e 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -24,6 +24,9 @@
 #include <sys/time.h>
 
 #include <glib.h>
+#include <stdbool.h>
+#include <inet.h>
+#include <arpa/inet.h>
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
@@ -53,3 +56,12 @@ static inline struct cb_data *cb_data_new(void *cb, void *user_data)
 
 void util_iso8601_to_timeval(char *str, struct timeval *time);
 char *util_timeval_to_iso8601(struct timeval *time);
+
+struct supported_afs {
+	bool af_inet;
+	bool af_inet6;
+};
+
+void util_set_afs(struct supported_afs *afs, int family);
+bool util_get_afs(struct supported_afs *afs, int family);
+void util_reset_afs(struct supported_afs *afs);
-- 
2.39.5


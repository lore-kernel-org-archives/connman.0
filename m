Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8072264A3
	for <connman@lists.linux.dev>; Fri, 21 Nov 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740966; cv=none; b=r2qepzrQ+defOroWpG/ptYLzwT3sFiR2HM5QfKxPVz1AGDDCzaz8jUbKxX0bFyg2lvYSzEo6nV4JRzSk+/JfrJeG3igLz3fc+7/SDG3eRMdWBybxndVjsdbpgA5A6Y11psUREaQI1BJFkRHxp/ReTo1NqiNYjwZIj5gLp8S0g6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740966; c=relaxed/simple;
	bh=eEk8BWC92rsQVqBAVpfbYH2Cq251gIGA/GBaWzL1Sao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV1XCNQb4r3SYVXm6Cf28t0a6M/xC0WVIsyAPfbbdvrMcnsHVgcwAPYvuTHJTfQEFTntXdmr915goi6foxbVqTV/a3t4+aJcMtX9D7vdJ2xQHJfBKPfAoyOkTY/vmvjd4aPl6JCzzmmkGyQvoPJa6iC/PWCsZCtVK4b4KzFIOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=PQg9AmKK; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="PQg9AmKK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZhmzHWeZ/bC8cDxzihdHB3JvSHmhqclReqAUQLjyjuw=; b=PQg9AmKKwyK6jsJtl9xZOjTk3d
	9XdgIdOyMeXJBVk0pdETB0GFRGkiywNNSoxDrkqhtvEqdpYbARDrbyeuBekj0AetwX4TQ3y7BGpAn
	i8s9wbmUdnx3MIdWazwW9kV2rDLqW/CGEXOeoHp7ICXiEb4H/CYTqax/xs++6l09qgHqU7hNot360
	kKCC5J6Y/mOTkvth4NWqOyi5Csn0IjUPcvbC+/OG3/Np771wdNl9BTmHaTw4oujMcDRgRT0p+VulJ
	lSlfvg+Xf6Wfj3L2YU/mZ2w8wxbTFnI+Aqt9+I7l1P9bqc1Q6GX6T7/Cph/1swjgnP/EzypFYYSd7
	IuHO+ybQ==;
Received: from [2a10:a5c0:37:6500:6f7f:9248:2d02:98f5] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vMT7x-00Ebjt-2N
	for connman@lists.linux.dev;
	Fri, 21 Nov 2025 17:32:49 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 21/42] util: Add address family set/get/reset helpers
Date: Fri, 21 Nov 2025 17:31:41 +0200
Message-ID: <20251121153240.130896-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813150214.189282-22-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-22-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:6f7f:9248:2d02:98f5
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Add address family (af) helper functions to be used for defining which
address families a provider has. Supports AF_INET and AF_INET6 as
set/get parameters.
---
 src/shared/util.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

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
index 430b821f..30630f93 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -24,6 +24,8 @@
 #include <sys/time.h>
 
 #include <glib.h>
+#include <stdbool.h>
+#include <arpa/inet.h>
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
@@ -53,3 +55,12 @@ static inline struct cb_data *cb_data_new(void *cb, void *user_data)
 
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
2.47.3


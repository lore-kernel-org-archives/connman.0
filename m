Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8C22ACEB
	for <connman@lists.linux.dev>; Fri, 21 Nov 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739324; cv=none; b=nFw5YA6d8Y5ydD9jnnY66T2WmWh9O4zPVaoyR2Q6a6r4FnDXNjm8XAB5XfF4v+3xNWbrwlI41pjHAhbtgUauzdpLeTAiilLeyg/ooVw5lxUZ3kwiXR3H33Cp1eY+B72K8E5aRoZeeMYcPCXznpUDb4s2yM/sTJKi4/xpEJY9T+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739324; c=relaxed/simple;
	bh=eEk8BWC92rsQVqBAVpfbYH2Cq251gIGA/GBaWzL1Sao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxlbX5q+OFgUoOEOe7EhVwcVCmjCdpqi8hA4clVVf/bqNwEnzjff19s/G9//RXLrfBON4XTdKdstxcSqYxQb6lyj63NQpPI4oVi8WPT/pad6IfAkGwrDKeIfDfPRMAYD7lykoUZlUkCRWDMyGzS6UjyXORklds9E1z0aR/Uh0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=EPX62kwQ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EPX62kwQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZhmzHWeZ/bC8cDxzihdHB3JvSHmhqclReqAUQLjyjuw=; b=EPX62kwQqZpl/61ZxJ30+1/+V8
	BwOva9GbRyryERQEQGiahhu7dF5FXjX3rJnXME9T8cXjJB7JLhJoAG0PS+UGpX4VNazAUTCx1GjAZ
	0l4QPsNH9IR7/Y9mUYE9IcJUHvP16Tb1VUq2K7hQlenTnNv8x9pGh+cGIlxUj8rCRmxWXOoxIFhSC
	w3U8mZdmAiHlut3JaM77ju9QOLtvnzNiVcANlmxBDAhueM4gN5KkfbA5hfnCTWW4TsWYl4UjDhVFz
	RoLnH+sWgVIoz+OK+kg5tHjh6u12+Q5ooFpNhgqmhNzLTvWRWY6qV/fj3K245BFSCEyW+7lbHOOa5
	aDgsIrgQ==;
Received: from [2a10:a5c0:37:6500:6f7f:9248:2d02:98f5] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vMTAI-00Ec7O-0L
	for connman@lists.linux.dev;
	Fri, 21 Nov 2025 17:35:14 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 21/42] util: Add address family set/get/reset helpers
Date: Fri, 21 Nov 2025 17:34:30 +0200
Message-ID: <20251121153507.131033-1-jussi.laakkonen@jolla.com>
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


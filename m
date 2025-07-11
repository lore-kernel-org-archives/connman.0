Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF702E7BAC
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=acqxRHSdget/ncx/fbKtaNodnXpU/DVUnCZcyPMsKrE7bWKGPKerPjkwU+GXCYeAF9+2gZZaFM/B/Dfit5LgWUWqRfAbUUOLhpQvt533Acee627oOe+OYInQ5yGUzv/oGqtMIOgiSIspheruCrCoI2ymYdYu2TY0D3x9SeUFWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=oVetn3rdat80WPQ1XEQP8j2qBZZJqWCKnamalRp6Ngg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0Q133C+Aw0QIwQjo0yYnYkksV2iq+nsfzkJxjlPU5AuyEWGgU5VguVYnIq5iRXvNSdC89ebKQa+znNR2g3GWd7CDsgqjeaUNImDigabb3tp6XBuj8VEBiK4d8oZE/aDrI3eIiALlvxZMlhB61wQTWlJnOR2ocnCOXNL+utgpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=rCvGs9mW; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="rCvGs9mW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=26idGT3rnLkga4oFKXzAQcA3UGfFIXE1bcmmrG6zgdA=; b=rCvGs9mWy+UAIDBP+WkqvXjNke
	5YwVea+OeTUDqj15bU26nNzaU2mTfIGlByFNLWANjQxA05qfrwnCm39DSjkm5/nXS+OblxtQ0WX7d
	EvVJd7tyDro1RXCnkYqZTa38qJWzybTOph/EAUO1qyBuj3AnxNi2IAJpzHM4rW+WZjuysqk9esDlg
	DHmxKi9oiKL+aDxjExViN2JUSzJIOQlWRPy03svpemAWVYrzF7pUg6wRiQ/7hK5QRFLR73UAHzaWL
	7I1v3ITxYMKIr5Lvu5DOKCr2htOt0Q0ONsEadqiYveO47l7ofxNCpiLQxlppRdVVXatjehxV0a9QR
	22Rfocbw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-1k
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 17/45] vpn-util: Add wrappers for GResolv hostname lookup use
Date: Fri, 11 Jul 2025 17:27:08 +0300
Message-Id: <20250711142736.1757060-18-jussi.laakkonen@jolla.com>
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

To avoid linking GResolv with every VPN plugin that uses it, add wrappers
for the required calls in VPN utils.
---
 vpn/vpn-util.c | 30 ++++++++++++++++++++++++++++++
 vpn/vpn.h      | 10 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/vpn/vpn-util.c b/vpn/vpn-util.c
index bc3b01dd..2e526701 100644
--- a/vpn/vpn-util.c
+++ b/vpn/vpn-util.c
@@ -222,3 +222,33 @@ out:
 	return err;
 }
 
+unsigned int vpn_util_resolve_hostname(GResolv *resolv,
+				const char *hostname, GResolvResultFunc func,
+				gpointer user_data)
+{
+	DBG("resolve %s", hostname);
+
+	return g_resolv_lookup_hostname(resolv, hostname, func, user_data);
+}
+
+bool vpn_util_cancel_resolve(GResolv *resolv, unsigned int id)
+{
+	DBG("");
+
+	return g_resolv_cancel_lookup(resolv, id);
+}
+
+GResolv *vpn_util_resolve_new(int index)
+{
+	return g_resolv_new(index);
+}
+
+void vpn_util_resolve_unref(GResolv *resolv)
+{
+	g_resolv_unref(resolv);
+}
+
+int vpn_util_get_resolve_error(GResolv *resolv)
+{
+	return g_resolv_get_error(resolv);
+}
diff --git a/vpn/vpn.h b/vpn/vpn.h
index 1f8c8fcd..88afce45 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -134,3 +134,13 @@ bool vpn_settings_is_system_user(const char *user);
 struct passwd *vpn_util_get_passwd(const char *username);
 struct group *vpn_util_get_group(const char *groupname);
 int vpn_util_create_path(const char *path, uid_t uid, gid_t grp, int mode);
+
+#include <gweb/gresolv.h>
+
+unsigned int vpn_util_resolve_hostname(GResolv *resolv,
+				const char *hostname, GResolvResultFunc func,
+				gpointer user_data);
+bool vpn_util_cancel_resolve(GResolv *resolv, unsigned int id);
+GResolv *vpn_util_resolve_new(int index);
+void vpn_util_resolve_unref(GResolv *resolv);
+int vpn_util_get_resolve_error(GResolv *resolv);
-- 
2.39.5


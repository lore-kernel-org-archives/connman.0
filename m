Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927262248B8
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745171; cv=none; b=Ncs2ZFEJPCEzfmEvWpK7kF47q2nOMKdfb3VeOKesAjC9VedzwpB10R10CxqHEf462t8pO2krSTaNf8WibitrEzzSJJ/GOOF0FnfNhD2QU5c95flyUK1t/ryGahRPpU+dTT9EvjP4nLUhDFoTi4ltXVn1y0JqjQjaWg8eLHKQRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745171; c=relaxed/simple;
	bh=oVetn3rdat80WPQ1XEQP8j2qBZZJqWCKnamalRp6Ngg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSNFUO53PXwC9opCRN0OjSReARjifN+Djj7ethW7RBvBZ6EXehQ6Lbq4Ds24Vs3fLaw4gyv+C6WLel7eq1fTWsG1R19ESy7pNpzNq8Kzk2UYBRvJMWj2GxOr91vCtzAwQkLDi9MP58sKc3M4uKoR35ENRiG5Y6ak/ShVnFYO6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=GFOijc0d; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="GFOijc0d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=26idGT3rnLkga4oFKXzAQcA3UGfFIXE1bcmmrG6zgdA=; b=GFOijc0dRo9TdqYL0eryfa/Fxq
	S3y/wlgFzWJDP3/go81o6buevgc7kWnrrSkWk3ofFVZaStdWl/2nmA3wTbVtWa9R8pyBmPyCWeaek
	zWoZJxVQ0H/OV2ZAO9nwE4Y/sa3Zvyh/yBn5YPYW9NIDtquMZEvuXolf60ejSrR2pc8ut1gh/6A1A
	LewnN4vbBT4gZPVxJpMVvKUNmWu5GG0OXMBujSCmDNAYm2kxp506OROPGWeiWa2enqWd0bPdF5Y4U
	L/dSAFIiDgtt6a5RJV0ZLql/jFZiPxrXwV9foDhJMBje7XXyR5DgW4UhiP6skbjKANJNmYt3pzB27
	ugX/hX0w==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-2o
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/12] vpn-util: Add wrappers for GResolv hostname lookup use
Date: Fri, 24 Jan 2025 20:59:10 +0200
Message-Id: <20250124185916.1546471-7-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
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


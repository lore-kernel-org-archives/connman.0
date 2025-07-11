Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1812E7F00
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=fEdHsKwgy3+jyawXd2YccxGXIIuj19p8KtL8NOyWwxtpyy0UyIquiN2rNX28LNkBBcQc7Rvy+hRg/9m5Qo1+xiR3Jj8bHnS0nehJXxIrRtbLEclWQoNE3a3zkzV52r2H7TbY2o1uhFTJfXJb0z+0SfpJZDi9LzLjQH+vzPlE2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=+ouk9jeU05cPemHlX0mNs5VnUhgYBnFeb/xFdjQBxl0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSqPiCHvkoo/+lMNWrMh0d8ksxsXpBAHkep5g8645ks9rWloDs7DQhQ/eLwZMk1ZFJdE15ON2TFHgDcJKPLhhscd/Uxj7D7SvuyHrRq+2EfV6X0y4QDm/zskILC1wUG/stytQQwJ/PNuEKYvgx2Y1Ln1RWPDBDRFqWjj6jWBI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=eVY26biO; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="eVY26biO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lXTYPVo6SlWVbeniQ536rPUHGhjXnutT02fgK87DpJQ=; b=eVY26biOtq9ObXLM+//POiZ+tQ
	wG45XJF8oLrrE6V9BF9E8Vf4AGkV77CBNDOU+WXrWqcslh4958njIYGOyDwLHPxm7AEgnLZuaQhZZ
	VEZouklJ4y/gVHc49nrY/gbM33u8y90IEqt+mvgBzDMpm/yUvAxktcLV27b77NB4tjpIm71y7Ccdd
	esSV08MPX7//HEU9K331aIuA7Z8s98FXZnUIr6CiyFCfHOiRylehxeGXVMRtKbAk64dV8FqF9Rfra
	lCCnD9DnuRRJNGklecQYSNx7kdbVBxvTy5K4g1d205RhFE/uWzLRXVF7yXJFreBsJ9t6cxRjzOGda
	vYePLm7Q==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-1u
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 40/45] vpn-util: Add wrapper for adding a namerver for GResolv
Date: Fri, 11 Jul 2025 17:27:31 +0300
Message-Id: <20250711142736.1757060-41-jussi.laakkonen@jolla.com>
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

The nameservers must be added for the GResolv for the resolving to
succeed. Add a wrapper for this.
---
 vpn/vpn-util.c | 8 ++++++++
 vpn/vpn.h      | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/vpn/vpn-util.c b/vpn/vpn-util.c
index 2e526701..c1264935 100644
--- a/vpn/vpn-util.c
+++ b/vpn/vpn-util.c
@@ -222,6 +222,14 @@ out:
 	return err;
 }
 
+bool vpn_util_resolv_add_nameserver(GResolv *resolv, const char *address,
+					uint16_t port, unsigned long flags)
+{
+	DBG("dns %s:%u", address, port);
+
+	return g_resolv_add_nameserver(resolv, address, port, flags);
+}
+
 unsigned int vpn_util_resolve_hostname(GResolv *resolv,
 				const char *hostname, GResolvResultFunc func,
 				gpointer user_data)
diff --git a/vpn/vpn.h b/vpn/vpn.h
index 01e9ac11..869a3c2c 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -138,6 +138,8 @@ int vpn_util_create_path(const char *path, uid_t uid, gid_t grp, int mode);
 
 #include <gweb/gresolv.h>
 
+bool vpn_util_resolv_add_nameserver(GResolv *resolv, const char *address,
+					uint16_t port, unsigned long flags);
 unsigned int vpn_util_resolve_hostname(GResolv *resolv,
 				const char *hostname, GResolvResultFunc func,
 				gpointer user_data);
-- 
2.39.5


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239A1D54D8
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=XxnAvS7boQpufag2yuiDHlq0QeUHlMciNAX59yVkLpxx4vaF5TzaUeaJxaM+hIiw8QCddGg+571LIoBxqZRLRMk0buDDWwfv0qahHbArkz4DjKvbm3PC0z5UPbyK3ZtPixdCPSk0cXd6k8xjK48bSps3P0MKlUosyF4SULkvNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=xsjUFBMTwAqoOVx06aFuE/zprZB7psalZbvHzKRD8CQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XU2LRY6bbx0pXR3SCIpUhtmW0+2OcoEXWEoBWhrj/KyOQE1usyZ1G4D/XoyqLHsWv0yfwsNgyVec5hcx6kVcPmdtRfpBc7VVGcczpkgGp4VyduRKufAuqQMYL8h4dzb2XPjqpCuXEUd4DJaAsOh8myPPqOJge32Rz/1Lj7z9z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=HTncup/K; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="HTncup/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JISa8J6dhFaTlcyGxUHT14JSFpMkHQQ8h8LOyC0vlIg=; b=HTncup/Kktg1er+d/R4/sv9uVU
	EYQ6Yx793piEAy5R1TLdCoXRoM6gaXfe09jxZn64f4chXo8V1EiPjTFzd0gp1yIR09FhYZyWJqlFv
	YlDNc7z82UUlVzrz1NPw7LZYkWJwCciMrfu0XtK9Rl/579vKRG0NHy/LZw0rSqX9eMUzqrsJgOFK6
	UXJzJPAi+UZCMk87/E4VAq8dY/XkQSZj3F2Ik+ydfJkRaNd+e1dY488c4yU/O0XtMXI2qhuIdf2AE
	kTw+lVSCMgZS614Ex0Y86nuMdDnl7hNJaToLxPYQtmvk/0P78fN44Dx4orTp4D0By20qn9nxAGT/g
	zLOfWoGQ==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-2f
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/12] gresolv: Add generic error for GResolv struct with getter
Date: Fri, 24 Jan 2025 20:59:09 +0200
Message-Id: <20250124185916.1546471-6-jussi.laakkonen@jolla.com>
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

Add a error for the struct to be used with hostname lookup. The function
should return either 0 in case of error or the source id, this fixes the
wrong returns when error happens and makes it possible to retrieve the
error afterwards.
---
 gweb/gresolv.c | 15 +++++++++++++--
 gweb/gresolv.h |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 8101d718..1f1db474 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -116,6 +116,7 @@ struct _GResolv {
 
 	GResolvDebugFunc debug_func;
 	gpointer debug_data;
+	int err;
 };
 
 #define debug(resolv, format, arg...)				\
@@ -1060,7 +1061,8 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 	if (resolv->result_family != AF_INET6) {
 		if (add_query(lookup, hostname, ns_t_a)) {
 			g_free(lookup);
-			return -EIO;
+			resolv->err = -EIO;
+			return 0;
 		}
 	}
 
@@ -1073,7 +1075,8 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 			}
 
 			g_free(lookup);
-			return -EIO;
+			resolv->err = -EIO;
+			return 0;
 		}
 	}
 
@@ -1119,3 +1122,11 @@ bool g_resolv_set_address_family(GResolv *resolv, int family)
 
 	return true;
 }
+
+int g_resolv_get_error(GResolv *resolv)
+{
+	if (!resolv)
+		return 0;
+
+	return resolv->err;
+}
diff --git a/gweb/gresolv.h b/gweb/gresolv.h
index 5e82c168..1994ac34 100644
--- a/gweb/gresolv.h
+++ b/gweb/gresolv.h
@@ -71,6 +71,8 @@ bool g_resolv_cancel_lookup(GResolv *resolv, guint id);
 
 bool g_resolv_set_address_family(GResolv *resolv, int family);
 
+int g_resolv_get_error(GResolv *resolv);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.39.5


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEC23BCEF
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098917; cv=none; b=Wwi5rPuQ3de3s00oGSnpFul4G3uBlnzLUS/BeTQkwe2LYKjEl2PVK1/wmKdC1RWtutkgVYk7+Txf0za6EatNvOzzPhho5uueYl0ErFf6l9mdkOv+vjEhMDL5ykV2mj42xmcYVJkuXdCMoaH0y8hoAizF3TLbhRYIZdo8Wd/pX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098917; c=relaxed/simple;
	bh=qcT+ybmk+x3ItGow4nkDk2SYrx6NshB4tFr53lbdCKo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXwZD0TJ78Ymp2Yr63M+TXgp5772dkeJb20Vao3mtjPguro+K4AQ1EemZ3IWgSWHjw+vZ9eRsfH/aTmnwq6LIJVx7xBgjKr116KE2EpA9fd5a4EzSqyxOIMB+A2U7dw33f4gAl7/AAURNRbiKBm8rzb4gSNP4Ky9Fk2wOwC5GyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ZE78kjbb; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ZE78kjbb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1f3Sr13sTIfqJj/SMikprxUnwfciAuLZzhJD4g0BJXQ=; b=ZE78kjbbQ0DlxZ2SEa/QdtyxQ1
	f1yjz5/3MXtxkGMR2PFiGTXEcnlcUCiYGX0zUbJE/Mn5HtQ7Z0j+ZxE3cPHy6dK0qHBTotk8YRoCZ
	/xDXhzZ4BrMBcnuYhZW6Ju8ogozwUjFtiFcKzZQbAi/RfTBwkRlPnyOQw6ulwIkQ67kahNxr/QqU3
	Rld24d65wg3oTKX4x7eHeFBGcHGTt0YPIN9pjwLILwsjDgftx2TGR1XzM/PZyiFd4n+i1tJNVE29i
	yletXsrbQIQhmkPZeBQlniFowVw3aa81zs83sg+dUWjOoio50m+Kdcr94DZBEhDE7JCDpwEG2CXwS
	Gnix8efw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-24
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 15/42] gresolv: Add GError for hostname lookup
Date: Wed, 13 Aug 2025 18:01:47 +0300
Message-Id: <20250813150214.189282-16-jussi.laakkonen@jolla.com>
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

Add a GError for the hostname lookup call to indicate the error as the
function should return either 0 in case of error or the source id. This
fixes the wrong returns when error happens and makes it possible to
check the error. The error message is propagated from add_query() and a
generic G_RESOLV_ERROR_ADD_QUERY error is reported as the GError code.
---
 gweb/gresolv.c      | 40 +++++++++++++++++++++++++++++++++++-----
 gweb/gresolv.h      |  8 +++++++-
 gweb/gweb.c         |  2 +-
 plugins/vpn.c       |  2 +-
 src/dnsproxy.c      |  4 ++--
 src/timeserver.c    |  2 +-
 src/wpad.c          |  4 ++--
 tools/resolv-test.c |  2 +-
 tools/wpad-test.c   |  5 +++--
 vpn/vpn-provider.c  |  2 +-
 10 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 8101d718..e1d23f8f 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -40,6 +40,9 @@
 
 #include "gresolv.h"
 
+#define G_RESOLV_ERROR g_resolv_error_quark ()
+G_DEFINE_QUARK (g-resolv-error-quark, g_resolv_error)
+
 struct sort_result {
 	int precedence;
 	int src_scope;
@@ -116,6 +119,7 @@ struct _GResolv {
 
 	GResolvDebugFunc debug_func;
 	gpointer debug_data;
+	int err;
 };
 
 #define debug(resolv, format, arg...)				\
@@ -1014,9 +1018,11 @@ static gint add_query(struct resolv_lookup *lookup, const char *hostname, int ty
 }
 
 guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
-				GResolvResultFunc func, gpointer user_data)
+				GResolvResultFunc func, gpointer user_data,
+				GError **error)
 {
 	struct resolv_lookup *lookup;
+	gint err;
 
 	if (!resolv)
 		return 0;
@@ -1058,14 +1064,23 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 	lookup->id = resolv->next_lookup_id++;
 
 	if (resolv->result_family != AF_INET6) {
-		if (add_query(lookup, hostname, ns_t_a)) {
+		err = add_query(lookup, hostname, ns_t_a);
+		if (err) {
 			g_free(lookup);
-			return -EIO;
+
+			g_set_error(error,
+					G_RESOLV_ERROR,
+					G_RESOLV_ERROR_ADD_QUERY,
+					"Failed to add query: %s",
+					g_strerror(-err));
+
+			return 0;
 		}
 	}
 
 	if (resolv->result_family != AF_INET) {
-		if (add_query(lookup, hostname, ns_t_aaaa)) {
+		err = add_query(lookup, hostname, ns_t_aaaa);
+		if (err) {
 			if (resolv->result_family != AF_INET6) {
 				g_queue_remove(resolv->query_queue,
 						lookup->ipv4_query);
@@ -1073,7 +1088,14 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 			}
 
 			g_free(lookup);
-			return -EIO;
+
+			g_set_error(error,
+					G_RESOLV_ERROR,
+					G_RESOLV_ERROR_ADD_QUERY,
+					"Failed to add query: %s",
+					g_strerror(-err));
+
+			return 0;
 		}
 	}
 
@@ -1119,3 +1141,11 @@ bool g_resolv_set_address_family(GResolv *resolv, int family)
 
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
index 5e82c168..093b9a2d 100644
--- a/gweb/gresolv.h
+++ b/gweb/gresolv.h
@@ -47,6 +47,11 @@ typedef enum {
 	G_RESOLV_RESULT_STATUS_NO_ANSWER,
 } GResolvResultStatus;
 
+typedef enum {
+	G_RESOLV_ERROR_ADD_QUERY,
+	G_RESOLV_ERROR_NO_ERROR,
+} GResolvError;
+
 typedef void (*GResolvResultFunc)(GResolvResultStatus status,
 					char **results, gpointer user_data);
 
@@ -65,7 +70,8 @@ bool g_resolv_add_nameserver(GResolv *resolv, const char *address,
 void g_resolv_flush_nameservers(GResolv *resolv);
 
 guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
-				GResolvResultFunc func, gpointer user_data);
+				GResolvResultFunc func, gpointer user_data,
+				GError **error);
 
 bool g_resolv_cancel_lookup(GResolv *resolv, guint id);
 
diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4dbbb4c8..4aa4416a 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2673,7 +2673,7 @@ static guint do_request(GWeb *web, const char *url,
 		session->address_action = g_idle_add(already_resolved, session);
 	} else {
 		session->resolv_action = g_resolv_lookup_hostname(web->resolv,
-					host, resolv_result, session);
+					host, resolv_result, session, NULL);
 		if (session->resolv_action <= 0) {
 			free_session(session);
 			/*
diff --git a/plugins/vpn.c b/plugins/vpn.c
index d683c67d..c0739fc1 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -243,7 +243,7 @@ static void resolv_host_addr(struct connection_data *data)
 	DBG("Trying to resolv %s", data->host);
 
 	data->resolv_id = g_resolv_lookup_hostname(data->resolv, data->host,
-						resolv_result, data);
+						resolv_result, data, NULL);
 }
 
 static void free_config_cb_data(struct config_create_data *cb_data)
diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1dd2f7f5..71a01f6d 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -400,14 +400,14 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
 	if (!entry->ipv4) {
 		debug("Refreshing A record for %s", name);
 		g_resolv_lookup_hostname(ipv4_resolve, name,
-					dummy_resolve_func, NULL);
+					dummy_resolve_func, NULL, NULL);
 		age = 4;
 	}
 
 	if (!entry->ipv6) {
 		debug("Refreshing AAAA record for %s", name);
 		g_resolv_lookup_hostname(ipv6_resolve, name,
-					dummy_resolve_func, NULL);
+					dummy_resolve_func, NULL, NULL);
 		age = 4;
 	}
 
diff --git a/src/timeserver.c b/src/timeserver.c
index d364f728..8f077307 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -204,7 +204,7 @@ static void sync_next(void)
 
 		DBG("Resolving timeserver %s", ts_current);
 		resolv_id = g_resolv_lookup_hostname(resolv, ts_current,
-						resolv_result, NULL);
+						resolv_result, NULL, NULL);
 		return;
 	}
 
diff --git a/src/wpad.c b/src/wpad.c
index e1886d2b..f3bc6282 100644
--- a/src/wpad.c
+++ b/src/wpad.c
@@ -111,7 +111,7 @@ static void wpad_result(GResolvResultStatus status,
 	DBG("hostname %s", wpad->hostname);
 
 	g_resolv_lookup_hostname(wpad->resolv, wpad->hostname,
-							wpad_result, wpad);
+						wpad_result, wpad, NULL);
 
 	return;
 
@@ -176,7 +176,7 @@ int __connman_wpad_start(struct connman_service *service)
 	wpad->service = connman_service_ref(service);
 
 	g_resolv_lookup_hostname(wpad->resolv, wpad->hostname,
-							wpad_result, wpad);
+						wpad_result, wpad, NULL);
 
 	g_hash_table_replace(wpad_list, GINT_TO_POINTER(index), wpad);
 
diff --git a/tools/resolv-test.c b/tools/resolv-test.c
index 1aad2841..acf4f0bd 100644
--- a/tools/resolv-test.c
+++ b/tools/resolv-test.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 	timer = g_timer_new();
 
 	if (g_resolv_lookup_hostname(resolv, argv[1],
-					resolv_result, NULL) == 0) {
+					resolv_result, NULL, NULL) == 0) {
 		printf("failed to start lookup\n");
 		return 1;
 	}
diff --git a/tools/wpad-test.c b/tools/wpad-test.c
index 2ecbcdae..518d42ea 100644
--- a/tools/wpad-test.c
+++ b/tools/wpad-test.c
@@ -75,7 +75,7 @@ static void resolv_result(GResolvResultStatus status,
 
 	str = g_strdup_printf("wpad.%s", ptr + 1);
 
-	g_resolv_lookup_hostname(resolv, str, resolv_result, str);
+	g_resolv_lookup_hostname(resolv, str, resolv_result, str, NULL);
 
 	g_free(hostname);
 
@@ -118,7 +118,8 @@ static void start_wpad(const char *search)
 
 	hostname = g_strdup_printf("wpad.%s", domainname);
 
-	g_resolv_lookup_hostname(resolv, hostname, resolv_result, hostname);
+	g_resolv_lookup_hostname(resolv, hostname, resolv_result, hostname,
+					NULL);
 
 	return;
 
diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index b21e9e61..b79b7963 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -980,7 +980,7 @@ static void provider_resolv_host_addr(struct vpn_provider *provider)
 	vpn_provider_ref(provider);
 
 	g_resolv_lookup_hostname(provider->resolv, provider->host,
-				resolv_result, provider);
+				resolv_result, provider, NULL);
 }
 
 void __vpn_provider_append_properties(struct vpn_provider *provider,
-- 
2.39.5


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B57818
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AC4D77321A
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:04 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 640A873229
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/17] gweb: Add optional OS error status parameter to 'g_web_request_*'.
Date: Wed, 15 Nov 2023 17:02:50 -0800
Message-ID: <20231116010259.628527-10-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds an optional operating system error status parameter to
'g_web_request_{get,post,post_file}' allowing callers, so interested,
to obtain the underlying failure status for a failed GWeb request.
---
 gweb/gweb.c      | 59 +++++++++++++++++++++++++++++++++---------------
 gweb/gweb.h      |  8 ++++---
 src/6to4.c       |  2 +-
 src/wispr.c      |  6 ++---
 tools/web-test.c |  3 ++-
 tools/wispr.c    |  8 +++----
 6 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 1463b588d411..1cf830a46773 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2255,23 +2255,31 @@ static bool is_ip_address(const char *host)
 static guint do_request(GWeb *web, const char *url,
 				const char *type, GWebInputFunc input,
 				int fd, gsize length, GWebResultFunc func,
-				GWebRouteFunc route, gpointer user_data)
+				GWebRouteFunc route, gpointer user_data,
+				int *err)
 {
 	struct web_session *session;
 	const gchar *host;
+	int request_id = 0;
+	int status = 0;
 
-	if (!web || !url)
-		return 0;
+	if (!web || !url) {
+		status = -EINVAL;
+		goto done;
+	}
 
 	debug(web, "request %s", url);
 
 	session = g_try_new0(struct web_session, 1);
-	if (!session)
-		return 0;
+	if (!session) {
+		status = -ENOMEM;
+		goto done;
+	}
 
-	if (parse_request_and_proxy_urls(session, url, web->proxy) < 0) {
+	status = parse_request_and_proxy_urls(session, url, web->proxy);
+	if (status < 0) {
 		free_session(session);
-		return 0;
+		goto done;
 	}
 
 	debug(web, "proxy host %s", session->address);
@@ -2299,14 +2307,16 @@ static guint do_request(GWeb *web, const char *url,
 	session->receive_buffer = g_try_malloc(DEFAULT_BUFFER_SIZE);
 	if (!session->receive_buffer) {
 		free_session(session);
-		return 0;
+		status = -ENOMEM;
+		goto done;
 	}
 
 	session->result.headers = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
 	if (!session->result.headers) {
 		free_session(session);
-		return 0;
+		status = -ENOMEM;
+		goto done;
 	}
 
 	session->receive_space = DEFAULT_BUFFER_SIZE;
@@ -2325,33 +2335,46 @@ static guint do_request(GWeb *web, const char *url,
 	} else {
 		session->resolv_action = g_resolv_lookup_hostname(web->resolv,
 					host, resolv_result, session);
-		if (session->resolv_action == 0) {
+		if (session->resolv_action <= 0) {
 			free_session(session);
-			return 0;
+			status = session->resolv_action < 0 ?
+						session->resolv_action :
+						-ENOENT;
+			goto done;
 		}
 	}
 
 	web->session_list = g_list_append(web->session_list, session);
 
-	return web->next_query_id++;
+	request_id = web->next_query_id++;
+
+done:
+	if (err)
+		*err = status;
+
+	return request_id;
 }
 
 guint g_web_request_get(GWeb *web, const char *url, GWebResultFunc func,
-		GWebRouteFunc route, gpointer user_data)
+		GWebRouteFunc route, gpointer user_data, int *err)
 {
-	return do_request(web, url, NULL, NULL, -1, 0, func, route, user_data);
+	return do_request(web, url, NULL, NULL, -1, 0,
+		func, route, user_data, err);
 }
 
 guint g_web_request_post(GWeb *web, const char *url,
 				const char *type, GWebInputFunc input,
-				GWebResultFunc func, gpointer user_data)
+				GWebResultFunc func, gpointer user_data,
+				int *err)
 {
-	return do_request(web, url, type, input, -1, 0, func, NULL, user_data);
+	return do_request(web, url, type, input, -1, 0,
+		func, NULL, user_data, err);
 }
 
 guint g_web_request_post_file(GWeb *web, const char *url,
 				const char *type, const char *file,
-				GWebResultFunc func, gpointer user_data)
+				GWebResultFunc func, gpointer user_data,
+				int *err)
 {
 	struct stat st;
 	int fd;
@@ -2365,7 +2388,7 @@ guint g_web_request_post_file(GWeb *web, const char *url,
 		return 0;
 
 	ret = do_request(web, url, type, NULL, fd, st.st_size, func, NULL,
-			user_data);
+			user_data, err);
 	if (ret == 0)
 		close(fd);
 
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 3c50979cfd0a..7c65aebf4698 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -150,13 +150,15 @@ bool g_web_get_close_connection(GWeb *web);
 
 guint g_web_request_get(GWeb *web, const char *url,
 				GWebResultFunc func, GWebRouteFunc route,
-				gpointer user_data);
+				gpointer user_data, int *err);
 guint g_web_request_post(GWeb *web, const char *url,
 				const char *type, GWebInputFunc input,
-				GWebResultFunc func, gpointer user_data);
+				GWebResultFunc func, gpointer user_data,
+				int *err);
 guint g_web_request_post_file(GWeb *web, const char *url,
 				const char *type, const char *file,
-				GWebResultFunc func, gpointer user_data);
+				GWebResultFunc func, gpointer user_data,
+				int *err);
 
 bool g_web_cancel_request(GWeb *web, guint id);
 
diff --git a/src/6to4.c b/src/6to4.c
index 71a288277104..5542b339691a 100644
--- a/src/6to4.c
+++ b/src/6to4.c
@@ -318,7 +318,7 @@ static void tun_newlink(unsigned flags, unsigned change, void *user_data)
 			g_web_set_debug(web, web_debug, "6to4");
 
 		web_request_id = g_web_request_get(web, STATUS_URL,
-				web_result, NULL,  NULL);
+				web_result, NULL,  NULL, NULL);
 
 		newlink_timeout(NULL);
 	}
diff --git a/src/wispr.c b/src/wispr.c
index 1e62e0cd2dee..4b4c9c1e59ec 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -634,7 +634,7 @@ static void wispr_portal_request_portal(
 					wp_context->status_url,
 					wispr_portal_web_result,
 					wispr_route_request,
-					wp_context);
+					wp_context, NULL);
 
 	if (wp_context->request_id == 0) {
 		wp_context->cb(wp_context->service, wp_context->type, false);
@@ -751,7 +751,7 @@ static void wispr_portal_request_wispr_login(struct connman_service *service,
 					wp_context->wispr_msg.login_url,
 					"application/x-www-form-urlencoded",
 					wispr_input, wispr_portal_web_result,
-					wp_context);
+					wp_context, NULL);
 
 	connman_wispr_message_init(&wp_context->wispr_msg);
 }
@@ -906,7 +906,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		wispr_portal_context_ref(wp_context);
 		wp_context->request_id = g_web_request_get(wp_context->web,
 				redirect, wispr_portal_web_result,
-				wispr_route_request, wp_context);
+				wispr_route_request, wp_context, NULL);
 
 		goto done;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
diff --git a/tools/web-test.c b/tools/web-test.c
index 55c58af5a7dc..a65e6c115c41 100644
--- a/tools/web-test.c
+++ b/tools/web-test.c
@@ -150,7 +150,8 @@ int main(int argc, char *argv[])
 
 	timer = g_timer_new();
 
-	if (g_web_request_get(web, argv[1], web_result, NULL,  NULL) == 0) {
+	if (g_web_request_get(web, argv[1], web_result,
+			NULL, NULL, NULL) == 0) {
 		fprintf(stderr, "Failed to start request\n");
 		return 1;
 	}
diff --git a/tools/wispr.c b/tools/wispr.c
index e56dfc169411..ef7b60d3f5ca 100644
--- a/tools/wispr.c
+++ b/tools/wispr.c
@@ -531,7 +531,7 @@ static bool wispr_result(GWebResult *result, gpointer user_data)
 		printf("\n");
 
 		wispr->request = g_web_request_get(wispr->web, redirect,
-				wispr_result, wispr_route, wispr);
+				wispr_result, wispr_route, wispr, NULL);
 
 		return false;
 	}
@@ -591,7 +591,7 @@ static bool wispr_result(GWebResult *result, gpointer user_data)
 		printf("\n");
 
 		wispr->request = g_web_request_get(wispr->web, redirect,
-				wispr_result, NULL, wispr);
+				wispr_result, NULL, wispr, NULL);
 
 		return false;
 	}
@@ -608,7 +608,7 @@ static gboolean execute_login(gpointer user_data)
 
 	wispr->request = g_web_request_post(wispr->web, wispr->msg.login_url,
 					"application/x-www-form-urlencoded",
-					wispr_input, wispr_result, wispr);
+					wispr_input, wispr_result, wispr, NULL);
 
 	wispr_msg_init(&wispr->msg);
 
@@ -694,7 +694,7 @@ int main(int argc, char *argv[])
 						parser_callback, &wispr);
 
 	wispr.request = g_web_request_get(wispr.web, option_url,
-			wispr_result, wispr_route, &wispr);
+			wispr_result, wispr_route, &wispr, NULL);
 
 	if (wispr.request == 0) {
 		fprintf(stderr, "Failed to start request\n");
-- 
2.42.0


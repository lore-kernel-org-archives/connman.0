Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501D38FB6
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 89141730F7
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:35 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 40DFB7310A
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] service: Add and leverage 'clear_error'.
Date: Mon, 20 Nov 2023 13:53:28 -0800
Message-ID: <20231120215329.786768-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120215329.786768-1-gerickson@nuovations.com>
References: <20231120215329.786768-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There are a suffient number of instantiations of the following
implementation pattern:

    set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);

to clear or reset the "Error" service property where it makes sense to
embody this in a single function, 'clear_error'.

This introduces and leverages the 'clear_error' function to embody
this pattern.
---
 src/service.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index 9808028637dd..b30e75b9ac13 100644
--- a/src/service.c
+++ b/src/service.c
@@ -183,6 +183,8 @@ static void complete_online_check(struct connman_service *service,
 					bool success,
 					int err);
 static bool service_downgrade_online_state(struct connman_service *service);
+static bool connman_service_is_default(const struct connman_service *service);
+static void clear_error(struct connman_service *service);
 
 struct find_data {
 	const char *path;
@@ -3992,7 +3994,7 @@ int __connman_service_set_passphrase(struct connman_service *service,
 
 	if (service->hidden_service &&
 			service->error == CONNMAN_SERVICE_ERROR_INVALID_KEY)
-		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+		clear_error(service);
 
 	return 0;
 }
@@ -4374,7 +4376,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 			 * have the same effect as user connecting the VPN =
 			 * clear previous error and change state to idle.
 			 */
-			set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+			clear_error(service);
 
 			if (service->state == CONNMAN_SERVICE_STATE_FAILURE) {
 				service->state = CONNMAN_SERVICE_STATE_IDLE;
@@ -4674,6 +4676,11 @@ static void set_error(struct connman_service *service,
 				DBUS_TYPE_STRING, &str);
 }
 
+static void clear_error(struct connman_service *service)
+{
+	set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+}
+
 static void remove_timeout(struct connman_service *service)
 {
 	if (service->timeout > 0) {
@@ -4715,7 +4722,7 @@ static DBusMessage *clear_property(DBusConnection *conn,
 							DBUS_TYPE_INVALID);
 
 	if (g_str_equal(name, "Error")) {
-		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+		clear_error(service);
 
 		__connman_service_clear_error(service);
 		service_complete(service);
@@ -6795,7 +6802,7 @@ static void request_input_cb(struct connman_service *service,
 
 	if (err >= 0) {
 		/* We forget any previous error. */
-		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+		clear_error(service);
 
 		__connman_service_connect(service,
 					CONNMAN_SERVICE_CONNECT_REASON_USER);
@@ -7017,7 +7024,7 @@ static int service_indicate_state(struct connman_service *service)
 		break;
 
 	case CONNMAN_SERVICE_STATE_READY:
-		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+		clear_error(service);
 
 		if (service->new_service &&
 				__connman_stats_service_register(service) == 0) {
@@ -7084,7 +7091,7 @@ static int service_indicate_state(struct connman_service *service)
 		break;
 
 	case CONNMAN_SERVICE_STATE_DISCONNECT:
-		set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
+		clear_error(service);
 
 		reply_pending(service, ECONNABORTED);
 
-- 
2.42.0


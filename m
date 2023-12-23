Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037CD134D0
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2FD0D73146
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 13:58:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:601e:89f:ea32:6713])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E67E973171
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 13:58:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] service: Log service default, error, and state changes.
Date: Sat, 23 Dec 2023 10:58:12 -0800
Message-ID: <20231223185812.2389541-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231223185812.2389541-1-gerickson@nuovations.com>
References: <20231223185812.2389541-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Service default, error, and state changes are significant enough and
low-frequency enough to warrant logging at the info level. This adds
log entries for each in the form:

    ... [Ii]nterface <interface name> [ <service type> ] ...

to achieve:

    Interface eth0 [ ethernet ] is the default
    Interface eth0 [ ethernet ] error "online-check-failed"
    Interface eth0 [ ethernet ] state is online

log entries for default, error, and state changes, respectively.
---
 src/service.c | 57 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index d3bd1fe83b37..f3e022c91879 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4187,6 +4187,17 @@ bool __connman_service_index_is_default(int index)
 	return __connman_service_get_index(service) == index;
 }
 
+static void service_log_default(const struct connman_service *service)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_info("Interface %s [ %s ] is the default",
+		interface,
+		__connman_service_type2string(service->type));
+}
+
 static void default_changed(const char *function)
 {
 	struct connman_service *service = connman_service_get_default();
@@ -4233,6 +4244,8 @@ static void default_changed(const char *function)
 	current_default = service;
 
 	if (service) {
+		service_log_default(service);
+
 		if (service->hostname &&
 				connman_setting_get_bool("AllowHostnameUpdates"))
 			__connman_utsname_set_hostname(service->hostname);
@@ -4257,10 +4270,24 @@ static void default_changed(const char *function)
 	__connman_notifier_default_changed(service);
 }
 
+static void service_log_state(const struct connman_service *service)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_info("Interface %s [ %s ] state is %s",
+		interface,
+		__connman_service_type2string(service->type),
+		state2string(service->state));
+}
+
 static void state_changed(struct connman_service *service)
 {
 	const char *str;
 
+	service_log_state(service);
+
 	__connman_notifier_service_state_changed(service, service->state);
 
 	str = state2string(service->state);
@@ -6450,6 +6477,19 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static void service_log_error(const struct connman_service *service,
+					enum connman_service_error error)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_warn("Interface %s [ %s ] error \"%s\"",
+		interface,
+		__connman_service_type2string(service->type),
+		error2string(error));
+}
+
 /**
  *  @brief
  *    Set the specified network service "Error" property.
@@ -6471,7 +6511,14 @@ static DBusMessage *set_property(DBusConnection *conn,
 static void set_error(struct connman_service *service,
 					enum connman_service_error error)
 {
-	const char *str;
+	const char *str = error2string(error);
+
+	if (!str)
+		str = "";
+
+	DBG("service %p (%s) error %d (%s)",
+		service, connman_service_get_identifier(service),
+		error, str);
 
 	if (service->error == error)
 		return;
@@ -6481,14 +6528,12 @@ static void set_error(struct connman_service *service,
 	if (!service->path)
 		return;
 
+	if (error != CONNMAN_SERVICE_ERROR_UNKNOWN)
+		service_log_error(service, error);
+
 	if (!allow_property_changed(service))
 		return;
 
-	str = error2string(service->error);
-
-	if (!str)
-		str = "";
-
 	connman_dbus_property_changed_basic(service->path,
 				CONNMAN_SERVICE_INTERFACE, "Error",
 				DBUS_TYPE_STRING, &str);
-- 
2.42.0


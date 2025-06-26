Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C8191F7E
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922935; cv=none; b=hTanUootwM1gQly+P3kmaIJZSSj8I7hMHX560TpGJLg6a8xD4zLO81+H6NGKAJI9xvAzHAQDF880DBt7luUcFtH2+2yBPGW0L1G47oZYk5L1PXCFjfxhCyTEoeTp+gqnRylqqnZSSABqZeQpGh66Bhuhtdwy8AH5QFKw6Sn7SuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922935; c=relaxed/simple;
	bh=0rNEEp+Q5puWgZBZi/qyFJ84M+RQj1LzrDgw7ufykOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmE5+F17tC1AV+BDvW5BiVlg7pgVDb8DTZGImwKyUZ/1N0+QBMI1bjTV9XIba4Nwj43QQFPE7IdOGWscp+f/PpBOYerevxu5oam+h8MFyRGUlhed5A4IkqwMO6TJmQVMKbLrBWafpTJhn3Hgsb5P3fCKLznAgKsGFqtKl7ceVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aMkoxsIR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aMkoxsIR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45348bff79fso6213345e9.2
        for <connman@lists.linux.dev>; Thu, 26 Jun 2025 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1750922931; x=1751527731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZGmHwBHVbqvfEnmXJiKARNkaZj0DHuY0mO4Tbmv96s=;
        b=aMkoxsIRMtAvaus2A0pIkjtiL4novRAfJ5G1ogC0JzMWBdVKNoYvfiqpF7bl5Ehl/U
         SQi2BjiNXG6rpdizTwCpNemS4sBngIHw7YjhmXz90sYTLjWaIMN6ZaSGjMV/ZGTTbC1U
         uS0wV28OawJCFegKGOH0jLxw043TjwNW6AmwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750922931; x=1751527731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZGmHwBHVbqvfEnmXJiKARNkaZj0DHuY0mO4Tbmv96s=;
        b=EiCMhHOR8Jzx6g/urG0o2ufx1oywdTyODSoWcqHLsnvO2iP4EoDLiDQTc0Etv9+96E
         TiYdeZ8XvF6trm5s3Fd2BakYqbZTHCoXgObH1/XR7Po8KiLf5+Q0mzXBGteH9hnsPDQp
         CYTxIvC38btjeddzjh2KATS24h/A+Dy8cMXwdfxOTen9zNjtVrOcG3YniV0Hi8bnlgYt
         lZ4zoaNn0AAkNK1Exp2lmtZ7s1rkov2ILH+csZ97m30ptQiRJ+sBj5WLGPDiWgglHY8Q
         hS4q3ZISDhVkZ0hIL3ku/J3zHRuIZfp3E+PY7S1MveyoMG5H92upphltoCsN0sCbdbwS
         AnjA==
X-Gm-Message-State: AOJu0Yz2x30IQHUjpkXkYZDD9y/H3n7WxofUKv4LEAkcrep3EK4eBe88
	zjovt43aT3Y2X/nSMPdlY/U69IUgDSJVQqG1fe02dwXSaM3jnBXZmgirlalCOidB/1BjEVbj82G
	9NLZnpwk=
X-Gm-Gg: ASbGnctz/dG7daw6tOTXjkqJcYT1fg0nMA+3F7LGBis/lL39FEMir6uuQFLLElfh/+c
	A9X+ShENpvmgivozIv77MrewAsYkzTynvTuw599h8MnjmY9ZRZTV5Ply+gb38AWgn033LGrxgLE
	fho/IgJ8Jd8Pe0GlWLRBcrPYmPogvYTpJqbYuqjaTjT6rZFsELSRvJokLMgZVIiCXluKNEoOt2W
	7LfD3rAA3I4s5RSbyP6D+emIRu2v1xu63/pbOPf2dVXRC/9+HwlXEQj1VzqLsn7oYkHfekgWyeI
	XSCeVemX+blUS0QooKmB2FCvtU7N7P+Igds2yxji0scggEFB9nVkvvvrEW4bs4FTaSFuAGaSnai
	ClCipkGCmYSVI9ENgcei232rMYppu5Jcj7Nmgb5ParBY=
X-Google-Smtp-Source: AGHT+IFMgOXx1Z1l+yNdSbOuy6HseHskqS/L4zRiHfOTkJGXLB8TBR/KFqzn4xzJPZjVKMtb2/xvFw==
X-Received: by 2002:a05:600c:670a:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-45381aaa60amr64033665e9.10.1750922930691;
        Thu, 26 Jun 2025 00:28:50 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8382-0206-0000-0000-0000-05fa.ipv6.o2.cz. [2a00:1028:8382:206::5fa])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6e8063a5dsm6780573f8f.35.2025.06.26.00.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 00:28:50 -0700 (PDT)
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 2/3] Add RemoveKnownService to connman
Date: Thu, 26 Jun 2025 09:27:45 +0200
Message-ID: <20250626072822.1941-3-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626072822.1941-1-roman@amarulasolutions.com>
References: <20250626072822.1941-1-roman@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

Add a way to remove stored network in connman storage. This
allow to remove network even if they are not visible
---
 src/connman.h        |  3 +++
 src/manager.c        | 21 +++++++++++++++++++++
 src/service.c        | 25 +++++++++++++++++++++++++
 tools/manager-api.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 tools/session-test.h |  2 ++
 5 files changed, 94 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index a4e7e4f1..1f90c9b1 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -790,6 +790,8 @@ int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
 bool __connman_service_remove(struct connman_service *service);
+bool __connman_service_remove_known_service(DBusConnection *conn,
+					    DBusMessage *msg, const char *path);
 void __connman_service_set_hidden_data(struct connman_service *service,
 				gpointer user_data);
 void __connman_service_return_error(struct connman_service *service,
@@ -847,6 +849,7 @@ void __connman_service_set_split_routing(struct connman_service *service,
 void __connman_service_split_routing_changed(struct connman_service *service);
 int __connman_service_get_index(const struct connman_service *service);
 void __connman_service_set_hidden(struct connman_service *service);
+void __connman_service_set_auto_connect(struct connman_service *service, bool autoconnect);
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname);
 const char *__connman_service_get_hostname(const struct connman_service *service);
diff --git a/src/manager.c b/src/manager.c
index b196109a..8c66ad3d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -215,6 +215,24 @@ static DBusMessage *get_known_services(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *remove_known_service(DBusConnection *conn,
+				   DBusMessage *msg, void *data)
+{
+	const char *name;
+
+	DBG("conn %p", conn);
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &name,
+							DBUS_TYPE_INVALID);
+
+	DBG("Service to remove [%s]", name);
+
+	if (!__connman_service_remove_known_service(conn, msg, name))
+		return __connman_error_failed(msg, -ENOENT);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static void append_peer_structs(DBusMessageIter *iter, void *user_data)
 {
 	__connman_peer_list_struct(iter);
@@ -557,6 +575,9 @@ static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_METHOD("GetKnownServices",
 			NULL, GDBUS_ARGS({"knownServices", "a(oa{sv})" }),
 			get_known_services) },
+	{ GDBUS_METHOD("RemoveKnownService",
+			GDBUS_ARGS({ "name", "o" }), NULL,
+			remove_known_service) },
 	{ GDBUS_METHOD("GetServices",
 			NULL, GDBUS_ARGS({ "services", "a(oa{sv})" }),
 			get_services) },
diff --git a/src/service.c b/src/service.c
index bcda5076..88bbea3b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7530,6 +7530,31 @@ bool __connman_service_remove(struct connman_service *service)
 	return true;
 }
 
+bool __connman_service_remove_known_service(DBusConnection *conn,
+					    DBusMessage *msg, const char *path)
+{
+	struct connman_service *service;
+	const char* identifier;
+
+	DBG("Remove known service [%s]", path);
+
+	identifier = strrchr(path, '/');
+	if (!identifier)
+		return false;
+
+	service = g_hash_table_lookup(service_hash, identifier);
+
+	if (service) {
+		if (service->type != CONNMAN_SERVICE_TYPE_ETHERNET &&
+				service->type != CONNMAN_SERVICE_TYPE_GADGET) {
+			if (!__connman_service_remove(service))
+				return false;
+		}
+	}
+
+	return __connman_storage_remove_service(identifier);
+}
+
 static DBusMessage *remove_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
diff --git a/tools/manager-api.c b/tools/manager-api.c
index 8668ca9e..376ff8dc 100644
--- a/tools/manager-api.c
+++ b/tools/manager-api.c
@@ -94,6 +94,49 @@ DBusMessage *manager_get_known_services(DBusConnection *connection)
 	return reply;
 }
 
+DBusMessage *manager_remove_known_service(DBusConnection *connection,
+					  const char *service_path)
+{
+	DBusMessage *message, *reply;
+	DBusError error;
+	DBusMessageIter array;
+
+	DBG("Service path to remove [%s]", service_path);
+
+	message = dbus_message_new_method_call(CONNMAN_SERVICE,
+				   CONNMAN_MANAGER_PATH,
+				   CONNMAN_MANAGER_INTERFACE,
+				   "RemoveKnownService");
+
+	if (!message)
+		return NULL;
+
+	dbus_error_init(&error);
+
+	dbus_message_iter_init_append(message, &array);
+
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_OBJECT_PATH,
+				&service_path);
+
+	reply = dbus_connection_send_with_reply_and_block(connection,
+				  message, -1, &error);
+
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			LOG("%s", error.message);
+			dbus_error_free(&error);
+		} else {
+			LOG("Failed to get known services");
+		}
+		dbus_message_unref(message);
+		return NULL;
+	}
+
+	dbus_message_unref(message);
+
+	return reply;
+}
+
 DBusMessage *manager_get_services(DBusConnection *connection)
 {
 	DBusMessage *message, *reply;
diff --git a/tools/session-test.h b/tools/session-test.h
index ab89f8c5..c19acb56 100644
--- a/tools/session-test.h
+++ b/tools/session-test.h
@@ -115,6 +115,8 @@ DBusMessage *session_disconnect(DBusConnection *connection,
 
 /* manager-api.c */
 DBusMessage *manager_get_known_services(DBusConnection *connection);
+DBusMessage *manager_remove_known_service(DBusConnection *connection,
+					  const char *service_path);
 DBusMessage *manager_get_services(DBusConnection *connection);
 DBusMessage *manager_get_properties(DBusConnection *connection);
 DBusMessage *manager_create_session(DBusConnection *connection,
-- 
2.49.0


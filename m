Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7820A5D2
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403579; cv=none; b=TIZ2aVSTODD8lRPK4vOb5y0o4TYkd7vlLT2VQZPfA0H5n6Gsob/J1BXOKv35h9vWWEG/VGsx5pVChoA9HhpW8lYrigW9lIJlqWwiKDwNNT2nMtsDx/AH82vjJE0nhqOWXb3/mfKDviG8mTop5p6oOVMkI1fK1itRX3eilibeH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403579; c=relaxed/simple;
	bh=KYNPp/4UOv+B3ah5/c++m/4AWlw/N4SQD2/O40c9Wb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHiQipwKYdjb3AdSZknGQaaQxoBJlJliDmn7CFZhWWPGiPQcKM0OFyaZFA+B2z7B+A1Uq8mMZKLccUmrGgyqx5jAsEON+FV0kv21S1zxdgAJiwF+6ukbUctp9x5ienaHb8/sdtNu3WdkQ4Q2+B50Wz9P9qU3S5bCQ2wepIHaCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=CGxjqHqZ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="CGxjqHqZ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 155F41649C6
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BEC12124E85
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/4] ofono: Add additional 'DBG' statements.
Date: Wed, 12 Feb 2025 15:39:30 -0800
Message-ID: <266252ccc068271920248994a394928d000777f5.1739403363.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739403363.git.gerickson@nuovations.com>
References: <cover.1739403363.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=R5L5m50rEloIvVQYGUn49ngbGe691ns1yTt+UIadAmA=; b=CGxjqHqZ0wckAhB9AHZhuJNC9icI9dUPUQPRPRIwJIP4mk5jdnaoyUMVYhM6iBa2ZRSMtaft5Oj2r6KVmI/qOMdjhjWFkbZwFIg1EwpiwVUYxaP975fmnZlaCo12BDDauoJNm+gMszWQdepQHREb5m8bPtlS410TUi7bdyZDPQCm7pY5dWi836GfdPwosNbxSHF3Z9ZsUq0BTAiQDOeRqIQQZwayuUgIZmCt54qkUwo1xURT9IxEA1YmFLlhdo66uMUfbQNzK2Z3eWFEmnw37xzfvJbl5QkdithOoS6ed6v2PQr8z060YmJN2bQ/bnT0EURDx0KxzVgQbACpnruhFQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds additional 'DBG' statements to make debugging current and future
ofono integration and interactions easier.
---
 plugins/ofono.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 062905c8a3a6..47f289f605e0 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -289,7 +289,7 @@ static void set_connected(struct modem_data *modem,
 	char *nameservers;
 	int index;
 
-	DBG("%s", modem->path);
+	DBG("modem %p path %s context %p path %s", modem, modem->path, context, context->path);
 
 	index = context->index;
 
@@ -300,10 +300,14 @@ static void set_connected(struct modem_data *modem,
 		return;
 	}
 
+	DBG("context->network %p", context->network);
+
 	service = connman_service_lookup_from_network(context->network);
 	if (!service)
 		return;
 
+	DBG("service %p", service);
+
 	connman_service_create_ip4config(service, index);
 	connman_network_set_ipv4_method(context->network, method);
 
@@ -1054,7 +1058,9 @@ static void add_network(struct modem_data *modem,
 {
 	const char *group;
 
-	DBG("%s", modem->path);
+	DBG("modem %p path %s context %p path %s network %p",
+		modem, modem->path,
+		context, context->path, context->network);
 
 	if (context->network)
 		return;
@@ -1295,10 +1301,14 @@ static gboolean context_changed(DBusConnection *conn,
 	if (!modem)
 		return TRUE;
 
+	DBG("modem %p", modem);
+
 	context = get_context_with_path(modem->context_list, context_path);
 	if (!context)
 		return TRUE;
 
+	DBG("context %p", context);
+
 	if (!dbus_message_iter_init(message, &iter))
 		return TRUE;
 
@@ -1371,6 +1381,8 @@ static gboolean context_changed(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&value, &ip_protocol);
 
+		DBG("%s Protocol %s", modem->path, ip_protocol);
+
 		set_context_ipconfig(context, ip_protocol);
 	}
 
@@ -1520,7 +1532,12 @@ static gboolean cm_context_removed(DBusConnection *conn,
 	if (!modem)
 		return TRUE;
 
+	DBG("modem %p", modem);
+
 	context = get_context_with_path(modem->context_list, context_path);
+
+	DBG("context %p", context);
+
 	remove_cm_context(modem, context);
 
 	return TRUE;
@@ -1772,10 +1789,14 @@ static gboolean cm_changed(DBusConnection *conn, DBusMessage *message,
 	DBusMessageIter iter, value;
 	const char *key;
 
+	DBG("");
+
 	modem = g_hash_table_lookup(modem_hash, path);
 	if (!modem)
 		return TRUE;
 
+	DBG("modem %p modem->ignore %u", modem, modem->ignore);
+
 	if (modem->ignore)
 		return TRUE;
 
@@ -1849,6 +1870,8 @@ static gboolean sim_changed(DBusConnection *conn, DBusMessage *message,
 	if (!modem)
 		return TRUE;
 
+	DBG("modem %p modem->ignore %u", modem, modem->ignore);
+
 	if (modem->ignore)
 		return TRUE;
 
@@ -1860,6 +1883,8 @@ static gboolean sim_changed(DBusConnection *conn, DBusMessage *message,
 	dbus_message_iter_next(&iter);
 	dbus_message_iter_recurse(&iter, &value);
 
+	DBG("key %s", key);
+
 	if (g_str_equal(key, "SubscriberIdentity")) {
 		sim_update_imsi(modem, &value);
 		try_create_device(modem);
@@ -1943,9 +1968,10 @@ static void modem_update_interfaces(struct modem_data *modem,
 				uint8_t old_ifaces,
 				uint8_t new_ifaces)
 {
-	DBG("%s", modem->path);
+	DBG("modem %p path %s", modem, modem->path);
 
 	if (api_added(old_ifaces, new_ifaces, OFONO_API_SIM)) {
+		DBG("modem->imsi %p modem->set_powered %u", modem->imsi, modem->set_powered);
 		if (!modem->imsi &&
 				!modem->set_powered) {
 			/*
@@ -1957,6 +1983,7 @@ static void modem_update_interfaces(struct modem_data *modem,
 	}
 
 	if (api_added(old_ifaces, new_ifaces, OFONO_API_CM)) {
+		DBG("modem->device %p", modem->device);
 		if (modem->device) {
 			cm_get_properties(modem);
 			cm_get_contexts(modem);
-- 
2.45.0


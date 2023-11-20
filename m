Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455938FBC
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9147273108
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:38 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4A14F73145
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] service: Document '{clear,set}_error'.
Date: Mon, 20 Nov 2023 13:53:29 -0800
Message-ID: <20231120215329.786768-3-gerickson@nuovations.com>
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

This adds documentation to the '{clear,set}_error' functions.
---
 src/service.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/src/service.c b/src/service.c
index b30e75b9ac13..85315548c2fe 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4650,6 +4650,24 @@ static DBusMessage *set_property(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+/**
+ *  @brief
+ *    Set the specified network service "Error" property.
+ *
+ *  This sets the specified network service "Error" property to the
+ *  provided value.
+ *
+ *  @note
+ *    This function results in a D-Bus property changed signal for the
+ *    network service "Error" property.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to set the "Error" property.
+ *  @param[in]      error    The error value to set.
+ *
+ *  @sa clear_error
+ *
+ */
 static void set_error(struct connman_service *service,
 					enum connman_service_error error)
 {
@@ -4676,6 +4694,25 @@ static void set_error(struct connman_service *service,
 				DBUS_TYPE_STRING, &str);
 }
 
+/**
+ *  @brief
+ *    Clear or reset the specified network service "Error" property.
+ *
+ *  This sets the specified network service "Error" property to the
+ *  initialization value of #CONNMAN_SERVICE_ERROR_UNKNOWN,
+ *  effectively clearing or resetting the property.
+ *
+ *  @note
+ *    This function results in a D-Bus property changed signal for the
+ *    network service "Error" property.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to clear or reset the "Error"
+ *                           property.
+ *
+ *  @sa set_error
+ *
+ */
 static void clear_error(struct connman_service *service)
 {
 	set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);
-- 
2.42.0


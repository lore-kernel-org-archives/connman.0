Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8778462
	for <connman@lists.linux.dev>; Sat,  7 Jan 2023 21:50:36 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id h26so5097942qtu.2
        for <connman@lists.linux.dev>; Sat, 07 Jan 2023 13:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLkBWHYpVeK1ModDh28jklcmCdwzkdB2oQT7ug02cvE=;
        b=KT6RRLQdCFUlqAVulthw3B8HnRjA27dE/+8Pt5S5vy6DZAV56G6lJ3D05wNZ6Tq8Y3
         vOgJ6oDjUfFQ+cIUibcj2owcDwspRshdV9GN+6WDHpUQPXP7VU9mTlYaAF4RDugxAoVh
         hVMNPJCtvwoCp7NSY+ruuj6ks3Q7xM3scChUmUCOrzVO8xon8w31YlSC4YRRiOytTgqb
         /DJhztywLuab/T9/3q43T2vaMlAlFOUIXsepsyw8m+Ppsrcj+4EpAqBhlcxnvfaHxPxC
         lJ9Nmuat1/RjlxzLU0mk5zOK7nM+gIxbhFS81p0ITwl/ZZHurn1taYQiP/uDeshClsex
         e3JQ==
X-Gm-Message-State: AFqh2koxEzlCZlZPsN9x96kN7OFM9kP7hBpX8yqUpgAiKTqpPnGkdYuJ
	AGFvXbspTHyvTOw5Q2KZl+0NAO7a45CLZgb9XfyCgHuP
X-Google-Smtp-Source: AMrXdXvWKsqiHGhC2n9J4qrGZeuSgjUzDRhGnYUOjFugD7SJr96tjFo1X2KL+CIfhGXMbZqlofEtBg==
X-Received: by 2002:ac8:760d:0:b0:3a5:a2f7:36aa with SMTP id t13-20020ac8760d000000b003a5a2f736aamr77570374qtq.44.1673128235270;
        Sat, 07 Jan 2023 13:50:35 -0800 (PST)
Received: from localhost ([45.42.73.38])
        by smtp.gmail.com with ESMTPSA id x8-20020ac81208000000b003999d25e772sm2350893qti.71.2023.01.07.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 13:50:35 -0800 (PST)
From: lists@jade.fyi
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>,
	Jade Lovelace <lists@jade.fyi>
Subject: [PATCH 1/3] plugins/iwd: Rename autoconnect fields to clarify meaning
Date: Sat,  7 Jan 2023 16:50:21 -0500
Message-Id: <20230107215023.8288-2-lists@jade.fyi>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107215023.8288-1-lists@jade.fyi>
References: <20230107215023.8288-1-lists@jade.fyi>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jade Lovelace <lists@jade.fyi>

Signed-off-by: Jade Lovelace <lists@jade.fyi>
---
 plugins/iwd.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 485e0661..5593fa74 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -96,7 +96,7 @@ struct iwd_network {
 	struct iwd_device *iwdd;
 	struct connman_network *network;
 	/* service's autoconnect */
-	bool autoconnect;
+	bool cm_autoconnect;
 };
 
 struct iwd_known_network {
@@ -106,11 +106,11 @@ struct iwd_known_network {
 	char *type;
 	bool hidden;
 	char *last_connected_time;
-	bool auto_connect;
+	bool iwd_auto_connect;
 	int auto_connect_id;
 
 	/* service's autoconnect */
-	bool autoconnect;
+	bool cm_autoconnect;
 };
 
 struct iwd_station {
@@ -246,7 +246,7 @@ static void cm_network_connect_cb(DBusMessage *message, void *user_data)
 					"net.connman.iwd.InvalidFormat"))
 			connman_network_set_error(iwdn->network,
 					CONNMAN_NETWORK_ERROR_INVALID_KEY);
-		else if (!iwdn->autoconnect)
+		else if (!iwdn->cm_autoconnect)
 			connman_network_set_error(iwdn->network,
 					CONNMAN_NETWORK_ERROR_CONNECT_FAIL);
 		return;
@@ -474,25 +474,25 @@ static int enable_auto_connect(struct iwd_known_network *iwdkn)
 
 static int update_auto_connect(struct iwd_known_network *iwdkn)
 {
-	DBG("auto_connect %d autoconnect %d", iwdkn->auto_connect, iwdkn->autoconnect);
+	DBG("iwd_auto_connect %d cm_autoconnect %d", iwdkn->iwd_auto_connect, iwdkn->cm_autoconnect);
 
-	if (iwdkn->auto_connect == iwdkn->autoconnect)
+	if (iwdkn->iwd_auto_connect == iwdkn->cm_autoconnect)
 		return -EALREADY;
 
-	if (iwdkn->autoconnect)
+	if (iwdkn->cm_autoconnect)
 		return enable_auto_connect(iwdkn);
 	return disable_auto_connect(iwdkn);
 }
 
 static int cm_network_set_autoconnect(struct connman_network *network,
-				bool autoconnect)
+				bool cm_autoconnect)
 {
 	struct iwd_network *iwdn = connman_network_get_data(network);
 	struct iwd_known_network *iwdkn;
 
-	DBG("autoconnect %d", autoconnect);
+	DBG("cm_autoconnect %d", cm_autoconnect);
 
-	iwdn->autoconnect = autoconnect;
+	iwdn->cm_autoconnect = cm_autoconnect;
 
 	if (!iwdn->known_network)
 		return -ENOENT;
@@ -501,7 +501,7 @@ static int cm_network_set_autoconnect(struct connman_network *network,
 	if (!iwdkn)
 		return -ENOENT;
 
-	iwdkn->autoconnect = autoconnect;
+	iwdkn->cm_autoconnect = cm_autoconnect;
 
 	return update_auto_connect(iwdkn);
 }
@@ -1679,12 +1679,12 @@ static void known_network_property_change(GDBusProxy *proxy, const char *name,
 		return;
 
 	if (!strcmp(name, "AutoConnect")) {
-		dbus_bool_t auto_connect;
+		dbus_bool_t iwd_auto_connect;
 
-		dbus_message_iter_get_basic(iter, &auto_connect);
-		iwdkn->auto_connect = auto_connect;
+		dbus_message_iter_get_basic(iter, &iwd_auto_connect);
+		iwdkn->iwd_auto_connect = iwd_auto_connect;
 
-		DBG("%p auto_connect %d", path, iwdkn->auto_connect);
+		DBG("%s iwd_auto_connect %d", path, iwdkn->iwd_auto_connect);
 
 		update_auto_connect(iwdkn);
 	}
@@ -1708,7 +1708,7 @@ static void init_auto_connect(struct iwd_known_network *iwdkn)
 		if (iwdkn != kn)
 			continue;
 
-		iwdkn->autoconnect = iwdn->autoconnect;
+		iwdkn->cm_autoconnect = iwdn->cm_autoconnect;
 		update_auto_connect(iwdkn);
 		return;
 	}
@@ -1736,11 +1736,11 @@ static void create_know_network(GDBusProxy *proxy)
 	iwdkn->hidden = proxy_get_bool(proxy, "Hidden");
 	iwdkn->last_connected_time =
 		g_strdup(proxy_get_string(proxy, "LastConnectedTime"));
-	iwdkn->auto_connect = proxy_get_bool(proxy, "AutoConnect");
+	iwdkn->iwd_auto_connect = proxy_get_bool(proxy, "AutoConnect");
 
-	DBG("name '%s' type %s hidden %d, last_connection_time %s auto_connect %d",
+	DBG("name '%s' type %s hidden %d, last_connection_time %s iwd_auto_connect %d",
 		iwdkn->name, iwdkn->type, iwdkn->hidden,
-		iwdkn->last_connected_time, iwdkn->auto_connect);
+		iwdkn->last_connected_time, iwdkn->iwd_auto_connect);
 
 	init_auto_connect(iwdkn);
 
-- 
2.38.1


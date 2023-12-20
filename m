Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9A4123E
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="CGD0udP+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336788cb261so837718f8f.3
        for <connman@lists.linux.dev>; Wed, 20 Dec 2023 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703086974; x=1703691774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJkNV5NErn2wr+Vq8tMb5sLdgjIoZyWiuJsHQa47BXE=;
        b=CGD0udP+oL02RRRu7vc2fjeky77TxhMRzfN90eAe3+RH2af6BI659ORFvBvta/DUxm
         vzDyUMFXp0oev7EkXfkW/NQZaF+r1ZfJI9VfxR/RR1o1S5yxhr1wJxpTKYg1S/gt+e5t
         gVURQY0smqlzdwu2Wse/iX8xXP+/nXVEvlFVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086974; x=1703691774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJkNV5NErn2wr+Vq8tMb5sLdgjIoZyWiuJsHQa47BXE=;
        b=O391eTGLsYQEktB6Y48mu3lvfIV+6q5CvJvrnrb/e6nmbLCpJ/1q/hXr+MabSQj2yy
         b7pVnB6EhUHOuCllc6SS5amCU8Ascrm9aI+EGgLemGhPn9kGoArYsjfsDXk5V/2MCALx
         euSAeX54JbLUI2wMHaB/FHIicMm6zxwc346pM6uc8gUt10gqkyK/ilqce2xD9mPIN8Ao
         xmftVwbqLU6lCYuUuKuXcJKUdiJjpqJJ8FEHB38EG9vmAlYiN0R6CFW/k4H6aM3ogRSt
         iJI7Mkouhfae9oKgjruvT/zU69STLAhEalxbOazYUVnDVA8jTEjkeoSxCdXbvKZ/3a7+
         1Dwg==
X-Gm-Message-State: AOJu0YznLhxtWP4uId2i1yQXytS/4k9XA3M2Da9i55Eq3Xg4O41j4GM6
	bteff/ln+AyLDMqwFDj1P+spD6foxLThxxSelnw=
X-Google-Smtp-Source: AGHT+IHvdD3YrbkSL3DMlxWe1T2GoQ6QBCwXbNAFXf9AK+YFbmWmOET4aiZ7sbBnb63O50VzfUcqnA==
X-Received: by 2002:a5d:64aa:0:b0:336:6a76:40cd with SMTP id m10-20020a5d64aa000000b003366a7640cdmr3406758wrp.62.1703086974041;
        Wed, 20 Dec 2023 07:42:54 -0800 (PST)
Received: from acme-iron-carrot.home ([2a01:14:112:2860:24e1:e1c3:823a:9b45])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b003367433118bsm4327938wrt.78.2023.12.20.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:42:53 -0800 (PST)
From: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
Subject: [PATCH 1/2] add option to omit dhcp client identifier
Date: Wed, 20 Dec 2023 15:42:47 +0000
Message-Id: <20231220154248.91773-2-antonio.oliveira@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* add "OmitClientIdenfier" option to main.conf, which causes the DHCP
  client to not include the option 61 (Client Identifier) in DHCP
  packets.

Signed-off-by: António Oliveira <antonio.oliveira@konsulko.com>
---
 src/dhcp.c | 18 ++++++++++++++++--
 src/main.c | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/src/dhcp.c b/src/dhcp.c
index 18dbab27..d7689ae4 100644
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -61,6 +61,7 @@ struct connman_dhcp {
 	char *dhcp_debug_prefix;
 
 	bool ipv4ll_running;
+	bool omit_client_identifier;
 };
 
 static GHashTable *ipconfig_table;
@@ -209,7 +210,9 @@ static int ipv4ll_start_client(struct connman_dhcp *dhcp)
 					dhcp->ipv4ll_debug_prefix);
 	}
 
-	g_dhcp_client_set_id(ipv4ll_client);
+	if ( !dhcp->omit_client_identifier ) {
+		g_dhcp_client_set_id(ipv4ll_client);
+	}
 
 	if (dhcp->network) {
 		hostname = connman_utsname_get_hostname();
@@ -572,6 +575,7 @@ static int dhcp_initialize(struct connman_dhcp *dhcp)
 	GDHCPClientError error;
 	int index;
 	const char *vendor_class_id;
+	const char *omit_client_id;
 
 	DBG("dhcp %p", dhcp);
 
@@ -588,7 +592,17 @@ static int dhcp_initialize(struct connman_dhcp *dhcp)
 					dhcp->dhcp_debug_prefix);
 	}
 
-	g_dhcp_client_set_id(dhcp_client);
+	omit_client_id = connman_setting_get_string("OmitClientIdentifier");
+	if ( omit_client_id && g_str_equal(omit_client_id,"true" ) ) {
+		dhcp->omit_client_identifier = true;
+	}
+	else {
+		dhcp->omit_client_identifier = false;
+	}
+
+	if ( ! dhcp->omit_client_identifier ) {
+		g_dhcp_client_set_id(dhcp_client);
+	}
 
 	if (dhcp->network) {
 		struct connman_service *service;
diff --git a/src/main.c b/src/main.c
index d2ec8296..7b3d8b17 100644
--- a/src/main.c
+++ b/src/main.c
@@ -107,6 +107,7 @@ static struct {
 	bool persistent_tethering_mode;
 	bool enable_6to4;
 	char *vendor_class_id;
+	char *omit_client_id;
 	bool enable_online_check;
 	bool enable_online_to_ready_transition;
 	char *online_check_ipv4_url;
@@ -139,6 +140,7 @@ static struct {
 	.persistent_tethering_mode = false,
 	.enable_6to4 = false,
 	.vendor_class_id = NULL,
+	.omit_client_id = NULL,
 	.enable_online_check = true,
 	.enable_online_to_ready_transition = false,
 	.online_check_ipv4_url = NULL,
@@ -171,6 +173,7 @@ static struct {
 #define CONF_PERSISTENT_TETHERING_MODE  "PersistentTetheringMode"
 #define CONF_ENABLE_6TO4                "Enable6to4"
 #define CONF_VENDOR_CLASS_ID            "VendorClassID"
+#define CONF_OMIT_CLIENT_ID             "OmitClientIdentifier"
 #define CONF_ENABLE_ONLINE_CHECK        "EnableOnlineCheck"
 #define CONF_ENABLE_ONLINE_TO_READY_TRANSITION "EnableOnlineToReadyTransition"
 #define CONF_ONLINE_CHECK_IPV4_URL      "OnlineCheckIPv4URL"
@@ -204,6 +207,7 @@ static const char *supported_options[] = {
 	CONF_PERSISTENT_TETHERING_MODE,
 	CONF_ENABLE_6TO4,
 	CONF_VENDOR_CLASS_ID,
+	CONF_OMIT_CLIENT_ID,
 	CONF_ENABLE_ONLINE_CHECK,
 	CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
 	CONF_ONLINE_CHECK_IPV4_URL,
@@ -518,6 +522,15 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	string = __connman_config_get_string(config, "General",
+										 CONF_OMIT_CLIENT_ID, &error);
+	if (!error) {
+		connman_settings.omit_client_id = string;
+		connman_info("OMIT_CLIENT_ID: %s\n",string);
+	}
+
+	g_clear_error(&error);
+
 	boolean = __connman_config_get_bool(config, "General",
 					CONF_ENABLE_ONLINE_CHECK, &error);
 	if (!error) {
@@ -843,6 +856,9 @@ char *connman_setting_get_string(const char *key)
 	if (g_str_equal(key, CONF_VENDOR_CLASS_ID))
 		return connman_settings.vendor_class_id;
 
+	if (g_str_equal(key, CONF_OMIT_CLIENT_ID))
+		return connman_settings.omit_client_id;
+
 	if (g_str_equal(key, CONF_ONLINE_CHECK_IPV4_URL))
 		return connman_settings.online_check_ipv4_url;
 
@@ -1146,6 +1162,7 @@ int main(int argc, char *argv[])
 	g_strfreev(connman_settings.blacklisted_interfaces);
 	g_strfreev(connman_settings.tethering_technologies);
 	g_free(connman_settings.vendor_class_id);
+	g_free(connman_settings.omit_client_id);
 	g_free(connman_settings.online_check_ipv4_url);
 	g_free(connman_settings.online_check_ipv6_url);
 	g_free(connman_settings.localtime);
-- 
2.34.1


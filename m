Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E452C83
	for <connman@lists.linux.dev>; Thu,  7 Oct 2021 21:30:31 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id t2so23178319wrb.8
        for <connman@lists.linux.dev>; Thu, 07 Oct 2021 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eEoJr9Nz/PF5PUAy1glMap6kVZ+qbICJ6WmVem1exe0=;
        b=X7/ZzMEflOomuqOwulq9lKq+agbj8M34f1XXhmC9q74bpL1IbfIsOAz6vtrXLu0It0
         J9DENTygOBsQbRmEeuCFgDj7OyafIfI1Y7tzUb2dOpNUEgja6GC8U7UIqmLH4aGuYdCh
         rRWs3+6ilX8Nv59VqNXis0fTDSyRM0yEZfg4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEoJr9Nz/PF5PUAy1glMap6kVZ+qbICJ6WmVem1exe0=;
        b=zSgcGM+7vitgyFzRwltQCGU06LnDO4t575eDK89LexfQug7mwdVtm6pIIJjJPoyQ5H
         gJO5K8USMRv5WChDRnd4mvBFxPNA52dJ7JJC2T4BagsdnRkhY5r3e7lOXacDpD7IT4t3
         qR3jDv35rPJB7Vul0LHL/rStxTaMjAYmHG3uKk012r5dE2iE0GCEfvn3DuOzQu4Vfkod
         zdspw3u5xaIm/9eQpry/KL/lmhZDtljHND3RafzfsMpkWxXRsC3nfGDQivzyfveLElk5
         i19PTSlcB3m3Jpw4zP2dtRFpj4SOZW70OOq72XnSDWxgxWruBX1gv33Jcd+AUE6LqFTg
         0zcA==
X-Gm-Message-State: AOAM533DOTGsgaKNqKGo1gv/IfOD+pdSD37oaVw2Y0LtwzIEeuIp8Kfj
	IgKAPZQpX9OOjuGXq4zU2BKOxujVjYuKe9yn
X-Google-Smtp-Source: ABdhPJx++bKypBIoktCLcmDD/SYUt1+T0Fswk5Dhm+fs+JqmN33S30QCUsHMSUMev+a5OfEraRZHvA==
X-Received: by 2002:adf:a292:: with SMTP id s18mr8466487wra.42.1633642229182;
        Thu, 07 Oct 2021 14:30:29 -0700 (PDT)
Received: from localhost.localdomain ([109.52.197.122])
        by smtp.gmail.com with ESMTPSA id a17sm497068wrx.33.2021.10.07.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:30:28 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 4/4] client: Update the connmactl to support optional tethering channel
Date: Thu,  7 Oct 2021 23:30:21 +0200
Message-Id: <20211007213021.58712-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007213021.58712-1-michael@amarulasolutions.com>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tethring frequency is added as an option to activate the access
point.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 client/commands.c | 60 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/client/commands.c b/client/commands.c
index 94c375dd..53cc14c8 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -550,20 +550,23 @@ struct tether_properties {
 	int ssid_result;
 	int passphrase_result;
 	int set_tethering;
+	int freq_result;
 };
 
 static int tether_update(struct tether_properties *tether)
 {
 	int ret;
 
-	if (tether->ssid_result == 0 && tether->passphrase_result == 0) {
+	if (tether->ssid_result == 0 && tether->passphrase_result == 0 &&
+			tether->freq_result == 0) {
 		ret = tether_set("wifi", tether->set_tethering);
 		g_free(tether);
 		return ret;
 	}
 
 	if (tether->ssid_result != -EINPROGRESS &&
-			tether->passphrase_result != -EINPROGRESS) {
+			tether->passphrase_result != -EINPROGRESS &&
+			tether->freq_result != -EINPROGRESS) {
 		g_free(tether);
 		return 0;
 	}
@@ -603,9 +606,25 @@ static int tether_set_passphrase_return(DBusMessageIter *iter, int errnum,
 	return tether_update(tether);
 }
 
-static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering)
+static int tether_set_freq_return(DBusMessageIter *iter, int errnum,
+				  const char *error, void *user_data)
 {
-	struct tether_properties *tether = g_new(struct tether_properties, 1);
+	struct tether_properties *tether = user_data;
+
+	if (!error) {
+		fprintf(stdout, "Wifi access point frequency set\n");
+		tether->freq_result = 0;
+	} else {
+		fprintf(stderr, "Error setting wifi frequency: %s\n", error);
+		tether->freq_result = -EINVAL;
+	}
+
+	return tether_update(tether);
+}
+
+static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering, int freq)
+{
+	struct tether_properties *tether = g_new0(struct tether_properties, 1);
 
 	tether->set_tethering = set_tethering;
 
@@ -621,8 +640,17 @@ static int tether_set_ssid(char *ssid, char *passphrase, int set_tethering)
 			tether_set_passphrase_return, tether,
 			"TetheringPassphrase", DBUS_TYPE_STRING, &passphrase);
 
+	if (freq > 0) {
+		tether->freq_result =__connmanctl_dbus_set_property(connection,
+				"/net/connman/technology/wifi",
+				"net.connman.Technology",
+				tether_set_freq_return, tether,
+				"TetheringFreq", DBUS_TYPE_INT32, &freq);
+	}
+
 	if (tether->ssid_result != -EINPROGRESS &&
-			tether->passphrase_result != -EINPROGRESS) {
+			tether->passphrase_result != -EINPROGRESS &&
+			tether->freq_result != -EINPROGRESS) {
 		g_free(tether);
 		return -ENXIO;
 	}
@@ -638,24 +666,30 @@ static int cmd_tether(char *args[], int num, struct connman_option *options)
 	if (num < 3)
 		return -EINVAL;
 
-	passphrase = args[num - 1];
-	ssid = args[num - 2];
-
 	set_tethering = parse_boolean(args[2]);
 
 	if (strcmp(args[1], "wifi") == 0) {
+		int freq = 0;
 
-		if (num > 5)
+		if (num > 6)
 			return -E2BIG;
 
-		if (num == 5 && set_tethering == -1)
+		if (num >= 5 && set_tethering == -1)
 			return -EINVAL;
 
 		if (num == 4)
 			set_tethering = -1;
 
+		if (num == 6) {
+			freq = atoi(args[num - 1]);
+			num --;
+		}
+
+		passphrase = args[num - 1];
+		ssid = args[num - 2];
+
 		if (num > 3)
-			return tether_set_ssid(ssid, passphrase, set_tethering);
+			return tether_set_ssid(ssid, passphrase, set_tethering, freq);
 	}
 
 	if (num > 3)
@@ -1425,7 +1459,6 @@ static void monitor_del(char *interface)
 	int i;
 	char *rule;
 
-
 	for (i = 0; monitor[i].interface; i++) {
 		if (g_strcmp0(interface, monitor[i].interface) == 0) {
 			if (monitor[i].enabled == false)
@@ -1811,7 +1844,6 @@ static int session_connect_cb(DBusMessageIter *iter, int errnum,
 	return -EINPROGRESS;
 }
 
-
 static int session_connect(void)
 {
 	return __connmanctl_dbus_method_call(connection, "net.connman",
@@ -2768,7 +2800,7 @@ static const struct {
 	  "Disables given technology or offline mode",
 	  lookup_technology_offline },
 	{ "tether", "<technology> on|off\n"
-	            "            wifi [on|off] <ssid> <passphrase> ",
+	            "            wifi [on|off] <ssid> <passphrase> [<freq>] ",
 	                                  NULL,            cmd_tether,
 	  "Enable, disable tethering, set SSID and passphrase for wifi",
 	  lookup_tether },
-- 
2.25.1


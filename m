Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989F3C2B81
	for <connman@lists.linux.dev>; Tue, 12 May 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600212; cv=none; b=bpP1geDSu/+FMqlslXbR+TqOP2v0duxAtJ0zD8G6qwGlAO3KZFdXZ3o5NBB1e1npnT19OnunX21Fjhfg6xKezcIVUWZ4lHPKuakhC82OtO/x0exsroHObcz9k3zd6+oB97maz3ZIb7N0tn6vBppKA/mXkCD27ITBCTQ+4qBfiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600212; c=relaxed/simple;
	bh=A8rKYPTesDMvpG3IpgjS9Zkb4zvGPI79Xu38lZ6lOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la7nw/5V4s7ZjnJi6J/XH0mVIZ3iSEe0WpKbpHPJ6CpD1Qa7mTm1MY66Iz6zGq22rn9Hv7r+LBPrrrS9U4hJtcHpxOWBxHcTCQP2SabtXEwSv9OHZpdlD40aepN3arJlDR7dWm5oDX4ZtY4mj6R92rIFoenMaQkNjWb/7e+jkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=MVGztH+e; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="MVGztH+e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3HW9KEvOaqrnKxm/vN0C8DQQXhi7i2zDjXjkxg4AJeA=; b=MVGztH+eKmi288wK62NCkP+eAg
	NKGOZXXjn3KUBGuwnK33QzBLinNVU61MOhk11BJNWWs1zc+xf2TJz9TA5xY7N1W4fvM72FOEEJ+KL
	B/DIav3DLXiAGxkPv2xv0ExQHzhw7muaWOKBETlf8BHdicQK/cHulHyvCI2YEN0iFW4yXnCsXx8A7
	ohLHCxs+OlIgLnbhTfNTMre1weiwwKVZfd5X0DJS75G0b2cRPmEVrF8Mr/XQLZ8aKapGsg72mvG65
	25YOPeTzOzoyWXljOtnjW86O7lR1bEj26aAbP/t2snMuxtB0pjwkenlhMrC2zTsinJlG8MbSj2xnX
	Y8oksk2Q==;
Received: from [2a10:a5c0:37:6500:9c0c:5ab0:fb2a:7a98] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wMpA0-00EZ9d-3C;
	Tue, 12 May 2026 18:36:41 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Simo Piiroinen <simo.piiroinen@jollamobile.com>
Subject: [PATCH 3/3] rtnl: Use FallbackDeviceTypes configuration option
Date: Tue, 12 May 2026 18:36:24 +0300
Message-ID: <20260512153627.443352-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
References: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260512153627.443352-4-jussi.laakkonen@jolla.com

From: Simo Piiroinen <simo.piiroinen@jollamobile.com>

If /sys/class/net/<interface>/uevent file exists but does not specify
DEVTYPE, check whether fallback device type has been defined in main
configuration.

Co-authored-by: Jussi Laakkonen <jussi.laakkonen@jolla.com>
---
 src/rtnl.c | 123 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 72 insertions(+), 51 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index d49ea4d4..0e556a3a 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -116,90 +116,111 @@ static bool wext_interface(char *ifname)
 	return true;
 }
 
-static void read_uevent(struct interface_data *interface)
+static bool read_devtype(const char *filename, char **devtype)
 {
-	char *filename, *name, line[128];
-	bool found_devtype;
-	FILE *f;
+	FILE *file;
+	char buf[128];
 
-	name = connman_inet_ifname(interface->index);
+	*devtype = NULL;
 
-	if (ether_blacklisted(name)) {
-		interface->service_type = CONNMAN_SERVICE_TYPE_UNKNOWN;
-		interface->device_type = CONNMAN_DEVICE_TYPE_UNKNOWN;
-		goto out;
-	} else {
-		interface->service_type = CONNMAN_SERVICE_TYPE_ETHERNET;
-		interface->device_type = CONNMAN_DEVICE_TYPE_ETHERNET;
+	if (!(file = fopen(filename, "re")))
+		return false;
+
+	while (fgets(buf, sizeof(buf), file)) {
+		static const char key[] = "DEVTYPE=";
+		const char *val;
+
+		if (strncmp(buf, key, sizeof(key) - 1))
+			continue;
+
+		val = buf + sizeof(key) - 1;
+		*devtype = g_strndup(val, strcspn(val, "\r\n"));
+
+		break;
 	}
 
-	filename = g_strdup_printf("/sys/class/net/%s/uevent", name);
+	fclose(file);
 
-	f = fopen(filename, "re");
+	return true;
+}
 
-	g_free(filename);
+static void read_uevent(struct interface_data *interface)
+{
+	char *name;
+	char *filename = NULL;
+	char *devtype = NULL;
+
+	interface->service_type = CONNMAN_SERVICE_TYPE_UNKNOWN;
+	interface->device_type = CONNMAN_DEVICE_TYPE_UNKNOWN;
 
-	if (!f) {
-		interface->service_type = CONNMAN_SERVICE_TYPE_UNKNOWN;
-		interface->device_type = CONNMAN_DEVICE_TYPE_UNKNOWN;
+	name = connman_inet_ifname(interface->index);
+
+	if (ether_blacklisted(name))
 		goto out;
-	}
 
-	found_devtype = false;
-	while (fgets(line, sizeof(line), f)) {
-		char *pos;
+	filename = g_strdup_printf("/sys/class/net/%s/uevent", name);
 
-		pos = strchr(line, '\n');
-		if (!pos)
-			continue;
-		pos[0] = '\0';
+	if (!read_devtype(filename, &devtype))
+		goto out;
 
-		if (strncmp(line, "DEVTYPE=", 8) != 0)
-			continue;
+	if (!devtype) {
+		const char *fallback =
+			__connman_setting_get_fallback_device_type(name);
 
-		found_devtype = true;
+		if (fallback) {
+			connman_warn("%s no DEVTYPE, using fallback: %s",
+					name, fallback);
+			devtype = g_strdup(fallback);
+		}
+	}
 
-		if (strcmp(line + 8, "wlan") == 0) {
+	if (devtype) {
+		if (strcmp(devtype, "wlan") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_WIFI;
 			interface->device_type = CONNMAN_DEVICE_TYPE_WIFI;
-		} else if (strcmp(line + 8, "wwan") == 0) {
+		} else if (strcmp(devtype, "wwan") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_CELLULAR;
 			interface->device_type = CONNMAN_DEVICE_TYPE_CELLULAR;
-		} else if (strcmp(line + 8, "bluetooth") == 0) {
+		} else if (strcmp(devtype, "bluetooth") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_BLUETOOTH;
 			interface->device_type = CONNMAN_DEVICE_TYPE_BLUETOOTH;
-		} else if (strcmp(line + 8, "gadget") == 0) {
+		} else if (strcmp(devtype, "gadget") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_GADGET;
 			interface->device_type = CONNMAN_DEVICE_TYPE_GADGET;
-		} else if (strcmp(line + 8, "vlan") == 0) {
+		} else if (strcmp(devtype, "vlan") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_ETHERNET;
 			interface->device_type = CONNMAN_DEVICE_TYPE_ETHERNET;
-		} else if (strcmp(line + 8, "bond") == 0) {
+		} else if (strcmp(devtype, "bond") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_ETHERNET;
 			interface->device_type = CONNMAN_DEVICE_TYPE_ETHERNET;
-		} else if (strcmp(line + 8, "dsa") == 0) {
+		} else if (strcmp(devtype, "dsa") == 0) {
 			interface->service_type = CONNMAN_SERVICE_TYPE_ETHERNET;
 			interface->device_type = CONNMAN_DEVICE_TYPE_ETHERNET;
 		} else {
-			interface->service_type = CONNMAN_SERVICE_TYPE_UNKNOWN;
-			interface->device_type = CONNMAN_DEVICE_TYPE_UNKNOWN;
+			connman_warn("%s DEVTYPE=%s not supported, ignoring",
+					name, devtype);
+		}
+	} else {
+		/*
+		 * We haven't got a DEVTYPE, let's check if it's a wireless
+		 * device
+		 */
+		if (wext_interface(name)) {
+			interface->service_type = CONNMAN_SERVICE_TYPE_WIFI;
+			interface->device_type = CONNMAN_DEVICE_TYPE_WIFI;
+			connman_error("%s runs an unsupported 802.11 driver",
+					name);
+		} else {
+			interface->service_type = CONNMAN_SERVICE_TYPE_ETHERNET;
+			interface->device_type = CONNMAN_DEVICE_TYPE_ETHERNET;
+			connman_warn("%s no DEVTYPE, defaulting to ethernet",
+					name);
 		}
-	}
-
-	fclose(f);
-
-	if (found_devtype)
-		goto out;
-
-	/* We haven't got a DEVTYPE, let's check if it's a wireless device */
-	if (wext_interface(name)) {
-		interface->service_type = CONNMAN_SERVICE_TYPE_WIFI;
-		interface->device_type = CONNMAN_DEVICE_TYPE_WIFI;
-
-		connman_error("%s runs an unsupported 802.11 driver", name);
 	}
 
 out:
+	g_free(devtype);
+	g_free(filename);
 	g_free(name);
 }
 
-- 
2.47.3


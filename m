Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82874962D
	for <connman@lists.linux.dev>; Fri,  5 Jul 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720152134; cv=none; b=FdNstl5YUnRAxeEIhCuojd+yjI507rvktgnDZ+97Kzo7VDFy7e7TzP9Q6jwpIoC0q3M+k4QYbIkaXOLXw5IXVDSvvw6i9EIHiUD7RAmLpddkF4Vj3KNHhJgWVmddXUgvL0n/J38mOxJqxUjrPoXStnBdFRNtlvIQlJayGtAvlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720152134; c=relaxed/simple;
	bh=P5p3HBrZ1x7dfPlpnmAfRzRP+hTHOIFU8/wsfRY/Vmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rf/3UOJSKGAP/X6aT8D3AdWONq7WfZiLElIBNF1TMyczQ1xytuZbdVK19f9MASmwroReir8VF9pwkUB2xuGnNOp8G1cbjePqUhEgYLGo/vRQ99gm8dwtMB7taaTc9vtZeGiSaDgW9SmA3MZB5zznbexs8UyJpUtpd4vuyj6nALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=i+91hPOc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="i+91hPOc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so10598365e9.2
        for <connman@lists.linux.dev>; Thu, 04 Jul 2024 21:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1720152131; x=1720756931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbUwn+IxwHBz3JOnwJfpKPuCScGFISe0HWftX+7Aa74=;
        b=i+91hPOc9ehbo7D0BNfAw/o5GA8eCw89cApjqwjmCzPVMuCqml7e2f7Tb5BBR2XlhI
         dTNuN0RTW8GJZKnoj8ndpk4Ub/2GRHw8nkLB+Rs7ITUs4+RSYfCw1wj+YzOUw7GS5Qdb
         k2rpYZx/BQSIESys5hbR4ilpNe+JKHSA0tFp7uqFeEVbP7d3o5NLtNuyHYQkdj91psPg
         5WXRsSz9S7zSYvVBCf/lj8jWTDi8eEceaqClaPe91KxzJ9FgTwlQI7mDFcPVSQxC/kfN
         anDiODCW/37IRUIq9AyUQRemSY/7xmqI6nIti4islG1CQQsFpU6fq3T1/0p7ZceZE3Ld
         rWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720152131; x=1720756931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbUwn+IxwHBz3JOnwJfpKPuCScGFISe0HWftX+7Aa74=;
        b=DOR93UyAPZK5OubMjEVHhcLQYWpzNzF43aL2WLwmiGSePQy1CApCl1czW5qZJsPziT
         Mw+B2OVzJPw5ic3NvruZP9W0N+EtPpomuDMor01UbPaG4cNZbsJlznOv0WRfe0a27BiW
         Mnp/dS7rHBM0/enX5+tnN9Ov3n0LxEj2BHv3T6OjXYXInjuf8ibCZukb5cNRzZ2FJwTl
         ln1nKGajIbeAG+u1WWGeD207McxcEb7ssCJ6kI/dXxeLU5vKVJgE65D4rT6vdo65WBuT
         KSPVnUbNhG86UB1ma/lgAtgxTUJ4D2yfFnj/90nJyIV4GQmgjiCCSFpAGkXBuW9+KnX/
         d3ow==
X-Gm-Message-State: AOJu0YwdgI6in+c82Mx1gA0iipWi10nIr1I1dg5YZhEzNbDyXltbZ4ZS
	fBFBZvE+qx1Zt6BNi6p2cR4lTRz2w0l0m9cEKVdP12339l+RqWNzTBWVjQEiyMU0BiYh9mffAbt
	qZPi00g==
X-Google-Smtp-Source: AGHT+IELVPVuiscCNuqG2DyXCQ/cxC8DWBR3TzA53fMmp9Gd3TCQey6OPZJvm31OWbcZqtUyZKmeTw==
X-Received: by 2002:a05:600c:1688:b0:424:90f4:309d with SMTP id 5b1f17b1804b1-4264a3bd946mr26369145e9.8.1720152130742;
        Thu, 04 Jul 2024 21:02:10 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dd902sm45686095e9.12.2024.07.04.21.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 21:02:10 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: connman@lists.linux.dev
Cc: Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2] manager: add support for changing 'PreferredTechnologies' over DBus
Date: Fri,  5 Jul 2024 07:02:03 +0300
Message-ID: <20240705040204.58337-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds support for reading/modifying the 'PreferredTechnologies'
over DBus.
This can be extended to 'DefaultAutoConnectTechnologies',
'DefaultFavoriteTechnologies' & 'AlwaysConnectedTechnologies' as well.
However the interest (so far) was in changing the 'PreferredTechnologies'
order (at runtime) between cellular and wifi.
Also, 'PreferredTechnologies' was the only that was tested.

Changing 'PreferredTechnologies' seems to yield the desired result, as the
switch between cellular/wifi does not need to be super-fast.
And it changes the routing table (as desired) when cellular is preferred
over WiFi (and vice-versa).

On some boxes that have both cellular & WiFi, it's often desired to prefer
cellular (over WiFi) in case WiFi is not able to connect to the internet.
The logic (for this switching) can be determined outside of connman.
Setting 'PreferredTechnologies' helps in this case.
---

Changelog v1 -> v2:
* v1: https://lore.kernel.org/connman/20240704204732.56553-1-alex@shruggie.ro/
* removed 'tools/ip6tables-test'
  * added to .gitignore via https://lore.kernel.org/connman/20240705035028.57697-1-alex@shruggie.ro/T/#u
* added a bit of documentation in 'src/main.conf' for the 'PreferredTechnologies'
  property now also being accessible over DBus

 doc/connman.conf.5.in |  2 ++
 doc/manager-api.txt   | 13 +++++++++
 include/setting.h     |  2 ++
 src/main.c            | 22 ++++++++++++++
 src/main.conf         |  4 +++
 src/manager.c         | 67 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 3eb240f5..c8ce8eb6 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -101,6 +101,8 @@ with state 'ready' or with a non-preferred type; a service
 of a preferred technology type in state 'online' will get
 the default route when compared to either a non-preferred
 type or a preferred type further down in the list.
+This property can be read and set over DBus as well, on
+the 'net.connman.Manager' DBus interface.
 .TP
 .BI NetworkInterfaceBlacklist= interface\fR[,...]
 List of blacklisted network interfaces separated by ",".
diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 6eaa0a38..3be9cffc 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -319,3 +319,16 @@ Properties	string State [readonly]
 			and does not affect ConnMan in any way.
 
 			The default value is false.
+
+		array{string} PreferredTechnologies [readwrite] [experminental]
+
+			This property is the same one that is defined in
+			/etc/connman/main.conf. It controls the order of
+			preferred technologies (e.g. wifi, cellular) at
+			runtime.
+			Changing it here will not have an immediate effect.
+			It's only when connman gets triggered via service changes
+			that this gets taken into consideration. Or, when it's
+			triggered via manual connect/disconnect of services.
+
+			The default value is defined in /etc/connman/main.conf.
diff --git a/include/setting.h b/include/setting.h
index 920e6754..6a575dc4 100644
--- a/include/setting.h
+++ b/include/setting.h
@@ -33,6 +33,8 @@ unsigned int connman_setting_get_uint(const char *key);
 char *connman_setting_get_string(const char *key);
 char **connman_setting_get_string_list(const char *key);
 unsigned int *connman_setting_get_uint_list(const char *key);
+int connman_setting_set_uint_list(const char *key, const unsigned int *lst,
+                                  int len);
 
 unsigned int connman_timeout_input_request(void);
 unsigned int connman_timeout_browser_launch(void);
diff --git a/src/main.c b/src/main.c
index f5da979b..7858b967 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1122,6 +1122,28 @@ unsigned int *connman_setting_get_uint_list(const char *key)
 	return NULL;
 }
 
+int connman_setting_set_uint_list(const char *key, const unsigned int *lst,
+				  int len)
+{
+	unsigned int *new_list;
+
+	new_list = g_try_new0(unsigned int, len + 1);
+	if (!new_list)
+		return -1;
+
+	memcpy(new_list, lst, sizeof(unsigned int) * len);
+
+	if (g_str_equal(key, CONF_PREFERRED_TECHS)) {
+		g_free(connman_settings.preferred_techs);
+		connman_settings.preferred_techs = new_list;
+		return 0;
+	}
+
+	g_free(new_list);
+
+	return -1;
+}
+
 unsigned int connman_timeout_input_request(void)
 {
 	return connman_settings.timeout_inputreq;
diff --git a/src/main.conf b/src/main.conf
index 5357edb8..80b4fb83 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -60,6 +60,10 @@
 # of a preferred technology type in state 'online' will get
 # the default route when compared to either a non-preferred
 # type or a preferred type further down in the list.
+# This property is also configurable via DBus through the
+# 'net.connman.Manager' & SetProperty method.
+# The GetProperties DBus method will list this property
+# and its current value.
 # PreferredTechnologies =
 
 # List of blacklisted network interfaces separated by ",".
diff --git a/src/manager.c b/src/manager.c
index 892d3a42..62f34c50 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -34,6 +34,27 @@
 static bool connman_state_idle;
 static dbus_bool_t sessionmode;
 
+static const char *tech_property_names[] = {
+	"PreferredTechnologies",
+	NULL,
+};
+
+static void append_tech_list(DBusMessageIter *iter, void *user_data)
+{
+	unsigned int *tech_list = user_data;
+	int i;
+
+	if (!tech_list)
+		return;
+
+	for (i = 0; tech_list[i]; i++) {
+		const char *s = __connman_service_type2string(tech_list[i]);
+		if (!s)
+			continue;
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &s);
+	}
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -41,6 +62,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter array, dict;
 	dbus_bool_t offlinemode;
 	const char *str;
+	int i;
 
 	DBG("conn %p", conn);
 
@@ -64,6 +86,13 @@ static DBusMessage *get_properties(DBusConnection *conn,
 					DBUS_TYPE_BOOLEAN,
 					&sessionmode);
 
+	for (i = 0; tech_property_names[i]; i++) {
+		const char *name = tech_property_names[i];
+		unsigned int *lst = connman_setting_get_uint_list(name);
+		connman_dbus_dict_append_array(&dict, name, DBUS_TYPE_STRING,
+						append_tech_list, lst);
+	}
+
 	connman_dbus_dict_close(&array, &dict);
 
 	return reply;
@@ -110,6 +139,44 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&value, &sessionmode);
 
+	} else if (g_str_equal(name, "PreferredTechnologies")) {
+		unsigned int techs[MAX_CONNMAN_SERVICE_TYPES] = {};
+		DBusMessageIter entry;
+		int cnt;
+
+		if (type != DBUS_TYPE_ARRAY)
+			return __connman_error_invalid_arguments(msg);
+
+		dbus_message_iter_recurse(&value, &entry);
+
+		cnt = 0;
+		while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
+			enum connman_service_type type;
+			const char *val;
+			dbus_message_iter_get_basic(&entry, &val);
+			dbus_message_iter_next(&entry);
+			int i;
+
+			if (!val[0])
+				continue;
+
+			type = __connman_service_string2type(val);
+			if (type == CONNMAN_SERVICE_TYPE_UNKNOWN)
+				return __connman_error_invalid_arguments(msg);
+
+			if (cnt >= MAX_CONNMAN_SERVICE_TYPES)
+				return __connman_error_invalid_arguments(msg);
+
+			/* check for duplicates */
+			for (i = 0; i < cnt; i++) {
+				if (type == techs[i])
+					return __connman_error_invalid_arguments(msg);
+			}
+
+			techs[cnt++] = type;
+		}
+
+		connman_setting_set_uint_list(name, techs, cnt);
 	} else
 		return __connman_error_invalid_property(msg);
 
-- 
2.45.2


Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568C152532
	for <connman@lists.linux.dev>; Wed, 27 Mar 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568624; cv=none; b=TuVe0m6J0zfWuiQmh2MM505UocgLgdcF6g99ufwBaGto6UsgAT/aVWPlxeKWBj3hE9mR4koN/haImJoLGeCEjtr9xo+nc4HDzFYT2Fg+/zvH0dY271DkWFgreaNBKnlgmygRM8bwn2wtPEO31/NuWI6F/CEbogSJb/7YLfJ6XcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568624; c=relaxed/simple;
	bh=dDHi7kAmLPx+GXbha00tQgOwsSE7gWe+gS4Cy7QNfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/R3A9k1sZlhecUF7O5p/zU2bebREdW7o0FYLtdVZGNKAlIY9PtW5mjWrmyGsobGRfIHlOT3KjHuaCJQ/iPDvml+PEy+ttf2oX1VufSRLlqAg2iEWziq94FqSkzlflgYe2KxT0qYrKvSLzo0/WI794GW0VxCZiBgO6ZhDIlnYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvyVdlSg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvyVdlSg"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6a5bd015dso89274a34.2
        for <connman@lists.linux.dev>; Wed, 27 Mar 2024 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568621; x=1712173421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLW1cq8IAVydduF8IBDR8syAndOt+QA00WXnxYOU3p0=;
        b=FvyVdlSgeF5AUuvagyyKGgBc60WGlzpLHx154auTRjeERUqs4BhaMTD8x7IJE6Ot36
         ccg+bumB9TJV6+ZH8YbfSu52XzM7YjLytlHaxg93ezFAQCbCzlVW1fzZ7qr6haY5BX2B
         qQhBbeU4OYr10R+6JFl+B7wZKLPWwi0LMrCi5fA/gUz+0xkHf0qri4gGEH1nqyEFZUcO
         OLh6wQL+lFE28yrGojP/kP5cW3sKtasl76pxuGXjWMPjKOwBNuf8eDsGxTJYPWMNvfQ1
         2Vr6jJHPsGui5Kko+DKI6T3k4dL2pGtijyoBAt1qbuvCNewUW6evV0yrYMW8xtCmaZKK
         ppCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568621; x=1712173421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLW1cq8IAVydduF8IBDR8syAndOt+QA00WXnxYOU3p0=;
        b=mnkAsXxzN7b3AMmL0oXdTNF97z16kVZ1HHqZ0vEq1FPnydv4ZK5nve+HJO/B0exgnf
         Cwq747FldCYgZ/xM4D8Cf8HY+Rog8q4cb7uB74eBJA0pzLR0fNdO/dygbBEvF9/yeb7e
         9aaTDwvhsdIxKdA4Mb+B9KZBriFokdZ4JPR3OnmNK0dClLGljldCZwjlqC4rMU/50Meh
         SM6dXnED1drnqKJ8DCNSrdURZLcOEroBviy3xRxyV7TBciOaxUgwWItmrivwWVW6N/VS
         7UP5D/Pv6YU4LPnukcjgb9LvFePp4Ylq6/9RrpYw0sIZZIDaqPDl2gp9qpXnwDUMfC2v
         muMg==
X-Gm-Message-State: AOJu0YzPVClcPzRCyofuE7aS5RMP92grfHYGSbDJynjkqSjySmJezJhM
	ys64ZhLNbroEpwP9p16SaxvZ4srcI+b1Ja3az3Sj65pja3ZaTI16YvJmVdyr
X-Google-Smtp-Source: AGHT+IGKwZKMKhnK/cNFC5CM1jxjbTEKC6a4peBNcXk0mMnWuN5GSLE5wvhWO+pMBWJz9nCFpjn6RA==
X-Received: by 2002:a05:6870:2386:b0:22a:7c41:8c8d with SMTP id e6-20020a056870238600b0022a7c418c8dmr708394oap.34.1711568621683;
        Wed, 27 Mar 2024 12:43:41 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id f22-20020a056830205600b006e6cb624064sm1876919otp.40.2024.03.27.12.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:43:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] ofono: delay device creation until lte settings are provisioned
Date: Wed, 27 Mar 2024 14:43:35 -0500
Message-ID: <20240327194337.2735677-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327194337.2735677-1-denkenz@gmail.com>
References: <20240327194337.2735677-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For LTE capable devices, successful network registration typically
requires the default attach APN to be configured.  Some carriers will
allow the device to register to the network even if this setting is
empty or missing.  Sometimes devices will utilize carrier specific
settings present on the device itself (such as profiles in modem NVRAM,
etc).  However, there may be situations where missing default
attach APN settings preclude successful registration, or registration is
performed with an incorrect profile.

Currently ConnMan does not take oFono's LTE support into consideration
when setting the modem 'Online'.  This can result in the modem
attempting registration too early, when the default attach settings have
not been applied.

oFono has recently introduced Modem.Capabilities property which can
provide an early hint whether the modem is LTE capable.  If the modem
is LTE capable, then ConnMan should wait until oFono LongTermEvolution
interface is available (and thus default attach settings have been
applied) prior to setting the device 'Online'.
---
 plugins/ofono.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index ad85c55d3df3..062905c8a3a6 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -52,6 +52,7 @@
 #define OFONO_NETREG_INTERFACE		OFONO_SERVICE ".NetworkRegistration"
 #define OFONO_CM_INTERFACE		OFONO_SERVICE ".ConnectionManager"
 #define OFONO_CONTEXT_INTERFACE		OFONO_SERVICE ".ConnectionContext"
+#define OFONO_LTE_INTERFACE		OFONO_SERVICE ".LongTermEvolution"
 
 #define MODEM_ADDED			"ModemAdded"
 #define MODEM_REMOVED			"ModemRemoved"
@@ -70,6 +71,11 @@ enum ofono_api {
 	OFONO_API_SIM =		0x1,
 	OFONO_API_NETREG =	0x2,
 	OFONO_API_CM =		0x4,
+	OFONO_API_LTE =		0x8,
+};
+
+enum capabilities {
+	LTE_CAPABLE = 0x1,
 };
 
 /*
@@ -137,6 +143,7 @@ struct modem_data {
 	bool powered;
 	bool online;
 	uint8_t interfaces;
+	uint8_t capabilities;
 	bool ignore;
 
 	bool set_powered;
@@ -169,6 +176,8 @@ static const char *api2string(enum ofono_api api)
 		return "netreg";
 	case OFONO_API_CM:
 		return "cm";
+	case OFONO_API_LTE:
+		return "lte";
 	}
 
 	return "unknown";
@@ -730,6 +739,7 @@ static uint8_t extract_interfaces(DBusMessageIter *array)
 		{ .value = OFONO_SIM_INTERFACE, .flag = OFONO_API_SIM },
 		{ .value = OFONO_NETREG_INTERFACE, .flag = OFONO_API_NETREG },
 		{ .value = OFONO_CM_INTERFACE, .flag = OFONO_API_CM },
+		{ .value = OFONO_LTE_INTERFACE, .flag = OFONO_API_LTE },
 	};
 	uint32_t flags;
 
@@ -741,6 +751,21 @@ static uint8_t extract_interfaces(DBusMessageIter *array)
 	return flags;
 }
 
+static uint8_t extract_capabilities(DBusMessageIter *array)
+{
+	static const struct flag_map capabilities_map[] = {
+		{ .value = "lte", .flag = LTE_CAPABLE },
+	};
+	uint32_t flags;
+
+	if (string_list_to_flags(array, capabilities_map,
+					G_N_ELEMENTS(capabilities_map),
+					&flags) < 0)
+		return 0;
+
+	return flags;
+}
+
 static char *extract_nameservers(DBusMessageIter *array)
 {
 	DBusMessageIter entry;
@@ -972,6 +997,9 @@ static bool try_create_device(struct modem_data *modem)
 	if (!modem->imsi)
 		return false;
 
+	if ((modem->capabilities & LTE_CAPABLE) &&
+			!has_interface(modem->interfaces, OFONO_API_LTE))
+		return false;
 
 	/*
 	 * Create the device and register it at the core. Enabling (setting
@@ -1940,6 +1968,9 @@ static void modem_update_interfaces(struct modem_data *modem,
 			netreg_get_properties(modem);
 	}
 
+	if (api_added(old_ifaces, new_ifaces, OFONO_API_LTE))
+		try_create_device(modem);
+
 	if (api_removed(old_ifaces, new_ifaces, OFONO_API_CM)) {
 		if (modem->call_get_contexts) {
 			DBG("cancelling pending GetContexts call");
@@ -2017,6 +2048,9 @@ static gboolean modem_changed(DBusConnection *conn, DBusMessage *message,
 		modem->serial = g_strdup(serial);
 
 		DBG("%s Serial %s", modem->path, modem->serial);
+	} else if (g_str_equal(key, "Capabilities")) {
+		modem->capabilities = extract_capabilities(&value);
+		return TRUE;
 	}
 
 	return TRUE;
@@ -2092,6 +2126,12 @@ static void add_modem(const char *path, DBusMessageIter *prop)
 				DBG("%s Ignore this modem", modem->path);
 				modem->ignore = true;
 			}
+		} else if (g_str_equal(key, "Capabilities")) {
+			modem->capabilities = extract_capabilities(&value);
+
+			DBG("lte capable: %s",
+					modem->capabilities & LTE_CAPABLE ?
+					"yes" : "no");
 		}
 
 		dbus_message_iter_next(prop);
-- 
2.43.0


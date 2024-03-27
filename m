Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A81152532
	for <connman@lists.linux.dev>; Wed, 27 Mar 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568622; cv=none; b=aNPnPptSgvvFRRn4nu++QywiP10g186WO4WSh1kqkL0rgx0fQoFw3CE5UqJ0hPo6pAxYQ20u/qsLD9AL5dlxkTHqFuaSWBYhlc1euDVOoMi+EOxNLeHfQG6fTVnHJlX5IQ/F+G2+11EcIxi0DnrVXV3/1xpy1yTC1W3sW3GYzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568622; c=relaxed/simple;
	bh=XLg4I+lxDqbMJa7JuH8UXWZJu/SVWMvHB32RB7W5L+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sM/GwrqPXGMcA43Ml1+d/LpRBOIhU18f2q1c4P+WWAQI1Y/mdj6Ns+li7I3XzWWeMQauCzVYhm34GdOH+dkJwZf8rJmjMI9B4qmCJEJULkTmVFzbs9ba6ot5QSva/AWE+IH3pA8dw8fykbAOoMnf8IGBoVttNgoOwS3C87d3V3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxYjUeAS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxYjUeAS"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6888358dfso106137a34.2
        for <connman@lists.linux.dev>; Wed, 27 Mar 2024 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568619; x=1712173419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cr/lDZKJfxyhqipGWzxhm7njoKXqpNlMhjaYtrvzLik=;
        b=FxYjUeASu2i8w2rFHFG/iuDGaO/OO7lYfqY2O0FEI2iDG2Jspkp+kgGODq2gtVu8zc
         Jkmx7dZTXuYtiJho8s9C9r8+VKo6q1MgBbo3cMBiWq0PtZqURDoxCULsqyBxt7rZkaTh
         H5Z1vK8r+9+KLWS5P61cHmrKf3gFYCZ1r/LVolgQiwk2CA7XfsRwkK5FM2yxpwTizB58
         5MKFsCGz63RGpkS+LQUJhvGs7P4z5a0yVd7rBnSI9PVB0AR7fon1NAq2gKzcevhGeBWh
         3Sq7QUVFpPZ9SNt4Npw6nrUc7r/VPpcNHQNYV+DrR7ECfwY5pS2sTBkywefoB8qErnMC
         +97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568619; x=1712173419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cr/lDZKJfxyhqipGWzxhm7njoKXqpNlMhjaYtrvzLik=;
        b=cWGdeIUb8/32qBrhMJNsIQ1x0bU8tRLz5CKShulaAYCGPTy/EvTz/iH999T+2Vov21
         KYspD0GT+CYxSiVR9XvUSOqSTNbj3DArJPUVofOMVH9sWORtXsTtzY+BOtD9tqOGGT6E
         CzaJof9DzDcMY/P8cWEdQ67LmGFOYPMeZ72WN6aKQ9XLfyszyTwEJlYnjGJuae6Ng04+
         2nUnLCqOSrBjYF5SNo2l3hU/UGU468C5iuoxB5+TgDRzMeEC5i5lTV6LDelpisLyLK6b
         l1aOEgq7MqkqT9gOV8jXTP9Wx7z/i1NHR4EMLTiJSBhRPiStRhFql/PdQuiJLwO28Yqb
         f0aA==
X-Gm-Message-State: AOJu0YxAGD7O8l2klHMpCp1YtOiR3VvTQ8ULr3sWI5GReAVyNsrJQkfJ
	oRzm9kQBDV+FnxsDmuUyUEynz2p1ErY3ejTj+dDEMGC2AaIJ3R5vwal4cBlf
X-Google-Smtp-Source: AGHT+IF4r28q2JaRhPf0F5sj7pvhnKN9F2Ty2x7KqSyFPwBnpMjv2Anx9aZoMJjxfXZ98V7OoSy3Pg==
X-Received: by 2002:a05:6870:f685:b0:22a:5423:45fc with SMTP id el5-20020a056870f68500b0022a542345fcmr756000oab.11.1711568619565;
        Wed, 27 Mar 2024 12:43:39 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id f22-20020a056830205600b006e6cb624064sm1876919otp.40.2024.03.27.12.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:43:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] ofono: Add generic method to convert a list of strings to flags
Date: Wed, 27 Mar 2024 14:43:32 -0500
Message-ID: <20240327194337.2735677-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oFono D-Bus APIs are string based, with several string list based
properties that convey information that might require tracking.  For
example:
	- Interfaces -> list of interfaces supported
	- Features -> list of features supported
	- Capabilities -> modem capabilities

Introduce a new convenience method that can be used to convert such
string lists to a set of flags (bitmap).  Make extract_interfaces()
use it.  While here, tighten up error checking and do not attempt to
parse non-string list signatures.
---
 plugins/ofono.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 65a722fd85d6..1906843335cf 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -685,29 +685,60 @@ static bool has_interface(uint8_t interfaces,
 	return false;
 }
 
-static uint8_t extract_interfaces(DBusMessageIter *array)
+struct flag_map {
+	const char *value;
+	uint32_t flag;
+};
+
+static int string_list_to_flags(DBusMessageIter *array,
+				const struct flag_map *map, size_t map_len,
+				uint32_t *out_flags)
 {
 	DBusMessageIter entry;
-	uint8_t interfaces = 0;
+	uint32_t flags = 0;
+
+	if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	if (dbus_message_iter_get_element_type(array) != DBUS_TYPE_STRING)
+		return -EINVAL;
 
 	dbus_message_iter_recurse(array, &entry);
 
 	while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
+		size_t i;
 		const char *name;
 
 		dbus_message_iter_get_basic(&entry, &name);
 
-		if (g_str_equal(name, OFONO_SIM_INTERFACE))
-			interfaces |= OFONO_API_SIM;
-		else if (g_str_equal(name, OFONO_NETREG_INTERFACE))
-			interfaces |= OFONO_API_NETREG;
-		else if (g_str_equal(name, OFONO_CM_INTERFACE))
-			interfaces |= OFONO_API_CM;
+		for (i = 0; i < map_len; i++)
+			if (!strcmp(name, map[i].value))
+				flags |= map[i].flag;
 
 		dbus_message_iter_next(&entry);
 	}
 
-	return interfaces;
+	if (out_flags)
+		*out_flags = flags;
+
+	return 0;
+}
+
+static uint8_t extract_interfaces(DBusMessageIter *array)
+{
+	static const struct flag_map interfaces_map[] = {
+		{ .value = OFONO_SIM_INTERFACE, .flag = OFONO_API_SIM },
+		{ .value = OFONO_NETREG_INTERFACE, .flag = OFONO_API_NETREG },
+		{ .value = OFONO_CM_INTERFACE, .flag = OFONO_API_CM },
+	};
+	uint32_t flags;
+
+	if (string_list_to_flags(array, interfaces_map,
+					G_N_ELEMENTS(interfaces_map),
+					&flags) < 0)
+		return 0;
+
+	return flags;
 }
 
 static char *extract_nameservers(DBusMessageIter *array)
-- 
2.43.0


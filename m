Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A4A41
	for <connman@lists.linux.dev>; Mon, 18 Apr 2022 19:40:50 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id 12so13142820pll.12
        for <connman@lists.linux.dev>; Mon, 18 Apr 2022 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QktCCkNvyH9627eyOkoHu2l1zpEaEm+gRKyrHwv3p60=;
        b=chyeA22jCoGfdidQqt3U2fJRsIrO3OhRnSFp3rgZa3KyLGXLfPsnlqg1UCJ28dniEG
         hXMw5EYw2P3OeSBQhRQw5iTUATBw6mRllXjO8WLroFEuPS2AYjwYHSwSJfWHZXAsgS9X
         VU+sYS4RnsDbJ6d9eeaX3w1ipbwEsCJ7Ng95o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QktCCkNvyH9627eyOkoHu2l1zpEaEm+gRKyrHwv3p60=;
        b=bHbmOKldA+sF7CzAwAmg6hCRfe1FyQaVcRc6X4M5b3bsl28N0VJ8/eB6jGq1k6GGMv
         JxvZc7alSobVCCjYw0INAi13/bAEJxzbX4m5gkBRliVmB0S5BQ3DkZaSl91E7oHBj+fs
         A5B8DOp1yQoD0+Xr4xgtsRAFiGXL9T//i8jL4aUvhV58vr8vcFGefhZyf1nFeKaD2lSq
         nReoLWygsiwYxDANCS2Oz+03aXrXLaDx74NbJgKUdhF38QrggsR/wsluviIke+zBYCK/
         V3g/gbTfIu5s2wt4hhMlu4tzfHsy4MivEAs9W7fy7iIYNsWv2hOSS/LvK6ofSFidB8E2
         oXwQ==
X-Gm-Message-State: AOAM5324JzZqLDLG7TuWgzRxyQaEoFlmzyaEIixtSocfrlF3G4C5+twM
	IzSs58fLj2k6FQbMr9VlbR1oKdmRgF7r3g==
X-Google-Smtp-Source: ABdhPJyEme0P3FIueHsXwC5srHTEQu0dEWY7w3tepKkU5WTOT7CoVMuYfQQc1rlMany207yL0qwNew==
X-Received: by 2002:a17:902:eb92:b0:158:5130:957b with SMTP id q18-20020a170902eb9200b001585130957bmr12374790plg.104.1650310850011;
        Mon, 18 Apr 2022 12:40:50 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm13986117pfh.83.2022.04.18.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:40:49 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v2] clock: fix time update transition auto->manual
Date: Mon, 18 Apr 2022 13:40:38 -0600
Message-Id: <20220418194038.525068-1-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418193440.524442-1-ryan.smith@density.io>
References: <20220418193440.524442-1-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TimeUpdates property is changed via D-Bus from auto to manual,
the change is written out to the settings state file. However, it does
no modify the current service. This causes the service to continue to
synchronize time even after TimeUpdates being set to manual. This patch
updates the service whenever any change is made to the TimeUpdates setting.
---
 src/clock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/clock.c b/src/clock.c
index 906538ac..54ac274a 100644
--- a/src/clock.c
+++ b/src/clock.c
@@ -270,6 +270,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	} else if (g_str_equal(name, "TimeUpdates")) {
 		const char *strval;
 		enum time_updates newval;
+		struct connman_service *service;
 
 		if (type != DBUS_TYPE_STRING)
 			return __connman_error_invalid_arguments(msg);
@@ -290,12 +291,8 @@ static DBusMessage *set_property(DBusConnection *conn,
 				CONNMAN_CLOCK_INTERFACE, "TimeUpdates",
 				DBUS_TYPE_STRING, &strval);
 
-		if (newval == TIME_UPDATES_AUTO) {
-			struct connman_service *service;
-
-			service = connman_service_get_default();
-			__connman_timeserver_conf_update(service);
-		}
+		service = connman_service_get_default();
+		__connman_timeserver_conf_update(service);
 	} else if (g_str_equal(name, "Timezone")) {
 		const char *strval;
 
-- 
2.25.1


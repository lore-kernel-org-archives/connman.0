Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01351A41
	for <connman@lists.linux.dev>; Mon, 18 Apr 2022 19:35:29 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 2so13822732pjw.2
        for <connman@lists.linux.dev>; Mon, 18 Apr 2022 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PlRB86ngBestmnGKFimGi8Q+HhC9CGl3pvY30gXBck=;
        b=tnksXJxYjUJr8Y75cuuvAZAmrY1W8DUmPdkE3xgC1Jtvok93DnFb6v/n1cmmZv9tcJ
         bBv/Sgv15soF5JCmvHh43Kwfrsmx/2B5wpKUMJMnOD88kNEiqrPYoWaiEIcLu6OwQfir
         DvM/qda056FkzkgU8xuQ5j4J0Pks5SO8cFv7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PlRB86ngBestmnGKFimGi8Q+HhC9CGl3pvY30gXBck=;
        b=eZRretbKZLYcR+4rJry1y29yhmry0PZ30QJqpJDqmMjnqrG6P2Ae7P81Imc/lVbaEv
         FrDmdyK+HvyPUIfyXwlm7LjXL+747TQlkudGQXZqkN6eIDsxySh+HGirGZAfNsWF0GbM
         n2k+BG9kEe7SNzgX8XDBkmwi9lvtKRzewyofQneEyOtGXKBhbrWe8/PT6Icr5l/UGFvE
         4E2SuH20l8zwPNq4q7IYooAmUGwDQf+rxNqs4pRoyHke64afGrBPSN2nZzF7eq18ohf8
         eGF0NWdDgZ1TJBrC6yvCiYmPHCPnB7if1w5WblG7sIeM5igcXEn0BFup+un3K1jeKsHh
         3hlg==
X-Gm-Message-State: AOAM531ebw4rDrBdtcSsyOs7YoKoHxAmn3a7cFDkn1xaIEoXITukwlot
	76Jtt1n+Wo24Ef0VgkwF5W6yE8m4518diw==
X-Google-Smtp-Source: ABdhPJwcCOgOvggrzWTw/r9xvjSQ1307Uzn/CPi4x0OIQb7RQOw8120SlvtNN16aVVOqkJqNKY02Sg==
X-Received: by 2002:a17:902:ba93:b0:157:1905:f4bc with SMTP id k19-20020a170902ba9300b001571905f4bcmr12451907pls.83.1650310528984;
        Mon, 18 Apr 2022 12:35:28 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001cb66e3e1f8sm13791926pjb.0.2022.04.18.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:35:28 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v1] clock: fix time update transition auto->manual
Date: Mon, 18 Apr 2022 13:34:40 -0600
Message-Id: <20220418193440.524442-1-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
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
 src/clock.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/clock.c b/src/clock.c
index 906538ac..365c49a1 100644
--- a/src/clock.c
+++ b/src/clock.c
@@ -290,12 +290,8 @@ static DBusMessage *set_property(DBusConnection *conn,
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


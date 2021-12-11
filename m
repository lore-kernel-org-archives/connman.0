Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43E68
	for <connman@lists.linux.dev>; Sat, 11 Dec 2021 13:50:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id i12so8806302wmq.4
        for <connman@lists.linux.dev>; Sat, 11 Dec 2021 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsPr6g1tZciO0S/7Z7aQB1KwJwPLynwa3vyCmwTl3ag=;
        b=MoX9PxUZQ2XUwYCbNA+YKHJ1oCsQ2LCP0eIQ3KLsJ5nd3H57r4/OhezGRs33ULsVuz
         aqYnMyR28SkE+XrqV/v6pK7OxXBYaO5ub1C+B38n6GLERNnyYF67znC8vPGSyZ2Qx3Hp
         WyuqEwOJ4gR2fmRmxfXTN8JteQQLcaXBzQy4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsPr6g1tZciO0S/7Z7aQB1KwJwPLynwa3vyCmwTl3ag=;
        b=IycRoAWhs6/oVKkM7YwDOAUdU1bjJd74Hn0Trp7UI6YqP3laJtDm6yeiHf2jcprplW
         hV1ZlrRv17PJjyS+wGWyKgA7FzA1exV1LNKUATsNWrrhF+GMV9d2jnq+ZdocxpzwcyZS
         0eSwzZUIk0KuqGAPFSQCRIqp0uiE9BHp45qszEqmEBYAdJu4/8gEK+n7B8TG5DXB9aqr
         Xe9Amg5o874VJXCTztsufHKBjwtrDCTYCTuID84h1CjFsPU8E5KGYLCbeCP4VwUI6q9N
         q8Yye5bZFfCw75OU/kxYG0bohjACrK3IuBH3j32Od9Pv/sHs3grwploTVXxnBzOr49v2
         MYHg==
X-Gm-Message-State: AOAM532jbAe4SLWvdXFBXmdlRXTQQpJFX+t/H3ejogXlzA9CFSusE1b/
	ZsTG4ikaChMr85JUZB++6MCBzxSMI5/vjw==
X-Google-Smtp-Source: ABdhPJxZrhfjAnpIWF5hM9jJ+IF22lkt9Gd+Xz7Ks0JFO01nUrRx62LKVTzgKmJeGDqrqqfTff+2Og==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr24336011wmq.191.1639230630891;
        Sat, 11 Dec 2021 05:50:30 -0800 (PST)
Received: from localhost.localdomain ([2.196.208.11])
        by smtp.gmail.com with ESMTPSA id t8sm5228897wrv.30.2021.12.11.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 05:50:30 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] Add ObjectManager interface to connman
Date: Sat, 11 Dec 2021 13:50:28 +0000
Message-Id: <20211211135028.11355-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ObjectManager let us to understand if the connman interface
is up before use it. InterfacesAdded and InterfacesRemoved
signals will then be emitted.

int main()
{
    auto connection = sdbus::createSystemBusConnection();

    auto managerProxy = std::make_unique<ManagerProxy>(*connection, "net.connman", "/");
    try {
        managerProxy->handleExistingObjects();
    }
    catch (const sdbus::Error& e) {
        if (e.getName() == "org.freedesktop.DBus.Error.ServiceUnknown") {
            std::cout << "Waiting for server to start ..." << std::endl;
        }
    }

    connection->enterEventLoop();
    return 0;
}

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 src/dbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dbus.c b/src/dbus.c
index c454a581..74b3157b 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -687,7 +687,7 @@ int __connman_dbus_init(DBusConnection *conn)
 
 	connection = conn;
 
-	return 0;
+	return g_dbus_attach_object_manager(conn);
 }
 
 void __connman_dbus_cleanup(void)
-- 
2.25.1


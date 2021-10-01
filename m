Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391A3FCC
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 12:26:12 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id g7so33420651edv.1
        for <connman@lists.linux.dev>; Fri, 01 Oct 2021 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qk84zpg3TKz4sx8hbBz8tgGjRNW2TGzknfzefLxB39c=;
        b=Xyd8F1UeqVjpJXxIvsTCc7AcK6o2iax9+Vl72NXP4Q6bE9+wi54JA+1Wr1AIaOKDbn
         ZtP9rP1PdXVyD2jufD+8mTjuxHpynBfu3Ay6QQpsYb6H+LbjblaCH9mTCgaEMjcHIGRP
         rswzV4Nsc/q+C3+VQrFtBRd0a/crvVDs7YkuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qk84zpg3TKz4sx8hbBz8tgGjRNW2TGzknfzefLxB39c=;
        b=my2DCz0rSnxS6o0aGaEMJTfWCHUEgxb/qZMSwNq6PvlqqgC+CZKOBPwvxwpvmv5lWB
         PyngjElrll71K8Fce8+K61GhboJfGgtF7BQswSGMl0xhnL0DjTOmOR4bx1oR+zrUcZ5p
         r0E9SU1rChL/nHC1Kug/DAmMKzc2MSTBF36xszaUF1e6QVe4rRLSwakirEAkhVC8nqEB
         BTzj5isOtJWaZhQdJoPUE+Xg/shsINPX6sF2Sd5XOqBFXGYfwoAWQChIn5XXhzZr69q5
         QYWq7LDhy4eOKl17is28EfKK19vP7lV4CdWjTHvSvXwvxf/BZJVUMbsxbyzRRT+4lxeH
         TXMQ==
X-Gm-Message-State: AOAM53032eMb643qQLmn0orFMZkwyLY2JV8CUmISWg6Rb4KUlV/1Thi9
	2vBqqYOUhrQTuRnTxe4KrLMyYa61yAYrCQ==
X-Google-Smtp-Source: ABdhPJwRbXuD9jIn8Ng7XfKwbkPl9gh/0QATLtf6UvIf9JxjHPo2lXbb7h+eHr6SQ0Mx6mlEW5G5rQ==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr14168751edp.267.1633091169984;
        Fri, 01 Oct 2021 05:26:09 -0700 (PDT)
Received: from localhost.localdomain (mob-2-43-201-216.net.vodafone.it. [2.43.201.216])
        by smtp.gmail.com with ESMTPSA id t15sm2218366ejy.74.2021.10.01.05.26.08
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:26:09 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] iwd: Set the network index add_network
Date: Fri,  1 Oct 2021 12:26:06 +0000
Message-Id: <20211001122607.34360-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to have compatibility with wpa_supplicant
configuration and fill the dictionary as was before
we need to set index not when the wireless is connected
but when it's registered. This allow to understand
what wireless card is using each services

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 plugins/iwd.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 14a442a7..48097a1f 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -208,19 +208,6 @@ static int cm_network_probe(struct connman_network *network)
 
 static void update_network_connected(struct iwd_network *iwdn)
 {
-	struct iwd_device *iwdd;
-	int index;
-
-	iwdd = g_hash_table_lookup(devices, iwdn->device);
-	if (!iwdd)
-		return;
-
-	index = connman_inet_ifindex(iwdd->name);
-	if (index < 0)
-		return;
-
-	DBG("interface name %s index %d", iwdd->name, index);
-	connman_network_set_index(iwdn->network, index);
 	connman_network_set_connected(iwdn->network, true);
 }
 
@@ -911,6 +898,7 @@ static char *create_identifier(const char *path, const char *security)
 static void add_network(const char *path, struct iwd_network *iwdn)
 {
 	struct iwd_device *iwdd;
+	int index;
 	char *identifier;
 
 	iwdd = g_hash_table_lookup(devices, iwdn->device);
@@ -920,6 +908,12 @@ static void add_network(const char *path, struct iwd_network *iwdn)
 	identifier = create_identifier(path, iwdn->type);
 	iwdn->network = connman_network_create(identifier,
 					CONNMAN_NETWORK_TYPE_WIFI);
+
+	index = connman_inet_ifindex(iwdd->name);
+	if (index < 0)
+		return;
+
+	connman_network_set_index(iwdn->network, index);
 	connman_network_set_data(iwdn->network, iwdn);
 
 	connman_network_set_name(iwdn->network, iwdn->name);
-- 
2.25.1


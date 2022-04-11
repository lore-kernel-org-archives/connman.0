Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F91865
	for <connman@lists.linux.dev>; Mon, 11 Apr 2022 17:32:54 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so3759124pjb.1
        for <connman@lists.linux.dev>; Mon, 11 Apr 2022 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2IrTu/Qhxc8yXxBRpX3ilJ+no7sGVAQ6dZtUCJ0Apk=;
        b=fFA3rHW+ewSw3TxZprQ1Le0ZEvfySEHx2aKiuM1zKgjQIIqS0zVJ5s/YHlJjypugqp
         8hS99oN4Ibfpb0oTaavbBmcSlRG9miqvV25CQ1+4q0Hd+qJ6pOOgrZIpSaV/891h8as6
         EqRpCjiA+UHFuo86MODqq0BaQgJBEN4Gk9RVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2IrTu/Qhxc8yXxBRpX3ilJ+no7sGVAQ6dZtUCJ0Apk=;
        b=Jb8Ggx3wv5frgLuog6DuAvkEzlYreeQcKGK6dNpi/6hGxjuS6SMVQglucX0Dq/toqT
         kb+JHvsmIbyx/ksuCNpTw4daDANMFeV7XtK18PIXd15gXXzaTXc90H8JsnRfOZkVn5fD
         2HvzAEuJJGfdzQ+qZ5pDYA5T+nsUTl9snBrvGYQ9k4vMAkZNN99fI4MyMRF29x5BLxNR
         iky+pE/wXBqx4HzZbF3Wd2OMeb2IzjMTpKT5QBd41iyPj2fznZwXvyDfxaOLI0Ux9MEf
         Q+18hTvq93+ah7VjJMOGOEUBFIYw6bEhRF8AD7W3RPzcx0+/wiwzPPPw6VgepsJplXbM
         dy3w==
X-Gm-Message-State: AOAM530grDONd5DYwG5IAHBX29fHab30E8fC4gwz/uxaElx5c1wWq8W4
	HisZkbns3ipcCof5VamHg4RhYeIlNUU8lA==
X-Google-Smtp-Source: ABdhPJwDfYHX91tY0PbQX1DJYPT/NWzUYid38efcaJvOkiQdJilEXhuUsRG9mVLRIFR0npmg7CfbvQ==
X-Received: by 2002:a17:903:2284:b0:154:3b97:8156 with SMTP id b4-20020a170903228400b001543b978156mr33807979plh.95.1649698373828;
        Mon, 11 Apr 2022 10:32:53 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm79523pjb.48.2022.04.11.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:32:53 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v1 1/2] dhcp: Set proxy properly when applying DHCP lease
Date: Mon, 11 Apr 2022 11:32:16 -0600
Message-Id: <20220411173217.505144-1-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DHCP Option 252 (PAC file URL) is included,
the service should be updated. Doing so sets the proxy
method to 'auto', updates the ipconfig object, and
notifies PACrunner (if included) that the proxy setting
has changed.

Currently, only the ipconfig object is updated. This patch
calls the proper function to perform these actions.
---
 src/dhcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/dhcp.c b/src/dhcp.c
index 11274269..bf100b9b 100644
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -422,8 +422,7 @@ static bool apply_lease_available_on_network(GDHCPClient *dhcp_client,
 		g_free(dhcp->pac);
 		dhcp->pac = pac;
 
-		__connman_ipconfig_set_proxy_autoconfig(dhcp->ipconfig,
-								dhcp->pac);
+		__connman_service_set_proxy_autoconfig(service, dhcp->pac);
 	}
 
 	if (connman_setting_get_bool("Enable6to4"))
-- 
2.25.1


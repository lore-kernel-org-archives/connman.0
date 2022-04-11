Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20D7B
	for <connman@lists.linux.dev>; Mon, 11 Apr 2022 15:20:56 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so12718902pja.0
        for <connman@lists.linux.dev>; Mon, 11 Apr 2022 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVwQuTPqp69kzS2aRwt8sV4aGtYVlrq5Q5I5PMiT/lo=;
        b=fNPVv7OfHCG+e+6PEKmtePHABeViazqEjdW7wf8JffqLh+NjSTc28UByenCcA46pwH
         /mSmtZvbZL7nnqfK5EeXK9nbHkBRUOH2DKzA7ocJBg7VFbNLDpbO3U2UebcmZshPQ5MH
         NK+JBOyYnvIrq9uzoyEI1nq5GimV+HFJrqltk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVwQuTPqp69kzS2aRwt8sV4aGtYVlrq5Q5I5PMiT/lo=;
        b=cNYhMMAhalDnwdSXRMWePvww3hk7BtHtMQotyhb3J/NMWP37s08YhD+YIOOST4gWKp
         WltMtKfbwKDxmwXHs5lTuEpR+L4UQOn+iPXQbZqNIe6xvywxHsRrqxUoGAqOXMgcknBu
         PC9OVcj2OMg6BwU12BVfQ7e0thmrlDJTNjZ4XLiLiyBHB34A9ls6R6sY8VqjI6tj0WbX
         5/AJh03+SqXv+hxfrxpmgMUIlpGrt2OlDmXo2WEM10bfNWcCh67Eivv4eSPChpq1t3mU
         Z0KIaiALxR/MQAFIQcqBIy05RTImyqba8CQjofXGSM5iPD1AaLbs5c0ylatRkwJNWmcH
         vx+w==
X-Gm-Message-State: AOAM533eBcWNf9NeH37MYcPY79WQ4/B2yOIq3cQLAyPgwPIU1rWeGKEm
	28S27kOqZC7MOh7cmqtgpSYemiM3t3c=
X-Google-Smtp-Source: ABdhPJyR7S3nlZD1t64ab+oUKrbCme19is9P/uBzETaAgK0yoluykVG6rvTJ9pr0X9ZP+uB+uQ5O6A==
X-Received: by 2002:a17:90b:4d11:b0:1c7:4c81:2996 with SMTP id mw17-20020a17090b4d1100b001c74c812996mr38139365pjb.170.1649690455725;
        Mon, 11 Apr 2022 08:20:55 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id fa11-20020a17090af0cb00b001ca6e27a684sm20471091pjb.16.2022.04.11.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:20:55 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v1] gdhcp: fix server address byte order
Date: Mon, 11 Apr 2022 09:20:39 -0600
Message-Id: <20220411152039.491710-1-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_ip function calls inet_ntoa, which expects the IP address
in network byte order.
---
 gdhcp/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 3016dfc2..7efa7e45 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -3036,7 +3036,7 @@ char *g_dhcp_client_get_server_address(GDHCPClient *dhcp_client)
 	if (!dhcp_client)
 		return NULL;
 
-	return get_ip(dhcp_client->server_ip);
+	return get_ip(htonl(dhcp_client->server_ip));
 }
 
 char *g_dhcp_client_get_address(GDHCPClient *dhcp_client)
-- 
2.25.1


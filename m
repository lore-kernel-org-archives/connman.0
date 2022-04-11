Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A251865
	for <connman@lists.linux.dev>; Mon, 11 Apr 2022 17:33:00 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id h5so13851889pgc.7
        for <connman@lists.linux.dev>; Mon, 11 Apr 2022 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0laknGz4p+OOSVhVxk81Jjr5W9OU8JMgh6X+bAV1jE=;
        b=FlzOS5EoSjGeqBtDt+xbtbqltpyw4+edkyQyU+pENEUsOFIit6cAb8K6Ja2z+8TClB
         AAb1wzybYplj/8bgIkktYWSJjZ9JV6Jcl37zPrxS1lOm5FuimQKSCKeA77g9IHyEe0Ke
         Y/NAhZtnGrCJcucGCwCZ2LzjhU0x7XBNb3OMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0laknGz4p+OOSVhVxk81Jjr5W9OU8JMgh6X+bAV1jE=;
        b=kWamV7NWregPzMnLDYJmvhVEMaSXeiQbveVxa+ULzFLPdx/bLKYmLuJtK/icSPiRcy
         WCqTh61Z5p7EdIFo5lNN2KkCrHYAf7g8jmISPVb7Itf9MThZWgsVH4IsVCKU9WEgF2q9
         Z//gIfwDSZ2dkaOJrvlXmTF9eC1MNyXNuCHUXO5JFPVXexDIrCpZneztDWzpp06INBRO
         hATszEex9ofBTNzDFY+oOhCJ8LD+0xowZmSVd9gtJ9WL0QnX/7PIWms/ZjFUHnb6Mpz2
         J0C6WYScwF2C6kX6J/nEwcdR/Ay1x5S4ltH7jiqYyx2rMw4ljoWSex1lGD9f1myuMk2V
         C3Tg==
X-Gm-Message-State: AOAM530jZ0ZYaSH4f3Nl72X0d4TU6eGn9K8i/+7rj8+DYd3K47dpr4nu
	p+XrsD9TsjZePhJZAGUPl89g8Yd7nnEWPg==
X-Google-Smtp-Source: ABdhPJzGSUaSNCscEUxFL5sPzpKtSGnZE1ofbbr30Oif3/5qGl3zimG6wG75qwJt/ccFmRgfyTE0Tg==
X-Received: by 2002:a63:104c:0:b0:39d:460f:5c58 with SMTP id 12-20020a63104c000000b0039d460f5c58mr6345063pgq.559.1649698379498;
        Mon, 11 Apr 2022 10:32:59 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm79523pjb.48.2022.04.11.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:32:59 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v1 2/2] wispr: Fix online check when using WPAD/PAC
Date: Mon, 11 Apr 2022 11:32:17 -0600
Message-Id: <20220411173217.505144-2-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411173217.505144-1-ryan.smith@density.io>
References: <20220411173217.505144-1-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PAC file can return multiple proxies in response to a query.
They are separated by a semicolon and, possibly, a space.

'PROXY proxy1.example.com:3128; PROXY proxy2.example.com; DIRECT'

Currently, this is not handled, and the inclusion of more than
one proxy causes the online check to fail. This fix parses the
first proxy in the list and uses it.
---
 src/wispr.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 41157580..d7afcf05 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -797,6 +797,26 @@ done:
 	return false;
 }
 
+static char *parse_proxy(const char *proxy)
+{
+	char *proxy_server = NULL;
+
+	if (g_strcmp0(proxy, "DIRECT") != 0) {
+		if (g_str_has_prefix(proxy, "PROXY ")) {
+			proxy_server = g_strdup(proxy + 6);
+
+			// Use first proxy server
+			for (char *c = proxy_server; *c != '\0'; ++c)
+				if (*c == ';')
+					*c = '\0';
+
+			g_strstrip(proxy_server);
+		}
+	}
+
+	return proxy_server;
+}
+
 static void proxy_callback(const char *proxy, void *user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
@@ -808,12 +828,10 @@ static void proxy_callback(const char *proxy, void *user_data)
 
 	wp_context->token = 0;
 
-	if (proxy && g_strcmp0(proxy, "DIRECT") != 0) {
-		if (g_str_has_prefix(proxy, "PROXY")) {
-			proxy += 5;
-			for (; *proxy == ' ' && *proxy != '\0'; proxy++);
-		}
-		g_web_set_proxy(wp_context->web, proxy);
+	char *proxy_server = parse_proxy(proxy);
+	if (proxy_server) {
+		g_web_set_proxy(wp_context->web, proxy_server);
+		g_free(proxy_server);
 	}
 
 	g_web_set_accept(wp_context->web, NULL);
-- 
2.25.1


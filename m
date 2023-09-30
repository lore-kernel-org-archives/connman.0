Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC39199A6
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:06 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ae2f8bf865so7775126b6e.2
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112825; x=1696717625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP24Q8GBqK1TVYw6upFL3/aL9KK79ZqcXP9Su1b/gGM=;
        b=HLAxjE0D91LUUMm4NAWKc0tWQLDxHM2/6PEB6igH1I3jZd+FYHKBTqNGmDNKylGDht
         6w/oisWUp8SFSREJwCD4zPLMQshd17gnHkoyz481ofevB5dJlfUETfJNy+ligUN32FMW
         eLt3+8711jIih9T/9eHKph2T02Vb1NIH3Xet3DSpqd33Bf45KPCLHoDhBlGWOEr45vMF
         OJhyGF/tI+raHSMFQ1k1vs2nxgZyt5OcAbAjXLQReDdpLT4RWRTTRdvdgnVuHvGj7r76
         +LAehshfiibRL3AiRJ2590aQ5tyc3hQBRqPi6WQp7axpdujjqMa9LYF420e5iDTqkU/G
         r2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112825; x=1696717625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qP24Q8GBqK1TVYw6upFL3/aL9KK79ZqcXP9Su1b/gGM=;
        b=Mtq0AF1khZ05La//ttKNDgv+/ZmiCTjKQN2TRzX1Sqm/KhhVv0NYzPLXajcZ+w6QMV
         1Xzgb2uS1J8pLTWNC5EXppfU6XVJnL4T4wBNkF4e9CV1pLw7NqshSQP66ThosTveSrgV
         ehfTn2gmFVreysZeavoinl157N4MYMfYRdXR+Frnsx0zb0A2P2z7FERbZJwwU3ObAfIo
         EJCkA/8WM5Ce5UtRX5Cq0Yl2LCvw6sasBKVKp0tzMJx72rDc6+HHvhJUrRraQeswQhTI
         43A2WaCwBYovOvNEYoMUs5w1M1BcsHo0Jek/9Oq/FJYzV0HjbbzyyEnxLT7sMwC46T5z
         tXsA==
X-Gm-Message-State: AOJu0Yxc2IZpb9i1gccmc0yADMKIJJmcT69bRKP2DfplL4iod7T0Sjw7
	Fn6ObwSlwRYADS3YOVwRbcLKgUtj6aA=
X-Google-Smtp-Source: AGHT+IFdZ4mxEmbK1JlsZr9RqlJp9kMCpLHhJL5FWLgfvDbRZbD2vhZXwHF0aMRckSsn2UP2vyfQLQ==
X-Received: by 2002:a05:6870:a3d0:b0:1dc:cd20:1e48 with SMTP id h16-20020a056870a3d000b001dccd201e48mr9126864oak.17.1696112825441;
        Sat, 30 Sep 2023 15:27:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] service: Remove unused functions
Date: Sat, 30 Sep 2023 17:25:54 -0500
Message-ID: <20230930222615.654178-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930222615.654178-1-denkenz@gmail.com>
References: <20230930222615.654178-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions were never used, get rid of them.
---
 src/connman.h | 12 -------
 src/service.c | 90 ---------------------------------------------------
 2 files changed, 102 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index b955d98b..f7da5e5b 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -807,18 +807,6 @@ const char *__connman_service_get_nameserver(struct connman_service *service);
 void __connman_service_set_proxy_autoconfig(struct connman_service *service,
 							const char *url);
 
-void __connman_service_set_identity(struct connman_service *service,
-					const char *identity);
-void __connman_service_set_anonymous_identity(struct connman_service *service,
-					const char *anonymous_identity);
-void __connman_service_set_subject_match(struct connman_service *service,
-					const char *subject_match);
-void __connman_service_set_altsubject_match(struct connman_service *service,
-					const char *altsubject_match);
-void __connman_service_set_domain_suffix_match(struct connman_service *service,
-					const char *domain_suffix_match);
-void __connman_service_set_domain_match(struct connman_service *service,
-					const char *domain_match);
 void __connman_service_set_agent_identity(struct connman_service *service,
 						const char *agent_identity);
 int __connman_service_set_passphrase(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index 06d02322..9b8f4427 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3082,96 +3082,6 @@ void __connman_service_set_pac(struct connman_service *service,
 	proxy_changed(service);
 }
 
-void __connman_service_set_identity(struct connman_service *service,
-					const char *identity)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->identity);
-	service->identity = g_strdup(identity);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.Identity",
-					service->identity);
-}
-
-void __connman_service_set_anonymous_identity(struct connman_service *service,
-						const char *anonymous_identity)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->anonymous_identity);
-	service->anonymous_identity = g_strdup(anonymous_identity);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.AnonymousIdentity",
-					service->anonymous_identity);
-}
-
-void __connman_service_set_subject_match(struct connman_service *service,
-						const char *subject_match)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->subject_match);
-	service->subject_match = g_strdup(subject_match);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.SubjectMatch",
-					service->subject_match);
-}
-
-void __connman_service_set_altsubject_match(struct connman_service *service,
-						const char *altsubject_match)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->altsubject_match);
-	service->altsubject_match = g_strdup(altsubject_match);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.AltSubjectMatch",
-					service->altsubject_match);
-}
-
-void __connman_service_set_domain_suffix_match(struct connman_service *service,
-						const char *domain_suffix_match)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->domain_suffix_match);
-	service->domain_suffix_match = g_strdup(domain_suffix_match);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.DomainSuffixMatch",
-					service->domain_suffix_match);
-}
-
-void __connman_service_set_domain_match(struct connman_service *service,
-						const char *domain_match)
-{
-	if (service->immutable || service->hidden)
-		return;
-
-	g_free(service->domain_match);
-	service->domain_match = g_strdup(domain_match);
-
-	if (service->network)
-		connman_network_set_string(service->network,
-					"WiFi.DomainMatch",
-					service->domain_match);
-}
-
 void __connman_service_set_agent_identity(struct connman_service *service,
 						const char *agent_identity)
 {
-- 
2.42.0


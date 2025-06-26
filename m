Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2E23ABAD
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922936; cv=none; b=ic3+XqWWR/CN6g+Z2/Km1pkG7IQrMOFydohkKXBwsCmVJYHnceURatXC+mW3XR+p3/DSpIKzmVc1/lQeZtovdsilUqLe8Qg4fZ/6MMUqj3+Ga1s2iwm842x8EsjIatfyOnsmA2ErMG3+IZW58eEptjoPrMTOQjxn+EjTqMvha4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922936; c=relaxed/simple;
	bh=wl8qVoQrZ2uXU4u8aU6z9qwKXkkf5oYED8lvprHM8o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuqwjOcX6qLFVVXuiOcMHI/I22dUfGmGkpmyjabfxOREmYvAWe70XW7Q2+ezdyVAyeg0sRjfjkRCzu9sRk4AP993i8IaCqxUfRnQhRJMdtHahUPMvngpI10os/4NPT+RNz1uFaKPPzjkiv0UCgmIY0xQ4mKOV8L+8ampl6gjqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=X2Ki/3rF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X2Ki/3rF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a522224582so265155f8f.3
        for <connman@lists.linux.dev>; Thu, 26 Jun 2025 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1750922933; x=1751527733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R2g+s52xwLwiAKGfzTjGkFy/WL+5Dpby0Utmyv0mpo=;
        b=X2Ki/3rF3lhJ02OdZXFBDtcnRaEDNrpAh5T44hHyC+7zo+74zaicx/q/FmuCPQp8gw
         w9ZEl9OxwjaVRXBVajNPvNX1ADkb7YCjmXvpfIZC5PvXE6x8n4cGS02m5IygiBqNO8Wd
         pYLXcvwVsW6QQrp0SqFkQXE+kLao6du0Os+0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750922933; x=1751527733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R2g+s52xwLwiAKGfzTjGkFy/WL+5Dpby0Utmyv0mpo=;
        b=eLYB2meNb/Cfc2JBJ28KQSZB3bPFG5MUnjxPQ/JCt41cFfiMNt0Ht8qaoHrfzObA/R
         4HodogCDxVKKj55bcz59R+gp9iDYLKPwo1avSH6LWMgOyU490f70iP42qNMcCVSSm42p
         +QAVCE86XKCXlb5SMh4+FGL3KMwZrq+LY0e43W4wMMOBQa9mPgYzHYRuFQO7ZFFgD9v+
         Yu0XYVhRduy4eW22EBCuKVfZ6lhhw8bLwQ1Izf7+Vs/YfDDERcoQ9aQpnIj+LAylPtfd
         v5jHF29vGWFFo8iCuDGlD0gJaSvEegFaoj0yLue+Dbtb5Gi+IKwXuVbiA/PWvS71jAs8
         V6Fw==
X-Gm-Message-State: AOJu0YwkItW+V9puNq5aM+Q+nuAbd4yHuQwBoxahL92UV/q6Bw4Vkgx+
	qBMwz2UOSo7vgTIz6/6177Qdfwjlyyv+78V/s/Uj2uXBxzicRhn5aE/FppuYVQnkNkKZfVXk8wl
	KRdh/v0s=
X-Gm-Gg: ASbGncvDCJ3mGw1ILuy+/w4iBYPtpYneaPyvLV6DeHDJaw+OkXNGnt9revSzs3EHPSl
	nbClXXi+TJ1V2JsvQIm5tQnBgZp0yLsWWmtZveAWzkeD0G2UhkquE0VDEIMOKoLRMpr6hBynWnh
	/grpzIqLJaYnQKSh/GT7ywQS/R6gQ5Rg1qAYxW/JtboLI0lGPc3SwVvF48hPIB/OeXt4gibdXP/
	5uLbgV2H6tDmYmW+YpR9cq/sBLwMEaQNKWOwE/TbuxyeimafL7dXZLIOLKkjX30Tr/HjAdWx4++
	LaIqM8Zx5O/ppyIlCiUSqwpgFeat3UTLzcX441AD9yStkkaxHBBQ0iZFEd4b2IOaBPngoOABNpK
	GyNwOQVgcADljfdOk2NEm+lI0JptGhYcuRfrgnoHiMoU=
X-Google-Smtp-Source: AGHT+IE1+qOgX8lL3ykjCJKt4DccmkBPJJgJf2TrvbbE8uYS3IKwG7R1xskJEhPA5fC97yeqPcnRbQ==
X-Received: by 2002:adf:e18f:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a6f30ac85fmr1936467f8f.53.1750922933130;
        Thu, 26 Jun 2025 00:28:53 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8382-0206-0000-0000-0000-05fa.ipv6.o2.cz. [2a00:1028:8382:206::5fa])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6e8105f93sm6613516f8f.76.2025.06.26.00.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 00:28:52 -0700 (PDT)
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 3/3] client: Add RemoveKnownService client implementation
Date: Thu, 26 Jun 2025 09:27:46 +0200
Message-ID: <20250626072822.1941-4-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626072822.1941-1-roman@amarulasolutions.com>
References: <20250626072822.1941-1-roman@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

Add a way to test the remove network feature
---
 client/commands.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/client/commands.c b/client/commands.c
index f4366e8c..14dc47e2 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -432,6 +432,47 @@ static int cmd_known_services(char *args[], int num, struct connman_option *opti
 			 services_list, NULL, NULL, NULL);
 }
 
+static int remove_known_service_return(DBusMessageIter *iter, int errnum,
+					const char *error, void *user_data)
+{
+	char *name = user_data;
+
+	if (!error)
+		fprintf(stdout, "Removed %s\n", name);
+	else
+		fprintf(stderr, "Error %s: %s\n", name, error);
+
+	g_free(user_data);
+
+	return 0;
+}
+
+static void remove_known_service_append_data(DBusMessageIter *iter, void *user_data)
+{
+	const char *data = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data);
+}
+
+static int cmd_remove_known_service(char *args[], int num, struct connman_option *options)
+{
+	char *data;
+
+	if (num > 2)
+		return -E2BIG;
+
+	if (num < 2)
+		return -EINVAL;
+
+	data = g_strdup_printf("%s", args[1]);
+
+	return __connmanctl_dbus_method_call(connection,
+			 CONNMAN_SERVICE, CONNMAN_PATH,
+			 "net.connman.Manager",
+			 "RemoveKnownService",
+			 remove_known_service_return, data, remove_known_service_append_data, data);
+}
+
 static int cmd_peers(char *args[], int num, struct connman_option *options)
 {
 	char *peer_name = NULL;
@@ -2822,6 +2863,8 @@ static const struct {
 	  "Display services", lookup_service_arg },
 	{ "known-services", NULL,  NULL, cmd_known_services,
 	  "Display known services", NULL },
+	{ "remove-known-service", "[<service>]",  NULL,
+	  cmd_remove_known_service, "Remove known service", NULL },
 	{ "peers",        "[peer]",       NULL,            cmd_peers,
 	  "Display peers", lookup_peer_arg },
 	{ "scan",         "<technology>", NULL,            cmd_scan,
-- 
2.49.0


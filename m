Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED71E47C5
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435090; cv=none; b=M1T6tGTIi8JgCBtAJBm6r2F9pm7ucTkxqq80k5ogxVfUN0pvZ9bU697A7eScwoy7pUWefOLURLM494102ksDnauYdgwcazwV7JkrMhqzysvw39oJR0QTuBry4AszfFZ1XiONnuify/nbHAdRaygWS2zxOQUd0B6WN5YMtyokAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435090; c=relaxed/simple;
	bh=/i/Y1hb0YDd3l27BepUsdLHDShUmvG+2lkg8ptrlGWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqcUnhXjIqwF4hjp5UIT01cNT6w6QAOVIVgODSFqZe5w6P3VrL16uFf6gVGlXdJUCeBlJtLvKiNHrRGfNlvx2A1QVMNNzmmlN066+Zvp2oQA8mgw9GnZLUPcVZRLR2Qf0h6H7rfSiObymmJtT803KB3Lt++e37gXy7/mWkidu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=QWuetvCi; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="QWuetvCi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PdeI6e+9YkzEhfB70XwOWR6v6bjlwSyDd5U3qACBibc=; b=QWuetvCiw7J4aCeWeZ5lI4D4t9
	6fvx5kL3kbjuj5GoTgLAHcsfjaqYkUFT+/0leCtky4PhAwX95EDlw1OsiRuqzOe0LfEA8mCfMfZp3
	MBZPsadpHFGyyGFRKUEHQ6H5gojs5+dUQq+VY5OgHDCfpWJJTteaQqyBxo85vgQ/vzdMcxz+OtLgG
	dJGH/A3mN1ealUaWlcfPpPMz/YP0yfm5EZ5/iDj8sSUgqlq6mMoJxfMyvL90zSg50xzg6E0iHX9eH
	KaZ6w3JS7spSw0yVcgV+lfI/BEr9zmqqYC1Uu680naFN8K5gAh2j/PCHvjGkucfTXCTe86v/Vj6Nm
	JW+5msHA==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-1k
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/9] pptp: Add Sync and Nobuffer as new PPTP only bool options
Date: Mon, 26 Jan 2026 15:43:41 +0200
Message-ID: <20260126134410.55749-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The options --sync and --nobuffer were missing from options list for
PPTP. Add these as separate PPTP only boolean options as they take no
parameter. --sync in PPTP requires "sync" in PPPD as well.
---
 vpn/plugins/pptp.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/vpn/plugins/pptp.c b/vpn/plugins/pptp.c
index 7274376f..04498a53 100644
--- a/vpn/plugins/pptp.c
+++ b/vpn/plugins/pptp.c
@@ -55,7 +55,8 @@
 enum {
 	OPT_STRING = 1,
 	OPT_BOOL = 2,
-	OPT_PPTP_ONLY = 3,
+	OPT_PPTP_ONLY_STRING = 3,
+	OPT_PPTP_ONLY_BOOL = 4,
 };
 
 struct {
@@ -65,8 +66,10 @@ struct {
 	int type;
 } pptp_options[] = {
 	{ "PPTP.User", "user", NULL, OPT_STRING },
-	{ "PPTP.IdleWait", "--idle-wait", NULL, OPT_PPTP_ONLY},
-	{ "PPTP.MaxEchoWait", "--max-echo-wait", NULL, OPT_PPTP_ONLY},
+	{ "PPTP.IdleWait", "--idle-wait", NULL, OPT_PPTP_ONLY_STRING},
+	{ "PPTP.MaxEchoWait", "--max-echo-wait", NULL, OPT_PPTP_ONLY_STRING},
+	{ "PPTP.Sync", "--sync", NULL, OPT_PPTP_ONLY_BOOL},
+	{ "PPTP.Nobuffer", "--nobuffer", NULL, OPT_PPTP_ONLY_BOOL},
 	{ "PPPD.EchoFailure", "lcp-echo-failure", "0", OPT_STRING },
 	{ "PPPD.EchoInterval", "lcp-echo-interval", "0", OPT_STRING },
 	{ "PPPD.Debug", "debug", NULL, OPT_STRING },
@@ -311,15 +314,24 @@ static int pptp_save(struct vpn_provider *provider, GKeyFile *keyfile)
 	return 0;
 }
 
+static bool get_value_boolean(const char *value)
+{
+	if (!value || !*value)
+		return false;
+
+	if (strcasecmp(value, "yes") == 0 ||
+			strcasecmp(value, "true") == 0 ||
+			strcmp(value, "1") == 0)
+		return true;
+
+	return false;
+}
+
 static void pptp_write_bool_option(struct connman_task *task,
 				const char *key, const char *value)
 {
-	if (key && value) {
-		if (strcasecmp(value, "yes") == 0 ||
-				strcasecmp(value, "true") == 0 ||
-				strcmp(value, "1") == 0)
-			connman_task_add_argument(task, key, NULL);
-	}
+	if (key && value && get_value_boolean(value))
+		connman_task_add_argument(task, key, NULL);
 }
 
 static void pptp_died(struct connman_task *task, int exit_code,
@@ -540,9 +552,18 @@ static int run_connect(struct pptp_private_data *data, const char *username,
 		else if (pptp_options[i].type == OPT_BOOL)
 			pptp_write_bool_option(task,
 					pptp_options[i].pptp_opt, opt_s);
-		else if (pptp_options[i].type == OPT_PPTP_ONLY)
+		else if (pptp_options[i].type == OPT_PPTP_ONLY_STRING)
 			g_string_append_printf(pptp_opt_s, " %s %s",
 					pptp_options[i].pptp_opt, opt_s);
+		else if (pptp_options[i].type == OPT_PPTP_ONLY_BOOL &&
+						get_value_boolean(opt_s)) {
+			/* --sync needs sync in pppd */
+			if (!g_strcmp0(pptp_options[i].cm_opt, "PPTP.Sync"))
+				connman_task_add_argument(task, "sync", NULL);
+
+			g_string_append_printf(pptp_opt_s, " %s",
+					pptp_options[i].pptp_opt);
+		}
 	}
 
 	str = g_string_free(pptp_opt_s, FALSE);
-- 
2.47.3


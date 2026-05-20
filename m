Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A33EFFAD
	for <connman@lists.linux.dev>; Wed, 20 May 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290451; cv=none; b=KMeUxnYjFlajMcKKEWtsuZ2EqkP3KrppQd1p0DhUzq7eQVtptZfPxPvRpjxBKyLU3G9H1O2OBe9aN2UtfQoREjWDeRkIjT677sqwrSFyjUdi8QrPwMo7p38s9317wAK32kPLXOBYJCdaQe5ciAF8SBb1ID8PfNsjrurREr0uBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290451; c=relaxed/simple;
	bh=cCM4TzJ5clbYZY4+dxx9IBNfU3d+WfPM9/ieXsGqCOc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQyL64UlochzTnnvuiKILlzVhNvQ4UYE0MIkbq1i5HYBZ/csEXcNo4UIvMlSJMB+BW63LMqoklz/MXO6fVFevHu/eoAf2YKYkuA1ERy6YYgwsYjw4cJxNZWd2CZAAbtdPmYzFtf75cvjsMEgNjLu0n/03TS67+7dK4t5V5hlkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=sNZaV5Tm; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="sNZaV5Tm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8gBdto68aIL12tgdhSWuckgNM+S6nL8ZtugkuPa8C/c=; b=sNZaV5Tmg1/1hybLcQ+FB3TcgL
	Oaw07QJzuWw5ZDwxreMrpVxzX2MAZ3lVIgaZHQJRbD4PlojJpo0rkw0odk41KHeMMMAYTF/cXn/MC
	Jz8CjV6hExgD0xlr51fUmGfajmVdIeMq0GRFSZTuJbiDqSKBio0zrINEHQCpIP8BsZgnyyIYHGzVZ
	wOtctD1q73HnFCnzSKWAMu85XL1PyEkBsMyG/HHNtx5ztfcl0C+cKLLEsw6G1/Z0qdLC9FOjepNX+
	oYMTr9u9FoAXgYX2eIcgr9FkDOv3qMG/XnDsXW4KXOffm68A6PIiAYJdjeo6iREokeVj4uaUwlsvn
	F15jiocw==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGj-002WBi-27
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:29 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/9] vpn: Use util conf.d to read additional configs
Date: Wed, 20 May 2026 16:47:08 +0300
Message-ID: <20260520134720.981315-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-2.99)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.984]
 X-Symbol: BAYES_HAM(-2.99); Message probably ham, probability:  [99.99%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-5-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

---
 Makefile.am |  3 ++-
 vpn/main.c  | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 88100968..85f70c8b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,7 +181,8 @@ vpn_connman_vpnd_SOURCES = $(builtin_vpn_sources) $(backtrace_sources) \
 			vpn/vpn-ipconfig.c src/inet.c vpn/vpn-rtnl.c \
 			src/dbus.c src/storage.c src/ipaddress.c src/agent.c \
 			vpn/vpn-agent.c vpn/vpn-agent.h src/inotify.c \
-			vpn/vpn-config.c vpn/vpn-settings.c vpn/vpn-util.c
+			vpn/vpn-config.c vpn/vpn-settings.c vpn/vpn-util.c \
+			src/shared/util.c
 
 vpn_connman_vpnd_LDADD = gdbus/libgdbus-internal.la $(builtin_vpn_libadd) \
 				@GIO_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
diff --git a/vpn/main.c b/vpn/main.c
index 1965c34b..a28cb0a2 100644
--- a/vpn/main.c
+++ b/vpn/main.c
@@ -42,8 +42,11 @@
 #include "vpn.h"
 
 #include "connman/vpn-dbus.h"
+#include "src/shared/util.h"
 
 #define CONFIGMAINFILE CONFIGDIR "/connman-vpn.conf"
+#define CONFIGMAINDIR CONFIGMAINFILE ".d"
+#define CONFIGSUFFIX ".conf"
 
 static GMainLoop *main_loop = NULL;
 
@@ -177,6 +180,7 @@ int main(int argc, char *argv[])
 	DBusConnection *conn;
 	DBusError err;
 	guint signal;
+	int conf_err;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -255,6 +259,12 @@ int main(int argc, char *argv[])
 	else
 		__vpn_settings_init(option_config, CONFIGDIR);
 
+	conf_err = util_read_config_files_from(CONFIGMAINDIR, CONFIGSUFFIX,
+			NULL, __vpn_settings_process_config);
+	if (conf_err && conf_err != -ENOTDIR)
+		connman_error("failed to read configs from %s: %s",
+				CONFIGMAINDIR, strerror(conf_err));
+
 	__connman_inotify_init();
 	__connman_agent_init();
 	__vpn_provider_init();
-- 
2.47.3


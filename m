Received: from pisarameressa.linjama.fi (pisarameressa.linjama.fi [207.154.243.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7933E9
	for <connman@lists.linux.dev>; Wed,  6 Apr 2022 18:09:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D75E6A9FF;
	Wed,  6 Apr 2022 21:02:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.linjama.com;
	s=dkim; t=1649268166; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pT2HekFTkpye0iYZTA46YA9leZ9t4r+I0L17O954Qa0=;
	b=T2W4CBnyqqdXTZQMTWC4FdOKfNohFu7QVD9ait1zgsBzKMPBEKtEr4htyuVBjAD2U1E67q
	7dKDoZ6O10TuHLkEiuSyDemlE2bWHkddax+4qu6CEV2fLT/YH1ypB5FdzFIgPrE2c8IOSK
	kHDPrnAkNqmRokDBa1u6r0Jtn7mMU3hMmKIlSnfiiusDDk4fgHJZbLJ/U9o4Xkd0QrxMMI
	jbMuGDTzzO4zuo4fymU1wspu/n5iZUZzDFW8+LNrU23JStPFLoVrojtjZg7n4EyAHvKkW5
	uIO+M9nUH6VAnkbiIgRimE9lID5g2iZ2Z+/xSdXeWw+r1BqD6yO/9lpfEywfnA==
From: Daniel Linjama <daniel@dev.linjama.com>
To: connman@lists.linux.dev
Cc: Daniel Linjama <daniel@dev.linjama.com>
Subject: [PATCH 1/2] build: Support configurable run dir with RUNSTATEDIR
Date: Wed,  6 Apr 2022 21:02:39 +0300
Message-Id: <20220406180240.1191631-2-daniel@dev.linjama.com>
In-Reply-To: <20220406180240.1191631-1-daniel@dev.linjama.com>
References: <20220406180240.1191631-1-daniel@dev.linjama.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add configurable $(runstatedir) to CFLAGS as RUNSTATEDIR
---
 Makefile.am      | 2 ++
 Makefile.plugins | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 15178eca..3779eab9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -243,6 +243,7 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DSCRIPTDIR=\""$(build_scriptdir)"\" \
 				-DSTORAGEDIR=\""$(storagedir)\"" \
 				-DVPN_STORAGEDIR=\""$(vpn_storagedir)\"" \
+				-DRUNSTATEDIR=\""$(runstatedir)\"" \
 				-DCONFIGDIR=\""$(configdir)\""
 
 if VPN
@@ -275,6 +276,7 @@ vpn_connman_vpnd_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DSCRIPTDIR=\""$(build_scriptdir)"\" \
 				-DSTORAGEDIR=\""$(storagedir)\"" \
 				-DVPN_STORAGEDIR=\""$(vpn_storagedir)\"" \
+				-DRUNSTATEDIR=\""$(runstatedir)\"" \
 				-DCONFIGDIR=\""$(configdir)\"" \
 				-I$(builddir)/vpn
 
diff --git a/Makefile.plugins b/Makefile.plugins
index 8e323617..bd5049ec 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -138,6 +138,7 @@ vpn_plugin_objects += $(plugins_vpnc_la_OBJECTS)
 vpn_plugins_vpnc_la_SOURCES = vpn/plugins/vpnc.c
 vpn_plugins_vpnc_la_CFLAGS = $(plugin_cflags) -DVPNC=\"@VPNC@\" \
 					-DVPN_STATEDIR=\""$(vpn_statedir)"\" \
+					-DRUNSTATEDIR=\""$(runstatedir)"\" \
 					-DSCRIPTDIR=\""$(build_scriptdir)"\"
 vpn_plugins_vpnc_la_LDFLAGS = $(plugin_ldflags)
 endif
-- 
2.35.1


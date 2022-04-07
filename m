Received: from pisarameressa.linjama.fi (pisarameressa.linjama.fi [207.154.243.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB772564
	for <connman@lists.linux.dev>; Thu,  7 Apr 2022 12:30:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EACBD68D69;
	Thu,  7 Apr 2022 15:30:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.linjama.com;
	s=dkim; t=1649334650; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5CZMrX1nj5jm+Q2sZl34h/Q+7Fl374dbj/9tcbldo7Y=;
	b=L74wuzgrAvCXlyPSnEQwKnm09mTrt0iKrYvKey4fJJRmtu2bNVMKyKp8ilHUA39t0hLSHF
	vzuHzIF8Se3O/xny8+VIzRXmJ038GhO5KSuS5iJ2+6XC8ykrlHlOuovCWTYfH7Xpn6ETt/
	ijZyJSXqfSriQKV7Rav04C60o58EhbNr+6GXQbf5nzx5QF+SPwJb4CMIQulrahbZuKfarb
	UBgpgXwxYQX6nuboqvwAvvHIyVumoTSRLGMrun/NWGil/ePNSQ6giCoKzeJeRTITUGyBK5
	+nZj/CljCTDhBhARCJ8ONhceXVcBbm8lKY9jbl2+f8uk48JWHg58pKjB7BvnfQ==
From: Daniel Linjama <daniel@dev.linjama.com>
To: connman@lists.linux.dev
Cc: Daniel Linjama <daniel@dev.linjama.com>
Subject: [PATCH v2 1/2] build: Support configurable run dir with RUNSTATEDIR
Date: Thu,  7 Apr 2022 15:30:44 +0300
Message-Id: <20220407123044.1204844-1-daniel@dev.linjama.com>
In-Reply-To: <20220406180240.1191631-2-daniel@dev.linjama.com>
References: <20220406180240.1191631-2-daniel@dev.linjama.com>
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
v1 -> v2:
 - Changed quotes escaping from \""$(runstatedir)\"" -> \""$(runstatedir)"\"

 Makefile.am      | 2 ++
 Makefile.plugins | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 15178eca..c108b8f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -243,6 +243,7 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DSCRIPTDIR=\""$(build_scriptdir)"\" \
 				-DSTORAGEDIR=\""$(storagedir)\"" \
 				-DVPN_STORAGEDIR=\""$(vpn_storagedir)\"" \
+				-DRUNSTATEDIR=\""$(runstatedir)"\" \
 				-DCONFIGDIR=\""$(configdir)\""
 
 if VPN
@@ -275,6 +276,7 @@ vpn_connman_vpnd_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				-DSCRIPTDIR=\""$(build_scriptdir)"\" \
 				-DSTORAGEDIR=\""$(storagedir)\"" \
 				-DVPN_STORAGEDIR=\""$(vpn_storagedir)\"" \
+				-DRUNSTATEDIR=\""$(runstatedir)"\" \
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


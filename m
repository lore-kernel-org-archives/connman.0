Received: from pisarameressa.linjama.fi (pisarameressa.linjama.fi [207.154.243.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E933E8
	for <connman@lists.linux.dev>; Wed,  6 Apr 2022 18:09:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D13676AA06;
	Wed,  6 Apr 2022 21:02:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.linjama.com;
	s=dkim; t=1649268167; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GuSEfNW3hHq+eO69hDe9nj8tZ2gBdEWqK9FTjkqEyW4=;
	b=DzvZ/6QH4TdEFhuyptqaqw0KQqO3QOfpR4sIPPWlCwYpfpjpcGmJti01t0F23xrppmiKYl
	uv19vrt2PubRpN/+7zPHBFIhAl7zHaJ1bYc1GY1ix9Kn9ARykEwN9alifae9WcpipPyeRr
	1uYVv87rRKriVoSqyayVMGnBzoip2FnlFtz9AWJ/v4YXoKZf1+1w6naxEkJ9l8q6ft2xFj
	uoC4crIC7i7NfbykyuOMwa+r5mB+FVhlPEzSVmYf+xlSJTuP4Bn0zpIxDFJdlNrirPnuP1
	9Q8+Xv12Wp6PX+hXrv1TUgOFx+oIz1wmj83u2Xz6435k64tQriU7/daBtUc+Uw==
From: Daniel Linjama <daniel@dev.linjama.com>
To: connman@lists.linux.dev
Cc: Daniel Linjama <daniel@dev.linjama.com>
Subject: [PATCH 2/2] vpn: Replace hardcoded paths with RUNSTATEDIR
Date: Wed,  6 Apr 2022 21:02:40 +0300
Message-Id: <20220406180240.1191631-3-daniel@dev.linjama.com>
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

Replace hardcoded /var/run paths with configurable RUNSTATEDIR
---
 vpn/plugins/vpnc.c | 2 +-
 vpn/vpn-util.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/vpn/plugins/vpnc.c b/vpn/plugins/vpnc.c
index d11b9111..73012c5b 100644
--- a/vpn/plugins/vpnc.c
+++ b/vpn/plugins/vpnc.c
@@ -54,7 +54,7 @@
 #include "../vpn.h"
 
 #define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
-#define PID_PATH_ROOT "/var/run/user"
+#define PID_PATH_ROOT RUNSTATEDIR "/user"
 
 enum {
 	OPT_STRING = 1,
diff --git a/vpn/vpn-util.c b/vpn/vpn-util.c
index 9ef14d38..bc3b01dd 100644
--- a/vpn/vpn-util.c
+++ b/vpn/vpn-util.c
@@ -102,8 +102,8 @@ struct group *vpn_util_get_group(const char *groupname)
  * running a VPN plugin as a different user and thus, user specific run dir is
  * allowed and limitation to access any other system dir is restricted.
  */
-static const char *allowed_prefixes[] = { "/var/run/connman-vpn/",
-					"/var/run/user/", "/tmp/", NULL };
+static const char *allowed_prefixes[] = { RUNSTATEDIR "/connman-vpn/",
+					RUNSTATEDIR "/user/", "/tmp/", NULL };
 
 static int is_path_allowed(const char *path)
 {
-- 
2.35.1


Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7A2C83
	for <connman@lists.linux.dev>; Tue, 12 Oct 2021 07:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEA2E61735;
	Tue, 12 Oct 2021 09:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634022413; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kvr1hhqeDmFMEJ23ztlnhgWsM0vxhjdTX1WTWeDBPKY=;
	b=VXmMWF5u3CDy9PDHnitjHDRc4Vh/XFlAYsuphzEt1Aw2AdawxsgmI10u4NtnxE6Crffpfr
	xzE6KoRbtZDb+czFJiTDMFTMX3P98+r7g1O7BTsscIrZ0zm+jEC30uAxX7Zdl1UyH6nBIP
	ahsw5Hoqmf1EvWE2ZgZp0Ei5GPIfvSiZOZ7lvLlx9sCZwbL0hItZOPYKIPjES4GSr8EAVD
	ONN+g5YdzRYdIq/whbvnop7Hv1vjD2ylv9S91Au0qt5WXy4pSkKudeBQhwvKN7g2bYCBCh
	UaoH308BiO2e6TC+qiABjj1CsgdlWLVDBTvWdsHqZI9p9yHzNc/Fi9y4GrDPfw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 3/3] gsupplicant: Fix error return type
Date: Tue, 12 Oct 2021 09:06:48 +0200
Message-Id: <20211012070648.28947-4-wagi@monom.org>
In-Reply-To: <20211012070648.28947-1-wagi@monom.org>
References: <20211012070648.28947-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

clang complains with:

gsupplicant/supplicant.c:1220:10: error: expression which evaluates to zero treated as a null pointer constant of type 'const char *' [-Werror,-Wnon-literal-null-conversion]
                return G_SUPPLICANT_MODE_UNKNOWN;
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
gsupplicant/supplicant.c:1228:10: error: expression which evaluates to zero treated as a null pointer constant of type 'const char *' [-Werror,-Wnon-literal-null-conversion]
                return G_SUPPLICANT_SECURITY_UNKNOWN;
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Return NULL instead of the enum. In both cases the enum is 0, so there
is no change.
---
 gsupplicant/supplicant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 8316f48ae0bf..470d99eb36b1 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -1217,7 +1217,7 @@ const char *g_supplicant_network_get_path(GSupplicantNetwork *network)
 const char *g_supplicant_network_get_mode(GSupplicantNetwork *network)
 {
 	if (!network)
-		return G_SUPPLICANT_MODE_UNKNOWN;
+		return NULL;
 
 	return mode2string(network->mode);
 }
@@ -1225,7 +1225,7 @@ const char *g_supplicant_network_get_mode(GSupplicantNetwork *network)
 const char *g_supplicant_network_get_security(GSupplicantNetwork *network)
 {
 	if (!network)
-		return G_SUPPLICANT_SECURITY_UNKNOWN;
+		return NULL;
 
 	return security2string(network->security);
 }
-- 
2.33.0


Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14C199A6
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:04 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e12f41e496so1177542fac.3
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112823; x=1696717623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDKTPX8CTOtvfHqeEmHgANVhTvneTAU/niaLzpZdc2Y=;
        b=RtcPJgx1D3ejBT6DFtU3dn4CAVAw+stn7PMajP0/5xnymm/Jnt7G8eDu1JB67dRand
         h8EVyKDgr+1l3EFK+OptyLJQR/r5BJWwlQC5jb5AlIBWXLAIkgRRL9RKmnbfHLfx4NsZ
         KdFDvHrn07oUibeCho1NDcwkLTplu/C63Butr2eGwXbcC5vKmy3I1zyf9V4K3BsDLfmN
         ppy5vvdHK5RotVpyriyauxH1iFXYrfgIE3RZhF4A3XJt7V3VCLflOGMecs9tQ4v9+Hkc
         cYDYwYTbhwMgMLiGIlmDPL7ApbvWz00cWqfegDnjykxM5GmdhTNQ+1jVhb/VxTYYqiUJ
         j6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112823; x=1696717623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDKTPX8CTOtvfHqeEmHgANVhTvneTAU/niaLzpZdc2Y=;
        b=oXwfZ2WLIQWHrpxyF9lIwgI/nc5ZYlIHZbxgtZdL4kHExMOVoeq7vmKCgjNjHmW7HC
         C+uzNMUa47kU3GgNdcylylquFyMtCPQ7YowzSETL5YoivgNyehPxbVXL1Az0CcDc6be2
         DKsSsIQaT08MGFR+Qc6mzYuuxnlMxlp9kfT1Iafhp8cl6IIlWPQJeXiB7fWy6c6Ncv68
         6+wijr0t7eJ9SjJSPkLQBZKj7gVDJpYKJNbI9vu2Uyd3oioMl4WnMQum5ILSXRJbyZ8+
         O/f7o3kKYPIpNAY6W5fNDWrVCai6NFfg2KTz+T6MLx1H7VdY2QBLoh+KZLyrR9uNy1MI
         sI0Q==
X-Gm-Message-State: AOJu0YxnjTkz1U6QSj8+cHhHHSG1KEQIG7v/4otGbXI2BVDH1iAE6JTw
	y3K1snjTksu7I+94zbqZ9lEVHBiWStM=
X-Google-Smtp-Source: AGHT+IEXO2H3l2Zuv6Uamq+GE1EFfanRJLlPvvs9JSvaOn8ZRPcuLhgMMD+paiSz9s9HJ58TXGXxCw==
X-Received: by 2002:a05:6870:e256:b0:1c8:bfd1:ecb8 with SMTP id d22-20020a056870e25600b001c8bfd1ecb8mr9088996oac.30.1696112823277;
        Sat, 30 Sep 2023 15:27:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] vpn: Remove unused __vpn_provider_check_routes
Date: Sat, 30 Sep 2023 17:25:52 -0500
Message-ID: <20230930222615.654178-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vpn_provider_check_routes isn't used anywhere.  Remove it.
---
 vpn/vpn-provider.c | 16 ----------------
 vpn/vpn.h          |  1 -
 2 files changed, 17 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index cc325967..4bcb8373 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -2952,22 +2952,6 @@ void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
 	provider->auth_error_limit = limit;
 }
 
-bool __vpn_provider_check_routes(struct vpn_provider *provider)
-{
-	if (!provider)
-		return false;
-
-	if (provider->user_routes &&
-			g_hash_table_size(provider->user_routes) > 0)
-		return true;
-
-	if (provider->routes &&
-			g_hash_table_size(provider->routes) > 0)
-		return true;
-
-	return false;
-}
-
 void *vpn_provider_get_data(struct vpn_provider *provider)
 {
 	return provider->driver_data;
diff --git a/vpn/vpn.h b/vpn/vpn.h
index 477cb227..dafb40c3 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -73,7 +73,6 @@ void __vpn_ipconfig_cleanup(void);
 #include "vpn-provider.h"
 
 char *__vpn_provider_create_identifier(const char *host, const char *domain);
-bool __vpn_provider_check_routes(struct vpn_provider *provider);
 int __vpn_provider_append_user_route(struct vpn_provider *provider,
 				int family, const char *network,
 				const char *netmask, const char *gateway);
-- 
2.42.0


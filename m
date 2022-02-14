Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA31627
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 02:20:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so5060685pjv.5
        for <connman@lists.linux.dev>; Sun, 13 Feb 2022 18:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1aUdPmhBOk4yHIqaKPKdu21+6eoQaXTyW/ifmgWNa4=;
        b=N65ufFG1yTqhhWd+HSzvOAnHe/9hpMB+nqsf19Yu8ES9PmOYPL6JYMJmkW3AtB78UF
         hEWCLU+qBSUNv3GG5zWXvqT0RbxdzF0Vg7GuaQFkihkGEcwFob5/WPJiePdJR34SG0on
         mA9qHCFqqWViLOjDiZFjL8dETf0WZlSIEVNcqZfaObI1M5Ic6T2MP87REgd7V4ZC+4yl
         8vubnfwp/cxrVGCHIF/FJ3vr2O9ckIAHjERlWInHjvoIMWHOj1h1FkGEne5tZmrY5A+f
         pFIzLRrYbK71oYSnEHGo29bzVTkn7q+FjICOgmeYBOnzV9OVVShyLke5joFq6ZmHVuYh
         J9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1aUdPmhBOk4yHIqaKPKdu21+6eoQaXTyW/ifmgWNa4=;
        b=haBivfJxEyXTRdiTLfPoXNA8czGFJ4K0U1Ir9OZt2D9oV1I7o0GfSlr/tFjzQ6nqyF
         teeZFczNYXytjmOXFfpdIjLI+IcRPxkXdPHh41YmEVgfZN8y4Er7fYlxA/QpzJxWRpNP
         lCfukgtQcBORlznJd1K8t5kTU0ptnHtEazefIsa8n7Sfz3edXmcpOmUAK4tPQ3+1aVuU
         +cSRhyrARxmqa9O/aGKHr54Htp0u+4meQQXuSvlLaxGznSekFwMUt5uaNTuAwUblVXvU
         9qc90ZNq175cY3Ls8Vm8Nd2LjRvamkoIQ3JSKKx9UjoEmnr65bHArPv6Wwep8CDs72kx
         xXiA==
X-Gm-Message-State: AOAM5324+9qqa3kF52oqNhtPZG3eyPDUCtuF2CYMtTmQkG/V63cplq3U
	FURqEg6Ge4tem4DRdCkFL+fDCEEDDHrPZg==
X-Google-Smtp-Source: ABdhPJx1XTm9TUaUySdgFRZeGSFQZDugPLmYkqwuDD+D0OotjLwT4I6JhPSpbmzKpNLu4yE1/QaSXA==
X-Received: by 2002:a17:90b:98:: with SMTP id bb24mr11887945pjb.175.1644805254090;
        Sun, 13 Feb 2022 18:20:54 -0800 (PST)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id q32sm25581745pgm.26.2022.02.13.18.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:20:53 -0800 (PST)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] iwd: Fix typo in warning message when enabling AccessPoint mode
Date: Mon, 14 Feb 2022 13:20:43 +1100
Message-Id: <20220214022043.523341-1-net147@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 648ed549f0ac ("iwd: Add support for tethering")
---
 plugins/iwd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index ac3d1e17..357f2c36 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -693,7 +693,7 @@ static void tech_enable_tethering_cb(const DBusError *error, void *user_data)
 	}
 
 	if (dbus_error_is_set(error)) {
-		connman_warn("iwd device %s could not enable AcessPoint mode: %s",
+		connman_warn("iwd device %s could not enable AccessPoint mode: %s",
 			cbd->path, error->message);
 		goto out;
 	}
-- 
2.35.1


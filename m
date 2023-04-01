Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7292CA5
	for <connman@lists.linux.dev>; Sat,  1 Apr 2023 23:51:21 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id u10so24836704plz.7
        for <connman@lists.linux.dev>; Sat, 01 Apr 2023 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680393081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Exda9SyHXeMYrVMA/RMb5G53/fpz5K9VtwrveTN+5mg=;
        b=FE1NyOG0Oib3w0GoEjpwr64K1sJYMtHQiWJGNvGfBr8wOP1/sNqn9FajqT0A2ol9yW
         v/p13pScsHzXn9Cw+0PYqbHSkW3Efkuad7+nBRMlX8UvEYaFUNyeFaFEmCbtWKhPuvSY
         8JAz34AeI0uoo7AUgO/k0f/TWmvgd3tcN/gs1hjefeKJXgaMs09RHhCFxPTq0Ta2p3u+
         vBxmWbXwl/SPm9ejQD1wJUFK0Gi4UxtwbzP/BXIM/zCFcSz8ioqLLSTuKQNBjPG9mz/f
         ySgsgFHFcFmYIFKCb6usaYtVGeuShEDSVnY63n6qk8vmGoWQ/mHN9eQQDMXhlf375KJt
         ed9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680393081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Exda9SyHXeMYrVMA/RMb5G53/fpz5K9VtwrveTN+5mg=;
        b=g0dP1pnOEHFUWFLyPj7deB1PCoh6ijIo1WroLfSxkkUXJEfnuc3PrMLcEaz7Fa+R4u
         0iCz3zro7KpNeX83su6YOYP7Ob6WJ+TYB3eq5gyqcxJPkXINA4qOiVkBmmQmrGsCqTyu
         8USaXesnujx3uPpmrUk/QJ5xgJbBfXRq8BNZehBjWhcIaADFN7ApNJ+TD4mTwes8O7OZ
         GY8tfglfdQd/4LmyHCy1pPnAGQeQYIpDSqf0vKyg+FC9fa8thtXqnxtTPDl6xRARmtJ/
         HAzOxosF4FcuOFetASEOcTU4C+y043NDZW4BAALxR1o/dXl3L5wWQ1b6+KD8iR6a6sRY
         Mp5Q==
X-Gm-Message-State: AO0yUKUFUXbcb/ZOOxcnsGnSc+c4FKyXLmfj7wuFa1QInohWb5OJ3MRX
	wXqgKPAF9UTYraL0HtdMUgo=
X-Google-Smtp-Source: AK7set8Yu+9pi0v2PJAjBM81Ay1aK7zdEfc/BthXq8lv4818Q431qxUkbblBmnQvMSIlcjp+J2SI3Q==
X-Received: by 2002:a05:6a20:8b9c:b0:da:d9e7:9a5d with SMTP id m28-20020a056a208b9c00b000dad9e79a5dmr27855306pzh.4.1680393080406;
        Sat, 01 Apr 2023 16:51:20 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b005e4c3e2022fsm4124192pfd.72.2023.04.01.16.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 16:51:19 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] ntp: Fix timeserver typo in warning when ntp_data is not NULL
Date: Sun,  2 Apr 2023 09:51:11 +1000
Message-Id: <20230401235111.107463-1-net147@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the timeserver variable is incorrectly referred to
as timerserver. Change it to timeserver to be consistent.
---
 src/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ntp.c b/src/ntp.c
index e7fee22a..5d0df9e5 100644
--- a/src/ntp.c
+++ b/src/ntp.c
@@ -577,7 +577,7 @@ int __connman_ntp_start(char *server, __connman_ntp_cb_t callback,
 		return -EINVAL;
 
 	if (ntp_data) {
-		connman_warn("ntp_data is not NULL (timerserver %s)",
+		connman_warn("ntp_data is not NULL (timeserver %s)",
 			ntp_data->timeserver);
 		free_ntp_data(ntp_data);
 	}
-- 
2.40.0


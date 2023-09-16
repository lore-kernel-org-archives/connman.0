Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B17E
	for <connman@lists.linux.dev>; Sat, 16 Sep 2023 20:01:38 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5008d16cc36so5411731e87.2
        for <connman@lists.linux.dev>; Sat, 16 Sep 2023 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694894496; x=1695499296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmMASaEMy37GYKHTouoBstMa6q1XIXzj8fk8ZidQ1Jw=;
        b=j4xqmqkFxP2g04AzNY36ydLNWsTir/6zw7brBqBW72oTrbSwbnS05GuwJnLVpyC1pX
         n2UdijYZRDxrqvTvPXEMoOvx+OoqrwhG/4rcG8/RHeFDKZjqPOWlUEH2c8P3jNwXiw9q
         Wv8NJezoGCQGhXDw5LdgwEGdg/GWdtj5nWz7qFIZqimyp6P34/3owQ/wgDBg9NgeQZZp
         nhka7Aqp/99DNPcWuPN0oanIi0pCW2uKEOG91MvBpaJdxsiivd57L4bxaEQ2osT0AbsN
         neehByAcwmJ10BU2Je0stQcV2ygvGg2H5As8fxDSL2Z7vfP68jQatvoXGiVvAXh2gzXL
         y6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694894496; x=1695499296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmMASaEMy37GYKHTouoBstMa6q1XIXzj8fk8ZidQ1Jw=;
        b=L+fEuh2a6wpg91K0m4X4XjxLLO2wfb8OwQ6gesqHiyo+z6+ANpS8yssbaL6kzq+jKp
         c50keo4ASQlka3gduSVIJGlf/mTXlXNho1N2BoR//4yKFq/Shi/OJg/QkxsMIrI6Oy5l
         lFMve7QpllGbgOVtNdSfvXkdsyMPBaNq17Q1q/4kw8WM3spVJ4DrZ0i/+Xzqdtc2vvMZ
         Ud/aKVrMtCvNmm2ZJuPW4lCi1aNKDbv7W5CJuJqakV0/ChbsrHvrf2Jsj4Q3tC22e8mv
         ZP6Dd/FR0VxvXczCYCOKj0X/40KhEcZEwWPBS4WCgUHg+zupzEWgjOU0jGfvS+dccyCa
         n0aw==
X-Gm-Message-State: AOJu0Ywlj9gDNAs9tl5QIn6IvZMpNq4uE4lLdNx1xGuyF1CRIuFnPisL
	CCgTIEi6jQti302VWrIOcZT9INrtDyk=
X-Google-Smtp-Source: AGHT+IHhoOJeyeIGW7N/7a2/5uHUl+608YSVwGWLmpUYhWLQFlXC6keBdfG2F50YlmCRLqv0xqKv1g==
X-Received: by 2002:a05:6512:3096:b0:500:94aa:739c with SMTP id z22-20020a056512309600b0050094aa739cmr5039132lfd.61.1694894496203;
        Sat, 16 Sep 2023 13:01:36 -0700 (PDT)
Received: from marcus-elitebook.. (c-0c3271d5.010013-0-69747578.bbcust.telenor.se. [213.113.50.12])
        by smtp.gmail.com with ESMTPSA id h13-20020a19700d000000b005007d16ad7csm1136821lfc.245.2023.09.16.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 13:01:35 -0700 (PDT)
From: Marcus Nilsson <brainbomb@gmail.com>
To: connman@lists.linux.dev
Cc: Marcus Nilsson <brainbomb@gmail.com>
Subject: [PATCH] config: Don't warn on `global` section when loading config
Date: Sat, 16 Sep 2023 22:01:15 +0200
Message-Id: <20230916200115.956547-1-brainbomb@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the `global` section is supported and already validated in
load_config(), skip over it without issuing the warning about it being
ignored.
---
 src/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/config.c b/src/config.c
index 33fdc737..d2832187 100644
--- a/src/config.c
+++ b/src/config.c
@@ -819,6 +819,9 @@ static bool load_service_from_keyfile(GKeyFile *keyfile,
 	groups = g_key_file_get_groups(keyfile, NULL);
 
 	for (i = 0; groups[i]; i++) {
+		if (g_strcmp0(groups[i], "global") == 0)
+			continue;
+
 		if (!g_str_has_prefix(groups[i], "service_")) {
 			connman_warn("Ignore group named '%s' because prefix "
 				"is not 'service_'", groups[i]);
-- 
2.39.2


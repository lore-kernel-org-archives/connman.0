Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DF4123A
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="JyUm2tCY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3366827ca79so3242810f8f.3
        for <connman@lists.linux.dev>; Wed, 20 Dec 2023 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703086973; x=1703691773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JimXoe1M/x7y8uDuk6sUFCHNm8EtX96wi+Kfh3LzPg0=;
        b=JyUm2tCYMZ+9GKhYYatoY7bOhAaUC6uvD/wJ5fAhYgSs8SY+dSnlnOMaLGi1XETWPY
         skXL7i9nlaK8NAe5WLRT0ldpTJ/L31Fvl33omKbHaejNswty1yMvfJ0IU/LqG9uCt+uS
         La1KgcoArdYFe5BSC4xKRl41TRhrbScb1gRTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086973; x=1703691773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JimXoe1M/x7y8uDuk6sUFCHNm8EtX96wi+Kfh3LzPg0=;
        b=SHL3dTq6wT9woc6wtZXsl4ZuXL/oxWzGKgZuwG/SSHH/VhvFpTY8XAIvyq0G3uw+k+
         KmxFF1swHzfWVPb/q+7rwHf3Gjr4vfnra87zjf/vDqS8MOEuOSDqwvDtx5MynN1q3xd9
         /fmO5p6J4OumgXFc3lxh+elYRe/Z+oe8xzoO0CPfoj5JXdZSralUY9FIb+bhw9aPiIuK
         M+OTWYLUBCUECf7hBUcKHxLPOkWUcnf0EwZEzrkPhSVXG/NsQdWVnsEsU0GSkTZSJMU/
         KBoVt6lPDoYDmuPP+z3J81sn80kll1clZz5BNNWWPramK9frWXKUs5QqTmUz6XmAAUmB
         XW8A==
X-Gm-Message-State: AOJu0Yxtdd2qN3hZJNIhE+DgkoLLdlACV5v9og9R7sCcwofX5FYDQRy5
	6IZWN4Ns+r6YdoKnjUY275q06+K4hYl8e737kM8=
X-Google-Smtp-Source: AGHT+IHuMQOhGBbWdNF9eA862kfMtK+PBkYFctDuHqt4j/9Own74nPSnpxQNCR0CeVyQ692x+OEjOg==
X-Received: by 2002:a5d:64c7:0:b0:336:6b17:a394 with SMTP id f7-20020a5d64c7000000b003366b17a394mr4800091wri.97.1703086973051;
        Wed, 20 Dec 2023 07:42:53 -0800 (PST)
Received: from acme-iron-carrot.home ([2a01:14:112:2860:24e1:e1c3:823a:9b45])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b003367433118bsm4327938wrt.78.2023.12.20.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:42:52 -0800 (PST)
From: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
Subject: [PATCH 0/2] Add option to omit DHCP Client Identifier
Date: Wed, 20 Dec 2023 15:42:46 +0000
Message-Id: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While recently working a customer project, I ran into an issue after
upgrading the OS to a newer version which uses connman for network
management.

The DHCP client in the old OS didn't include option 61 (Client
Identifier) but connman does. In this scenario, when the system
reboots after an upgrade, it changes IP address, which can get very
confusing, especially if a UI is waiting for the device to come back
alive to signal completion of the update.

This proposed change adds an option to main.conf - OmitClientIdentifier,
which, if set to true causes that option to not be added to DHCP
packets.

The default behaviour is retained in case no option is set in main.conf.

The change is relatively small, and I'm posting it here in case it is
helpful for connman users facing the same issue.

Please feel free to consider or exclude it. If there's anything that I
can do to improve it to match upstream requirements, please let me know
and I'll do what I can to help.

Cheers,
António

António Oliveira (2):
  add option to omit dhcp client identifier
  add documentation for OmitClientIdentifier

 doc/connman.conf.5.in |  5 +++++
 src/dhcp.c            | 18 ++++++++++++++++--
 src/main.c            | 17 +++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.34.1


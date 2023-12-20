Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EC3FE4E
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="rsucoq49"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3365f1326e4so4407622f8f.1
        for <connman@lists.linux.dev>; Wed, 20 Dec 2023 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703086975; x=1703691775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4DsyEDlqSEPyjQH0/pdX3LM60vOk7T7a+E015g90L0=;
        b=rsucoq49sly4TGrHxbw8qYztAJsCyUxCBk1HQ0XehBTTMZ27o9j+vtCrmRNvoMnGVa
         fDk1/hUuH/PcRB9aJNMGe0zgDDf+NlZDNOI4Y8Qc0pOLkooHkEzvSWVNfAO9xJPAwa0g
         mztBdf39FO/mGD7Kk2TZ6kO8KVpyhHo6vmk+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086975; x=1703691775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4DsyEDlqSEPyjQH0/pdX3LM60vOk7T7a+E015g90L0=;
        b=lyNFdfFtt+Bb1b+21kSDC03+4SIsWaxEQww7lhyr/5fw/lb7aZnWex5Vf21cxl+6yZ
         K6U1BUbXqQXBPoQqwiyfAHeQLLjT+tAkXlvCFS6GUAcbKi9Dw31tNDzWLsPfw6agDn7J
         of2q96OP2mYf1v+n/QtNc0LWr3sVLbfSo1H35xYYxIC15Qw+4GU+nBR6DbjYPhtAFhsq
         E7L8CVUCsUxUfqJzDLa3zwKHkhmI/OZ3EULHg9ll2SYxhsqocQc8xccjH53N/fEHUN2H
         bfNzVGBG+WB7OS6p2jGfC+DZftXX0m2kJtFcveEkvzA65uFuivzGp6im+AzMobkwokpl
         5sow==
X-Gm-Message-State: AOJu0YzOol0M1iElC5CJzUu504sPhP9pFM0AQ8e/K0wl8aUCUk6Ho/8L
	BLfcMexiqdIJ+TEFPhw02/fAbx+bP1FS+R1CTpI=
X-Google-Smtp-Source: AGHT+IGx1VAEfaODDvNFIK7hAI76PbaQpS4iONsMDzNVqwuc1vAw8B6YiKZsNL/IolOlzaBX7m6PdA==
X-Received: by 2002:adf:ea48:0:b0:336:7632:cdbb with SMTP id j8-20020adfea48000000b003367632cdbbmr1380247wrn.22.1703086974930;
        Wed, 20 Dec 2023 07:42:54 -0800 (PST)
Received: from acme-iron-carrot.home ([2a01:14:112:2860:24e1:e1c3:823a:9b45])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b003367433118bsm4327938wrt.78.2023.12.20.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:42:54 -0800 (PST)
From: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Ant=C3=B3nio=20Oliveira?= <antonio.oliveira@konsulko.com>
Subject: [PATCH 2/2] add documentation for OmitClientIdentifier
Date: Wed, 20 Dec 2023 15:42:48 +0000
Message-Id: <20231220154248.91773-3-antonio.oliveira@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* added the documentation for the OmitClientIdentifier in
  main.conf

Signed-off-by: António Oliveira <antonio.oliveira@konsulko.com>
---
 doc/connman.conf.5.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 9049d703..71263675 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -159,6 +159,11 @@ Set DHCP option 60 (Vendor Class ID) to the given string. This option can
 be used by DHCP servers to identify specific clients without having to
 rely on MAC address ranges, etc
 .TP
+.BI OmitClientIdentifier=false\ \fR|\fB\ true
+Omit the Client Identifier from DHCP DISCOVER packets. When true,
+DHCP DISCOVER will not contain the Client Identifier (option 61).
+Default value is false.
+.TP
 .BI EnableOnlineCheck=true\ \fR|\fB\ false
 Enable or disable use of HTTP GET as an online status check.
 When a service is in a READY state, and is selected as default,
-- 
2.34.1


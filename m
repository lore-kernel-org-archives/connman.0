Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B4168CA
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEE8/+N+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso787326e87.0
        for <connman@lists.linux.dev>; Sun, 19 Nov 2023 11:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423262; x=1701028062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X0sBqaBM/4vk23QHpN4OKiQIW3YzdhUNTulA/o9Z3K4=;
        b=aEE8/+N+M7d10Kekoc1hZXXo+XyMUHFvHAlKCKSsKZJIoxbSL2NBULR0cZeJJUfvY9
         DnTZssfkdzN2mj6lQHd6vWwlEPNldXWW9Pmi+1a41R1VWrmhcBW58IUuw3hWTgPxC0Ek
         jZQ1RqIzvMPT3lSF11genU9lTCQZHDis/9zV8Q5/qpT6yNURcwZCXED7HlykylilQLo1
         ydrkcOG5bPLczdiVFrfS8mNmRJkZ9/mkcqSXgIVmDCEGk3rzGybFLo3BUCXv+i73wl5h
         lHxlPothWGc1Llbb+YYZU5RCp0KBS+56zRcNKqGhDMn3Z0oF9XqTGFXWUo2RIYtrGXbM
         Dd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423262; x=1701028062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0sBqaBM/4vk23QHpN4OKiQIW3YzdhUNTulA/o9Z3K4=;
        b=h4Gtxn5o8Vg4z1mYA1N8i241XZ2NNXAJ0U9LJlmF6+TZUl3wmBz11O7em6TE/z16FS
         NPIZGR34C1sBc4h77QFHQC5fp8e4zPgOUtOYqZalD6TUuZIDiwyMZw8Sm7QOd8LyaY6K
         2y0lpg9TN7Udj9gz5zDX867BMZsCkFV1d0+a2f6H8/0v4N21tm59YSfEsLXbSFa9Ybya
         6vDdaml6MnShKkOIbKA+pilM8JYyn6enXSh3/I8fu/5heNAr3uEOn+EuugFHwj6J373x
         ms85UiV95XFEm3z1UAD7nzIJc+OB/5AA3OlXzvaZWy87K1D71lzrigP9lOUyIV8CIoC/
         o0pw==
X-Gm-Message-State: AOJu0YyOZbubvwDeKjT4TpC6sIqiFfgbVROwVpgy4tEiInfufbG8I8+W
	zdfir50OoLQBVJ3PWT+Qjh+Qv9/yBdA=
X-Google-Smtp-Source: AGHT+IFxfyQAAwXrbLwjyytgPEPsR7k7x36RdcC+Tn5/KkdB4FoWFQLNZSomhflxTYfXMIR+yO5VBQ==
X-Received: by 2002:ac2:4947:0:b0:503:261d:eab8 with SMTP id o7-20020ac24947000000b00503261deab8mr3766260lfi.28.1700423261877;
        Sun, 19 Nov 2023 11:47:41 -0800 (PST)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id z25-20020ac24199000000b00505a5ea726asm939950lfh.309.2023.11.19.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 11:47:41 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: connman@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>
Cc: marcus.folkesson@gmail.com
Subject: [PATCH] doc: add the optional freq parameter to the connmanctl manpage
Date: Sun, 19 Nov 2023 20:51:48 +0100
Message-ID: <20231119195148.73668-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'freq' to the parameter list used for WiFi Tethering.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 doc/connmanctl.1.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
index d87472c3..cf662ca3 100644
--- a/doc/connmanctl.1.in
+++ b/doc/connmanctl.1.in
@@ -10,7 +10,7 @@ SYNOPSIS
 .BI enable \ technology\fR|offline\ |
 .BI disable \ technology\fR|offline\ |
 .BI tether \ technology\ \fRon|off\ |
-.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\fR\ |
+.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\ freq\fR\ |
 .BR services \ [\fIservice\fR]\ |
 .BI peers \ peer\fR\ |
 .BI scan \ technology\fR\ |
@@ -86,7 +86,7 @@ by default since tethering it usually breaks local networks. See
 for enabling.
 .PP
 .TP
-.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase
+.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase\ [freq]
 Enable or disable wireless tethering, as well set the SSID and passphrase.
 .PP
 .TP
-- 
2.40.1


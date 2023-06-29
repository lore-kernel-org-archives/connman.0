Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F953FEA
	for <connman@lists.linux.dev>; Thu, 29 Jun 2023 09:58:31 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso484701a12.0
        for <connman@lists.linux.dev>; Thu, 29 Jun 2023 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688032709; x=1690624709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X0sBqaBM/4vk23QHpN4OKiQIW3YzdhUNTulA/o9Z3K4=;
        b=NvPD2f30Y3vQM2NgY6XpbtKr6VvYMZzd321TxnoNpQsPrGlCpDs+lE4PZ13lM8/mrc
         rR7n26bS1V0NhRy4HUggYHrOmXbjnr748xXUCItx6AIlAf8P2cDuJTXgraMidZcdViDD
         LvmWbGidEGD8Vl/e0DGcZHf8DIKB7Otc67tyW+m0TUWtTKRpiGf2HnG76B9UjhspXVsk
         mzJlK3TUKp59OAp4GKhJCjHf2AEQqMQzwWkI+zwz1PZ4PWx3rgdM7eOH0nT1kQdQdaBJ
         7KOeP9JSRjucYLs7ROsJ5+fCaOkh8fCDjmJA5TIltIBw8vijjS6Ch1Tihbgyzt6BY6g2
         ilCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032709; x=1690624709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0sBqaBM/4vk23QHpN4OKiQIW3YzdhUNTulA/o9Z3K4=;
        b=X9z5dxsQ8rJC8c/oxDQlikWeRcGELi3t//SISx1uWIpatUHDhw41xRm+74UPpKpNA2
         Dyh4Npxo7m1XmIlK3ygajUl6IYvPDZ+qrUdme4iKk8MjUkC7eXHyUTpBoaPqvEAHtZA3
         8J+kvmHnQ+FAtvZJgDmX9Hkd7OGiCnH6rMmkUyytQ2wQiMtjMW5juIazQBdyhZdwNeVT
         4Jag7m6hHwi8resSwGuI2ikR4Q3UF2XHyR9o10hSMQzOO8bV10TpGZsbrZ3MGWMQGvpr
         VEyZ5rmtiQvZX2op2wHeUQO7wIuUhYoVPPCYIszq5hKoXwhfHA8w+1+qZcYk+aqWbiza
         GU3g==
X-Gm-Message-State: AC+VfDxSsEOVcaZheB+gdEloeMrob/sauhN5ldtVQBW00g6e4+dZJvS2
	CSOB866F0aLvE7zE26/OzBQfmm9D6NGUIA==
X-Google-Smtp-Source: ACHHUZ4Bafmmw5TWnavLEq4hr8UKG2JYQj8vueAC2rfr7V8GWdFx6VqYlXylXYOXgcudxc5s62iCSg==
X-Received: by 2002:a17:907:62a7:b0:986:f586:b97 with SMTP id nd39-20020a17090762a700b00986f5860b97mr30841528ejc.59.1688032709044;
        Thu, 29 Jun 2023 02:58:29 -0700 (PDT)
Received: from goliat.praguecc.cz (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id k19-20020a05640212d300b0051d988bd64bsm3965187edx.97.2023.06.29.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:58:27 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: connman@lists.linux.dev
Cc: marcus.folkesson@gmail.com
Subject: [PATCH] doc: add the optional freq parameter to the connmanctl manpage
Date: Thu, 29 Jun 2023 12:00:00 +0200
Message-Id: <20230629100000.49254-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
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


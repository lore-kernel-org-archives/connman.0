Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37A14AB5
	for <connman@lists.linux.dev>; Tue, 11 Jul 2023 15:40:38 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e5672d580so3761859a12.2
        for <connman@lists.linux.dev>; Tue, 11 Jul 2023 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689090036; x=1691682036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hpzs/RI/RAhm7sXpu3ICY961MzaQRJaxDCedSXVXErE=;
        b=dpe+Dgjmc6qJdDZ/lp8JemQNA+5ytPUhtpS6BCzlXD0RveIFvWKFsGrrEgsLzK784P
         PSoZq+mQtSdYAf72pqCwVGoZPmD/CmbSG9MEDvqQsNKK/dRBGy9EPR6zfsc1D7uILsDB
         aupBAe8vUONGagF7WEugsfTAJ+NmGs6freFs3v7wyTkBavST51vGmGYSuD7JAZ+B19RD
         NSCkfesZtpGRipFkCVVw+jrBG0GP23lN6NwjXGG2bjl4G+r5SdHqMsBjs5hMJnUKvRKn
         3s0kDb6QB6Ywb2tjUzrZIPlvXPkk9eJW2pfrwH7ncmbxyM6kGCBVFPkkFd1yaVpdGG0D
         0/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090036; x=1691682036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hpzs/RI/RAhm7sXpu3ICY961MzaQRJaxDCedSXVXErE=;
        b=XUnywybo6SKq5chLse4WvetXJCkTSphd85XslE/O96ja0Z6DgYudaME55OPFDsr0+A
         5LPrVehoUGxI/adTJjCxvStIE+zjdm4Y9Ci06lZvvMEIEY2xy6QqirKiz64KPvVJSgKl
         JlKknhQ0zebzZ7fcM/G3K1PGe23UmcVATbbF0IG5NozbBk+nnpxG4+mEru9bw1TgnVQt
         H6UA8h2rstNlyu9PVR/G6OkCleVU79rIPtZwPx3nMsLwMrTtqeYnRzH43KE3C2Bixcr7
         z2ODDBwb71EeiSE55crawIFECfWW2+/Xo5Vsc/MdB8PNHaFom2M/DaCwkJgLbFYOYRFD
         DEvQ==
X-Gm-Message-State: ABy/qLb5vVXctojopSMSd3gHEUIQ8aHmIKUePTPyPsW5g5noz+i9g6VP
	vqfic3+6bT9w/ozylwbF5CHdrhvDwl0=
X-Google-Smtp-Source: APBJJlFrRWcXYNFLJCwbT8TbJjobK/ksU4JgnrzK//itgylHT0BF01OSpv5VjtsE+tpAEmUYD9uTLA==
X-Received: by 2002:a17:907:2383:b0:98d:63c5:d132 with SMTP id vf3-20020a170907238300b0098d63c5d132mr15391522ejb.72.1689090036260;
        Tue, 11 Jul 2023 08:40:36 -0700 (PDT)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170906f91000b0096f6a131b9fsm1314365ejb.23.2023.07.11.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:40:35 -0700 (PDT)
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
Subject: [RFC][PATCH] gdhcp/client: Don't attach a DHCP client to veth* devices
Date: Tue, 11 Jul 2023 17:40:32 +0200
Message-ID: <20230711154032.935972-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

veth* interfaces are created as sub-interfaces for a bridge
by Docker and not actually used for communication in my use case.

But Connman tries to use DHCPv4 on them and they end up with
an IP address in the 169.254.x.x range with routes added to them,
which extra routes in turn break networking on the host.

This is a very bad approach, hence the RFC status of the patch.
It may be better if Connman didn't add routing for interfaces
with only a link local address. Please give me some pointers
so I can implement it properly.

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 gdhcp/client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 82017692..36c233a1 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -1175,6 +1175,11 @@ GDHCPClient *g_dhcp_client_new(GDHCPType type,
 		goto error;
 	}
 
+	if (strncmp(dhcp_client->interface, "veth", 4) == 0) {
+		*error = G_DHCP_CLIENT_ERROR_INTERFACE_IN_USE;
+		goto error;
+	}
+
 	if (!interface_is_up(ifindex)) {
 		*error = G_DHCP_CLIENT_ERROR_INTERFACE_DOWN;
 		goto error;
-- 
2.41.0


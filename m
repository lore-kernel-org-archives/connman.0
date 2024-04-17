Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19480147C7D
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370968; cv=none; b=BfaD+rfm8jXjS7U4G3Pks6DqmutVc7EuzIPvXTJVhIHWon6jrmXetGYpzY8OXDh5awfqjJ5m0LyvwJaZYwzijpFa/2IUAz5mqce5WKYwg8TIw3nUcEmD5X9Sq6hIGgzy4ohbiyHsb10UpyhUQA8UQbpmxbJHPA5PRr9xHDLbX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370968; c=relaxed/simple;
	bh=YSjMPw8R13xfbf8wDjkvWCpb6OiKHeSeghvWH3zM3Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/O/UOWx7jpK8chzwQpReql+naudC3lpQYAHTYQhMp0NSokABLsFyKuLd46jIfs1sJ43zgWI3sjpgTNLGVdvVGfF4pu1Ac0KTMYoDZf17oZGpxZqB8gkp3ZAb273/F+IakSNn+gEWCqP0kSWEA8zvuuXUn2+AtJtvfnP6BD99oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYmIyCtI; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYmIyCtI"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c730fc5749so184897b6e.3
        for <connman@lists.linux.dev>; Wed, 17 Apr 2024 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370966; x=1713975766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsJBCibRkcgELE9H1NVhk9XdXDyl138gSltvr4cK6rw=;
        b=OYmIyCtISygl9n3XdmhUYAqT5Cg3YgSbkSu/EahfH5UFm2xDHG3bj/6r00YtvyTs8K
         JLESupud/8bIhhzBD41VxnCJgk9DSREtSh4VjEkjC/Uii2QP5+Fy42iJ/QVS/VcNre7o
         +ezvCk/1H/hBqMvCFr0QmaCExR+ifA3x5vP+EiPEAyFfrKcYOJ22aZ6xC8/bIOYXI56i
         CTxr3qQEizG4X9ndioMUALRFlU9NpdZxemhSWokCQUIUO+CEBfgapYIJz/49TwwzP7mU
         sYl/4TQprurFFkbR0/nvPO0y7zVyLnfHwmGvlNcKEEnlCBFbZL4hfhp454VTUAvS+JM4
         vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370966; x=1713975766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsJBCibRkcgELE9H1NVhk9XdXDyl138gSltvr4cK6rw=;
        b=kO5p4xxiMSvB2dsXEDgGS7ROFLGEQYTgb4R5U5oO/TJ2AdwRUSAnCj2KNZK2GpetuU
         BCA2mDxT8fCnSbZx86T350yAWMGTGmXszVkxQ4VNtWBy89+CkKsssp8sCmN4M/6Ql3MA
         55T/0de02xGzrrd5qfLg35f3chmC+VWEKfUm+7r7PGUQ0SqkzaL1DU6Rl1CUBEi78Jl4
         f8E1tGDKBIxwgzGIbzkMHj8rhmjxDcSlmKiRdg2FEZk3bkO4TvDAA7Gmonfg1aqBqxuu
         j1R9UDAxyp+bQQOsYxaxt/SOMBnQJ7PNEC93PqNE+7VgXr7Std4hpsiru/o8nDPTnNHz
         rj6A==
X-Gm-Message-State: AOJu0YwFYidRj2YgmAZsdRyaTFTpaLcJ2Qbx6yK0z2hg3aOJlt0+y/jQ
	qj/XPKJJ0hr1CeD44bd5fbITttIGhA92MyhTZlK0uyiLqXKZcZhAy1uf7g==
X-Google-Smtp-Source: AGHT+IEcvNHsWX/QRHxU7+nvdneVJ5AS9Fnb0tobCMESL20vTT5CV46UelpN6lRB04N6xU1C0WPMqA==
X-Received: by 2002:a05:6808:1b22:b0:3c7:2a70:f0c2 with SMTP id bx34-20020a0568081b2200b003c72a70f0c2mr28030oib.17.1713370966044;
        Wed, 17 Apr 2024 09:22:46 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id y10-20020a056808130a00b003c6ef2d7539sm2226380oiv.24.2024.04.17.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:22:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] gdhcp: Allow client to work on veth devices
Date: Wed, 17 Apr 2024 11:22:24 -0500
Message-ID: <20240417162243.3373629-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth devices do not compute a checksum over the entire message.  They
simply pre-compute the pseudo-header portion and include this in the
checksum field.  Support such devices by computing the partial checksum.
If the partial checksum matches, accept the packet.
---
 gdhcp/client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index c58c7be91143..2afa19e6e2ea 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -1355,8 +1355,13 @@ static int dhcp_recv_l2_packet(struct dhcp_packet *dhcp_pkt, int fd,
 	packet.ip.tot_len = packet.udp.len; /* yes, this is needed */
 	check = packet.udp.check;
 	packet.udp.check = 0;
-	if (check && check != dhcp_checksum(&packet, bytes))
-		return -1;
+
+	if (check) {
+		uint16_t partial = ~dhcp_checksum(&packet, sizeof(struct iphdr));
+
+		if (check != partial && check != dhcp_checksum(&packet, bytes))
+			return -1;
+	}
 
 	memcpy(dhcp_pkt, &packet.data, bytes - (sizeof(packet.ip) +
 							sizeof(packet.udp)));
-- 
2.44.0


Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2975136A
	for <connman@lists.linux.dev>; Mon,  9 Sep 2024 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725857125; cv=none; b=cl1SqalwUeZssMivcCITGrwHMCJpBpMoQfbDRukwsD9sIjx8OPEAjoXsI72JBfbXftgbHn3OlCWp2u8B9SNB2QFlp+avFRAvCP3IzA+awKKwMXSEgKizVqaZH8RdD9ysCo1oxuDIhWVPmFgYiwssMX7ZsTO1rEIrBwxOxUkEUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725857125; c=relaxed/simple;
	bh=2qkaArIvaQ4u5br1qoogZbOEmcL98WfysHYQQXRaDLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQRC7hiJaFFz8Fi+fSh5aoTy+vh/2whoAA4hps225yd3Bnd246slS6JovyhdoUu/W/m8oZXyuCYvziKbVTa5uvat45CB1r5moTeir5KoEG+yjBJ4e8xmx/Zslf+UEd2MIJcM1eKb1XlW6P1KQ5Xyzikn3p6VsmFNQN0sWwVdROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJcEWMHl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJcEWMHl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso2738516a91.3
        for <connman@lists.linux.dev>; Sun, 08 Sep 2024 21:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725857123; x=1726461923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J842x6ySRiDIe7iLFVYl/QCNM7bursAiyMYcvI8uJMo=;
        b=HJcEWMHlZ+edqliImNxoDZTBO1UOpZqNX0CHuXG9y56vw87OERZOuWqXTgvpVL6Red
         pXPamXqTWYwlsG0Ygs2at2oGVRmqUh52PXRYnaqI96kQS55njPoWqAVO2NHi3RXPn41j
         etKJcnjzc4aUN6NRzvtQCC4VbglTYZGzVujCcjwmUpL6VZgSo8JOk/UfrtqkF8PFiZlA
         E+00OuUQgc6yAEsnRJ8muA20BffAA15A+kFhbPAGVtRUeo15q1/+TEGqTgKRUpNqcuS1
         0p318Je8TSIavvsVfPC9cNFmbT3Tf7gErUMpb+P3LTK8tXOpUzI6cQlS8+mgzCY5FVAD
         F4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725857123; x=1726461923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J842x6ySRiDIe7iLFVYl/QCNM7bursAiyMYcvI8uJMo=;
        b=Opd4XG4RlYP60BS0Ukmzs9sgFanPM7AW/57n5sAJ6tvwznq/d1IoYa+4AcsLr6sdzr
         Yjo8O04GI4lLvqc/L9FLbhSQuB7Aq8fGy5nI6GpyOG2Ir66z1AjIfE6RmFWp0mcjwBxP
         nsGuhC2qWGf8rOl4lrkdOLmFNa8eSDVhGC/egUFw2Xea6OuFE+GC925a59K4wX07IROs
         y+ElCp7Qt72+9Z0e/QFmfT50xfd/Rer6E5wV8yfkGRZKC8anzn3r5CziqaB9fxM8EKGS
         hIvyMq/JLxiFFMYPscA/xIPnpaPI/GHkHmpfHylBV61VU5CP4py9S1rPCEWW72bQYqxP
         Ql+A==
X-Gm-Message-State: AOJu0YxXw3hdDaoxUzeuuWO+G5nmGqj4CNyhm8+iiW4tlEIF0fN5jf42
	1a6ULv2g8vRV2rT2SgImeIZTmEWNraWq710foa0Xi8xgGVntqF5q
X-Google-Smtp-Source: AGHT+IFOV/BVU6GccKtiOxPDkRjG5p1Sb3q1hDNgMjRitSZ87bJVDUF/hRk+yFijj95WCtkpr8gg9Q==
X-Received: by 2002:a17:90b:180e:b0:2d3:b643:8386 with SMTP id 98e67ed59e1d1-2dad50d926amr8415410a91.9.1725857122816;
        Sun, 08 Sep 2024 21:45:22 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0419caa7sm3484561a91.14.2024.09.08.21.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:45:22 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] Revert "rtnl: Ignore adding/removing interface to/from bridge"
Date: Mon,  9 Sep 2024 14:45:15 +1000
Message-ID: <20240909044515.2863247-1-net147@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 64ba5d457c77ebb65b0a23910d26089973fb6ce7.

It is causing the wireless interface to remain in AP mode and the tether
SSID to still be visible after disabling tethering when using
wpa_supplicant. This can be confirmed with "iw dev wlan0 info" which
shows "type managed" before enabling tethering, "type AP" after enabling
tethering and "type AP" after disabling terhering when it should change
back to "type managed".
---
 src/rtnl.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index a28370ae..64ba6086 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -926,7 +926,7 @@ static inline void print_attr(struct rtattr *attr, const char *name)
 		print("  attr %d (len %d)\n", attr->rta_type, len);
 }
 
-static void rtnl_link(struct nlmsghdr *hdr, bool *has_master)
+static void rtnl_link(struct nlmsghdr *hdr)
 {
 	struct ifinfomsg *msg;
 	struct rtattr *attr;
@@ -968,7 +968,6 @@ static void rtnl_link(struct nlmsghdr *hdr, bool *has_master)
 			print_attr(attr, "priority");
 			break;
 		case IFLA_MASTER:
-			*has_master = true;
 			print_attr(attr, "master");
 			break;
 		case IFLA_WIRELESS:
@@ -1001,32 +1000,22 @@ static void rtnl_link(struct nlmsghdr *hdr, bool *has_master)
 
 static void rtnl_newlink(struct nlmsghdr *hdr)
 {
-	bool has_master = false;
 	struct ifinfomsg *msg = (struct ifinfomsg *) NLMSG_DATA(hdr);
 
-	rtnl_link(hdr, &has_master);
+	rtnl_link(hdr);
 
 	if (hdr->nlmsg_type == IFLA_WIRELESS)
 		connman_warn_once("Obsolete WEXT WiFi driver detected");
 
-	/* ignore RTM_NEWLINK when adding interface to bridge */
-	if (has_master)
-		return;
-
 	process_newlink(msg->ifi_type, msg->ifi_index, msg->ifi_flags,
 				msg->ifi_change, msg, IFA_PAYLOAD(hdr));
 }
 
 static void rtnl_dellink(struct nlmsghdr *hdr)
 {
-	bool has_master = false;
 	struct ifinfomsg *msg = (struct ifinfomsg *) NLMSG_DATA(hdr);
 
-	rtnl_link(hdr, &has_master);
-
-	/* ignore RTM_DELLINK when removing interface from bridge */
-	if (has_master)
-		return;
+	rtnl_link(hdr);
 
 	process_dellink(msg->ifi_type, msg->ifi_index, msg->ifi_flags,
 				msg->ifi_change, msg, IFA_PAYLOAD(hdr));
-- 
2.46.0


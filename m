Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2A2C83
	for <connman@lists.linux.dev>; Tue, 12 Oct 2021 07:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4551360DC0;
	Tue, 12 Oct 2021 09:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634022412; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=imiiynS3sdo09aosxwNlKQ8Z7N0RSzRrpWk0BipZVVE=;
	b=IyHFt5OC7yvxXhDHOkh++qKOYcuPDp7BWjOptwGaquVPEXC2BwfDqt21hV/IIo65eYkGTa
	YrtSVHW9E+uEea/AX9zbb+CY+G07GErIArSfeUjKwyq1JRHGkgVjxQ3vCg2gsVc7caVa2G
	GYOmihtCr0w5YK42iFFql2dir2q2PI4J1MgZfNhBm6jK4O1dtE/GQcktfTRSUfxSN6jnT1
	YYvIKbsWGWeW+8R3grXP+iTA9i2qHaD07OGDvg0xVoSz3rqYCLANBpo0bNV2gd3qu5TKpT
	dtl6YWBwZ22Icp5jvgyVLbUbiAMzRHOTTDY78U46CoS6V/GrA6NOSeLHca7yOw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 0/3] Fixup clang error messages
Date: Tue, 12 Oct 2021 09:06:45 +0200
Message-Id: <20211012070648.28947-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Based on Emmanuel's patches[1] I tried to get clang to compile
ConnMan.  -Wcast-align seems a bit too much for clang so I disabled it
for clang.  The rest are couple of fallouts. Nothing serious. Though I
was not able to reproduce the maybe-unitialized warnings.

[1] https://lore.kernel.org/all/MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM/

Daniel Wagner (3):
  build: Only enable -Wcast-align for gcc
  inet: Remove unused ipv6_addr_advert_mult
  gsupplicant: Fix error return type

 acinclude.m4             | 4 +++-
 gsupplicant/supplicant.c | 4 ++--
 src/inet.c               | 7 -------
 3 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.33.0


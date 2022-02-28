Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DC7B
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 12:49:41 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id hw13so24478069ejc.9
        for <connman@lists.linux.dev>; Mon, 28 Feb 2022 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UReMU16osUaADKxWUy4dPVGCRp6EytQNucdSRE9OLg=;
        b=X/5Tsr780l7h+vzalyHb46QZlOEFClCV++0lbSh6fVBJWW0nBYS1qxJ+Tvrj0UTbQu
         J+prk6jUZ7pzHsZ87AJTJnHb0n8OtxyPG94hqVXJEa3NoWdmG0lirChzcW4XrSv5XM1B
         PBSTrr+7Be0SSMMwQymlhOdaCpXAeJWiyghUeezaycP58WjCizQX1K3KfxcNdaU6yzrr
         DRTQWOv8jJLaM2pCeKfgiHkg2U8+QBkbCXOc++y/YT8gWfvcEjDqf6UDqopAH0qxr2k/
         Ihhqd7WmFkV+C4bP8WMqUKycHvHLEzYb8TTgEj9RHNs+BYE6oisA+kfU3WBT6zpRpuyF
         FfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UReMU16osUaADKxWUy4dPVGCRp6EytQNucdSRE9OLg=;
        b=6D0Ke+QfkoJuPOLkcFaEVgkPggGi/ktg95oKquqkqnau5ilXW/iuUikG7icaNHWFGN
         srsKl191hbGp6XvoeB26l/9L+KeHQnxBS+vxCA6491IV+I3zYM1wuo5SJVUdWUzwzClS
         bbgEUwDTR4HCpLjDeKqStIVG7BzbybzoDgbQoqdHS98dsar51qce8ia5z1oy+dWwo1xa
         nTrc8WjbHIFHcRMWRZyq87PFe/1Rf/LF0+b96i4iRL1Ik93apt+sbjUOtBJze4MseHAv
         7Y3iezPuo9E8Day4yjEC6WxyvEdNOMBpHCwqFr8VC8T5i7OiBY28QMDnkEnO5GJCYRQd
         bhLg==
X-Gm-Message-State: AOAM531g+XsQcHEsbQ6j5IqpOVnBXTGZkpB8ODM0Hv0PXQwfI4DKhHV4
	cmPhTYQ5YdT9B4eUwmUcg3SCBEoL0ox/EQ==
X-Google-Smtp-Source: ABdhPJxfL1lnf1nb7OH+xqzqhPhl1aYhTV0/KVlRFEwsE791Bh9M2lw/foFXRnb84pZNCFMHGyDDVQ==
X-Received: by 2002:a17:906:eb4a:b0:6cf:bb0e:69fb with SMTP id mc10-20020a170906eb4a00b006cfbb0e69fbmr15319812ejb.149.1646052578831;
        Mon, 28 Feb 2022 04:49:38 -0800 (PST)
Received: from localhost.localdomain (ptr-gppolqqj1pmj1s3xvfl.18120a2.ip6.access.telenet.be. [2a02:1812:2d0c:4800:5a95:daff:d376:c061])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm5981484edy.37.2022.02.28.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:49:38 -0800 (PST)
From: Nicky Geerts <nicky.geerts@gmail.com>
To: connman@lists.linux.dev
Cc: Nicky Geerts <nicky.geerts@gmail.com>
Subject: [PATCH 0/2] timeserver not resolving ntp server
Date: Mon, 28 Feb 2022 13:49:28 +0100
Message-Id: <20220228124930.4010311-1-nicky.geerts@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of fixes for an issue where the timeserver cannot
resolve the ntp servers.

1. when the UDP g_io_channel in the nameserver is closed or in an
invalid state (for example by a misbehaving external DNS server, during
a start up sequence), DNS resolve will fail for the ntp server, and
won't ever be able to recover

2. when a service switches from the autoconf link local address to an
address configured by DHCP, the timeserver will drop the notification,
and the nameservers will not be reloaded in the timeserver's resolv instance.

Nicky Geerts (2):
  timeserver: refresh the nameservers before each lookup
  timeserver: include the reason why a timeserver sync is requested

 include/timeserver.h |   7 +++
 src/connman.h        |   2 +-
 src/service.c        |   4 +-
 src/timeserver.c     | 118 ++++++++++++++++++++++++++-----------------
 4 files changed, 81 insertions(+), 50 deletions(-)

-- 
2.25.1


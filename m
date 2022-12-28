Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E9137E
	for <connman@lists.linux.dev>; Wed, 28 Dec 2022 13:39:17 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id r130so14865306oih.2
        for <connman@lists.linux.dev>; Wed, 28 Dec 2022 05:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8w61C4ls5hAEPOTTGpOKSIwYXf8DGMaz0ekZj8c0A0s=;
        b=7ygpSsCyu1jL46AcDFybohmkadhnJOEhos4yZ+T3Ftw4XO4bpkzRLI3GJnnjlnqBux
         /RMlrAB6GNXDiSIZB46EJ0eJygskLG6suVpGaajciwiwIPnKKHlyvxGMAbPAJFiXc/FM
         30lmGMkYMm6wT99uymBzauzfZ+UI2p34yc7ZJ809fjBSYaYD6ghNQsfWWNqd70cOZ2FT
         YUf17rwCXHYAkSvlBm2mSlJDYmztoULUwZ1+qUZcboqGnVGRa3nz9+H5icKHoliGr6NO
         ff/o0YM5EAS23Fy2psEMYZo+a5FPCRWN89SBifPsyvlwcvTCerI6w1Se93xqHDVsr/u3
         h2Gw==
X-Gm-Message-State: AFqh2ko4patroaTs4oBliyv0X/vObHjbdmoSEE3KJulflZH4c8tburaX
	a7hCJEiY8q+mNBH+0Yhiz3127kYUS1Lbnw5qhZ+0VtS9/yjha7h2SegxBWZZ
X-Google-Smtp-Source: AMrXdXuXhV7Ul7DvniSyDRurzvjwseSTlzqtVXc4EELj+iwm48eI0Y34sERD3W3yKD5ihOtPpoJREf6wlmCUgtMI5LQ=
X-Received: by 2002:aca:1b01:0:b0:350:4f8f:6ddf with SMTP id
 b1-20020aca1b01000000b003504f8f6ddfmr1343353oib.235.1672234756421; Wed, 28
 Dec 2022 05:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jade Lovelace <lists@jade.fyi>
Date: Wed, 28 Dec 2022 14:39:05 +0100
Message-ID: <CAFA9we9QrpTmyzBewdiL4gKP52_G_j25NvR2pjpqzBXb2xPnzQ@mail.gmail.com>
Subject: bug: iwd KnownNetworks AutoConnect setting desynchronizes with
 connman's, breaking auto connect
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have been using connman with iwd recently and I've found that the
autoconnect doesn't seem to work consistently and I often have to
manually use connmanctl to reconnect to the network.

This manifests in a strange (to me) way: the network is seen in
connmanctl but not automatically connected to. I've glanced through
the Connman iwd plugin code and it's my understanding that the actual
automatic connection when the network reappears is done by iwd, and
the Connman plugin merely sends configurations to iwd.

I can get the AutoConnect variable resynchronized by manually toggling
it with connmanctl. If I do this, when I put my machine to sleep and
open it back up, it will reconnect as expected, temporarily resolving
the issue. My assumption here is that iwd is turning AutoConnect off
for the network for some unknown reason, and connman is not accounting
for this change.

I am using connman-1.41 and iwd-2.0 on NixOS.

You can see that toggling in the below snippet:

~ =C2=BB busctl get-property net.connman.iwd
/net/connman/iwd/0000000000000000_psk net.connman.iwd.KnownNetwork
AutoConnect
b false
^^^^^ ---- On connman startup, the iwd KnownNetwork has AutoConnect =3D fal=
se

~ =C2=BB connmanctl
connmanctl> services
*A  REDACTED1            wifi_abcdefabcdef_0000000000000000_managed_psk

connmanctl> services wifi_abcdefabcdef_0000000000000000_managed_psk
/net/connman/service/wifi_abcdefabcdef_0000000000000000_managed_psk
  Type =3D wifi
  Security =3D [ psk ]
  State =3D idle
  Strength =3D 55
  Favorite =3D True
  Immutable =3D False
  AutoConnect =3D True
  ^^^^^ ---- However, connman thinks it is true
  Name =3D REDACTED1

connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
--autoconnect true
connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
--autoconnect false
connmanctl> config wifi_abcdefabcdef_0000000000000000_managed_psk
--autoconnect true
^^^^^ ---- If we manually toggle it back and forth, it will get synced agai=
n

~ =C2=BB busctl get-property net.connman.iwd
/net/connman/iwd/0000000000000000_psk net.connman.iwd.KnownNetwork
AutoConnect
b true

Jade

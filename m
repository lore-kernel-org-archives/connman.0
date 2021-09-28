Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E472
	for <connman@lists.linux.dev>; Tue, 28 Sep 2021 15:32:00 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id x7so70033724edd.6
        for <connman@lists.linux.dev>; Tue, 28 Sep 2021 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5Vk6YwXA39z3c8NZSWWMbdCYMCpD8J0oAlUbZr9Hx5g=;
        b=qj0j451m7j1LDzUWu6i9MRu4t6VsJ3DAFYCZHXLrt8svOjZWUF8CRGLbLsM1WA7lsh
         lNgJ1UJkEueummkPS7+1tzWGogQeqAYMI3xNAJE0gIMFAkthktZSb+sM+yMnkHW877lp
         H4vW3K0xyhZa1SSt8nGcf0D+OtExzIh9koIJtvoKnthDrr51v0AVZq/xt90KtlZMQjNS
         2ve3ApzUyGxXNStRtPi7P9tjgdYdhLZU1z4DF0EM/0c102irpa1XIaCvWp4VVk7jPndx
         s5vxiJTccgSEgqcpomYWeO3WJuGVFNzmWmc9YjGS//oXbybedHFMphDsNgFMLv27uAUO
         c28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5Vk6YwXA39z3c8NZSWWMbdCYMCpD8J0oAlUbZr9Hx5g=;
        b=f40gxjTri9sOM2tWnME6I0035Wpn5+7iurH7oJV1x2sBVGZoO9oc7P8XwYqdUj9pdj
         wJ2ZfML2+Khrm5bZtmZ3nedoNPnoPLQbmaPb7kDl+10bOAVh6EslhAU9eQwXO4YPwxjM
         1CLilY+k6UjF6m6qBtDdhhQbDopvN4X1b1NyXEguv0SpzTEVX0zOD6P2pf9+U4egjZQh
         WnXJQL+9LC2UCT4ymaOoNomoR8SnzmBYvAxWJyi1mv41OfMq22aQ/sVCm1/fipPI+eOV
         1xGMpAuXFNMnVT+njBRw059jDX2FB54gWV9USboP9XNpSpRc9BmXRVYPZX5Lvm6Kvi99
         CE6Q==
X-Gm-Message-State: AOAM530rcWaB5KLTpXlsBRrnHZpEJMr2JFjyt4KeGKp9Kf0Ip9wVdCDi
	K87hJiUGuNtmKRbXm6iuF1QvBfcF29R2Z4+dkD/PAkN7ACEfXqoy
X-Google-Smtp-Source: ABdhPJyVcOokbbUe08uUCUim5kXycol05ildo9fjzsEYofnYvIrtE9RBDIizUIn3pRanejt+2/sbxZNdbRT8SjeqCrg=
X-Received: by 2002:a05:6402:8c5:: with SMTP id d5mr8193268edz.122.1632843080395;
 Tue, 28 Sep 2021 08:31:20 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Sep 2021 15:31:19 +0000
From: Salvatore Mazzarino <apocalipse89@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 28 Sep 2021 15:31:19 +0000
Message-ID: <CAJU6sMnMkDpMCMVKSZYD7rT8mqao5ALgDfeZgY=VAiP=HbY=Kg@mail.gmail.com>
Subject: connman in dual stack breaks connectivity
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m running connman in dual stack with the following configuration:

=C2=A0 =C2=A0 =C2=A0 [service_eth0]
=C2=A0 =C2=A0 =C2=A0 Type=3Dethernet
=C2=A0 =C2=A0 =C2=A0 MAC=3D[hidden]
=C2=A0 =C2=A0 =C2=A0 IPv4=3D192.168.159.13/255.255.255.0/192.168.159.1
=C2=A0 =C2=A0 =C2=A0 IPv6=3D2001:[hidden]:[hidden]:[hidden]::13/64/2001:[hi=
dden]:[hidden]:1::1
=C2=A0 =C2=A0 =C2=A0 IPv6.Privacy=3Denabled
=C2=A0 =C2=A0 =C2=A0 Nameservers=3D192.168.159.1,1.1.1.1,2001:470:20::2

The problem is that I cannot ping to the Internet.

Here an example:

worker01 [~]$ ping6 google.com
PING google.com (2a00:1450:4014:80c::200e): 56 data bytes
--- google.com ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss

Weirdly also IPv4 is broken:

worker01 [~]$ ping google.com
PING google.com (2a00:1450:4014:80c::200e): 56 data bytes

Any other machine (not running connman) in the same IPv4/IPv6 subnets
works fine.

Once I set IPV6=3Doff, IPv4 connectivity gets back again.

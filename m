Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0C5223;
	Mon,  6 Jan 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736124130; cv=none; b=rueLHR3R+PYRZQiLpNfYUFZnExffDJ7MQ1sQHwrT38vHPPpwz8KsybOrXLUv5dqMkVJBqlpdSou3pBXDVFs92WsSd4tvxIJ20t5Ozr+GucMrfopE2tEZUVY3npUCATpvkaYevaocd7CW4BvTrLDu2Kdb1YjFNP5RX/xkF1WIsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736124130; c=relaxed/simple;
	bh=2Fb8b13/P3dzLIvFp/0RAdDOarYATNqeoRWItPEPfGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXiiQ4SBfW923aG3cI/Azl1O+apN2hLF2o04p3d633VSJ5RXblaCF44IUaUgP6uBsPSHneNSOs6jt1018jZx3mrWUZ5g4s9trji3msnMJEMosgp9yLNz7Qa/iVxAQ8Dg8BVqLYPEB+1mlMiV8mOCjTMSvcmRrmxu2Vm2edbAyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzlJps0C; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzlJps0C"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efded08c79so15541912a91.0;
        Sun, 05 Jan 2025 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736124128; x=1736728928; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkEov7BiZSlNescGbA5nE5JrkpqpgpPdU1WQaMZf4Yk=;
        b=dzlJps0CZygY1AHTC/Of49HGI5/hEQAaT8tHfvVw7QwF26vWRAiEisMCy9RLTZgQQD
         Niv3M3zdE+QJejOfwNcO1N71l5QkJ6o9VvQKfc7PJEuDXzdhfgagVYLOUswb2wvovYzU
         aapRjNwY4Jcyv8OWGYuofoVHxaJ7G8Mm5XiDKvaFZ6O73oACIJpGVuXKbfoD1cpPmFxm
         TqolYKfYiqmluvKhkQTR/GZJo2b7pjHCzfDA0UuApxtO2ICxGylPKgo4XS/m4cLcG0V1
         jvE1zKhJWEnX9g5yHsOMwLujWyHsNhi35IAvfpq/fuUkM/uamFjpAUZBvZIv/q872pHa
         89+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736124128; x=1736728928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkEov7BiZSlNescGbA5nE5JrkpqpgpPdU1WQaMZf4Yk=;
        b=dr0Gqjj+y1vIoNFWNMrt5F3Cksuaj95cZP9ML9rE2DDVjAl7VSihDMdkLnCIJ/6NM0
         fY7BiodJnNYcAxDa41RUVPypvYRvyYKIihdietEmb7WoF7K+Bmaa1z2NCZn2y1SJUBxM
         jZrUC19/D/yH/SqA0dusM0X82uk8/ExL4I/wrmENRrjcL0NzEIX8ydesCFHRKrYl5npt
         04TT/4GIo4EMo19mdI2suKnZLqmd5HTUHdBx7zp3xcy02F0ej+akfv2hoUvgpxqvPsY6
         9hQLMaqAu0Rww4Y7gKhVnQ1IZD7y8iYS2v4ThXw6LlL5WZ9L5yscuSB8K1fjfsUiutMv
         r0yw==
X-Forwarded-Encrypted: i=1; AJvYcCW05iK6v+F/COEtLA875VN1WY5A7TOwoNZhOUN5XADpmqL6hnNAxR91hhyFkpbAuLuU6xoQQQa0dGc=@lists.linux.dev, AJvYcCWlNQIM02/0BoznzU41Qk9vQMUzTdpnwsKOobyLIcOWEyNvJ+hK58VlZvGPV4Jgx4uXy855uq+uyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAXWb8gP72L2wC6sq73iFeu1py2JIqg1Zb/xfLP1xeZhRzXOUP
	WIcVDMciRpI4/PKjFqhXjtOuJwXiVrCBPawLrodzcxfx4ykANPCEaxh0yNq2Jz5Mt6Gvm+w8XCm
	srXiprP67n62t3nSGnv2e/436whM=
X-Gm-Gg: ASbGncuMKq1LI6P/d6H/ZWIDBE+cisRviwz5b5/7Om79pzhWcc/uq5RKpXCkV3IGzxy
	uQUxJhUCNtnCdJWJeWiTYdHpIdelq2r6i0xvZfw==
X-Google-Smtp-Source: AGHT+IGG+cPiTgc4eTSe5j1oO53XTcETt2p/o6AdGR/5X4Fgo2HOs6cTzqSVmmUeyMw+J6jYcmpBXG6HiOaYmJyQefw=
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f452e1d13amr84989746a91.14.1736124128100; Sun, 05 Jan 2025
 16:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com> <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com> <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
 <c6e8ab71-d1e3-41a1-925c-9013f5a87f12@broadcom.com> <CAG17S_MoZDbu1vSt+=80xs+Cje_PPFhFwPxmWDUeNPJ9qRZ6bw@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com> <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
In-Reply-To: <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 5 Jan 2025 18:41:56 -0600
Message-ID: <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am looking at the iwmon logs for a successful wpa_supplicant
connection versus one from IWD. Both connect and both pass data and
both grab a DHCP address. I do note one difference in the connection,
though.

Request : Connect
through the responses RTNL
wpa_supplicant knows it is dynamic
> RTNL: New Link (0x10) len 80                                        15.66=
3131
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x9003) [up,broadcast,multicast,dynamic]
        IfName (len:6): wlan0
        Wireless: len 48
            30 00 08 8c 00 00 00 00 20 00 00 00 00 00 00 00  0....... .....=
..
            01 08 82 84 8b 96 0c 12 18 24 32 04 30 48 60 6c  .........$2.0H=
`l
            7f 08 04 00 00 00 00 00 00 40 82 84 8b 96 24 30  .........@....=
$0

and wpa_supplicant connects like this:
# ifconfig wlan0
wlan0: flags=3D-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
        inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.255
        inet6 fe80::ba27:ebff:fea4:6e0f  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)
        RX packets 13  bytes 2785 (2.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 58  bytes 9015 (8.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


Whereas the iwd log does not:
> RTNL: New Link (0x10) len 128                                       26.80=
9429
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1003) [up,broadcast,multicast]
        IfName (len:6): wlan0
        Wireless: len 96
            60 00 07 8c 00 00 00 00 50 00 00 00 00 00 00 00  `.......P.....=
..
            00 07 64 65 73 6b 53 41 45 01 08 82 84 8b 96 24  ..deskSAE.....=
.$
            30 48 6c 32 04 0c 12 18 60 21 02 03 14 24 02 01  0Hl2....`!...$=
..
            0b 30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01  .0............=
..
            00 00 0f ac 08 80 00 7f 08 00 00 00 00 00 00 00  ..............=
..
            40 dd 09 00 10 18 02 00 00 10 00 00 00 00 00 00  @.............=
..

and when it does connect, it looks like this:
# ifconfig wlan0
wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.255
        inet6 fe80::ba27:ebff:fea4:6e0f  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)

On Sat, Jan 4, 2025 at 12:28=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> Started a new thread as the other was already at 30! Hope this is OK
> for the list.
>
> This is on a RPi running the latest connman and iwd, with the brcmfmac
> 43455 chip, a patch to the brcm80211 driver from Arend and the latest
> firmware from Infineon:
> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> (be70ab3 CY) FWID 01-95efe7fa
>
> The latest iwd (3.3 at latest commit: g4b535cee) will connect to an
> SAE/WPA3 AP. It just will not do it every time. I use connman as the
> manager with iwd to manage the wifi.
>
> I have seen 2 different errors. One is 'invalid key' and the other is
> 'connect-failed'
> The invalid key dialog in connman is:
> connmanctl> connect wifi_b827eba46e0f_6465736b534145_managed_psk
> Agent RequestInput wifi_b827eba46e0f_6465736b534145_managed_psk
>   Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
> Passphrase? secret123
> Agent ReportError wifi_b827eba46e0f_6465736b534145_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? no
> Error /net/connman/service/wifi_b827eba46e0f_6465736b534145_managed_psk:
> Input/output error
>
> This one did not connect and the iwmon log is attached as is the
> journal (iwd and brcmfmac debug enabled)
>
> The connect failed dialog in connman is:
> connmanctl> connect wifi_b827eba46e0f_6465736b534145_managed_psk
> Agent RequestInput wifi_b827eba46e0f_6465736b534145_managed_psk
>   Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
> Passphrase? secret123
> Agent ReportError wifi_b827eba46e0f_6465736b534145_managed_psk
>   connect-failed
> connmanctl> Retry (yes/no)? yes
> Connected wifi_b827eba46e0f_6465736b534145_managed_psk
>
> This 'connected' but it resulted in an AIPIA 169.254.133.42 address as
> is seen in the logs.
>
> I also attach an iwmon and journal of a successful connection with a
> valid DHCP address of 192.168.5.207 that passes traffic in the case
> teh comparison helps diagnose it.
>
> I could be wrong, but I think this is related to iwd because when I
> try wpa_supplicant ver 2.10-12 on the debian apt list, it connects
> every time. If it is useful, I also have an iwmon and journal log of
> successful connect using wpa_supplincant. I do notice that it connects
> very quickly with wpa_supplicant compared to a connection with iwd.
>
> Keith

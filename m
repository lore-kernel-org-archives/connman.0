Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA7258D
	for <connman@lists.linux.dev>; Mon, 29 Aug 2022 08:10:48 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11edd61a9edso3457817fac.5
        for <connman@lists.linux.dev>; Mon, 29 Aug 2022 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=iGpbLasmeLqt/qk0CnlrNw1TJM5Z9Rgcfu5WuBF+p3Q=;
        b=R6YvbwylEmwECHjN/FwIdwbM0JXAsk1hZR3Bp1/T9PyhZxBcPBvOVIzBe9e2JF3FVl
         jgNYRIW75ZJrvgYC+wP0EIErB8XnhrpnAr3WAbIjuuBVKDIXdyRAwEVfTdC/zIREZ1sI
         QgIDrfajCZ6+dE//69FahwsUap7GCsdGkJx3RI8xfAdtud9SpaJfr6a9YkTauCAJTsUW
         f54P52DGbGADLIfKnu3jXRZFR69gZDFDbL4eI+X6IxRrCKB0xT0FSyom1UFN9yi0z6ph
         PmD+8h0vpBTbQw9jNx7gdY3TxMl8mOxTnwG8BfvjD8NcMgwCpSky9EqOlESDRlnsf+aP
         T+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iGpbLasmeLqt/qk0CnlrNw1TJM5Z9Rgcfu5WuBF+p3Q=;
        b=bQBLC3ivnuKE+KiP+VCN1NqkVz38C9ZWhkY42DlOexZ3/XVyUJwosbIU/E2vG3Rm7o
         Uzlu5MLAnNKv7/hDXzhIWAF30vwM9t685TgBMQ4dYw9Ik2kZCsy1SM14FDGpsTWenxY+
         tVceb3+NCeN0cHLfEmVuV6uLuzfKI7/1PF1ZQa37Fu1ESkmvmoZANu5W6iKQv4VwGTFn
         NQsSoNXGuyCun4qEGdpagQcMCqJrXV6YALFnpL08Ig8Ee8WeOMDGyQq+7Ow4FVp59Hw1
         FiKr+jQcxm52yMpXoczVfWUGesDO1Ebs87MsaynQ9IC2mt7lCPySECTj5wiPSkImQxNV
         RILA==
X-Gm-Message-State: ACgBeo2sE8cNvENx3B5SF3Zd8nc3iygkZ0pPFGLrp5tVRSspvKaJByle
	iPvIrV/sCMj3yAK4JOIG7hg4sbzCJ2Wqtvqy+hsmKmxXfU1u5g==
X-Google-Smtp-Source: AA6agR4UzEOQjMwe+2Z/FA4gRl9SyEDUF7WrriVd+VK/VB0MudQ29CJgPTpti/DqJmoOKU0oB5DBJk80SAJUmTu0T0o=
X-Received: by 2002:a05:6870:a407:b0:10e:2baa:64f6 with SMTP id
 m7-20020a056870a40700b0010e2baa64f6mr7112794oal.195.1661760647798; Mon, 29
 Aug 2022 01:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
 <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
 <20220828140926.etfebtezdel5nvu4@beryllium.lan> <CA+iibzBE3sgRcZF+U-kPZV96ocFyRFy9g=XE=d9q=rc4DfH+Rw@mail.gmail.com>
 <20220828182908.kiv4ilf7uxoxrmcb@beryllium.lan> <CA+iibzCXXwAETXPNOy81Sjc_GDY_U8cCXU7AA6eU_f-uX8LoxA@mail.gmail.com>
In-Reply-To: <CA+iibzCXXwAETXPNOy81Sjc_GDY_U8cCXU7AA6eU_f-uX8LoxA@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Mon, 29 Aug 2022 10:10:36 +0200
Message-ID: <CA+iibzD7kNDV2zcdmoSngbsz=t84KGVJyM3iHDMkis4jqfobCQ@mail.gmail.com>
Subject: Re: Link always ready and don't pass online
To: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have installed the last patches from the git and I am always in ready sta=
te.

root@yaolinux2:~# ip r
default via 192.168.1.1 dev wlan0
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.16
192.168.1.1 dev wlan0 scope link
192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 linkd=
own
root@yaolinux2:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp2s0f0: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500
qdisc mq state DOWN group default qlen 1000
    link/ether c8:2a:14:26:87:69 brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
state UP group default qlen 1000
    link/ether e0:f8:47:35:21:84 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.16/24 brd 192.168.1.255 scope global wlan0
       valid_lft forever preferred_lft forever
    inet6 2a01:cb1d:710:7e00:e2f8:47ff:fe35:2184/64 scope global
dynamic mngtmpaddr
       valid_lft 86382sec preferred_lft 582sec
    inet6 fe80::e2f8:47ff:fe35:2184/64 scope link
       valid_lft forever preferred_lft forever
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
state DOWN group default qlen 1000
    link/ether 52:54:00:10:1f:9c brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever

Le dim. 28 ao=C3=BBt 2022 =C3=A0 21:29, daniel antoine <univac55@gmail.com>=
 a =C3=A9crit :
>
> I have added the two patches , the link remains ready not online
>
> root@yaolinux2:~# ip r
> default via 192.168.1.1 dev wlan0
> 192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.16
> 192.168.1.1 dev wlan0 scope link
> 192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1 lin=
kdown
> root@yaolinux2:~# ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc mq
> state DOWN group default qlen 1000
>     link/ether c8:2a:14:26:87:69 brd ff:ff:ff:ff:ff:ff
> 3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UP group default qlen 1000
>     link/ether e0:f8:47:35:21:84 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.1.16/24 brd 192.168.1.255 scope global wlan0
>        valid_lft forever preferred_lft forever
>     inet6 2a01:cb1d:710:7e00:e2f8:47ff:fe35:2184/64 scope global
> dynamic mngtmpaddr
>        valid_lft 86368sec preferred_lft 568sec
>     inet6 fe80::e2f8:47ff:fe35:2184/64 scope link
>        valid_lft forever preferred_lft forever
> 4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> state DOWN group default qlen 1000
>     link/ether 52:54:00:10:1f:9c brd ff:ff:ff:ff:ff:ff
>     inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
>        valid_lft forever preferred_lft forever
>
> Regards
>
> Le dim. 28 ao=C3=BBt 2022 =C3=A0 20:29, Daniel Wagner <wagi@monom.org> a =
=C3=A9crit :
> >
> > On Sun, Aug 28, 2022 at 06:35:52PM +0200, daniel antoine wrote:
> > > I have tried the patch but without success . I hope that I have
> > > written the contents of the patch well in the patch file. I send you
> > > the log and the patch file I used.
> >
> > Can you also try [1]. And if it still not working please add the output
> > from
> >
> >  ip r
> >  ip a
> >
> > thanks
> >
> >
> > [1] https://lore.kernel.org/connman/20220828181052.27467-1-wagi@monom.o=
rg/

Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FCB1CA93
	for <connman@lists.linux.dev>; Fri,  6 Oct 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ4/tVIc"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-419cc494824so11280611cf.2
        for <connman@lists.linux.dev>; Fri, 06 Oct 2023 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696596523; x=1697201323; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xATFYc032RlOFeLDCuZ5qaSd/1w5KPaFPBh9vFrZIM8=;
        b=BZ4/tVIcd1Y9YWeL/kp5NooVLIola0D52clxHpBC83Csw8h0XzAp9RktNNdYEEGipH
         vo+Hcmk3Cug4tSJ7Vf8LDI0fBZpPmWBjFVpwmshQCbhABzhHtzWi2FbL2WvYnt9fYJzH
         Wc61Tgm3C/A0AOldWY86iognNzVjGTWhxjQ+fWBigh/PlBSyIYJhHhWY+VXMx5LzKhCe
         +JO28pcfw1ms1uUbAIotaFdWX0+hgRPfakBWNRo/wT6RwrP+uR8PlvryXFyL8jmXW3dT
         3Odj0t8gsH5/jQCJ1vOjftpZSPkzqNtPqMQGxHgfhUH4HsQxHHaLhvT8L4D03k/8RVH9
         wblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596523; x=1697201323;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xATFYc032RlOFeLDCuZ5qaSd/1w5KPaFPBh9vFrZIM8=;
        b=OkUCwFDLv6mnNfXlQfLCqcJjC4WQblWJ5WepVLcx9gi7m40Ve389cpLLLm3X43M0ZH
         aWgamq/iF6875KqRZY8yzzaUr5G7fW6vjJ5r3KnkAL/hEKzqIWmmL3BOkPgH+6wBMj5X
         jbZKN0vG3YAWWXEB3vsrtOWHuFU93XxV8fsLeAwE9AsFC4hxPXdYjmf0fOtk9aQSp9MI
         Qvm11lOmytsUdBtNcKiGCTvt7PsJlXOe5A2Kol8XYt2W32wrgU0qvGwNDqG6eQFkuopZ
         keq0lsM3OOKwV7QkL/pNCnPqsOd5O+137iztF+QaAu6+oQS8mV8jTMXp6bplvGPyq9HG
         5m8g==
X-Gm-Message-State: AOJu0YwUDLSJhOocCvaNt7cm1TISraACdufSiZ1Jn9Q3DlhxlGtGr+jF
	lSELhg3NT1wK8Pqaa+4XXsR/6xWHeEypwx7G54DM1Jj9Lx6FVw==
X-Google-Smtp-Source: AGHT+IEaReH5Y4M2bY3GckP0ZnRagEYDhfVxOYxpmxsDh7rhSdqHGxx9scysoBso6zayJwf92LZe1KQpSEr9ciRRm2o=
X-Received: by 2002:ac8:5f8c:0:b0:417:9431:c61b with SMTP id
 j12-20020ac85f8c000000b004179431c61bmr8899083qta.18.1696596523217; Fri, 06
 Oct 2023 05:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCjJP2Y8YW2CV1N+cd75BKi_vd0FH0Yj84qK-whHypZKQ@mail.gmail.com>
In-Reply-To: <CA+iibzCjJP2Y8YW2CV1N+cd75BKi_vd0FH0Yj84qK-whHypZKQ@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Fri, 6 Oct 2023 14:48:32 +0200
Message-ID: <CA+iibzC5m0ZhMV_ibNLjWJBG2ftqGrULd+07C209nHUJoSr2Xg@mail.gmail.com>
Subject: Re: Polkit package missing during compilation
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I have tried to compile connman without the option --enable-polkit and
the warning has disappeared.
checking for dlopen in -ldl... yes
checking for glib-2.0 >=3D 2.40... yes
checking for dbus-1 >=3D 1.4... yes
checking for xtables >=3D 1.4.11... yes
checking for libmnl >=3D 1.0.0... yes
checking for iptables-save... /sbin/iptables-save
checking for ip6tables-save... /sbin/ip6tables-save
checking for gnutls... yes
checking for sys/inotify.h... yes
checking for inotify_init in -lc... yes
checking for wpa_supplicant... /sbin/wpa_supplicant
checking for readline/readline.h... yes
checking which DNS backend to use... internal
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/version.h
config.status: creating connman.pc
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands

I wonder if the option enable_polkit=3D"yes" is tested. It seems it was
remove in this commit
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D7c5=
f70200f076d2afdce9c34dc59ce8fd4e1baba
a long time ago.
In fact is the option --enable-polkit needed or is it built in ?
I have compiled but not tested without the option.

Best regards

Dania


d

I wonder if the option

Le dim. 17 sept. 2023 =C3=A0 11:30, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi
>
> During compilation there is a message "Package polkit was not found in
> the pkg-config search path". Polkit is present as a dependency and
> also --enable-polkit as an option  in the pkgfile. It doesn't cause a
> problem as connman work's very well.
> I send you my compilation log and the result of a cat connman.log | grep =
polkit
>
> root@grat-os1:/mnt/hd/var/log/pkgbuild# cat connman.log | grep polkit
> patching file src/connman-polkit.conf
> + ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/var
> --bindir=3D/usr/bin --sbindir=3D/usr/bin
> --with-systemdunitdir=3D/lib/systemd/system --enable-openvpn
> --enable-polkit --enable-client --enable-nmcompat --enable-pie
> --enable-iwd
> Package polkit was not found in the pkg-config search path.
> Perhaps you should add the directory containing `polkit.pc'
> No package 'polkit' found
>   CC       tools/polkit-test.o
>   CC       plugins/src_connmand-polkit.o
>   CC       gdbus/polkit.lo
>   CCLD     tools/polkit-test
>  /bin/mkdir -p '/tmp/work/pkg/usr/share/polkit-1/actions'
>  /usr/bin/install -c -m 644 plugins/net.connman.policy
> vpn/net.connman.vpn.policy '/tmp/work/pkg/usr/share/polkit-1/actions'
>
> the version of polkit I use is 122
>
> Best regards
>
> Dania

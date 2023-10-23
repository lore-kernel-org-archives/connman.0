Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F562156CD
	for <connman@lists.linux.dev>; Mon, 23 Oct 2023 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOgB2ygp"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-41cd444d9d0so19958641cf.2
        for <connman@lists.linux.dev>; Mon, 23 Oct 2023 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698076233; x=1698681033; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYDllVxzwbrHD8VGzTe+aoW+8zTxn3AN2nYBN21ekUQ=;
        b=iOgB2ygpCvuAEUFnQQT4TeQWbqRi0lEw5j7ZOZgwSXBAC8ceVmqwUQO1gKPndwhM9L
         zRitxYCXjBmD6YIfGcwMr8tvalloxGsTo06rqupFw35itrRpQTZwAa+lLkuJWdqmvAu4
         znrop7edKxHAvoR2dWfjOv7/XGJJxIciYNit63w6U7aZYz+OeFWRpnDuPvNVYLDjp+l0
         ho9EWwzWRhbnsXhKD55Wl8GrY5/x3tP7tcxsfp8RU61NJblDDYPsK37r2GcneHzHQ2E2
         3h1fEGAnEwiCOqZWKZQk1Rk2f8hePLeUCCOuoMXXCeNfZWyejD0EgjfpIM8/cgwgHWbL
         xoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076233; x=1698681033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYDllVxzwbrHD8VGzTe+aoW+8zTxn3AN2nYBN21ekUQ=;
        b=healbw484EacTaLgq3/fQ/FNOYBmmd1tUcs3nz4lMe/UYyo156JAUshYdG5tNL9H0O
         XrOtoAX0tbA46iUtcFpEuVKvUl1NlfTvfaM5PCa41AN5Dc+0mWqsX4fR0nNjNca9hHPs
         I4vh3KEJ/DTetWUk/16KlzStEIJkSzLabDPhlQa0Gne36JxNt1hL1Hi4yAQ10ZCMmlnV
         LDeeXZqQ5TtVl9/OmwvEFbeZpgnLUl5qafLF7XMcQSuoFyFlK/O1NjAMyhOA4qPRhs1y
         PjMe1msVCpbCSFmU+3DrBxAA73JTxwbshTgOKR1l7Uk+4P142CifwaipvEivINzdw7T0
         3/3w==
X-Gm-Message-State: AOJu0YxkLZlW4AdhBoTBYaMpOg40sOjUUkRLivKNe7bQcsOhXE8oYszT
	6OT1iIU8AiGl0EcPU5FDZHTHzVneZ9N3FnAm92Q1ynszxoTi+g==
X-Google-Smtp-Source: AGHT+IGDWil9DOahka+d6DgbusK2q4nf34AoOio3nzAgDyViNbSQE0p91z7vXqrMNxee4HYIhKkhL4QDEfmTQXGYtbc=
X-Received: by 2002:ac8:5b8e:0:b0:41c:ca25:8537 with SMTP id
 a14-20020ac85b8e000000b0041cca258537mr8555797qta.29.1698076232927; Mon, 23
 Oct 2023 08:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCjJP2Y8YW2CV1N+cd75BKi_vd0FH0Yj84qK-whHypZKQ@mail.gmail.com>
 <CA+iibzC5m0ZhMV_ibNLjWJBG2ftqGrULd+07C209nHUJoSr2Xg@mail.gmail.com>
In-Reply-To: <CA+iibzC5m0ZhMV_ibNLjWJBG2ftqGrULd+07C209nHUJoSr2Xg@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Mon, 23 Oct 2023 17:50:22 +0200
Message-ID: <CA+iibzDvPXyT0X3Ac5+tjf3CyzDE1MqAUovyoKrYmD8fJYUpAg@mail.gmail.com>
Subject: Re: Polkit package missing during compilation
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
The detection seems to be here in configure.ac

AC_ARG_ENABLE(polkit, AC_HELP_STRING([--enable-polkit],
[enable PolicyKit support]), [enable_polkit=3D${enableval}])
if (test "${enable_polkit}" =3D "yes"); then
PKG_CHECK_MODULES(POLKIT, polkit-dbus >=3D 0.7, enable_polkit=3Dyes,
AC_MSG_ERROR(PolicyKit >=3D 0.7 is required))
AC_SUBST(POLKIT_CFLAGS)
AC_SUBST(POLKIT_LIBS)
POLKIT_DATADIR=3D"`pkg-config --variable=3Dpolicydir polkit`"
if (test -z "${POLKIT_DATADIR}"); then
POLKIT_DATADIR=3D"${datadir}/PolicyKit/policy"
fi
AC_SUBST(POLKIT_DATADIR)
fi
AM_CONDITIONAL(POLKIT, test "${enable_polkit}" =3D "yes")

I have not found a trace of a polkit-dbus package with version >=3D 0.7

Best regards

Daniel

Le ven. 6 oct. 2023 =C3=A0 14:48, daniel antoine <univac55@gmail.com> a =C3=
=A9crit :
>
> Hi
> I have tried to compile connman without the option --enable-polkit and
> the warning has disappeared.
> checking for dlopen in -ldl... yes
> checking for glib-2.0 >=3D 2.40... yes
> checking for dbus-1 >=3D 1.4... yes
> checking for xtables >=3D 1.4.11... yes
> checking for libmnl >=3D 1.0.0... yes
> checking for iptables-save... /sbin/iptables-save
> checking for ip6tables-save... /sbin/ip6tables-save
> checking for gnutls... yes
> checking for sys/inotify.h... yes
> checking for inotify_init in -lc... yes
> checking for wpa_supplicant... /sbin/wpa_supplicant
> checking for readline/readline.h... yes
> checking which DNS backend to use... internal
> checking that generated files are newer than configure... done
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating include/version.h
> config.status: creating connman.pc
> config.status: creating config.h
> config.status: executing depfiles commands
> config.status: executing libtool commands
>
> I wonder if the option enable_polkit=3D"yes" is tested. It seems it was
> remove in this commit
> https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D7=
c5f70200f076d2afdce9c34dc59ce8fd4e1baba
> a long time ago.
> In fact is the option --enable-polkit needed or is it built in ?
> I have compiled but not tested without the option.
>
> Best regards
>
> Dania
>
>
> d
>
> I wonder if the option
>
> Le dim. 17 sept. 2023 =C3=A0 11:30, daniel antoine <univac55@gmail.com> a=
 =C3=A9crit :
> >
> > Hi
> >
> > During compilation there is a message "Package polkit was not found in
> > the pkg-config search path". Polkit is present as a dependency and
> > also --enable-polkit as an option  in the pkgfile. It doesn't cause a
> > problem as connman work's very well.
> > I send you my compilation log and the result of a cat connman.log | gre=
p polkit
> >
> > root@grat-os1:/mnt/hd/var/log/pkgbuild# cat connman.log | grep polkit
> > patching file src/connman-polkit.conf
> > + ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/va=
r
> > --bindir=3D/usr/bin --sbindir=3D/usr/bin
> > --with-systemdunitdir=3D/lib/systemd/system --enable-openvpn
> > --enable-polkit --enable-client --enable-nmcompat --enable-pie
> > --enable-iwd
> > Package polkit was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `polkit.pc'
> > No package 'polkit' found
> >   CC       tools/polkit-test.o
> >   CC       plugins/src_connmand-polkit.o
> >   CC       gdbus/polkit.lo
> >   CCLD     tools/polkit-test
> >  /bin/mkdir -p '/tmp/work/pkg/usr/share/polkit-1/actions'
> >  /usr/bin/install -c -m 644 plugins/net.connman.policy
> > vpn/net.connman.vpn.policy '/tmp/work/pkg/usr/share/polkit-1/actions'
> >
> > the version of polkit I use is 122
> >
> > Best regards
> >
> > Dania

Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A02D604
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G99X/7On"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41cc75c55f0so24091841cf.1
        for <connman@lists.linux.dev>; Fri, 03 Nov 2023 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699005253; x=1699610053; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8rEmcrV11EzyVSj9iy70/dzHXBHLURXZkF/sQnN4gk=;
        b=G99X/7OnmqSEylJ6xlb3StUsoS2K3Zc0+k0EPEFnMM9G17kZm7tFJvK1E/T/Y/k+es
         gUSVowDdwqXbEagpKsOkMZQbdLyHrFS9r3pDnk4ae+VNiaIxDC8Amp9i0FMmgwYJpxld
         HqHeb3k6niyGFDcb1BRtVkeCP/gUK7vcXGBGjcWVhwLLtAWEp+IaDDypUJ6/Evd74KW+
         i7RTV6ygKxJMdaFD2GBAVkgOfh5uD4iwpU5V06qFBZNQX3HEo26EuAia/vvWcmJ88Uuz
         S7Chp6dMz2pFQUVZrKBc/i898QUHoLroLb9IxeVLzoxK6tcZRfHLdoLfXMuikTCVGGUc
         BDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699005253; x=1699610053;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8rEmcrV11EzyVSj9iy70/dzHXBHLURXZkF/sQnN4gk=;
        b=PuHm2n/stoCDY4OzFJ+yxSjyTjLSh0775v7SZ9hgbd/vNlg7RpUniQr/IJWpassmHp
         8ZR2/86r3qzfSYtaD5zeD73uW6+oJ7t4lXhG3uxUAcq8VZkqXMxJfrLmAgEpqU9n7iHF
         CAP9X6QM5js/kX5V5Gw9Mo7fmSmJxbo7KTl0U05kzykl9I+wp7ApjDSMnTWwkSo6KjB9
         SDF1AvKRMgqJDUjd6+SDW5jy5nDbOjGuwijQUztieqBlB0VQ3i853VMc2C7UnunqSsGx
         HAWa6WbGhb5ixAQiqJ+EKvVCJmM+Depwr8iI0zKTgrxaCe88pHmpcj5m6kBU9Rj7gge2
         8PgQ==
X-Gm-Message-State: AOJu0Yz40/YzPlMny0wgd0/MNy6wakmBZbpNY+4LgbquqGjXVagHGUHq
	+u/17PYttSky4/PLf7VZI3/hgolB7YobnNzwLwWFo1eT
X-Google-Smtp-Source: AGHT+IG44ftdlZQfFbLqan2MGY4V2ueAWDQBZdlVqROe3wEe0kSrhLYAxKjPT2wm13avHejnquSQnidQhjSiCVx8oNs=
X-Received: by 2002:a05:622a:10d:b0:41e:535d:3de2 with SMTP id
 u13-20020a05622a010d00b0041e535d3de2mr3239961qtw.28.1699005252940; Fri, 03
 Nov 2023 02:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCjJP2Y8YW2CV1N+cd75BKi_vd0FH0Yj84qK-whHypZKQ@mail.gmail.com>
 <CA+iibzC5m0ZhMV_ibNLjWJBG2ftqGrULd+07C209nHUJoSr2Xg@mail.gmail.com> <CA+iibzDvPXyT0X3Ac5+tjf3CyzDE1MqAUovyoKrYmD8fJYUpAg@mail.gmail.com>
In-Reply-To: <CA+iibzDvPXyT0X3Ac5+tjf3CyzDE1MqAUovyoKrYmD8fJYUpAg@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Fri, 3 Nov 2023 10:54:01 +0100
Message-ID: <CA+iibzCiAZGSM0RS=FU6Z_9nAg+z4og_cjRXyDzZ2bWJ8G5PGQ@mail.gmail.com>
Subject: Re: Polkit package missing during compilation
To: connman@lists.linux.dev, James Prestwood <prestwoj@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I think that I have found the solution for the missing polkit package
during the compilation. In the /usr/share/pkgconfig it waits for a
polkit.pc file. The polkit package provides a polkit-agent-1.pc file
now. In the PKGfile I have done a cp
/usr/share/pkgconfig/polkit-agent-1.pc /usr/share/pkgconfig/polkit.pc
and the problem has disappeared. I have not found in the git where
there is a reference to polkit.pc

Best regards

Daniel

Le lun. 23 oct. 2023 =C3=A0 17:50, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi
> The detection seems to be here in configure.ac
>
> AC_ARG_ENABLE(polkit, AC_HELP_STRING([--enable-polkit],
> [enable PolicyKit support]), [enable_polkit=3D${enableval}])
> if (test "${enable_polkit}" =3D "yes"); then
> PKG_CHECK_MODULES(POLKIT, polkit-dbus >=3D 0.7, enable_polkit=3Dyes,
> AC_MSG_ERROR(PolicyKit >=3D 0.7 is required))
> AC_SUBST(POLKIT_CFLAGS)
> AC_SUBST(POLKIT_LIBS)
> POLKIT_DATADIR=3D"`pkg-config --variable=3Dpolicydir polkit`"
> if (test -z "${POLKIT_DATADIR}"); then
> POLKIT_DATADIR=3D"${datadir}/PolicyKit/policy"
> fi
> AC_SUBST(POLKIT_DATADIR)
> fi
> AM_CONDITIONAL(POLKIT, test "${enable_polkit}" =3D "yes")
>
> I have not found a trace of a polkit-dbus package with version >=3D 0.7
>
> Best regards
>
> Daniel
>
> Le ven. 6 oct. 2023 =C3=A0 14:48, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
> >
> > Hi
> > I have tried to compile connman without the option --enable-polkit and
> > the warning has disappeared.
> > checking for dlopen in -ldl... yes
> > checking for glib-2.0 >=3D 2.40... yes
> > checking for dbus-1 >=3D 1.4... yes
> > checking for xtables >=3D 1.4.11... yes
> > checking for libmnl >=3D 1.0.0... yes
> > checking for iptables-save... /sbin/iptables-save
> > checking for ip6tables-save... /sbin/ip6tables-save
> > checking for gnutls... yes
> > checking for sys/inotify.h... yes
> > checking for inotify_init in -lc... yes
> > checking for wpa_supplicant... /sbin/wpa_supplicant
> > checking for readline/readline.h... yes
> > checking which DNS backend to use... internal
> > checking that generated files are newer than configure... done
> > configure: creating ./config.status
> > config.status: creating Makefile
> > config.status: creating include/version.h
> > config.status: creating connman.pc
> > config.status: creating config.h
> > config.status: executing depfiles commands
> > config.status: executing libtool commands
> >
> > I wonder if the option enable_polkit=3D"yes" is tested. It seems it was
> > remove in this commit
> > https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=
=3D7c5f70200f076d2afdce9c34dc59ce8fd4e1baba
> > a long time ago.
> > In fact is the option --enable-polkit needed or is it built in ?
> > I have compiled but not tested without the option.
> >
> > Best regards
> >
> > Dania
> >
> >
> > d
> >
> > I wonder if the option
> >
> > Le dim. 17 sept. 2023 =C3=A0 11:30, daniel antoine <univac55@gmail.com>=
 a =C3=A9crit :
> > >
> > > Hi
> > >
> > > During compilation there is a message "Package polkit was not found i=
n
> > > the pkg-config search path". Polkit is present as a dependency and
> > > also --enable-polkit as an option  in the pkgfile. It doesn't cause a
> > > problem as connman work's very well.
> > > I send you my compilation log and the result of a cat connman.log | g=
rep polkit
> > >
> > > root@grat-os1:/mnt/hd/var/log/pkgbuild# cat connman.log | grep polkit
> > > patching file src/connman-polkit.conf
> > > + ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/=
var
> > > --bindir=3D/usr/bin --sbindir=3D/usr/bin
> > > --with-systemdunitdir=3D/lib/systemd/system --enable-openvpn
> > > --enable-polkit --enable-client --enable-nmcompat --enable-pie
> > > --enable-iwd
> > > Package polkit was not found in the pkg-config search path.
> > > Perhaps you should add the directory containing `polkit.pc'
> > > No package 'polkit' found
> > >   CC       tools/polkit-test.o
> > >   CC       plugins/src_connmand-polkit.o
> > >   CC       gdbus/polkit.lo
> > >   CCLD     tools/polkit-test
> > >  /bin/mkdir -p '/tmp/work/pkg/usr/share/polkit-1/actions'
> > >  /usr/bin/install -c -m 644 plugins/net.connman.policy
> > > vpn/net.connman.vpn.policy '/tmp/work/pkg/usr/share/polkit-1/actions'
> > >
> > > the version of polkit I use is 122
> > >
> > > Best regards
> > >
> > > Dania

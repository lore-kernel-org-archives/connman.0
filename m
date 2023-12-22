Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B72E832
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI9GtHuq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1523652a12.0
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276007; x=1703880807; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkgMyz1adLEUNRFlbZ2EhyDbQXa/6USwAb6Mlfnz9H0=;
        b=gI9GtHuqvWOnMJHSMc8VAWJs19Aj/FYrK64RyamdipPcwqXV1XUTnZC4yWhoxfjv3r
         LMh6pBlMuVkEx2EE7efpsq9HwFsD7lDH2miFM2HWwrvPqo/H51pUyVoZ+uBz9NS5DWQV
         wS9Y9qE6wwguMDsNIHmFeKnz/Ps25O8DYqKAlBqHnCqfCXF51Dp5afYrhSM5/0oCxOc+
         9flGzkF/xZadSWqz9Y8PwkREizaq6JAWJgjgb1LGi3cY/IJhg0P2ZmXi4dE863xFtULq
         r05Sor3d+PfeiBNdei/Wl76JUew7TEbDWErbxZTvVWW6CxQLQsJBWzuzk+cVhn+KsAcV
         zHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276007; x=1703880807;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkgMyz1adLEUNRFlbZ2EhyDbQXa/6USwAb6Mlfnz9H0=;
        b=ivSEuQnO+oqwNzbfh4relPc8UeHBfHvic9H0pXOkP/9/AkTq5mnWQrzk5QzHpRcdMD
         JoZkzaHWSl8eEuX07dbHdtb3dPY7Q2S4OoOBeE83WT4gvJPr7eeT8b48tH+yUbQbNzZ/
         pZqJlK4BDnD349SUIYr8dgboM0jdEYYiCXPwBRwroqu4oD4ni/QaQFbN/RTpgpyvGSLW
         QWPubKRieIl3q/lNHGu8U8swtxrx+ly8YAxXpvb2eYiSy3btK0qrYRBQoNEBzIZHQDZa
         3B9rbsImkZiy3D0o7+Ss+nMo2megTByE/ZXoXejSrRkweupk/ERXB25WCPT90lrnptno
         9dFQ==
X-Gm-Message-State: AOJu0Yzi44a8CVEC15jii2X2BT3Pf+eSP9V3rkzOZVjTuCwnSkGcBKP0
	cHWu/OEjC4lLLbq8Txk8p+pIiAn3wmfhwo6nqQddK7oH
X-Google-Smtp-Source: AGHT+IFYPXTEtzc/MrKVc82Cb+SAkxkW6IgT/ezxijqsCf5vtbfT7a6h/Tn2HlnOuwMT2S1nhFlwCuAMsiU9VJ1GkoQ=
X-Received: by 2002:a17:90a:ae11:b0:28b:6004:c29e with SMTP id
 t17-20020a17090aae1100b0028b6004c29emr3457485pjq.23.1703276006599; Fri, 22
 Dec 2023 12:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_PAwPF6BaL6SqLcZi7HxgGjho2oUOT1vHqbiqyA8LfJtg@mail.gmail.com>
In-Reply-To: <CAG17S_PAwPF6BaL6SqLcZi7HxgGjho2oUOT1vHqbiqyA8LfJtg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 22 Dec 2023 14:13:15 -0600
Message-ID: <CAG17S_MLsYxcvFpf3v4t578a6=0MuTUiNYj8SinzA5-DQr6jWw@mail.gmail.com>
Subject: Re: cannot build release 1.42 on RPiOS
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:49=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> In the past,I have successfully built connman versions 1.38-41 from
> source on numerous RPi based systems runnign arch and rpios. I tried
> to build the latest, 1.42, and cannot get past this error:
>
> scripts/libppp-plugin.c:37:10: fatal error: libppp-compat.h: No such
> file or directory
>    37 | #include "libppp-compat.h"
>       |          ^~~~~~~~~~~~~~~~~
> compilation terminated.
>
> A search for a debian package with this file reveals nothing. What am
> I missing here?
>
> I have used this 'config' for a while w/o issue (I borrowed it from Arch =
Linux):
>
>   ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/var =
\
>       --runstatedir=3D'/run' \
>       --enable-iwd \
>       --enable-l2tp \
>       --enable-openconnect \
>       --enable-openvpn \
>       --enable-pie \
>       --enable-polkit \
>       --enable-pptp \
>       --enable-selinux \
>       --enable-threads \
>       --with-openconnect=3D/usr/sbin/openconnect \
>       --with-openvpn=3D/usr/sbin/openvpn \
>       --with-systemdunitdir=3D/lib/systemd/system \
>       --with-tmpfilesdir=3D/usr/lib/tmpfiles.d
>
> Any help appreciated.
>
> Keith

Problem solved. Someone noted this previously that it was in the wrong
place in the tar file. I am guessing that between 1.42 and Head there
is a patch to fix it b/c I was able to build connman-git to the
current Head with the config as above. I tested it and it seems to run
w/o issue on arm64 on a RPi.

Keith

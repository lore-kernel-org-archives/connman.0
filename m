Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A1A5D
	for <connman@lists.linux.dev>; Fri, 18 Aug 2023 06:38:44 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4ff88239785so761980e87.0
        for <connman@lists.linux.dev>; Thu, 17 Aug 2023 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1692340723; x=1692945523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRPSd3Og3tumHfiGhq/Ls6yJGIPihZpQZeHEedXV5cY=;
        b=qJunEDyqLCEFk31cS+U6os+bHlW9OvcJEVG4PanpAbqGDcjtAqQ7+N3R+mocN0VSxS
         IkboXW75696OwIw2u9tTRzbHDxkG7bLKP7JT2GdUGiA3J+1r46EUCZMRbLOFjN6Rzen6
         UpVTNAmC/wjNJR7Z3T0erysbz81CP3Uk++6Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692340723; x=1692945523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRPSd3Og3tumHfiGhq/Ls6yJGIPihZpQZeHEedXV5cY=;
        b=Lg7nwrkOseySMHBGZwe7tTih1zD5NZJFoEKTpMNfPo/R37L/8ef//sE0yeEMnVe6bE
         5j38w2imxE2ByBZbekrTM6L1ETNW+7rudIJh9IptYgz/WRidhBnu8lA4xKBd594v9xnz
         864m5RSxzyaPMU22IXT+VQLlndf/XzKiHJ714XJxKlX5GAsvvdX4sXsLNqTMtYwMqENH
         0sDONuJiNjgkp+XB8iLkaSufil2ZExUnmyt7RMRM4zbwFZM+98XzsoxPyKhLpJ3ISjaO
         EaLcZAMnFD9wTgTKN715M4XElrCdQzS4YUhbdH8vVUXTJuiHKgravGdtGXyxetxvRYCg
         q+4w==
X-Gm-Message-State: AOJu0YwXTXNgivaYciyZRlC4Hij/2n1t+F48AfRrzTP4se28lVUHsHtL
	9uoWozIckB5zfOZWSfzfQIrBXziiOU8PsnGOySSH1w==
X-Google-Smtp-Source: AGHT+IHnoNqN0vLmEuq+Vt9bpHJOboxaCAGk/IdWdHPSdzoVOBeMV5iuTWGyhfioHFq3RepjP3lxoyvf4+uZhH2GyRw=
X-Received: by 2002:a19:2d59:0:b0:4fb:52f1:9ab4 with SMTP id
 t25-20020a192d59000000b004fb52f19ab4mr819436lft.50.1692340722706; Thu, 17 Aug
 2023 23:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211027140141.9267-1-michael@amarulasolutions.com>
 <CAOf5uwmcmkUNO0P3mZOC94bWRpodqLeJ4kmBTSu2N0j9xw_WQQ@mail.gmail.com> <20211028063130.wwz44zuqjuoatksx@beryllium.lan>
In-Reply-To: <20211028063130.wwz44zuqjuoatksx@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 18 Aug 2023 08:38:31 +0200
Message-ID: <CAOf5uw=QSSCXtk1stvXCJwd=BYzwH70YugDjcoOdj9bTwE+scA@mail.gmail.com>
Subject: Re: [PATCH V2] Add GetKnownServices api to connaman
To: Daniel Wagner <wagi@monom.org>, "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel

I will resend those patches again because seems that people needs
them. We will try to combine our work on another
try

On Thu, Oct 28, 2021 at 8:31=E2=80=AFAM Daniel Wagner <wagi@monom.org> wrot=
e:
>
> Hi Michael,
>
> On Wed, Oct 27, 2021 at 05:25:32PM +0000, Michael Nazzareno Trimarchi wro=
te:
> > Hi Daniel
> >

Michael

> > I even have the patch to remove known-networks. I have few question:
> >
> > - what should be the behavior for an ethernet on?
>
> I might not understand you question correctly, I assumed we don't
> differentiate between types. Return the complete list and let the user
> decide what to do with it.
>
> > - for wifi, it's removed and if you are connected it's disconnected is
> > that correct?
>
> I haven't tested this but I would assume nothing will happen. These
> files are all considered under control of ConnMan. So if you remove
> those while ConnMan is running, it wont notice it. Hmm, to get this
> working correctly we might need to add a RemoveKnownNetwork call. I want
> to avoid to have ConnMan monitoring the storage directory (it's fragile
> stuff and difficult to get right).
>
> If we go down the road with RemoveKnownNetwork, then I suggest the
> GetKnownNetwork call returns the object path, not the storage path.
>
> Sorry for this late enlightenment from my side. I didn't realize all the
> impacts when we started the discussion.
>
> > Apart of that:
> >
> > I'm working on a patch that allow to store network configuration using
> > the config storage
> > but I have few questions:
> >
> > - I have added autoconnect as a configuration option. I would like to
> > store networks but not have them
> > in auto connect mode. This should allow me to connect when they are
> > visible. (ethernet??)
>
> I can't remember all the details around AutoConnect. It's a difficult
> feature as it set on the first successful connect attempt. If
> configuration files are involved there are other rules.
>
> > - I have add an option to store if I want it immutable or not. The
> > stored configuration should be applied
>
> Immutable is derived from the fact if there is a config file, the
> service immutable. It doesn't really make sense to make this
> configurable.
>
> HTH,
> Daniel



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

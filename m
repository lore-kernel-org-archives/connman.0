Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E11A59F
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoGKFVAA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-27d2b814912so669523a91.0
        for <connman@lists.linux.dev>; Fri, 20 Oct 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697808618; x=1698413418; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMUD6eneN1kB3YvtnBzMqZ2xzYWNP+AxddGo0niNZrc=;
        b=XoGKFVAA4QypzSoJ4GEF4CbqURIdAAFNXQf4EhgYbp2dUOf5gZDZG/KKO1Z4SWd8tn
         5POkibwJr1FZlwOPN9IzPtyHUE2yfrRjjP89F9QnGEL6YYjXwdK6tryqz7e/4SwRPmxw
         tOiIgiW7c2Zh3yHATBaquU9jjbO7sa9M8RiQ5CfCAoGhF7XV0C09/R55m2qReq+DMTOR
         KCGwfICH3RR56j1JM8uDymG4OEWZ8Jd/hyBxLmTO/5SFeMhY6SDsvIngM6WGLZk3nrd0
         ZA3toDbl4owqyGY/GJ2VIr0s4nO123v1huDSWfeYBJoaFWYhWp/U7qcjY19+Sauy+ny6
         anCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697808618; x=1698413418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMUD6eneN1kB3YvtnBzMqZ2xzYWNP+AxddGo0niNZrc=;
        b=sX4ySWD7ztPa5F60+M5ymG9eCpKlE1WNUuyedKBvEEEz9qIhwTYJ54lDKTWh5bGMe5
         2U5ID5nRBnM6lmv9dGtnbRuLvCJ2gSEJxbzoyanodLmM1HDdNJq/k5Q6Z9Ka6Y1vK6jz
         5CReLa5/vGFfrrmZel0AHS1ZaXR9EgmRjQpU7tdmcCNDFco5kEf4rJLGCzkRfHdZvSvN
         qdid31cE67oZ15041quovKZwl2RVcog81gFpuhnl7QFN1N7qU9vG+N4Ks9/cOJJPcuwN
         SD6Ozs76Cm6t2Zc4A/lMJxk2UZP/ONH25Y7lJDDNweD8yTa74FR0tnaa016cFpzorAJ0
         80Bg==
X-Gm-Message-State: AOJu0YxAeQPqY5SetnF8euaI2p0HmGUdrXSqre2AeqUqOKpC9SijNLiE
	drcCcf2P1nhU9/8ZdQK3xYVWCmXSSDrplmZE6a3fpFoa
X-Google-Smtp-Source: AGHT+IEcEb9p1lZnDw+hshQCZ9Uv6SVs7mkeDTXg4fLXpagwkBY9Gd60jSNW3D1C2gMR9sfMzUi/bsIWpH1TrSjnDGM=
X-Received: by 2002:a17:90a:56:b0:27d:1ec3:4367 with SMTP id
 22-20020a17090a005600b0027d1ec34367mr1934106pjb.0.1697808618322; Fri, 20 Oct
 2023 06:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230629100000.49254-1-marcus.folkesson@gmail.com> <ZN9IvM5jGHuVlXv1@gmail.com>
In-Reply-To: <ZN9IvM5jGHuVlXv1@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 20 Oct 2023 08:30:07 -0500
Message-ID: <CAG17S_MnQ1kdE3T-Qocp=Xe2yFbWJJA1e9Mo1J_6gueOTS_VTw@mail.gmail.com>
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl manpage
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Marcus,

I have been watching your investigation with interest. I am a list
member as well, but have noticed that there seems to be very little
engagement by any devs in the past year or so. I think Daniel Wagner
was the primary developer and he was wanting someone to take this
project over. I also have a feature request that has not yet been
implemented, though some work has been done. It just doesn't work yet.

Are you interested in taking over this project? I, for one, would love
to see continued development of connman. If no one is maintaining
connman, I will have to see if I can migrate to another network
manager. I have been considering nmcli, but it is so complicated in
comparison.

Keith


On Fri, Aug 18, 2023 at 5:30=E2=80=AFAM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
>
> Ping?
>
> Is the mailing list still active?
>
> Best regards,
> Marcus Folkesson
>
> On Thu, Jun 29, 2023 at 12:00:00PM +0200, Marcus Folkesson wrote:
> > Add 'freq' to the parameter list used for WiFi Tethering.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  doc/connmanctl.1.in | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
> > index d87472c3..cf662ca3 100644
> > --- a/doc/connmanctl.1.in
> > +++ b/doc/connmanctl.1.in
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  .BI enable \ technology\fR|offline\ |
> >  .BI disable \ technology\fR|offline\ |
> >  .BI tether \ technology\ \fRon|off\ |
> > -.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\fR\ |
> > +.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\ freq\fR\ |
> >  .BR services \ [\fIservice\fR]\ |
> >  .BI peers \ peer\fR\ |
> >  .BI scan \ technology\fR\ |
> > @@ -86,7 +86,7 @@ by default since tethering it usually breaks local ne=
tworks. See
> >  for enabling.
> >  .PP
> >  .TP
> > -.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase
> > +.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase\ [freq]
> >  Enable or disable wireless tethering, as well set the SSID and passphr=
ase.
> >  .PP
> >  .TP
> > --
> > 2.40.1
> >

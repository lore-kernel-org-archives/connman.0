Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24B21ABA2
	for <connman@lists.linux.dev>; Tue, 25 Feb 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496043; cv=none; b=r9M8lheHbTrFzDHM/Z/YRQs/qjek3FFVaWHD5K31lAz/0xVFPBM5IyQpmSZvhUA9ktsINXJEtJGMUdLNmulo7nPZrF1XTNXfFmVTj6tQkd4PqYbVFRnROa7ckhJfppykyLN2YniW16pu8SKns7AAu/Yi67XBrSDxKDaOyLE+CWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496043; c=relaxed/simple;
	bh=z3812SUggOGF6vg7UzMw5ymJYUewNLICY86nEMv0jdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoL0u2WFN68flNdZiIsASqncB0nhuDXdW/527pdU+D1AJfKOFeEvh6gxl9v/3z8i6EXbe/3RSZMhusp7yBDl3q/y7W18vh40DOS+x7Iap2TWxR6KOle10Ra+QFPFAG3y2xhfSm2mKQ2spi9stV6z1lpmbannOrUeE6cJIbWXaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ4nS6dR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ4nS6dR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so8861858a91.2
        for <connman@lists.linux.dev>; Tue, 25 Feb 2025 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740496041; x=1741100841; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3812SUggOGF6vg7UzMw5ymJYUewNLICY86nEMv0jdc=;
        b=HQ4nS6dRb+yQciLC4jzdre0pDE5oluYSWWV/gOkbuoLnS6Jiwg9pdTRZZqPY9NyzYy
         xpRyJdJk6W2VFg+ZYr4HQe6EYJedN1Shms5l4wh6Eua12+pET3OqtrghWnlDyeLde9h3
         0tar8vgYlyFpH8yCj56S4lCMdnDV8ev6S8j4/zXDseZeM6rLkT3M/+nEkZC/FnT8sjdK
         2wDH3b3HK+H08SGx/VJDFSodEib8Co5ywoxqcac9LZEYq/P348N2Ex3ModqYMUNPlXP3
         Wy3DELaAYtnicf4MaJEgk5cZoiaViPWmObmVtaxhqtWJGo65oe7iExtCslF0Ls5dNL2w
         /C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496041; x=1741100841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3812SUggOGF6vg7UzMw5ymJYUewNLICY86nEMv0jdc=;
        b=smQ01sm/ZZjo+ioqe9BA/2vYm8NBKPenKE8hAmN10GC8HmsroAL0g+8HmTIMJ2kPXr
         kb6WLJZY1mJEdR8K2igDEmCfBz1Wl9nJtwGVq2YY9sazVSuHHEg4GXn01f5YcMyvpJtJ
         OiMG83EuX2CpiejZgsx7JT21zurO+o2hf1ANCTIUS+vP11gl1dlS48RWfqk4LU7bpqd6
         8b8S7ikgZR9gcz4mU9H89SoJ+ZRvsJaLvGLpNior+mfCJQ7RPpRr0jQFeXiRQ825xWBk
         A9CfsLbDxAyoBUQra5m1wJtDbFjpV/62ZwKB2XNyRuLup4lcotmjcuvrRIhOZxvbYd2P
         8OdA==
X-Gm-Message-State: AOJu0YyNwwVXCBhUEsARAPhwZYiw3n04s97nH0tIt/vlfwyOqhOl0c2o
	5qzBEdvO/XUxEWyzSXTQqNGkrNiyOdPoZYFpROYdlksLOyjtrDq5fbXUJ8IgFYGKXbBg/ZbvarI
	OpPfgcRJAGZk9qeI1Dcy48BI0ONX9zw==
X-Gm-Gg: ASbGnct6AT1XsL7Db3wNQCaotyVxqiMXMTP33kX09pzvI9vaNdAjY6D/hnJrdJY2gY3
	10gkux88iEjVyZvWM5HmwkkupAFDH0kkl9uG703exF++/IjM6gJfyPptLaPvab0klbyGYe5rTKR
	pSeBeHc5ZwFQ==
X-Google-Smtp-Source: AGHT+IGPDFb0uFUyJk6sMzSazmm0DRx1KCoYX069dUMOqseiYPAvkrINUjta2IPBNWm5l/a69BctMuJQ38WSxoU29wA=
X-Received: by 2002:a17:90b:4b0c:b0:2f4:43ce:dcea with SMTP id
 98e67ed59e1d1-2fce7af3f6cmr29358139a91.25.1740496039614; Tue, 25 Feb 2025
 07:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Mx9RKX=aZf9206tMkoc6GgGJs77nN70X9r_JS13eommw@mail.gmail.com>
 <E65D058F-7765-48D3-A73A-D98A5A5661C4@nuovations.com>
In-Reply-To: <E65D058F-7765-48D3-A73A-D98A5A5661C4@nuovations.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 25 Feb 2025 09:07:07 -0600
X-Gm-Features: AWEUYZmIV3ceSPF8CNE4fmVfhfN8PmRo2QYZVsKo8SXzEaqx7wGSlaKRuMaAdZY
Message-ID: <CAG17S_O4dZZfx+HwSrO3o=TOnh+_3oaotu_fi2GRvipuUY3B8g@mail.gmail.com>
Subject: Re: Configs interfere with SSID deletion in connmanctl
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:10=E2=80=AFPM Grant Erickson <gerickson@nuovation=
s.com> wrote:
>
> On Feb 14, 2025, at 7:39=E2=80=AFAM, KeithG <ys3al35l@gmail.com> wrote:
> >
> >
> > Is it intended behavior that when a *.config is present in
> > /var/lib/connman that connmanctl will refuse to delete the config?
> >
> > I have a config for my local SSID. What we do is upon boot: a script
> > looks for wifi info in a txt file in /boot/wifi. If one is there, we
> > create a *.config and put it in /var/lib/connman and when connman
> > starts, it will connect to that SSID. All good. Works as expected. If
> > I go to connmanctl and try to remove the config
> > connmanctl> config wifi_blah_blah --remove
> > Error wifi_blah_blah: Not supported
> >
> > Is there a requirement that the *.config must be named exactly as the
> > folder in /var/lib/connman for that SSID and then it will work? As it
> > is, we give it a name which is the "second blah".config (the hex
> > string conversion of the SSID name). Is the intention that we are
> > supposed to delete the *.config after our first connection to the SSID
> > and then let connman manage it? We do notice that when we delete the
> > *.config that connman automatically disconnects then deletes the
> > folder structure under /var/lib/conman.
>
> Keith,
>
> It is important to think of *.config and /var/lib/connman/<technology>_<i=
dent> as distinct and separate things that are, likewise, administered dist=
inctly and separately.
>
> I like to think of *.config as =E2=80=9Cprovisions=E2=80=9D. That is, a c=
onfiguration provisioned by a user or system administrator for a network th=
e system anticipates encountering at some time in the future. If the networ=
k is never encountered, then it lies dormant, in wait. When the network is =
encountered, it serves for automatically fulfilling information needed to c=
onnect to and create the associated network service that would otherwise be=
 interactively gathered from a user or system administrator. Since the =E2=
=80=9Cprovision" is created by a user or system administrator, bookending t=
hat, it can only be removed by a user or system administrator. In effect, i=
t lives under but outside of the connman automatic administrative domain.
>
> /var/lib/connman/<technology>_<ident> are connman=E2=80=99s own, internal=
 dynamic, mutable settings that both live under and inside the connman auto=
matic administrative domain. If there is no *.config, then settings will be=
 created for services automatically (Ethernet or Cellular) or with some use=
r intervention / input (Wi-Fi). The format and administration of these sett=
ings is opaque outside of connman, accessible only by the D-Bus interface. =
When a service is removed (or mutated) using the connman D-Bus API (which i=
ncludes connmanctl), these are the settings that are removed (or mutated). =
Any underlying *.config provision is untouched. While related, as we learne=
d above, provisions are understood by connman but are not administered by i=
t.
>
> I hope that helps!
>
> Best,
>
> Grant
>
> --
> Principal
> Nuovations
>
> gerickson@nuovations.com
> https://www.nuovations.com/
Grant,

Thanks! I now 'get it' as to why it was set up this way.

Keith

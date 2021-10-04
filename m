Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B33FF9
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 21:21:21 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id m26so2361006pff.3
        for <connman@lists.linux.dev>; Mon, 04 Oct 2021 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5kHEszIpqKV3FTSPNChruI+yP8g8F+q4tOGa+iCD0w=;
        b=lfYvX4AVXJkiv5AEEK5LFCrrCvCtDHbb0W/xnuljlalKRiUuOYvV87V7uCMHBVnWsv
         KHFyLvmDHNuAYB6PsPyLlcuTwfPcoYwm8Z9/eaMjIqh/VD91Bam5MX/QTdE6hmM1Fxmb
         +SnFXGeci37PqMSQ/L78M1sI2UMMSpyUU37pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5kHEszIpqKV3FTSPNChruI+yP8g8F+q4tOGa+iCD0w=;
        b=rjSfpwtzODeMC5X70Uz0Aq+fqbRztr7RbrxSgR8eJjfNkkqmBr/FzEMGZ3avJnj7OC
         5TSysM8Pw+d6asGMKAnASRN7YSlHuQHNqCZd+s2S5VEwO0zpwuPKgNUDxoyqeCxVYr31
         jjXqNoIE+Z04vKA3ag8wMYOdzGQAn3YVX1zNwld1S3GSkHh7ttgv4X+28G1ZwXpde1oO
         EUXOgjDBFcguIaNikxWIR+f9zX/ncHYsoPngZ6Dr2Qv1ii+k4Huuw65DA2V5bI1Uxr7F
         q3k3ahNYE3Hxlwzx9JLHPtBKjJRx5Tux/W+/BHKIA1duXzoTonBQSxeSZi5+YoLfdHg3
         slUg==
X-Gm-Message-State: AOAM530C4np+IcWxiJFVgTShXROwr6b56BzVrVnGLb3OGpKiTrQvrYcJ
	MUvWGdqxZuZVPQAD2SXBATMgMTLSV1o/wnpYfAVJ5FGA/TbPOQ==
X-Google-Smtp-Source: ABdhPJzEuxupKJROw7FaWUPmAwtU/G/ajMxk99bPYkhbK/LJMuMaOCgwTS2wIDT6mwjzPT+TwsaxQCSs9V59om2SEw0=
X-Received: by 2002:a63:334c:: with SMTP id z73mr12939388pgz.160.1633382480819;
 Mon, 04 Oct 2021 14:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210923124429.1123-1-v.henriet@overkiz.com> <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
 <20210929091641.fg4v7pbol2nysgrd@carbon.lan> <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
 <20211004070906.625dlmzqv57r7mac@beryllium.lan> <CAOf5uwnB3QQYRiMG5HtKVVeE8cL-MWh_5G94RM7FmZ+NeLpf=A@mail.gmail.com>
 <6f009b7c-d7ef-6800-f0d8-67f045d6ae4f@monom.org>
In-Reply-To: <6f009b7c-d7ef-6800-f0d8-67f045d6ae4f@monom.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Oct 2021 23:21:09 +0200
Message-ID: <CAOf5uw=dsGdFmSEBhhQBFY0CkUuAcky=YhouHaOa2zHnaVNE0g@mail.gmail.com>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
To: Daniel Wagner <wagi@monom.org>
Cc: HENRIET Vivien <vivien.henriet@overkiz.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Oct 4, 2021 at 9:46 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On 04.10.21 09:34, Michael Nazzareno Trimarchi wrote:
> > I can create a function to get
> >
> > ident = technology->tethering_ident;
> > passphrase = technology->tethering_passphrase;
> > freq = technology->tethering_freq;
> >
> > connman_tethering_get_params(techonology, &ident, &passphrase, &freq);
>
> Yes, that is what I had in mind. We need to retrieve these values from
> the core/config somehow.

I send an RFC in the mailing list just rebase some old patch and
adjust a bit to be more complete. I did not
time to test. I need to know if it can be a starting point or not.

Michael


-- 
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

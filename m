Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B93FCA
	for <connman@lists.linux.dev>; Fri,  1 Oct 2021 13:51:27 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id j4so4872551plx.4
        for <connman@lists.linux.dev>; Fri, 01 Oct 2021 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSRzo57QT2FGiKlVmEVGHTYWcoYzKHRS3i7BWQFniCA=;
        b=cAbKmKtiwOrkRGc6tCgOvvuDOvt/KUCAMrZ3Q/sCQ14PRyS4Qttr2gdjdYxi+pfV66
         j8sbl+zCiDtmMFCqRqmMOebnaxfxuK/RLH+nMB9CykfXyjJpNSyl0AKB3wZkAq5E0mcW
         NB+EGcUU4FgSviRWKhYI3px7g4Nm3CfobUESk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSRzo57QT2FGiKlVmEVGHTYWcoYzKHRS3i7BWQFniCA=;
        b=maK21M8ys9F5hgPPLtNqnPhC1wySg7TyiQv/rCiIjccd+EnE+/bzvCYVp+gwuVmnxa
         zLWAyfrvtRAdsq0gBKkXFw69SeScWkxhBAxTHrqaRdMd5WAwOpB9xL7Wkyv8eem9fAGx
         +4I+tQ1SkuiaUVMLRMN8F70iS/IdemGVnetB00ffp8Vp3MEjOPHbh+bcWmqLj/3Byp6D
         KfIvWk42T69Xsqsi+lFvg552KCizRAkzenn4nOiD7iJO8FZ5A8dgebVI0THmfKXTHwLU
         3Jux0tl829lcMNuTf8ayPOjcO9SuG7GFBgIGCYXeZR5TqY3G5+tlpNoQc2WakRrlq1Xb
         oYuQ==
X-Gm-Message-State: AOAM5333EpOCOKQ82UvM3GWtIA8H3s2BmkEFUoL4y7QH0hyTaJIDiD+R
	DqtoLiYpFh60SlP45FRmvQeCxvyHcVTPnQNBWcHmRw960ivVKA==
X-Google-Smtp-Source: ABdhPJwgdERRFMFmNRRvZ+ooa1uQDBDVKefoZDrex19QXOl9c4vfUG6cE+POMJefm4z1dBbSVm+C0GbGdTXNPobKyPg=
X-Received: by 2002:a17:90a:7342:: with SMTP id j2mr13589135pjs.59.1633096286913;
 Fri, 01 Oct 2021 06:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwnCvrffN6go_BwM0oOMGM+OZ=EucuV_OnifnmGQ+XE3kQ@mail.gmail.com> <MRZP264MB1544DC6779714C03B90848E993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB1544DC6779714C03B90848E993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 1 Oct 2021 15:51:15 +0200
Message-ID: <CAOf5uw=tibsuwk=-TnML2+Ltfd7g_SmUKdrFLX4-OgGtctHUCA@mail.gmail.com>
Subject: Re: [PATCH] iwd: Fix missing Ethernet attributes
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Oct 1, 2021 at 3:48 PM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> Hello Michael,
>
> > I have sent a similar patch 6 minutes after you. Anyway nice we get
> > the same conclusion.
>
> Indeed, what I have noticed.
>
> In fact, I have just integrated iwd in my projects (set-top-boxes),
> which where previously based on wpa-supplicant.
> When I ran my network test campaign, I have faced some issues I have fixed,
> to keep the same behavior as previously, with wpa-supplicant.
> Today, I am proposing  the corresponding patches.
>

Doing the same, at the moment ;). For another project.

Michael

> Best Regards,
>
> Emmanuel



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

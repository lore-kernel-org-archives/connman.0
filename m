Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9D2C9E
	for <connman@lists.linux.dev>; Sat, 29 Jan 2022 07:56:42 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id i30so8227215pfk.8
        for <connman@lists.linux.dev>; Fri, 28 Jan 2022 23:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BreLXZvOE960zypO5VUfYtrjrYJ2CsYuTIrqbinzvyo=;
        b=NcFf6JgmSZQFIoUmJ89pSq4+50Mp9T/S8fpzHogQAtsiXjE//nrdaWgemeCgrX/hp+
         RabAii+1kWCCJD1iNEgIOBZxyUxYmaOFOGAh9qO/xwXKx/mg/ykZ0VlHCwMMXRLSgmmI
         UlUOyXtlF2yvXgJtkWFjZfu0S6XZ3ShaGzvmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BreLXZvOE960zypO5VUfYtrjrYJ2CsYuTIrqbinzvyo=;
        b=Tsikdy6qAF9jpYO2XO7diC2Icn02wDFmjhaqnHabCKJRBHyILWMN72pHdeo3prTh0Z
         budACVfyCv0JgJNVoEAwJESJWhnryhTsMnH41ROqCtTcQu66K5xgjLGcnCtoVD/VF2Rp
         LSQv6r1vODBYvf96r893gDzpWuqMmyrje/TO0p9vhuTjMjaW1lqNWSlwwRy7LK4vnOVG
         NzZPtZlzj3XqeWvpAxX6AdtbJVpyxKwPaWs+SM5op6T+tNSDOeeZbhSXNwt2x1YvY8cC
         nAUVDtKrHyGvvah+0d0z+C2TBDunR9hO5k3iENqb39+gLECL7tuYw/ZgV0CtWzO4lUTL
         JcTA==
X-Gm-Message-State: AOAM530nbaAR62RlzG8Q7xbYPXNEM4M8ySeteAk3nG6Ofm8jqII2cXmn
	h3EfHjzCEsYs8S40OL4m1i6trdt3nN3ELVyIvCnqkwVBK/Y=
X-Google-Smtp-Source: ABdhPJyAU6fu8lKNp2pFXGXi72UNSszwnIcnXUDZdDXRF41wA5zVS8KwhkFlh89hY9/y0bT4pX8tKPe5tPjx5/CW23Q=
X-Received: by 2002:a63:c51:: with SMTP id 17mr9389929pgm.491.1643443001953;
 Fri, 28 Jan 2022 23:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <BN7PR04MB526773125C2674FE24553E789F239@BN7PR04MB5267.namprd04.prod.outlook.com>
In-Reply-To: <BN7PR04MB526773125C2674FE24553E789F239@BN7PR04MB5267.namprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 29 Jan 2022 08:56:29 +0100
Message-ID: <CAOf5uw=BwwJvgPd8EmX72S6VRweHSiBE-0jA0+yCzrDy2hfPiQ@mail.gmail.com>
Subject: Re: Question about 1.40
To: Thomas Green <TGreen2@sorenson.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Sat, Jan 29, 2022 at 1:14 AM Thomas Green <TGreen2@sorenson.com> wrote:
>
> I've been tasked with evaluating version 1.40 moving from 1.39, and I've =
come across an issue that I think is a bug.  When connecting to an AP and a=
n incorrect password is entered, the connect call never finishes.  Up to th=
is point, we do get an agent error, but the call to connect also returns, a=
nd the dbus error is returned as well.  Is the new behavior what I should e=
xpect going forward?  Or should I expect the connect call to complete with =
an error as in the past?
>
> Attached is the log from running connmand -dn and the log from connmanctl=
 that illustrates the issue.
>
> If I missed a fix, please let me know.  Thanks.

There are fixes in 1.41 release. Can you please test that one?

Michael

>
> Tom



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

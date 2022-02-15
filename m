Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCC1386
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 10:37:03 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id g20so9900903vsb.9
        for <connman@lists.linux.dev>; Tue, 15 Feb 2022 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PT/jGjVOEJ3/JbqyiiQmie/SJAZqtyuPD5jHdBMFwAg=;
        b=RSqya5AsxlhEOyheKgDaEqvlxMOsj8sDQpFBaTTc/UXpo13WYRhLH5RfT58RbvrlGz
         IUxdjMlat2+1T9XqIM4YD4w5TB6r2I97q1uWrEyAB927cQotdvWJl06xsINwl+EDHrAT
         xe5K8bgrLo/hKbWvs1CjFZ3E+b+Ca+Nao2eOvj4ccLuGe82sh5qYV34RyGqEXeeZ8XO+
         snz3Gr9quqXuXSC1l4bsomRwYbfg2f09rDircbLbUzU7aQ/CtSYQbqUqXFlDPpotqA6z
         xOcZUgD9m+MOkuTgvKLaOGpJmtUx7pO6EaF6eR8Y1ia7t0BJV9/20HBBPQjQJ8OmdVxR
         e6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PT/jGjVOEJ3/JbqyiiQmie/SJAZqtyuPD5jHdBMFwAg=;
        b=s2Padldmk7QfW7l4Obhuk1s9ElzyLJSy22mRQZOQwEgIslfbqY7GdgS5MQJYyVaETn
         5zjmrAUVsJRlDHG8vctjDcbxvl+sQZ5NDn6k7FIE/6UxLDY9XQgOGr9aR2c710EvVhFU
         SMf7Mls9yBOTysvEVac1esIarsVS656KbLdXESWSZnTSquyLNiv/HbFd3tZAum4llArQ
         r9gZF5/HkAu2rtb1OCn7kV2ROcxOTFiK4K7MELR3AmBkmibrzB0/WrbeBCPT45NOCvyA
         ft3r639k4LtR08nm+pXW0UPVlrstaW761rRpNkxGVoEfpJPua5XD4pocmpeNxP3brr8X
         LKTQ==
X-Gm-Message-State: AOAM532lmEGAalcpeFzzq461SQAJl6kEUGH7KxI4vzNTfR1Q5L+fydEK
	aVCUTt7eQXDJB20TfX//DwXduB9JfaYlr3nfMxLpRq2Tv8AdOA==
X-Google-Smtp-Source: ABdhPJzJkIG8uKEc5oeZ5pC8Ad2+5FYj0Xoe9ARPOK+sTWWR38HIH6erRAjF1O/AvTij7QsvyqM//79HrUhFnvT9rLQ=
X-Received: by 2002:a05:6102:ed0:: with SMTP id m16mr1224829vst.71.1644921422085;
 Tue, 15 Feb 2022 02:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220215102638.599189-1-net147@gmail.com>
In-Reply-To: <20220215102638.599189-1-net147@gmail.com>
From: Jonathan Liu <net147@gmail.com>
Date: Tue, 15 Feb 2022 21:36:49 +1100
Message-ID: <CANwerB0jFWpnTkpF1qispnAw5K1X__OQjMP=xEEGe9UHLDMd1g@mail.gmail.com>
Subject: Re: [WIP PATCH v2] iwd: Fix disabling tethering not working for brcmfmac
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 15 Feb 2022 at 21:27, Jonathan Liu <net147@gmail.com> wrote:
>
> For Broadcom BCM4356 chipset with brcmfmac driver, changing from AP mode
> to station mode returns -EBUSY if the wireless interface is a member of
> a bridge.
>
> To resolve the issue, the wireless interface is removed from the tether
> bridge before changing the mode rather than after.
>
> Fixes: 648ed549f0ac ("iwd: Add support for tethering")
> ---
>  plugins/iwd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

This is a work in progress patch. I needed to make these changes
otherwise disabling tethering would not work for my brcmfmac wireless.
This patch seems to result in a "no ap object found" debug message
when disabling tethering. It seems by the time it tries to lookup the
ap object in the access_points hash table in
tech_disable_tethering_cb() function, it has already been removed.
The connman_technology_tethering_notify(cbd->tech, false) line had to
be moved up before the ap object lookup as otherwise the lookup
failing would cause the tethering property to not be updated from true
to false when disabling tethering.

I guess that means Stop is not called on the iwd ap object as it was
already removed.

Any suggestions on how to improve this?

Thanks.

Regards,
Jonathan

Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7583FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:36:00 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so7577189pjb.0
        for <connman@lists.linux.dev>; Sun, 03 Oct 2021 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJOZ59untWSwdjWyFh7oKnCPluoy/XVY/aXMxjUD7PE=;
        b=WjpcBHsV/7R+xfZSLTMC2axqa8Iv0QVlb+Gjg7ARpAgGQKtFOpXz2PCpvS4KJSXYNC
         MHj6lwfEfHJt17mRX/qmdq2fm/MCzbpmWDY6jtwlUpOksufgXQrt+ux5X32h2auJYjbk
         I+N8RS0VNp6ySuKn6VdeeqyUO/YZEii72ZEq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJOZ59untWSwdjWyFh7oKnCPluoy/XVY/aXMxjUD7PE=;
        b=xhNKCqdPQEu5XqE0Yz2ST8b+J4PFkoH16B3JQg1tWgOz9kr7Vn7PLLZlzr/xNIayAT
         duz5lSaBSVIw0NHMAJh80ixEm0SYiQ2NgG54MEzS4ihupgCF/iaHb1Fyx2EkNCgliMZj
         fBQ3gwh5E6mtG2Gy4gcJE9aAMPPWhmixNGmWnqd0PE/P8rTNKNQxjZZu+hXmu21S3EW0
         0FQ9I41tI6+cuyJYudjeJoo3S5XxP4O8x5rYmUQvylFTRo9oYOo+XcrFaVBFFOFVPmZM
         XtPvzUa3wfgVRtn73B+Ii89YwxwKDPFVLDrbevJxFNyWQ9h5TywALnkg/A8I8Ji3nz6W
         1m6w==
X-Gm-Message-State: AOAM533hrGDuvgIoQBeV4JISJZvNLO+gtCIOKd88a9KamyHsbSLvTLcv
	Hfl92SFBkPrTOHzAyWVyf4Rim3mObrQHl4mt8ETlQAN5fd7MIQ==
X-Google-Smtp-Source: ABdhPJx9qjmCdF3gVDLLaA42vygJ/2qn8FUuCT12P1Ng4CwG84LT3Jy9jgOMBUe/oHcDDpjAAOzrlLPhjhdAbXCUSjk=
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr28862059pjd.171.1633329359894;
 Sun, 03 Oct 2021 23:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211001122607.34360-1-michael@amarulasolutions.com> <20211004063214.r4a2ie5njhk4y7hz@beryllium.lan>
In-Reply-To: <20211004063214.r4a2ie5njhk4y7hz@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Oct 2021 08:35:47 +0200
Message-ID: <CAOf5uwmyAkq5a4+NdPw48bBW+V588Bn8X5=z9_oKqcB9EKcdFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iwd: Set the network index add_network
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Oct 4, 2021 at 8:32 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On Fri, Oct 01, 2021 at 12:26:06PM +0000, Michael Trimarchi wrote:
> > In order to have compatibility with wpa_supplicant
> > configuration and fill the dictionary as was before
> > we need to set index not when the wireless is connected
> > but when it's registered. This allow to understand
> > what wireless card is using each services
>
> I've applied the version from Emmanuel. Hope that is okay.

Better commit message (aka better english) and 6 minutes before :)

Michael
>
> Thanks,
> Daniel



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

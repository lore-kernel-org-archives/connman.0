Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1053FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:46:09 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so2814977pjb.5
        for <connman@lists.linux.dev>; Sun, 03 Oct 2021 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJwEckt9A75cindn5lv8AMRX5FuFVYtC4ig7Btf9bsw=;
        b=iWNdgzHggRi5uzXrOv6V7m231uisEWcMtEqj61ItrcKH+bqHFA3aQoUXopgibSqydf
         zXXImYQ4QI+byHJq9sQaxuovCwyPXGmnCraj3zDj2KD9eccADomyL2VhezrFJzheFmHj
         IgNoos8p+6nKwEq3deb6WrQVcoB9/ZEmeM86w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJwEckt9A75cindn5lv8AMRX5FuFVYtC4ig7Btf9bsw=;
        b=vD63QuIOq+/O3ntyBpV44wMuXFQEcZeqKn0vhIF1Q+emvg9p/bexPdGp7w1+1Rm5/n
         N2n12TRdqp1rjaF+gFZAH9DkpAuEy7j1LFjZrn4sTTpi8ppVA2yceV5xUSrjbPTUrunu
         Yp1ZLRUSMNruveTB1mrLIyImlsxhxp09+CnrpCtS3gOPD3WkFdfmHKYhfewJE7f95L+s
         MKKlungKN3YWBE02lakD3sNJ1/LhCSZc3+wVwtHTRLrbnMnvd6kIqp4n1pH5DlgpLtky
         6D9DaLLs/O9dttzUQyeZ5rulfdTLiHbOKYLnOZvxaKEhXtHCjIDt0jdmNxVMndagV2oq
         9q7A==
X-Gm-Message-State: AOAM530Pg76VVGQ6GzDhjcXmPYhD5XhmHbdUR0naMY0iyAw2+SDiSdYd
	CA+DPIBEJ51xuZh6L7OFlV/P8jLzmt2DYhIv/yKIKFmMlXNdRw==
X-Google-Smtp-Source: ABdhPJxYlI8ACvAo0gumEIrdp/IhFBVUXVyddLAlW7cEpX8a/UfzH6OGasDpBu9Tu3pnveqChefvP0Z40PJIs89tMxc=
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr35404301pjg.118.1633329969070;
 Sun, 03 Oct 2021 23:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210923124429.1123-1-v.henriet@overkiz.com> <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
 <20210929091641.fg4v7pbol2nysgrd@carbon.lan>
In-Reply-To: <20210929091641.fg4v7pbol2nysgrd@carbon.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Oct 2021 08:45:57 +0200
Message-ID: <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
To: Daniel Wagner <wagi@monom.org>
Cc: HENRIET Vivien <vivien.henriet@overkiz.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

On Wed, Sep 29, 2021 at 11:23 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Vivien,
>
> On Wed, Sep 29, 2021 at 08:57:25AM +0000, HENRIET Vivien wrote:
> > Hi Daniel,
> >
> > Could you have a look to this patch?
>
> Sorry for the delay. Anyway, I think it would be better to make this
> configurable or smarter instead of a random channel selection. I just
> checked what iwd is doing and if I got it right, the iwd daemon does the
> channel selection itself.
>
> > I would like to be able to open the WiFi AP on different channel.
> > The simplest way to do it, is to select a random channel, which fit my need.
> > Do you think its acceptable to integrate this way?
>
> Random channel selection is a bit a wild solution :).
>
> > I've got also other ideas to achieve the same goal:
> > - Add an optional channel parameter when opening the AP
>
> This is what I would suggest. Alternatively, can't we use some metrics
> from the last scan to figure out which channel is crowded?
>
> > - Add a global config to set the channel
>
> Generally I would like to avoid adding more config option if there is a
> way to figure it out.
>

I have sent a patch long time ago in order to add the possibility to
set the frequency of
access point. Can I resend?

Michael

> Daniel
>
>


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

Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755E3FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 07:35:05 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id p1so7679428pfh.8
        for <connman@lists.linux.dev>; Mon, 04 Oct 2021 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjAMVlj8UgOn/JZhlsGEFtxdHQhsFTrBXfpyB0pgiFI=;
        b=Wxl71ej4FEtz8K8V248xBVZsAydhXx4dRINp51yZLTAV0NJgMdbCmDh3/abqrnfj6o
         6bgFyxuuOT8r7NCCAHt2UA4p6QZLLkr2RrFb85BdjOeXN84pwTOEd3OW5Da6A1WBLiB8
         DhnwjNIVPTU/5HZxUqLKHFBzCXyiFHkPCjWrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjAMVlj8UgOn/JZhlsGEFtxdHQhsFTrBXfpyB0pgiFI=;
        b=WhuHiG3vXzd9XCwdJzYoNQEmGvwYaVAH566fyFt5xv5Gj59T1gfOOpxk6v3Wdvq5G+
         k+mrUmrxnvIc+QTDeK7udZ4pd3A4LmCy8lDIGu1m2TE8Vya5o57VUowB7NfUZstriggl
         8WKoUfHSRuxHVLtMQt5snAg4iuKVuHYel5r/DJ352AelAsP93qLZQa78nFMG5gOE3Oh2
         W8HgSKkNtVRXa0DAOHri8RhAphJkE2/cHLoqNnaSprVFtnJZje6HrtmP8XsOnw5z8e9D
         qqYnaF1qXGqFw9QTeTwIpBBlq+lhgXoFEtepzLrsNvo6X5rvss7NZ7iLvNDXkD+n7txq
         9mYg==
X-Gm-Message-State: AOAM533XDY1ZAe9FvJeZslpDt0KumrhhoeqyhoHoX0XUK7+XjX7272wt
	HTEYwqDC7girIFqK1lZSbe9jx5pOGROrA83vE8sWPA==
X-Google-Smtp-Source: ABdhPJzlWliNSTNAZY7BvC/kCizSdffPEhJaugPRLAwzXTad37Oh/Gg3jNd+10TVFkD5p0Skv/nQfiktgL1bK6SxD0Q=
X-Received: by 2002:a05:6a00:1989:b0:44b:3bb1:9361 with SMTP id
 d9-20020a056a00198900b0044b3bb19361mr23180411pfl.67.1633332904432; Mon, 04
 Oct 2021 00:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210923124429.1123-1-v.henriet@overkiz.com> <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
 <20210929091641.fg4v7pbol2nysgrd@carbon.lan> <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
 <20211004070906.625dlmzqv57r7mac@beryllium.lan>
In-Reply-To: <20211004070906.625dlmzqv57r7mac@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Oct 2021 09:34:53 +0200
Message-ID: <CAOf5uwnB3QQYRiMG5HtKVVeE8cL-MWh_5G94RM7FmZ+NeLpf=A@mail.gmail.com>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
To: Daniel Wagner <wagi@monom.org>
Cc: HENRIET Vivien <vivien.henriet@overkiz.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Oct 4, 2021 at 9:09 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On Mon, Oct 04, 2021 at 08:45:57AM +0200, Michael Nazzareno Trimarchi wrote:
> > > Generally I would like to avoid adding more config option if there is a
> > > way to figure it out.
> > >
> >
> > I have sent a patch long time ago in order to add the possibility to
> > set the frequency of access point. Can I resend?
>
> Oh, my bad. Sure please resend.
>
> Thanks,
> Daniel

I'm rebasing it. I would like to know if:

  ident = technology->tethering_ident;
        passphrase = technology->tethering_passphrase;
        freq = technology->tethering_freq;

        __sync_synchronize();
        if (!technology->enabled)
                return -EACCES;

        bridge = __connman_tethering_get_bridge();
        if (!bridge)
                return -EOPNOTSUPP;

        if (technology->type == CONNMAN_SERVICE_TYPE_WIFI &&
            (!ident || !passphrase))
                return -EINVAL;

        for (tech_drivers = technology->driver_list; tech_drivers;
             tech_drivers = g_slist_next(tech_drivers)) {
                struct connman_technology_driver *driver = tech_drivers->data;

                if (!driver || !driver->set_tethering)
                        continue;

                err = driver->set_tethering(technology, ident, passphrase,
                                bridge, enabled, freq);

I can create a function to get

ident = technology->tethering_ident;
passphrase = technology->tethering_passphrase;
freq = technology->tethering_freq;

connman_tethering_get_params(techonology, &ident, &passphrase, &freq);

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

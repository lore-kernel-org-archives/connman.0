Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04D2C81
	for <connman@lists.linux.dev>; Sun, 24 Oct 2021 07:46:10 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id m26so7715520pff.3
        for <connman@lists.linux.dev>; Sun, 24 Oct 2021 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IZfAGXY2NSfho+SkhmuRck96WTGMg2mwItkw97BKrJE=;
        b=SGsjv3UnOOnw5PYq4GC0Sr4VEOsuobYfmGt5BShrn0DxAg1/yJabnXArcbofOA7HjJ
         xrBdbNeKum6R96aho2pnQVvtbrlqON0UuG2LhCZwON90zJ+HkJwf/KQUH7zCDKOL24pc
         cZiRmlYmVevzOjtGbrkXz+HaJZL6ledAuN+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IZfAGXY2NSfho+SkhmuRck96WTGMg2mwItkw97BKrJE=;
        b=cyhima31pu3t2dM9+qw2V05N13AKPJAhvYklxYLVulTX7EceKxGU7XMlTGr+RD5OCf
         4a5YlQe3MU+e+UWWD1Sl0zzRDjVUDAvcVzScN4j2FSU1XpA2rqMow2xHlp/8LHQvGzox
         2kqhT9SRMhzjqQPFuvPyvIV7fQbJu/g1PcsJdoywnIWFF59L5xxt8/uZ9R9geaWCg5Bv
         eifyY8W/TsUrdTu1I/gufSPKQqyBNeLVMMeuXC4oaqraxEDYFLIzgw8WvUzCBMTx367M
         tOR8HrUqJOJeYvg20SyPy+pownmRuSAOxe4Ax7NS1H52T/oFH1SY2WNMbbzFajUmOrbV
         BXgA==
X-Gm-Message-State: AOAM530XJYvxthL1j4xf3+KoSgtGiB10JaAPf/DILO1tdu8TCl/LJF7E
	Xy9hqXcdR1lzYjjYiqrRRUL+1oO7lk9kxTv8zxVSYzBLOP0=
X-Google-Smtp-Source: ABdhPJzddPHq4uRzvePuTxCNquV8/DVTKAYjRo80pCszHm8N3KlpPGWpSOxrxeQp4WiuVvs82uGia58O5OODqjaQLxM=
X-Received: by 2002:a63:334c:: with SMTP id z73mr8037087pgz.160.1635061569839;
 Sun, 24 Oct 2021 00:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211023214953.5606-1-michael@amarulasolutions.com>
In-Reply-To: <20211023214953.5606-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 24 Oct 2021 09:45:57 +0200
Message-ID: <CAOf5uwk_bPAr9u06pkuSz0yS+hanycVHcsxDeKkfTTss4D41zA@mail.gmail.com>
Subject: Re: [PATCH] tether: Fix connman_technology_get_wifi_tethering
To: connman@lists.linux.dev, Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I keep the compatibility. Another option is to give back them all anyway

Michael

On Sat, Oct 23, 2021 at 11:50 PM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The function is called from tethering, so the tethering is not
> yet enabled. We need to workaround in order to get the right
> value
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  src/technology.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/technology.c b/src/technology.c
> index 97419150..5c469111 100644
> --- a/src/technology.c
> +++ b/src/technology.c
> @@ -367,19 +367,23 @@ bool connman_technology_get_wifi_tethering(const struct connman_technology *tech
>                                         const char **ssid, const char **psk,
>                                         int *freq)
>  {
> +       bool force = true;
> +
>         if (!ssid || !psk)
>                 return false;
>
>         *ssid = *psk = NULL;
>
>         /* Workaround for the neard plugin */
> -       if (!technology)
> +       if (!technology) {
>                 technology = technology_find(CONNMAN_SERVICE_TYPE_WIFI);
> +               force = false;
> +       }
>
>         if (!technology)
>                 return false;
>
> -       if (!technology->tethering)
> +       if (!force && !technology->tethering)
>                 return false;
>
>         *ssid = technology->tethering_ident;
> --
> 2.25.1
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

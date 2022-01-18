Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBC168
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 10:39:08 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id g2so13548336pgo.9
        for <connman@lists.linux.dev>; Tue, 18 Jan 2022 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBTyVMySdXnjO/u0+EWEKNmpAHILfvUtJzQvq1Ty4lU=;
        b=odf0Lf5th0DV3l0V4ALfTB0vCWn+2SzwKQ2ZC/DI5IBHhDSwIArSKm8uizqOpYQk4M
         lQc43cQMzzUzBivtFlgQCqNhaI4ey69mdd6f12cRNMkVnWfNQWR+5CElqHB17Cvbp4Y7
         X3Qmj99176RPDtAtiZQF2KsVHAqdAJ3XZ+lS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBTyVMySdXnjO/u0+EWEKNmpAHILfvUtJzQvq1Ty4lU=;
        b=gA2HZpd74031TrEHsYsoY8eIdCN+sQIGz04mOH3R7EhsyvjG3fB8pFIfkNXBqVuYf8
         JsYOrWM5hSUgPkZV8UKYowAo4qiySEWE+SQE44tpzxRc6tB0KVdOReCKXQiPnVfdFh8i
         p8BS+I/p++afzQSBrYsbo6v6WFIAuxSwgQ2wJI2azC1PajjkzlN7nmGBblSjPM05t8nS
         44FMvIGlk3uFe8nCt8jxVHjlblzta7PeI7lyK8P++vxzDrkkbqb842RJkrBFr7LqEbnU
         WU9yQMt6LK2BTlcVckp6ZVGFcA8ZWq10faMWinkiM2RiCooxsUSTDtb19VipUJdOiwXm
         wEhg==
X-Gm-Message-State: AOAM5322yxVN8R0irJMC1yBFYOKZdSyKfeE5Hmdgl9ann3khjbqXnv5/
	vEJ0LfmvovpAXHpwDfu1tUt08Vll3mpmZP69o52dkrCP7eNyAw==
X-Google-Smtp-Source: ABdhPJx6q6EfSfAOvBX0AmhKm4cUmn0IS0bwAuY02KFyesY2R9hGdOTIVwFixCUpvrN26Z13uYVgvhd8e4eeXa3VQdk=
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr23343960pgc.94.1642502347898;
 Tue, 18 Jan 2022 02:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220118102842.1199829-1-Emmanuel.VAUTRIN@cpexterne.org> <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB15441C964067460C12EC95B793589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 18 Jan 2022 11:38:56 +0100
Message-ID: <CAOf5uwnROoPv55mkO267v97UdSaPo9=Lu2-npKcbObhfxo6HUw@mail.gmail.com>
Subject: Re: [PATCH] iwd: Fix station in scan callback
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Jan 18, 2022 at 11:33 AM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> The station shall be searched in stations table instead of networks.
> Fixes: 8371114aaef9 ("iwd: Hookup manual scan trigger")
> ---
>  plugins/iwd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index b0e17a4d6396..bb97262eff38 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -555,7 +555,7 @@ static void cm_device_scan_cb(DBusMessage *message, void *user_data)
>         const char *path = user_data;
>         struct iwd_station *iwds;
>
> -       iwds = g_hash_table_lookup(networks, path);
> +       iwds = g_hash_table_lookup(stations, path);
>         if (!iwds)
>                 return;
>

Can you describe how to verify the problem?

Michael

> --
> 2.25.1
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

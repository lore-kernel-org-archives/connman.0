Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5A2C9C
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 11:03:24 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id r5so5613946pfl.2
        for <connman@lists.linux.dev>; Tue, 18 Jan 2022 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzGkJMfVnXRo7VDg51XtPhvVdYuyjZtb6gxGfDmW+EE=;
        b=IooYXsGtLsyjW9f4ngsKqpiT/0NKGx5yIR/Jw0seHYy+3EYKXF8nFtUpODaIWwzvtW
         YHwVq4D4Y8zGHEyj5G/N1/Q7HqyzbY/ng5evsptAHCHqpa2RtrFqO5SEtucMvFAo8Qn9
         XQQaF72j42jUBsP6NtgE5CniBrF6Yc9iWJMm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzGkJMfVnXRo7VDg51XtPhvVdYuyjZtb6gxGfDmW+EE=;
        b=ZFhnzB2L1U1fnY+WaXOa3pQGjVkhWyUG4/WpJ581u+WVJIjg/1xaaUluhqlvYZiyBb
         +8YD20q6SY+6/8BNvw9Vs1g/sioI/IB/DPptYzMSFCWPNsMqf/Ldyj8QGqeeN/QXhO5d
         Bssb5bvGxMey+BeLTU6sJmQ/MbaCfyTaXNlNNtzBv1Ll+1+3PnR5yMBBpEBnDMyekx/O
         PvVwgiB/ImsI+5MqzTVoorGH+SvxgJqcUiMr+7WYnnktMyx+Y3DujK6VCDQlFAlFlIX5
         TlIJ05NB0HnWpbvr7e9neAXnaYbSsnmUJwVbe9wh9IPg9N9nzpfkObQk3XxgVzhwJeM2
         yz4Q==
X-Gm-Message-State: AOAM533Gri+nz1tEQMh2H20Wa8DWd6srHF9YmpYwtleZ18zteBsMs9Qg
	0nOq+zgnHLzjL0C5saVxfiVfpZy4wA8pfunSVKnR58vH1k73dQ==
X-Google-Smtp-Source: ABdhPJwU/CPCQ+HUb2IZTKaOJD8vLaZsGYlmItkOmLrgftbf0rUZrLSD2ijipMH8+wk9rxsEPI0GWjNy53aziyP6HrI=
X-Received: by 2002:a63:7d42:: with SMTP id m2mr22660895pgn.491.1642503803960;
 Tue, 18 Jan 2022 03:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220118105214.1201110-1-Emmanuel.VAUTRIN@cpexterne.org> <MRZP264MB154494E627C59DCFE5854FC593589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB154494E627C59DCFE5854FC593589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 18 Jan 2022 12:03:12 +0100
Message-ID: <CAOf5uwmgupp-oHt2a9jahxE9V9pYgw2VbNfsHa7g8o32WiPBqg@mail.gmail.com>
Subject: Re: [PATCH] iwd: Fix connection with no passphrase
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Jan 18, 2022 at 12:01 PM VAUTRIN Emmanuel (Canal Plus
Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
>
> During a failing connection on a secure network with no passphrase,
> agent_request_passphrase() crashes, trying to manipulate the value
> of the "WiFi.Passphrase" key, which is null.
> ---
>  plugins/iwd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index b0e17a4d6396..b524a731fb92 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -1489,6 +1489,8 @@ static DBusMessage *agent_request_passphrase(DBusConnection *dbus_conn,
>                  return get_reply_on_error(message, EINVAL);
>
>          passwd = connman_network_get_string(iwdn->network, "WiFi.Passphrase");
> +       if (!passwd)
> +               return get_reply_on_error(message, ENOKEY);
>
>          return g_dbus_create_reply(message, DBUS_TYPE_STRING, &passwd,
>                                          DBUS_TYPE_INVALID);
> --
> 2.25.1

I don't know if we have some Reviewed-by: Michael Trimarchi
<michael@amarulasolutions.com>

Michael

> Hi,
>
> Same problem here, I attach the patch.
>
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

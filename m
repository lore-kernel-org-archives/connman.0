Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50A71
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 18:39:16 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id j2so37569695lfg.9
        for <connman@lists.linux.dev>; Tue, 22 Jun 2021 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuXoEWKunhFTxfMA9+NvMWX/h30106TQQDvgHod/UU0=;
        b=dDIYGh7vfEgbqVaK3AVaX1DtyUdmZypK0NR72Cq5GCgqyUSJDp7k36rHiv3wwca2u4
         cNCdKHvHUF+7GERWEbC5IxHunVw+C1AerDK47PgZ26e+krf0VVdApBznXwpPC4pr9pIt
         UQT3csBwZVFOL48E6cPEwXuw7uXtbo2O9ogq/8i64XdXYUY2wfm6/a5rdoL2Fjs9GaRs
         /ISPKIgsOXHRIH9nlTND+IN9MiALk425RVXPkMyHlq6+Io8BSu1k/c41bkQ7u8+fGuMX
         B98Qpp5SXOIH2MMsrEeubZjmNkzI8vAaWu2vrtLyuCuMNz5ecIW5xlZvJOFuLBr3Fcc+
         90+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuXoEWKunhFTxfMA9+NvMWX/h30106TQQDvgHod/UU0=;
        b=pJweXMHYJaXzSPI4i1AX2qMpdA2FjHXUX15j0GD6AqVV57WcQu5TcdT0HwI8gKsFSm
         Il4rVkl49W3DeNbBeHZTrsKnKtDNSaOccGZ5/aSsZOQCelxHvzw2MGO+bJg6cGVWUg2g
         J15emV7waOYiJ0THCopiherBvpvwDt7jf6qkLIzBVTMbQAnNBNH87AOP9G5NkNyziF6i
         RYlz0pS/ApGHiiEhibT5Lbd8R824PYaIUJ8pmIOAB3JmSV0DmdEbKeMBzL7XDkA+3W99
         MAFY1MsDS3UDrcFYC0+YXBt7dVW9N30G04vEpFsCl8IoL24OUdZU9YNVYG99uK24Zvr0
         wvNA==
X-Gm-Message-State: AOAM533YgaCDTN0xwgZmooAxvpRK3/ZlNSo/vYr3/IqJjZoD/eVmAx4Z
	obm11NkK4msSlJrh6leY4ARHBgFs1fvub9QMfH4=
X-Google-Smtp-Source: ABdhPJx6nlbfXE54d5pGb4SaM6MWhU1fQVTv6oyy6WTPhFeXhaFxSA0FRRdi6wq/DY89+EJa5gqF3HlIgEWKkn+gjlI=
X-Received: by 2002:a05:6512:3b27:: with SMTP id f39mr3775968lfv.360.1624387154322;
 Tue, 22 Jun 2021 11:39:14 -0700 (PDT)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAmFs7=AcOmoNWVaGEoi_9FPgh3NBS1LiceWOVQgL0xS=hnKYw@mail.gmail.com>
 <20210622193132.5cd53815.john@metanate.com>
In-Reply-To: <20210622193132.5cd53815.john@metanate.com>
From: Andrei Datcu <datcuandrei@gmail.com>
Date: Tue, 22 Jun 2021 21:39:03 +0300
Message-ID: <CAAmFs7k-MPU3KXAD7JJUuwL-LXJtjTXnYC8e10Bfs2kdtvxMkw@mail.gmail.com>
Subject: Re: Clearing service error from invalid-key will not invoke the agent anymore
To: John Keeping <john@metanate.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello John,

Even though they share a great deal, these are not similar, because
a) I'm calling Service::ClearProperty("Error"); // there's no way to
do this from connman afaik
b) I'm getting operation aborted as an error

If I skip a) then I get subsequent agent calls. Also I'm able to
reproduce the issue on 1.36.

On Tue, Jun 22, 2021 at 9:31 PM John Keeping <john@metanate.com> wrote:
>
> Hi Andrei,
>
> On Tue, 22 Jun 2021 21:10:05 +0300
> Andrei Datcu <datcuandrei@gmail.com> wrote:
>
> > Using version 1.40, I'm trying to connect to a basic psk wifi hotspot.
> > If I input a wrong key to the agent request, the service will
> > correctly get Error == "invalid-key" (and State == "idle"). Invoking
> > Service::ClearProperty("Error") will put the service in a weird state:
> > every subsequent Service::Connect() call will fail without ever
> > requesting any agent input. To leave this state, one has to call
> > `Service::Remove()`.
> > Is this expected or is this a bug?
>
> This sounds like the issue I reported here:
>
>         https://lore.kernel.org/connman/20210615120930.2970caef.john@metanate.com/
>
> I have reverted 8ea2d67a6e8935d06f71b1ec77a2f89d72be49eb locally and
> that fixes this scenario.
>
>
> Regards,
> John

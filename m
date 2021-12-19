Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658722CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:41:38 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so7888404pjq.4
        for <connman@lists.linux.dev>; Sun, 19 Dec 2021 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIfwEIF2C1yC3kf77SjkE8KhkgqD8b3QK6GGB3oNq40=;
        b=HUzEx+rLF8uEGyPWr/enTrMBGEYXyAUzgKXUx8zub7ui4PG+mu8R7auC8bKblqw0Uj
         gfkx74yfHFHeCqfkKZGAorbIPanOywpwK3NQN39E+bkVs4z+NzAQB5qCNxmofpfbXFio
         fcLuKx9x4k1SWG5t2gqIb/slkeNF2YqVTmdLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIfwEIF2C1yC3kf77SjkE8KhkgqD8b3QK6GGB3oNq40=;
        b=jROlDu3KtC9aJoTX2H5SjmYOm4E0hqKqbqR6rCsK8Y2OGGtQ1K9jxWT6gdbbZUU+l5
         utwAzPJvCqT6dJZ/1QMzSLZ3Tf4dE5qdnrUCLqe8XiPbRm00Q6WbulAR79Oz7ER8YJ1g
         g/r78lHEaIQaPHr30UEXs6A5EoErsGB93ItRwHwXSHfqw+asS/28Y4mvb+zl8EG0rj4q
         jkfM4HmS9sGQpiVYGh66rzQQaBzSUNLd0CsFbaO6IAK/9oQR5gRAwyVRD/umFHDakD0t
         3yhrvdlLxWefZpRTyEoYJsAgO1dTsj5yk929nIoLwy3i7+/bBohRf1FG2B4uvukAS8RO
         hIBA==
X-Gm-Message-State: AOAM532dtOG/0SGz54qLK70wWXTm320ulX+a0ENM1YA2dDHGCTk3BurG
	KZLK1rI4325VEBl7CFdM/BLNlDshPNzGBHImm2HPiesTLtU=
X-Google-Smtp-Source: ABdhPJzstGE+N1PSdprwgjmwTvluiAeoWXnoTQZjNofCcq/0aVfr/I+8MshYu9fuuoPkOe/YS5q0iWkqGT++Y+9+vwc=
X-Received: by 2002:a17:902:7248:b0:148:eb68:f6d7 with SMTP id
 c8-20020a170902724800b00148eb68f6d7mr9548401pll.97.1639935697774; Sun, 19 Dec
 2021 09:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ya4LuuATLuB7waD6@ikki.ethgen.ch> <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
 <CAOf5uwnvYzk0ZX3Ca_FSQLM4sf4mp_UtBStoUcdoeH9L8DJvOQ@mail.gmail.com> <20211219173114.nmbtxjmzxee2izbk@beryllium.lan>
In-Reply-To: <20211219173114.nmbtxjmzxee2izbk@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 19 Dec 2021 18:41:25 +0100
Message-ID: <CAOf5uwmDHhMpVh6tFfpHHqo-YzfhaHSAY6zStDqxUmOFu5QsVw@mail.gmail.com>
Subject: Re: Too many wlans
To: Daniel Wagner <wagi@monom.org>
Cc: Klaus Ethgen <klaus@ethgen.ch>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Sun, Dec 19, 2021 at 6:31 PM Daniel Wagner <wagi@monom.org> wrote:
>
> On Sun, Dec 19, 2021 at 06:23:55PM +0100, Michael Nazzareno Trimarchi wrote:
> > > I think by deleting all known networks and previously corrupted? entry
> > > got removed which prevented the proper working before.
> > >
> >
> > I have respin the patches on network removal. I will send
>
> That would be great. IIRC the patch was almost ready.

I would like to send it on Christmas as I have a nice way to put
variables :D follow the Christmas tree pattern ;)

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

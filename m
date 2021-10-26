Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882B2CA8
	for <connman@lists.linux.dev>; Tue, 26 Oct 2021 07:42:48 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id x66so13452450pfx.13
        for <connman@lists.linux.dev>; Tue, 26 Oct 2021 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOpMTdvalvpjMXRZDRfACfrVXg2B41FUtBYU0QOzfRI=;
        b=d2VL8s6mbUOVXvIl5w7jGcOeF5ztIlYdYipqI9CEcetCblbAPNDXvDnAz+j51IL22A
         vZIIR7vkW/iNUz50sSuHC55GtTEmuKmGFHaJVmSoHfoQ09GFWwcA5/G3gY0Q2RUiFn0r
         9HgA9lrDx9MPSERLTl8/6m8/W1egD0iy+8T5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOpMTdvalvpjMXRZDRfACfrVXg2B41FUtBYU0QOzfRI=;
        b=cCLxE3Cb8BBV6tM8to0JdP0C4bPIGGUp+cbxYW7oYuSszaBSMc63FHXyqYgXvG0u8C
         xgMDdtuBB+ndR5gWGN6BZu4E9O8iOSdO1nQ/pJfu804bF7R87AZGxrqIrKDu6L6Y9c9I
         1QAUpkSBQ21n/sH3oJ2Yxz6IUfvb93xidj6oDkkKNf3L+sd3g2bObRXrrQGOGZfdtSFo
         /MUKNcEs4DEcV85pNz55vkCEyNc0SoCccQ85wRsGbr0KFiEMlnh9yXYokN3GlqIMp4Ch
         85bRVEHhjr4NLtpMs2sm3WeuG9H7qqI3VMFom4oL22H1eXlzsE87cR2Xbx6uAfAV8b6T
         ldsQ==
X-Gm-Message-State: AOAM533/TfqYDt+gtWBbk0oQGnNKgrxdYW9VVhGBnGBWZ7Vxn2Mk4nPg
	sLyWg6LLLECfAJMM+6mgneW2gcTWxZbO1WE/+izhgA==
X-Google-Smtp-Source: ABdhPJwuZAIMhMFWedtIpXDuTOV13hmD9jBpVNB4+vKanS53L4r00f7g4Ww2RiXwqJ3rej4LKEicu6ni0B9dlJ/MIiQ=
X-Received: by 2002:a05:6a00:21c4:b0:475:e532:3d18 with SMTP id
 t4-20020a056a0021c400b00475e5323d18mr24264493pfj.40.1635234167987; Tue, 26
 Oct 2021 00:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211025132643.4485-1-michael@amarulasolutions.com>
 <20211026070413.fv5bbuwpch3qelab@beryllium.lan> <CAOf5uwk-7TNhtfqUY-7Pb_w1id3yq5=jyJdv0Gf9OE46Zp+DAg@mail.gmail.com>
 <20211026073737.jtlyqaj2azyiauee@carbon.lan>
In-Reply-To: <20211026073737.jtlyqaj2azyiauee@carbon.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 26 Oct 2021 09:42:36 +0200
Message-ID: <CAOf5uwkyhumUFPj8xsJ--r6hwDKJ2tAdkfg_+0pkpcdeHnto8g@mail.gmail.com>
Subject: Re: [PATCH] Add GetKnownServices api to connaman
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, Jan.Ryll@bshg.com, Simon.Holesch@bshg.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

On Tue, Oct 26, 2021 at 9:37 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On Tue, Oct 26, 2021 at 09:09:06AM +0200, Michael Nazzareno Trimarchi wrote:
> > > > +             service->identifier = g_strdup(services[i]);
> > > > +             service_id_parts = g_strsplit(services[i], "_", -1);
> > > > +
> > > > +             if (service_id_parts == NULL) {
> > > > +                     g_free(service);
> > > > +                     continue;
> > > > +             }
> > >
> > > IIRC, this check will always be false, as g_strsplit() will return a
> > > valid array or call abort() if allocation fails.
> > >
> >
> > I don't want an abort to be called, I will adjust it.
>
> Sorry, I didn't express it clearly, g_strsplit() will call abort(). This
> means the return value of g_str*() function always succeed, thus you
> don't have to check for NULL.

Sorry, I have already checked the code in the project in the meantime
. I understand

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

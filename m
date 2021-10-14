Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504852C80
	for <connman@lists.linux.dev>; Thu, 14 Oct 2021 07:36:27 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id r2so4699952pgl.10
        for <connman@lists.linux.dev>; Thu, 14 Oct 2021 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwTxyKaPbAoPxPZ5TpuMkzcO/4GawxHLU4si4aBC1Uo=;
        b=QYJalHQqj6uCM7CGWYndAIoTW9InyOq5QWGeey97zwmMp8mOfI9SZhE/hGna4FEv3z
         NNENyVgsYXU/qkux/fu9BgQ9UDmsMLnoBnFrftDCqraHTXRA1u2L5A9hJ4wPnmJntzk4
         wDxh2qbOkZq9F4A8SKb+yhv3WaU/C/lkz/aZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwTxyKaPbAoPxPZ5TpuMkzcO/4GawxHLU4si4aBC1Uo=;
        b=jzNeUe0g3iczy/LqVaqTB8CVSJywYe7jvV9EaO2WbQJmjSHcBDowKpMrXdXAwZyxIg
         IZKxIAjGIasDhxTkr6gXq9hDMfjh7L1R8t4u6LVcUkQb3+D9afjwpJ3xomDOSqtLCRGT
         jQJkfLWNmmT5CCUbv9F+wdMu5gNkCRbt866grUxjV9UXMSmTEEWAbcdE/eOiLR9ASxGN
         M9ZWeuSahGAi3u8yz8yo7DonprkA5WR9KHEJBMgRwe4gU3IJZhUWwnkxIqbBoWnLzMz+
         fcjnIei5YgHjeElQvnGmU+3FNeuZFQ5F42U/mWxa+SA9CphmwIFJSEB8gfRjtL+w4gKd
         yTlw==
X-Gm-Message-State: AOAM533jcVdK8CBmafk1CYatJduTkYfDLj34WkPYsEhapfC9jG5qicST
	RW4ukykpw4slvYeGmn8BkoQ3lkOaXVFsbwyQVgQO7Q==
X-Google-Smtp-Source: ABdhPJz3lx7jNKUoW88xG7alqJ82YbKBmpj4kdvjVekAfTl8+SOUG9qT8NlZdhysXh5LsMGPtHwkDARRKfHbn6rNjK4=
X-Received: by 2002:a63:334c:: with SMTP id z73mr3168486pgz.160.1634196986350;
 Thu, 14 Oct 2021 00:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DM6PR04MB700338BA0F2EBF84D07EF5759FAE9@DM6PR04MB7003.namprd04.prod.outlook.com>
 <20211006123643.txym4njkm7pqnken@carbon.fritz.box> <DM6PR04MB7003F49568682041E308855A9FB79@DM6PR04MB7003.namprd04.prod.outlook.com>
 <20211014073337.wvlnjeognyhlw5dw@carbon.lan>
In-Reply-To: <20211014073337.wvlnjeognyhlw5dw@carbon.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 14 Oct 2021 09:36:10 +0200
Message-ID: <CAOf5uw=jE7YpD-c6fbaRHrRZTFTD08eQAKFaEmTYMjYoQ9sJjA@mail.gmail.com>
Subject: Re: Removing old service directories
To: Daniel Wagner <wagi@monom.org>
Cc: Thomas Green <TGreen2@sorenson.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Oct 14, 2021 at 9:33 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Thomas,
>
> On Wed, Oct 13, 2021 at 10:47:42PM +0000, Thomas Green wrote:
> > Thank you so much for this information.  Is there any plan to take this up
> > again?
>
> The last attempt (Bosch?) was almost there. As I said there were a
> couple of small issues left, but unfortunately, there was never a
> followup and I forgot after a while.
>
> I searched again for the last attempt, I only found these posts:
>
> https://lists.01.org/hyperkitty/list/connman@lists.01.org/message/4RJBOEEVYDAWFDT4PJ64FJ3PSAQ2SBMM/
> https://lists.01.org/hyperkitty/list/connman@lists.01.org/thread/PTMSQLBY6RKGYWUFWA7FDBRT5RZCWI7H/
>
> > Is it something that would be better for me to take up, or for your
> > group?
>

I will work on them on weekend and check them

Michael

> If you want to work on, please go ahead. It's not that difficult.
>
> > Currently the only work around I can think of is to shutdown connman,
> > remove the files, then restart connman.  This is really not the option
> > I was hoping for.
>
> Yes, that's a show stopper.
>
> Daniel
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

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864992C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 07:01:28 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id v20so5807819plo.7
        for <connman@lists.linux.dev>; Fri, 15 Oct 2021 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9gBUxdr3zDIP35nYcf5XFyM6k4bH/B+ZsRiGZJ+r24=;
        b=V3Vb3F7x6bchQffUZgVzNgUu1zmpbjaZq2MW6MekZ4aeqg2nL1lGetq9uTxNJsildy
         S43LM9wjTx41qQLCCF1DkM6/ykti6Dou4JMOeX+bgn45B9Iwvovfc6s8mRiaJWGdGlcV
         3lzimYizSWwRx0EPgLze/abtEsrzICw/nD80c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9gBUxdr3zDIP35nYcf5XFyM6k4bH/B+ZsRiGZJ+r24=;
        b=75CwcEuvdO4uMKE3i79E+oT0KluM5nBfD/2yENcWlt44ibA4D4Bv0v1NHib+6TWkAC
         nuMg/KRrGuCyfJXCcKIQ2UNYPuttJw0SIZeId2bjJnENWNOOneJpO9/703cRbdqSWdDC
         XmuiH8Rx2AmKhXgPgIccCsEWBqT/BeRsI145/E8vUwxVV7SYJYwz3tzdJpl2+okF9VGs
         3pLcgRkeN5Qn8kbK+LIwPbxMONmOGiyH+XFD8vQDARhMywRZhOnCYd9QLxBpSXdkDkmS
         emm5Wuo/bPIj1EU5i+tW8PLmUrvm48vUWCXCXQPPgdRJegJoIzGl5ZniIAKzNqgeXKIP
         ukvw==
X-Gm-Message-State: AOAM530tdt0U+xWBVI/Hm6x/o+x5NxRkA7VKVAb7AJHuVp0ogSEeQP7t
	nJvpg3L05abZLXqGzeqehtQk/iLcG5KQWjCJgMl/Yn3/x8JPKQ==
X-Google-Smtp-Source: ABdhPJxWYNQX859t2B2lv/TkpPg/K0EmA2K0TV2NPnR9yYOz5Rk309/0FTXHn10VEtnDLGtiy4nNeU1RGGVk5rAzGIw=
X-Received: by 2002:a17:90a:be02:: with SMTP id a2mr11877010pjs.59.1634281287594;
 Fri, 15 Oct 2021 00:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <20211007213021.58712-2-michael@amarulasolutions.com> <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
In-Reply-To: <20211015065250.nt2bprsnsrpdfeoq@beryllium.lan>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 15 Oct 2021 09:01:15 +0200
Message-ID: <CAOf5uwkB6FYrpzs0djVB8EYe3-rG8C0o+JfzoV7+3B_YtU1OrA@mail.gmail.com>
Subject: Re: [PATCH 2/4] tethering: Add possibility to configure the access
 point frequency
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Oct 15, 2021 at 8:52 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On Thu, Oct 07, 2021 at 11:30:19PM +0200, Michael Trimarchi wrote:
> > When the tethering mode is started, a WiFi ap is created using the fixed
> > channel 1 (2412 MHz). Add a way to configure the channel
>
> I had to update this patch because of my changes in your patch
> #1. Nothing scary, so I applied it directly.

I have done git remote update. Nothing new there ;)

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

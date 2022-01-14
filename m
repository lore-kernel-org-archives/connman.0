Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A932C80
	for <connman@lists.linux.dev>; Fri, 14 Jan 2022 11:20:06 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id i30so2504314pgl.0
        for <connman@lists.linux.dev>; Fri, 14 Jan 2022 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIWc46mwraot50w21sF+xbYaEqowUKvSDh5XiJCiL0w=;
        b=UYdHYZgBS298CXLGYUdsnlhzNYWxobClpwBIuWe2Yim5CGOmfuGoscYXfnkPRqve/Z
         DeN2qUNH9CI8m0q1bI9W2tJYckv/FPCNX6mi7dbR1vDPvDz1UISGGACxMw+UrUrPhO4R
         aeL5KhufxyyhmSDTEakgOURMs30PC351yamxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIWc46mwraot50w21sF+xbYaEqowUKvSDh5XiJCiL0w=;
        b=jmLycrCPCgdBthUiuMVEwktRXuvRQJbFTW7/vbS8idP3HWqFn9vtzOcnS+SyI7hhKk
         frhyrz3djDVUjvRw60VAIJJX8Cp6K4ETaoRdpxNNXV0jWLD0kI1foa0l6+NSWSmtbPe8
         O8vyiZaE3nynfBCBeck/zZbmY8cje8I/3zEfWtyHfDclBQ/YSNsa2J87mN4etIbt4/AQ
         3JOULVfLDBLVK4TFgVMa6Yh20d9Ow4d/6j+p3hPyqZIwEufbrMQ8G0B9eGinklDhmUUo
         IyxthzTNdzjpZsnLZ6DKecSt+DFP9UuSRB1KPBAU2xytNAkm9P1akxAQ7MEeUfpOi7tM
         C0eg==
X-Gm-Message-State: AOAM5310bW6sDvst8kDFVKbEGdRc6PDxZaTQPnhiv2VKchmD6Gh14dIx
	M49yjAcHW2YU5h4VfuMcM5jgEUEjdM/M2m44Dk1+GJwSi5VB3A==
X-Google-Smtp-Source: ABdhPJzxdt8h0eBRZhDVhpomAFX55W73sxa8YphOCYicZyyQrsn+AYDWbL3POCZ4A5NbML/ZppGDXPo+ff+zg3mcUgc=
X-Received: by 2002:a63:79c2:: with SMTP id u185mr7837988pgc.74.1642159206202;
 Fri, 14 Jan 2022 03:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org> <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
 <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com> <03304641-cc5c-4150-277e-3ac77732f9f1@monom.org>
In-Reply-To: <03304641-cc5c-4150-277e-3ac77732f9f1@monom.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 14 Jan 2022 12:19:54 +0100
Message-ID: <CAOf5uwn3TyX_mKLRmSy1Hk98esi-AbKV9rqjo3-oh0-hngKAHg@mail.gmail.com>
Subject: Re: Network with same ssid question
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel

On Fri, Jan 14, 2022 at 12:17 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Michael,
>
> On 14.01.22 10:50, Michael Nazzareno Trimarchi wrote:
> > suppose you have 3 access point with different signal strength on a
> > network, the best will be connman select access point in the area
>
> This selection is done by the wpa_supplicant/iwd, not by ConnMan.

the wpa_supplicatan using wpa_cli show all the network so connman
can create several services with the same ssid name. The logic to what
service to connect is can not be done even in connman

>
> >>> IIRC, ConnMan merges those together and only exposes it one Service.
> >>
> >> is_duplicated the one that merges them? I think that in scenario when
> >> multiple access point
> >> are present we should not do it. I have seen that even iwd does not
> >> show duplicated. Is that correct?
>
> wpa_supplicant or iwd? I can't remember the wpa_supplicant details here.
> For iwd, all these stuff is done in iwd. Not ConnMan.

I have tested iwctl and wpa_cli. The first one show only one ssid the second one
all the access point. iw scan show all of them

Michael


>
> HTH,
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

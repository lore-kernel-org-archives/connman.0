Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BB15A6
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 20:45:01 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id u7so11084276lfs.8
        for <connman@lists.linux.dev>; Thu, 14 Apr 2022 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ayclhj5y4Rn1Dr1ZtbOxFjELAsCAJoVksoQHjiGlww=;
        b=gNOhoR06XudUP25tXhwFJ7h8vY7goPwzBVum2HrBRipCTiYBGdJM9N0mIfvDlY0E7m
         t9pEiHaYoLfP81zZCD1Gs9rWGeKv/c9zE2TxW0MFItZcai6PJjory0KyJCFmntsNv7gn
         GYZMtJZH6DPOZJlipw2d3ZkxP1/Aj4AzJH8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ayclhj5y4Rn1Dr1ZtbOxFjELAsCAJoVksoQHjiGlww=;
        b=I1gIrVPvxDNc0C6pXvjyZ9dOz83o6Hso7LePAERjp8il8/KymsOawQvT0nMti+4ogq
         WhNN7HyuvWmELghaM9AN+piw+y9AOS/ZZbNts8TA2VaShoihGzrArVpi5BaFclsdGI5r
         AeSOdVzx6LQM3Cbfhf14BBjzfYSzrOzgtDF1BjxcP3uh9tJVmd4SgCZeFRKA1BbspP0V
         bhscbNJVCr++X4EN97AfWwX2WEsrIKnoF+hk9CB9Xj7iwreZ2RmeEKFtbXnJ/aVDzwTr
         5nd9M8/4xssjSO2hhr4R1P+QQxJFbzMN3ju6pXkGj3WS5+fnQlruDEkKuy8nGEYt2IpV
         +QMA==
X-Gm-Message-State: AOAM532/1INMcV5F5aovuz/wZ2uz4ihpC9b6dXRBSAQnCTli4lJpI57K
	cEigjlomDg1ti04bGwir+41LEQA9pffNhFqwOYhri/SVnHWWOQ==
X-Google-Smtp-Source: ABdhPJyOxPoOw1bOn4Blm8VHyhOMpzEAbp4Vt0gpRV+36C+ODZHKu0gFyX9yedLBQ2ghRs9Pk+Bp6QG/prxWJe7MDyk=
X-Received: by 2002:a05:6512:4012:b0:46d:14d8:954f with SMTP id
 br18-20020a056512401200b0046d14d8954fmr2681196lfb.52.1649969099854; Thu, 14
 Apr 2022 13:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220411173217.505144-1-ryan.smith@density.io>
 <20220411173217.505144-2-ryan.smith@density.io> <20220414190136.zebsvyjysfyem3tz@beryllium.lan>
In-Reply-To: <20220414190136.zebsvyjysfyem3tz@beryllium.lan>
From: Ryan Smith <ryan.smith@density.io>
Date: Thu, 14 Apr 2022 14:44:49 -0600
Message-ID: <CAM7Wg-Xhvm9zFJx4wnr5pVo_VDGTh+UK9GSbDX_HB+uAVk0kiw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] wispr: Fix online check when using WPAD/PAC
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

It looks good to me. Thanks for the quick response!

-Ryan

On Thu, Apr 14, 2022 at 1:01 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Rayn,
>
> On Mon, Apr 11, 2022 at 11:32:17AM -0600, Ryan Smith wrote:
> > A PAC file can return multiple proxies in response to a query.
> > They are separated by a semicolon and, possibly, a space.
> >
> > 'PROXY proxy1.example.com:3128; PROXY proxy2.example.com; DIRECT'
> >
> > Currently, this is not handled, and the inclusion of more than
> > one proxy causes the online check to fail. This fix parses the
> > first proxy in the list and uses it.
>
> Patch patches applied. I took the liberty and refactored parse_proxy()
> slighly to much the style. Also we are still stuck pre C99 (I know...)
> so the declaration have to go to the beginning of the block.
>
> Please let me know if I screwed it up.
>
> Thanks,
> Daniel

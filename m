Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066B15A6
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 20:45:41 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id t25so11090964lfg.7
        for <connman@lists.linux.dev>; Thu, 14 Apr 2022 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WSoyILIvM9dJksmUY4+CEtTCcGp7BnUiN48ZkxD/gE=;
        b=AhhxlrHoCPqO8SthSTg6kZhsCFG6v3rQl6SAG9v3Z3ooiHAKYHrC/EncTPQdaCAwRa
         JpubwAOqRmNFznTaq6Botv5efXJ6bdEwS2sDOGgH9j0/HuhehSHzuViS7YJ+y/10UFz2
         JUeiPBqWmq7hO94QHKUACk9ilKPiTtaU5DlHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WSoyILIvM9dJksmUY4+CEtTCcGp7BnUiN48ZkxD/gE=;
        b=H3PRfVBiLH0MkVy+obndZYfQI+F7OQKyL4GBo7cDnF/S6u1k/aasTzcSpSyvKTPld6
         vCP/ceYBla8L3L/s+NxUF0Xiz4ucf1qZOuOhzdFk6pMht1uKWVefXOw2Ep0r2eZGKDAU
         Y3mPs/h1FNVzkbpOJRx75kd/f0PilNfiJCAReyh4nHJpzjVbBKbkJJTuQqO+aFuegimx
         XqSOmBqilghNc35aShGX3EEa2o+iYKDCufxqnPEIIfYuZC3DDzx84e10HPr5wqd2rZ7r
         jDtDM69DU/sqCBgciBZNh5j/QwJZyxXv9qk8VOMzV/1d7S2k8sC7Lst744JO3Y3Xwqdd
         YI8w==
X-Gm-Message-State: AOAM531fBVql7Kd78qDBj/Wnfn0SwgfYoZY2vIgvvWA0FNP4z8k3o7Tb
	Y0ZLBEhy+9SzYhwV5GniDZMIIg/T4RM/mIzIYDMbWg==
X-Google-Smtp-Source: ABdhPJwMQTF/7+AsjZgDejzG271NMyX2DxA1fvhqBXex8xiLKjOweurfnGvOcsAQUFt4YgU33qU5wRMlPWeVOh5C6W0=
X-Received: by 2002:a05:6512:220c:b0:46b:8594:ad6f with SMTP id
 h12-20020a056512220c00b0046b8594ad6fmr2983629lfu.148.1649969139712; Thu, 14
 Apr 2022 13:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220411165821.501633-1-ryan.smith@density.io> <20220414185139.eq5w2jirf4e7fy35@beryllium.lan>
In-Reply-To: <20220414185139.eq5w2jirf4e7fy35@beryllium.lan>
From: Ryan Smith <ryan.smith@density.io>
Date: Thu, 14 Apr 2022 14:45:28 -0600
Message-ID: <CAM7Wg-XfW6h570F0pUQMcsQEMYo7Y39oLFJ3nZo=KewhU6qOsg@mail.gmail.com>
Subject: Re: [PATCH v1] dnsproxy: fix debug logging
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I will take a crack at minimal DBG logging when I get a chance. As is,
it is impossible to enable debugging of src/dnsproxy.c from the
command line. It would require a specially-compiled version.

Thanks,
Ryan

On Thu, Apr 14, 2022 at 12:51 PM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Ryan,
>
> On Mon, Apr 11, 2022 at 10:58:21AM -0600, Ryan Smith wrote:
> > This fixes the debug logging by compilation unit just as it
> > is done with all of the other files in src/.
>
> This is on purpose: 3977a250624c ("dnsproxy: Disable noisy DBGs")
>
> It really spams the logs and these are in my opinion left overs from
> the development phase. If you want logs please figure out which of those
> are actually making sense and just enable those.
>
> Thanks,
> Daniel

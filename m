Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF16108
	for <connman@lists.linux.dev>; Mon,  9 Jan 2023 18:12:40 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id a30so6783590pfr.6
        for <connman@lists.linux.dev>; Mon, 09 Jan 2023 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IJPoC5I9UE1Owx/Qx75gOsEt9njfDgki6NZ7QadCHQo=;
        b=Ngkf+tHY/yJg35uLJdRxlmL/8mYobspVXchgaYa854oNiyu9Pw0Luq78pRSL237Rot
         JcDewtaO+SfNSAeCpgE3ZA6cXTKEQ34gVk2PeRmwlsuzQpBhTDYKLohI6G5O3i7N02DL
         dBE56H4lGHY9JW6M3HaptFH54GvyWlZfCmPBY+UJ68zOu4EcduTBF7iF2zKZrclC62Hg
         bYiGmPXDmlZUNRaQo9OR2f8TGZDKfNT5iRdPUAdyNaInGWL+K0fLrTj3u83niXq6L1f2
         8PqFpXFDrEPRPmT4Dd9YBF0+M9YI8zCY2C5Tr5+AeHYsRwDuzOqqemDEyh9L0EMXqqGI
         rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJPoC5I9UE1Owx/Qx75gOsEt9njfDgki6NZ7QadCHQo=;
        b=kGyYATpY7UdOhDeROAatv9PG5++p0GAX1N0/KE5x/Hw2kAKMFHovMYDVC/n9TLO7iD
         fAeh/6HCflyrU/P2fI0yMUMAmYt2QesHbift0r20J5BqreYKJVSbBf0dr4pc7UVAXyZn
         FiPBDKkxKRP+mlHK4dxmdvxzcOwTqjsf+nGe/lCFQ/7Ld8NVFGn5fGQ+uhzctsqDvGuD
         H8pAR5GBOsWdzCkGsqhq7SVtpJwjF3DM1idS74to6UtPHUqEOBzBCCnfP3CqO558sann
         3dFxHsxgJk0z27RHbk5kNbW3uWV5T4EQDIS6mpUleMq1oVsrH969A8iRgOd2A0exPtV+
         R5uA==
X-Gm-Message-State: AFqh2kqKQrzbCthoPrH03ukqz15Fq/Arbdw8m5/LpPfBz39yoVWf+zrw
	GZBOkZiwE62xtlWot+3Qd5WS34pibMmXM+GK2BxSVT7nGE0=
X-Google-Smtp-Source: AMrXdXtuVMdzhY5RTVr7lMsWyjHJZqX9ohVi8XWEcdjSo3vei2PzSFZJWx6MnxCV433lRZ8AFjzDASnuFhOOyLoNCi4=
X-Received: by 2002:a63:1c4a:0:b0:478:46b4:4f91 with SMTP id
 c10-20020a631c4a000000b0047846b44f91mr3215985pgm.211.1673287959562; Mon, 09
 Jan 2023 10:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
 <20230102084635.74a7xgmwmvbxiodn@beryllium.lan> <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
 <CAG17S_O_cy2gCgsdSLqpy6c5JXVg=LeGS9pxE-3SzHsHYs1YzQ@mail.gmail.com> <CAFA9we8eF3Uof5vTVZPNHcTxfwK5JUXVgV_n8TZVpi+zEYcD0w@mail.gmail.com>
In-Reply-To: <CAFA9we8eF3Uof5vTVZPNHcTxfwK5JUXVgV_n8TZVpi+zEYcD0w@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 9 Jan 2023 12:12:28 -0600
Message-ID: <CAG17S_MWsA98=doWTPMkGJMK0G_wfwrNaASjDz6nTWO+dd_Znw@mail.gmail.com>
Subject: Re: Connman Request for feature
To: Jade Lovelace <jade@jade.fyi>
Cc: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 9, 2023 at 11:12 AM Jade Lovelace <jade@jade.fyi> wrote:
>
> Hi!
>
> That patch would not work. There are a couple of reasons:
>
> The code in question is:
>     if (strcmp(iwdd->mode, "station"))
>         return -EINVAL;
> which will return nonzero if iwdd->mode is *not* "station". That is to
> say, if the mode is not station mode, scan attempts will be blocked.
> Also, the use of `||` there is operating on the string pointers rather
> than the results of the comparison, to unexpected effect.
>
> The patch you need is to delete that check entirely, but in my testing
> with the check removed, there is still some other issue there where
> somewhere along the line there is an ENOTSUPP returned, which I cannot
> debug with rr due to some unsupported ioctl on the rr side. Also, I
> got iwd stuck in a weird state where my interface is in AP mode
> according to `device list` but `ap wlan0 stop` says it is not in AP
> mode.
>
> So you may have more exciting hacking ahead of you. Godspeed.
>
> Jade
>
> On Thu, Jan 5, 2023 at 7:29 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > Ok, I found it. It is plugins/iwd.c
> >
> > Would a patch that changes:
> >         if (strcmp(iwdd->mode, "station"))
> > to
> >         if (strcmp(iwdd->mode, "station" || "ap"))
> >
> > be 'correct'?
> >
> > On Thu, Jan 5, 2023 at 6:10 PM KeithG <ys3al35l@gmail.com> wrote:
> > >
> > > Daniel,
> > >
> > > Which file is this so I can make a patch and try it out.
> > >
> > > Keith
> > >
> > > On Mon, Jan 2, 2023 at 2:46 AM Daniel Wagner <wagi@monom.org> wrote:
> > > >
> > > > On Wed, Dec 28, 2022 at 07:52:06AM -0600, KeithG wrote:
> > > > > Would it be possible to allow connman to scan for wifi networks when
> > > > > iwd has been put in ap mode?
> > > >
> > > > As far I can tell, the only thing which prevents the call to iwd to do a scan
> > > > is:
> > > >
> > > > static int cm_device_scan(struct connman_device *device,
> > > >                                 struct connman_device_scan_params *params)
> > > > {
> > > >         struct iwd_device *iwdd = connman_device_get_data(device);
> > > >         struct iwd_station *iwds;
> > > >
> > > >         if (strcmp(iwdd->mode, "station"))
> > > >                 return -EINVAL;
> > > >
> > > > You could drop the test in which mode the device is in and ConnMan
> > > > should forward the scan request.
> >
Jade,

Thanks for the hints. I'll have to see if I can make heads and or
tails of this. As you can tell from my first attempt, I am not well
versed in this. I'll see if I can get some help and make a patch. As
it was, I locked up the machine and it wouldn't even connect via
ethernet.

Keith

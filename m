Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CB3C0B
	for <connman@lists.linux.dev>; Mon,  9 Jan 2023 17:12:01 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1442977d77dso9312895fac.6
        for <connman@lists.linux.dev>; Mon, 09 Jan 2023 09:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMnLPA6KHxKqbOBXUq6urzi1WLcYR+eaiSFazx9O204=;
        b=qdHZ0tVAZNFSRB7x5YcDJrUY74AJcYy/hkktf4FpJsKzCVGOkRcjAGbjUmmaq7YNe9
         rVz8sfSB1tU6UAD3McUJ6AC9t3ihGp/TEJDBfKUqp7nja5CKtUDDTJ6w3nSnzvNaMyTO
         N+0D46TyVUvXOauTIm4gVX01yIzXgCA+SMEEHQ0ichsMeyu964JGpAdJei+IyypI8DTO
         BVrIVco4Bz2X90trlW8nmXFNNFenAuX3eMhCun4ulVMddYe/qoxky/KVflYSFwi6pEmM
         P/sCzl/X6i5/ggum+AT1/dc/QIXEtS/VuP7CE8ockTx6Cqm610KMgkNe7uam3l5Wikoo
         M+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMnLPA6KHxKqbOBXUq6urzi1WLcYR+eaiSFazx9O204=;
        b=AhR9d3XRCVVdRwDvHnjOLkqZMII8iB1EOvkok8ButRBMkHfVyw0lfDbK79AjO/18NS
         /l7WipQVEMSnBrxZJsw5u44iVy9pRBn6c5ldnqRzIsXNH5fKz/dWolk/3Je82Yg/xjfV
         NTX5OioYgkb0TKs7fzMk/xRPtj2tQWRiY74NsoyXDT6FOASvPpLMBTnOl8NcGuVlN4q0
         13RW4U0aZp0bZuLUCwTMJ/rYQqobFE/48wbrmbMocguwHq+GdmWtK2veYhYl7FkHzvlT
         nNk3/9XQPKMEPbqkfGCZDmjwI4E/2uLa5qYoXdUStpsK1+TkBRR5Dn/lq84hLFc0Y8I0
         tBVw==
X-Gm-Message-State: AFqh2kqamJobxmymGmFeXCDJ4xyJ5pvKbGx6KPEIRqyQhdwpa3uE+Nu7
	TFA96dJjQTO6xV/c+fLSUxnaAwC7kVoIn1BVj65qQe4c7HST1iwlq1p899W3
X-Google-Smtp-Source: AMrXdXvVzD42qijmE1f33KgFgnG48oX6m6I65w3bYrBUvMFa48gce4dSraPqXIAYUYhr9S6wr/NvKL1xfn0DbDuMStk=
X-Received: by 2002:a05:6870:cb90:b0:150:ef5e:3dc8 with SMTP id
 ov16-20020a056870cb9000b00150ef5e3dc8mr1723299oab.235.1673284320065; Mon, 09
 Jan 2023 09:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
 <20230102084635.74a7xgmwmvbxiodn@beryllium.lan> <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
 <CAG17S_O_cy2gCgsdSLqpy6c5JXVg=LeGS9pxE-3SzHsHYs1YzQ@mail.gmail.com>
In-Reply-To: <CAG17S_O_cy2gCgsdSLqpy6c5JXVg=LeGS9pxE-3SzHsHYs1YzQ@mail.gmail.com>
From: Jade Lovelace <jade@jade.fyi>
Date: Mon, 9 Jan 2023 12:11:49 -0500
Message-ID: <CAFA9we8eF3Uof5vTVZPNHcTxfwK5JUXVgV_n8TZVpi+zEYcD0w@mail.gmail.com>
Subject: Re: Connman Request for feature
To: KeithG <ys3al35l@gmail.com>
Cc: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi!

That patch would not work. There are a couple of reasons:

The code in question is:
    if (strcmp(iwdd->mode, "station"))
        return -EINVAL;
which will return nonzero if iwdd->mode is *not* "station". That is to
say, if the mode is not station mode, scan attempts will be blocked.
Also, the use of `||` there is operating on the string pointers rather
than the results of the comparison, to unexpected effect.

The patch you need is to delete that check entirely, but in my testing
with the check removed, there is still some other issue there where
somewhere along the line there is an ENOTSUPP returned, which I cannot
debug with rr due to some unsupported ioctl on the rr side. Also, I
got iwd stuck in a weird state where my interface is in AP mode
according to `device list` but `ap wlan0 stop` says it is not in AP
mode.

So you may have more exciting hacking ahead of you. Godspeed.

Jade

On Thu, Jan 5, 2023 at 7:29 PM KeithG <ys3al35l@gmail.com> wrote:
>
> Ok, I found it. It is plugins/iwd.c
>
> Would a patch that changes:
>         if (strcmp(iwdd->mode, "station"))
> to
>         if (strcmp(iwdd->mode, "station" || "ap"))
>
> be 'correct'?
>
> On Thu, Jan 5, 2023 at 6:10 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > Daniel,
> >
> > Which file is this so I can make a patch and try it out.
> >
> > Keith
> >
> > On Mon, Jan 2, 2023 at 2:46 AM Daniel Wagner <wagi@monom.org> wrote:
> > >
> > > On Wed, Dec 28, 2022 at 07:52:06AM -0600, KeithG wrote:
> > > > Would it be possible to allow connman to scan for wifi networks when
> > > > iwd has been put in ap mode?
> > >
> > > As far I can tell, the only thing which prevents the call to iwd to do a scan
> > > is:
> > >
> > > static int cm_device_scan(struct connman_device *device,
> > >                                 struct connman_device_scan_params *params)
> > > {
> > >         struct iwd_device *iwdd = connman_device_get_data(device);
> > >         struct iwd_station *iwds;
> > >
> > >         if (strcmp(iwdd->mode, "station"))
> > >                 return -EINVAL;
> > >
> > > You could drop the test in which mode the device is in and ConnMan
> > > should forward the scan request.
>

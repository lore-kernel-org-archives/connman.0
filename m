Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF47E3
	for <connman@lists.linux.dev>; Fri,  6 Jan 2023 00:29:04 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id 18so783pfx.7
        for <connman@lists.linux.dev>; Thu, 05 Jan 2023 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEH3MX2SMucDwMB+C26NvaBMv4fOX3XJSnJ8YvQLk5M=;
        b=ePGihDwpP/sIgo3+0NuOHOCWyfp9bFt7l/Ax/yO9iQduNzsx5IvuPN3XQYXaGLDXeN
         +a4dzJXleUnf19AOTMOnTw1G6XR52P6i7pou75lJPvdY/g25eAtZ6L1tr6q+hDrdCVPW
         9VESqW7UeuhnV5P2m82QwF3liDdrzF5mmer2Y22V348U5itoToOUtty6DVTAVhph05Ur
         1xberae13lLz7eKOI2CoB2BqEK4jshL7YVR4BLKkWFG6enjIo9ufa0+NMHuR52x4GSh6
         lmhr99yJejz/f9FdPs5QZe0zxS/Y7bVh+G+heUTRCneBhxE2TShwHnqbXxwroPhY5A95
         E2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEH3MX2SMucDwMB+C26NvaBMv4fOX3XJSnJ8YvQLk5M=;
        b=6gCv0iNPvfcVhR7dbujrk4mTcJxeqlPlIA4IEGGE7atkWWRw38dpCnXL/KJLkVP4iw
         Bi5OcqJkFHWRI1HO2TqfVPAw1p/z3dYJSQytGfRY7T3JqyM8TmvgQcgiSIM0DNs3eA1d
         +cVOPQA0D3D/eMiBQ/LN11CR6ddLb9fx8Z+wv1+6L5HQ4r55buyovalYF14Eo8RCdRO6
         e4+dgKwyW09AAFxzumcZiRPC8fazle02g4bWJh8qTgDoQSN2oZFzKu5EE1ezb/NYjcP5
         RL5jPBb9hrBva3x5fsBfpXoVEyF0iY3quD2pCqll/XImV7ZDX1CdGd+S5deNDqSSTyvg
         tbLw==
X-Gm-Message-State: AFqh2kqsw5Q97AYFYznFaSVvblAHNg0bLORpTnMBtElu6meqJgJgPdg5
	HygxCqOFcTiFga3M8pX+BNEvMtslr+ZhulzNXVKmr6KTPp0=
X-Google-Smtp-Source: AMrXdXuqBnsZ7OUS0vpVRXGi+0etqpMFhgRJbECxXVMdUiJBz+M3aBTWH0V1ztJNEVflujn236oT74iPHsfbvVFDxiQ=
X-Received: by 2002:a63:f844:0:b0:478:1020:b1e6 with SMTP id
 v4-20020a63f844000000b004781020b1e6mr3887678pgj.561.1672964943703; Thu, 05
 Jan 2023 16:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
 <20230102084635.74a7xgmwmvbxiodn@beryllium.lan> <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
In-Reply-To: <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 5 Jan 2023 18:28:52 -0600
Message-ID: <CAG17S_O_cy2gCgsdSLqpy6c5JXVg=LeGS9pxE-3SzHsHYs1YzQ@mail.gmail.com>
Subject: Re: Connman Request for feature
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ok, I found it. It is plugins/iwd.c

Would a patch that changes:
        if (strcmp(iwdd->mode, "station"))
to
        if (strcmp(iwdd->mode, "station" || "ap"))

be 'correct'?

On Thu, Jan 5, 2023 at 6:10 PM KeithG <ys3al35l@gmail.com> wrote:
>
> Daniel,
>
> Which file is this so I can make a patch and try it out.
>
> Keith
>
> On Mon, Jan 2, 2023 at 2:46 AM Daniel Wagner <wagi@monom.org> wrote:
> >
> > On Wed, Dec 28, 2022 at 07:52:06AM -0600, KeithG wrote:
> > > Would it be possible to allow connman to scan for wifi networks when
> > > iwd has been put in ap mode?
> >
> > As far I can tell, the only thing which prevents the call to iwd to do a scan
> > is:
> >
> > static int cm_device_scan(struct connman_device *device,
> >                                 struct connman_device_scan_params *params)
> > {
> >         struct iwd_device *iwdd = connman_device_get_data(device);
> >         struct iwd_station *iwds;
> >
> >         if (strcmp(iwdd->mode, "station"))
> >                 return -EINVAL;
> >
> > You could drop the test in which mode the device is in and ConnMan
> > should forward the scan request.

Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8F7E0
	for <connman@lists.linux.dev>; Fri,  6 Jan 2023 00:11:05 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id k137so21765757pfd.8
        for <connman@lists.linux.dev>; Thu, 05 Jan 2023 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sDS4NeTpf9XNJIc1PsXXlfqngj9oqr4ezksQO3sdjsY=;
        b=eyC0xpcUzVI94FuJbQt3NyWdoLi8SiY4SJJC99pqN7k9XEXw+I9FeT9FfQ/p3qewz7
         GwuIKKWxyyAuylmCyNOFsyVFhmcPfSmv1we527bMpO100quT50dAexHjtJVwgGsb+0Wj
         DmwzIEoTSRAMnXBHWvIHyNULW+xBkgADhxoz30FwXpb3bTLbZwjrDwk7WDohE540466j
         qLBUrNSKVa8fFBTwfEvBeGLCbErXrY33WVS9Ye7o/GTegautGRyLIQJSEWrBzWkXutX4
         PDysPcQPeySo/2Ow8CuQuVW4otO0rrrLFFD1trlMQUjowAZIbPLTRQib7cVCvjDVH8ou
         9Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDS4NeTpf9XNJIc1PsXXlfqngj9oqr4ezksQO3sdjsY=;
        b=iAC4KBQixIe02KUdWTZWa9lU8AnWlcQZq0dzZ1zja1J7lxDkh353lYZDRXT17D+28O
         mqcRP2WFFvSCzvemgZkreyoioMYvvYKppJC7pdOJhihWj10Rsj34fmwXw6z1HiKvDcOb
         H7SAIhT2rqF/hpv/KHS1AnCBpqMYHMb8tumM4pC1nWE0rDg/Yqk3eWIyuHwPNNRSE5kr
         qrjouHv2eqc2bq0uU2voLPBRzHSwBSfSd74CahM1v40PZrvkXruJXFnarUkKAWDF1Vjd
         TRHUZY9ojGc8ZFaen9EApSxogxXJwIRFbYkigg0UWLkct/+xLm1SI6/hX5AJrKTzzYW3
         EGHw==
X-Gm-Message-State: AFqh2kov5vOb19pUlDXgyG9KpF5qpaC7gXBFTsOuG+IxGLoYX2QIddDk
	vH5N7mU1eWZ+HS/SLePFOtdTC+u7UEH0qbUMqW/k8RaQ
X-Google-Smtp-Source: AMrXdXvangyF0KuxofAaFxBSwUgGY1W7/+7mdERuSFZd2hvQMMuHGhpGyKWwI0ZzisqDsVQqMNFp3ItgglCs7zHBv4k=
X-Received: by 2002:a63:1c4a:0:b0:478:46b4:4f91 with SMTP id
 c10-20020a631c4a000000b0047846b44f91mr2519273pgm.211.1672963864609; Thu, 05
 Jan 2023 16:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
 <20230102084635.74a7xgmwmvbxiodn@beryllium.lan>
In-Reply-To: <20230102084635.74a7xgmwmvbxiodn@beryllium.lan>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 5 Jan 2023 18:10:53 -0600
Message-ID: <CAG17S_MbDM+-Jv4AvyeLU3_P-TYoLXaN+Ym-38UbqkCpDTnuOQ@mail.gmail.com>
Subject: Re: Connman Request for feature
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Daniel,

Which file is this so I can make a patch and try it out.

Keith

On Mon, Jan 2, 2023 at 2:46 AM Daniel Wagner <wagi@monom.org> wrote:
>
> On Wed, Dec 28, 2022 at 07:52:06AM -0600, KeithG wrote:
> > Would it be possible to allow connman to scan for wifi networks when
> > iwd has been put in ap mode?
>
> As far I can tell, the only thing which prevents the call to iwd to do a scan
> is:
>
> static int cm_device_scan(struct connman_device *device,
>                                 struct connman_device_scan_params *params)
> {
>         struct iwd_device *iwdd = connman_device_get_data(device);
>         struct iwd_station *iwds;
>
>         if (strcmp(iwdd->mode, "station"))
>                 return -EINVAL;
>
> You could drop the test in which mode the device is in and ConnMan
> should forward the scan request.

Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF427A
	for <connman@lists.linux.dev>; Fri, 25 Feb 2022 08:33:35 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id n10so1184902vkm.10
        for <connman@lists.linux.dev>; Fri, 25 Feb 2022 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Enc0TIVS47xHnklAlgEVyfD3/TJ8Rppb06q4u8X2vEk=;
        b=hFXEpxo9BH1LDa/y/iolo4IKv0rJ6SU5yQJCB4zgrCIGmvKDJg0ayCVmXPqbPxm4ZC
         wmDPzxkjeiYH3vNNuQUgzoLy/N2nn8eSmRGLI26z9pYISy4Dc+2LkRPDLqFepByXARkP
         LPdEGKDcaoyKF+WrCsW2p/Mgw0jyzMz/jOZCGbXuSEguCI9AJ+GoHSH0/UzqCalDDz29
         oj5YuYxYdueLDEcOuq6q8GfyuPO2bqqzno6lULAIpfAkW5t7XiwHIk1wEM3sGwY9CwsP
         +dmn2CwtD8BJ5ss3mww0xo2o4LT0REV7qhS+AekMMXMI83cMM5vj+78ynXO+7dNkpSO2
         Vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Enc0TIVS47xHnklAlgEVyfD3/TJ8Rppb06q4u8X2vEk=;
        b=fV2IKhw8QIHesEc8NCt6qyldsTu3fmQEKO1P2P1Yx3My5MVdQXCjEd1oZzmRFmzH8X
         2RVIJ597WkG/0JLsBD2K+amC/GQgztQq4KjtEeyaeV8zLK6rDZrJm/Csk4GnllOK6Oyp
         jkWlko7hKSrifcDbqUp2MD5SblFou+VDEzdcd2lzgQWT1C0G5igzzVsfm4/EZF/yBcj0
         9EHvYcb5rfCakJMzujEk75ZPo58EBiH5tvtSuSumqRR90m0ba1xVE3+UEJ8SRStKAaCr
         st66HDVLhAOyLWDSV0fCeiBRll2DtNhIghrh3zLBdv8jPEoqL3K8ndMQb67zflefEpSK
         UX0w==
X-Gm-Message-State: AOAM531Mh7eLPXfFLPFLBv905hhdXvdwFsP6fETdAXuaG5nupPEPnrZS
	pxWvVsxVjn94xMtriGYox3wEyDEi5sab6/OdeiaMYfLm2mE=
X-Google-Smtp-Source: ABdhPJytk/sGDcfsjc3LM2uCNyDANtF8+2YezSqhiXhezNl+UZzA8X6KuNy5fj9jITyzBRDTMfE4oRSKoz49nFYENtE=
X-Received: by 2002:a05:6122:a29:b0:321:dd99:acd8 with SMTP id
 41-20020a0561220a2900b00321dd99acd8mr2984866vkn.3.1645778013877; Fri, 25 Feb
 2022 00:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220215102638.599189-1-net147@gmail.com> <CANwerB0jFWpnTkpF1qispnAw5K1X__OQjMP=xEEGe9UHLDMd1g@mail.gmail.com>
 <20220221083259.yj2gjrqbeplny645@beryllium.lan>
In-Reply-To: <20220221083259.yj2gjrqbeplny645@beryllium.lan>
From: Jonathan Liu <net147@gmail.com>
Date: Fri, 25 Feb 2022 19:33:22 +1100
Message-ID: <CANwerB1ETxcgeGhaCg3zRmjCZ-uAUaeDY0mePe9Mg1z2xCh9wQ@mail.gmail.com>
Subject: Re: [WIP PATCH v2] iwd: Fix disabling tethering not working for brcmfmac
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Mon, 21 Feb 2022 at 19:33, Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Jonathan,
>
> On Tue, Feb 15, 2022 at 09:36:49PM +1100, Jonathan Liu wrote:
> > Hi,
> >
> > On Tue, 15 Feb 2022 at 21:27, Jonathan Liu <net147@gmail.com> wrote:
> > >
> > > For Broadcom BCM4356 chipset with brcmfmac driver, changing from AP mode
> > > to station mode returns -EBUSY if the wireless interface is a member of
> > > a bridge.
> > >
> > > To resolve the issue, the wireless interface is removed from the tether
> > > bridge before changing the mode rather than after.
> > >
> > > Fixes: 648ed549f0ac ("iwd: Add support for tethering")
> > > ---
> > >  plugins/iwd.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > This is a work in progress patch. I needed to make these changes
> > otherwise disabling tethering would not work for my brcmfmac wireless.
> > This patch seems to result in a "no ap object found" debug message
> > when disabling tethering. It seems by the time it tries to lookup the
> > ap object in the access_points hash table in
> > tech_disable_tethering_cb() function, it has already been removed.
> > The connman_technology_tethering_notify(cbd->tech, false) line had to
> > be moved up before the ap object lookup as otherwise the lookup
> > failing would cause the tethering property to not be updated from true
> > to false when disabling tethering.
> >
> > I guess that means Stop is not called on the iwd ap object as it was
> > already removed.
> >
> > Any suggestions on how to improve this?
>
> I think your approach is correct. The order of cleanup should be in the
> in reverse to the setup steps. We add the interface to the bridge when
> we get the Started signal. If I am not completely mistaken we should
> first undo this operation and then call Stop.
>
> The only thing I need to double check if we do not leak any resources
> due to the -EIO I saw there when I quickly looked at.

Would you be willing to have an attempt at this as you are more
familiar with connman+iwd?
brcmfmac is quite common - it is used for Raspberry Pi for example.

Thanks.

Regards,
Jonathan

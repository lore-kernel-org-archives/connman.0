Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA846129
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:33:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7619A5D345;
	Mon, 21 Feb 2022 09:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645432380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rya4xbLZLv92KRFCJRur/bvG9ayeF10aafRO8AQ1BVk=;
	b=Mp4bGrxmyNs5EFOse0G28aLgwzb59wwpbtD8XJWEiJJWHU4gMBqqdUq+g/ewoUgkOCpiR9
	s7uxmNJrtUm0+2GW5o9OeAFr7HxAWPHJBDbtKlxZcPEZ7vZU+u1fhYVs1/9QZw3QQ9fHIR
	qhDHPH5KnN9elo8E44fNvkmaCqAP6LE2M6fLA5xSASZ7x+osoli7FR4V4xfptVpThUCnah
	IJ2cHtWVuujovWFvwz2XawT3U7bB16hivoT+cBHDG04UkiwHV1r0yqYPf+2d0/IiFBCDkb
	w9On4J7KsP89XqTlRy2jd8ATUIqScoDyAeYHDxiHsshleZv6nVmkTYQ+Y1Y4Cw==
Date: Mon, 21 Feb 2022 09:32:59 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [WIP PATCH v2] iwd: Fix disabling tethering not working for
 brcmfmac
Message-ID: <20220221083259.yj2gjrqbeplny645@beryllium.lan>
References: <20220215102638.599189-1-net147@gmail.com>
 <CANwerB0jFWpnTkpF1qispnAw5K1X__OQjMP=xEEGe9UHLDMd1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwerB0jFWpnTkpF1qispnAw5K1X__OQjMP=xEEGe9UHLDMd1g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On Tue, Feb 15, 2022 at 09:36:49PM +1100, Jonathan Liu wrote:
> Hi,
> 
> On Tue, 15 Feb 2022 at 21:27, Jonathan Liu <net147@gmail.com> wrote:
> >
> > For Broadcom BCM4356 chipset with brcmfmac driver, changing from AP mode
> > to station mode returns -EBUSY if the wireless interface is a member of
> > a bridge.
> >
> > To resolve the issue, the wireless interface is removed from the tether
> > bridge before changing the mode rather than after.
> >
> > Fixes: 648ed549f0ac ("iwd: Add support for tethering")
> > ---
> >  plugins/iwd.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> This is a work in progress patch. I needed to make these changes
> otherwise disabling tethering would not work for my brcmfmac wireless.
> This patch seems to result in a "no ap object found" debug message
> when disabling tethering. It seems by the time it tries to lookup the
> ap object in the access_points hash table in
> tech_disable_tethering_cb() function, it has already been removed.
> The connman_technology_tethering_notify(cbd->tech, false) line had to
> be moved up before the ap object lookup as otherwise the lookup
> failing would cause the tethering property to not be updated from true
> to false when disabling tethering.
> 
> I guess that means Stop is not called on the iwd ap object as it was
> already removed.
> 
> Any suggestions on how to improve this?

I think your approach is correct. The order of cleanup should be in the
in reverse to the setup steps. We add the interface to the bridge when
we get the Started signal. If I am not completely mistaken we should
first undo this operation and then call Stop.

The only thing I need to double check if we do not leak any resources
due to the -EIO I saw there when I quickly looked at.

Thanks,
Daniel

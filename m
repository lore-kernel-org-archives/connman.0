Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319267EF
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 07:43:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C05D3DAD11;
	Mon, 27 Feb 2023 08:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1677483795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iks1fzGAWG7DDcp1kR8z5MgxXoiydro95DgCStzyCNA=;
	b=sbJh0BaSSNr381GXEwNVZz9utegdwl65G86wsPRtuZUhrv2xuct90HnLAx42xct2a/Dv4R
	3z60deGbWk9agosPvqwDtkNHWAqBCWl7joggyw/7xDdM5XCO26KJAg8dghOHc2RYwpvyZq
	1PSvIcvaTJxtrEPjowK7/vFzUaFzyVP+E/6AQy3j/stGi7BhrnVDDgw3FKsHg97CYDKWky
	AbVd1owsZgkklH7Uz4H5eRPg00oE7JbNWa06WCYc0OF6V3ljMM+BYfRTrb4yN1Z+R0a2mw
	WzhgJekdYojHYQo9W5idINw546Jed191JmcCD9PT2+/lPUkpxRHjkVaSSqnl+g==
Date: Mon, 27 Feb 2023 08:43:14 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Add support to Scan in AP mode
Message-ID: <20230227074314.pys65eppvaus2wbs@carbon.lan>
References: <20230116081624.12618-1-wagi@monom.org>
 <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
 <CAG17S_NzXYUOPkF1h0e056=jCBQaP3nUh2t0y0n9R5nzhe9yYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_NzXYUOPkF1h0e056=jCBQaP3nUh2t0y0n9R5nzhe9yYA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi KeithG

On Tue, Feb 14, 2023 at 12:55:37PM -0600, KeithG wrote:
 > ~# iwctl device list
> >                                     Devices
> > --------------------------------------------------------------------------------
> >   Name                  Address               Powered     Adapter     Mode
> > --------------------------------------------------------------------------------
> >   wlan0                 b8:27:eb:a4:6e:0f     on          phy0        ap
> >
> > ~# iwctl ap wlan0 scan
> > ~# iwctl ap wlan0 get-networks
> >                                     Networks
> > --------------------------------------------------------------------------------
> >             Property              Value
> > --------------------------------------------------------------------------------
> >             Name                  spg4
> >             SignalStrength        -4400
> >             Type                  psk
> >
> >             Name                  ATTcVY9ZWa
> >             SignalStrength        -5100
> >             Type                  psk
> >
> >             Name                  ATT3zFM5gH
> >             SignalStrength        -5900
> >             Type                  psk
> >
> >             Name                  2WIRE811
> >             SignalStrength        -6900
> >             Type                  psk
> >
> >             Name                  ATTU8Z3d7i
> >             SignalStrength        -8400
> >             Type                  psk
> >
> > So I am in AP mode and I am connected via WiFi to it.
> >
> > In connman, though, I do not get any wifi SSIDS:
> >
> > ~# connmanctl services
> > *AO Wired                ethernet_b827ebf13b5a_cable
> > ~# connmanctl enable wifi
> > wifi is already enabled
> > ~# connmanctl scan wifi
> > Error /net/connman/technology/wifi: Did not receive a reply. Possible
> > causes include: the remote application did not send a reply, the
> > message bus security policy blocked the reply, the reply timeout
> > expired, or the network connection was broken.

This means the connmanctl tool didnt' receive any response. Do you have the logs
from the iwd plugins by any chance (connmand -d plugins/iwd.c).

> > Is this how it might work? This is how we do it when we use hostapd to
> > connect instead of iwd.

It looks like the plugin is still using the wrong API and either iwd doesn't
respond or the iwd plugin doesn't handle the error case correctly.

> Is this still something that could be done? I can build and test any
> patches pretty quickly (except for next week).

I am not that fast sorry :)

Thanks,
Daniel

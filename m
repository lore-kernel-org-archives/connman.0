Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B98471
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 20:29:40 +0000 (UTC)
Date: Mon, 27 Feb 2023 20:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1677529772; x=1677788972;
	bh=DqYX2S7ZdeTFOdM8xV68N8wdV3FbST+7jDSu38+mDUg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Cs7BVQ89HPiPieaz5DT6uI4rn23TL76p3gcxp3ugqKjjhPvy9kMrmCn1CD+TO4Li0
	 RBz787RF9q37ZdusJm4iR8Lh8ccR6Np6uL2zAFY1dpRnsE6emaVS2uo+89Rsz2HY3q
	 F/j0Oau5L7QfxSZmpaINCgAfdu/BpgRcHVRr9m9fI+/A7JtPrOosW/88cEPLHfD7N9
	 kTccipSbPuRw7o4RzMUil8wcZbfJ+xbQFjFYR/DQCu/HwJN+48oyP59z6s2EIotH0u
	 J/BBp5GMYXfhd/64S5i2nztLv6ruc4ZfV7nsULCAxlAoW9BHqtsAqLDaDHC9BljkWT
	 +WL+MR3PkVI+Q==
To: Daniel Wagner <wagi@monom.org>
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: No 6GHz networks found if connman does the scan, but connman see them if 'iw DEV scan' used instead.
Message-ID: <1a20dca6-8431-1d24-1ad9-7ae6b386c29d@protonmail.ch>
In-Reply-To: <20230227080130.gtmid6ojmjmn6h4q@carbon.lan>
References: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch> <91794321-2d0b-0c40-3d02-9880c20c7cab@protonmail.ch> <20230227080130.gtmid6ojmjmn6h4q@carbon.lan>
Feedback-ID: 7579861:user:proton
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/02/2023 09.01, Daniel Wagner wrote:
> I suppose the best strategy is getting iwd to work in standalone first. C=
onnMan
> is a user of iwd, so it doesn't really do anything 'special' in the iwd p=
lugin.
> The wpa_supplicant plugin on the other hand has a lot of wireless logic i=
n there
> and it is likely there are some limitiations.

That make sense.

I sent some time and concluded that my issue is in fact firmware of
Intel ax210 card. By default it has firmware-choosen country code 00
that blocks of entire 6 GHz frequencies, only after some, unknown, time
it stays online, based on nearby access points that sends out the
Country Code (not all of them does) it decides the country code PL is
the right one and from that moment onward I have working 6 GHz, This is
clearly visible in 'iw phy phy0 reg get'.

However the moment I disconnect from network, ax210 goes back on phy#0
to country 00 and blocks me from reconnecting because all the bands
above 5835 MHz are disabled (iw list shows them as supported and disabled).

This makes the entire 6 GHz APs absolute useless with Intel WIFI 6e
cards as you cannot reliably connect there because of the awful way how
Intel decided to fulfill radio frequency regulations and prevent user
from setting country code by themselves.

Case closed.

-- Piotr.


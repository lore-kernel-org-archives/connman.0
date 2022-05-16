Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50607A
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:31:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 505D45D51C;
	Mon, 16 May 2022 08:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652682710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BnyNm7RIvxueTo1nLzl0qsWXc6opSi181vBcwpMOExs=;
	b=rndmHn28WvtOY56sL+BC0GSFC4UaFvYo/RbI8ZMIYtR1OlPbKv3YwnCIeyats6NU0JKxmA
	l3P5OJa2EUDJYSwEszsCKsRrpPtbNrJeoaTrm9s2pU/3pDY8us0g258o3U6Q0bKk727CxO
	gAYkV0eY0/GaTpskud6YIKGGaVPYsOTgknqlJHGRL6Mc8JEqkbx3iZjsKcTjdR3SAX3v2L
	uGy5fJbNoCAq72EOzFOGiHrXatXbOjcnpz+A1ZryBvLrYq86+k9WZFR7wTOtSflRVOOveF
	jQiahJNg5+uKTogKgGYvP9NE3aVbHCVme23PejP3Z4mTxtfRi4J2u3RY4IB7bw==
Date: Mon, 16 May 2022 08:31:48 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Message-ID: <20220516063148.7paefesgwu3toa2v@beryllium.lan>
References: <AM5PR0901MB1633AB6BB661EEADB165A51DF2E99@AM5PR0901MB1633.eurprd09.prod.outlook.com>
 <20220414184519.7frygekryu5caiuc@beryllium.lan>
 <AM5PR0901MB163329B615A92BFEED7F60A7F2F29@AM5PR0901MB1633.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0901MB163329B615A92BFEED7F60A7F2F29@AM5PR0901MB1633.eurprd09.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On Tue, Apr 19, 2022 at 09:56:48AM +0000, Thomas Bartosik wrote:
> Hi Daniel, thanks for answer!
> tl;dr: Skip down to below the syslog output/snip, I found the error!

Nice!

> I'd like to prefer wired over wifi and only have one technology
> connected and still be able to open a VPN. Is this possible? I'll
> stick with "PreferredTechnologies=ethernet,wifi" for the time being
> and see whether the problems come back.

I can't remember all the details of the connection algorithm anymore,
but the SingleConnectedTechnology option is currently incompatible with
VPNs.

> If that's not possible then please add some info in the man page that
> using VPN with "SingleConnectedTechnology=true" is impossible.

I just send out a patch which updates the man page.

> I'd also vote for an error condition/log statement when a VPN connection
> is started and this option is true as this can by definition not work
> out, as every VPN needs two connections. Or don't count VPNs :-)

I agree it makes sense to filter out VPN when
SingleConnectedTechnology is used.

> I have a few other problems/questions as well:
> 
> - connmanctl operates on (internal?) service names, not the human
> readable ones. This pretty cumbersome/somewhat unexpected, and leads
> to error messages that don't really guide the user to the correct way
> of specifying a services. I guess the human readable IDs can be
> ambiguous, but maybe try them and only error out when they really are
> non-unique? The missing column titles in the "services" output also
> make it hard to know what exactly <service> in commands (like
> "connect" means). This is an example of an error message:
> 
> Error /net/connman/service/vpnname: Method "Connect" with signature "" on interface "net.connman.Service" doesn't exist

connmanctl is not really user friendly indeed and I fear the tool needs
a bit of a rewrite.

> - The VPN server I connect to does not route public traffic, so I need
>   my default route to stay as it is (in my LAN).
>
> After searching around a long time I managed to fix this by using
> connmanctl's move-before command for my local LAN (before the VPN).
>
> Is there any better way to achieve this? (Did I not RTFM enough? I
> know the manual states the order is important, that's why I tried it.)

The order of the services defines the routing table, hence the
move-before and move-after is the interface to change it.

> Specifying "Networks=<only VPN networks>" in
> /var/lib/connman-vpn/myvpnname.config did not change this. I would
> have expected this to do exactly what I mean.

Because there is no Networks entry defined for the config. I know that
ConnMan lacks good documentation but we have at least all the config
options listed in the man pages. So if it's not mentioned than it
doesn't exists.

> Connman is a great product as it's so lightweight. Configuration
> however sometimes trips me up ;-)

Thanks, unfortunately, there are only a few contributions and no one is
willing to spend time or money to move this project really forward
(fixing obvious bugs, fixing obvious shortcomings such as configuration,
...). This means not will change unless someone steps up.

Daniel

Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829872CAB
	for <connman@lists.linux.dev>; Sun, 18 Dec 2022 19:14:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6EDDDAD2C;
	Sun, 18 Dec 2022 20:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1671390589; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mdgb1XD6rLSzwWRCRIXJFzyGw1nai6ft+w6QaMLZtOU=;
	b=kBovaEyK34Onq+G/W0INjjlxziuu959JuBP1hcaJa0Pvu+0sTI9cuwvYBkRRhgrm4jwu5P
	vLSy1uHfoZ0Yfj8bjhlI7XNldlwryV4mZ/svyMDb1cDKA+gnOgIhwajjB+hXaK+c7502pY
	E/XkO8v/h3xGMrIFALZRmHBj6OvFl61RttOY49gQlwk5nuLfOqgyqycqtbNJt4r8TnayC6
	TluAK/pIFIoYlgboSqsiDTj77k6R4XMACOu9fEExRAjujyHYFVs0rauPWQoINN7OLBMk52
	fxBdvrdE+tH8xqOpLxdJRH5I3aHO264c54AUMIsrmvWddR9AUHzdzHtHzACECA==
Date: Sun, 18 Dec 2022 20:09:45 +0100
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev, Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: Re: connman HEAD regression
Message-ID: <20221218190945.w3ff5sed2n2s3wso@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <4ab804a6-883c-ba5d-f495-cc8be368cc1e@dark-templar-archives.net>
 <20220828180311.ccczbttfdmteeyhi@beryllium.lan>
 <3677d1bf-5dc7-e5b6-eefe-13cc62480465@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3677d1bf-5dc7-e5b6-eefe-13cc62480465@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 08:08:24PM +0200, i.Dark_Templar wrote:
> 28.08.2022 20:03, Daniel Wagner пишет:
> > On Sun, Aug 28, 2022 at 07:48:01PM +0200, i.Dark_Templar wrote:
> > > I don't do any manual configuration. Hamachi does it on it's own as far as
> > > I'm aware. I.e. it connects to network and assigns an address to network
> > > interface on it's own after that depending on network it connected to. I
> > > guess it might be similar to DHCP.
> > 
> > Right, so without an manual configuration (static IP) ConnMan starts the
> > DHCP client and if this fails it assigns the interface a link local
> > address. And we also try to set the GW for such an address. In my test
> > setup with OpenVPN I have fixed IPs assigned, hence I don't see this
> > problem. No idea how Hamachi is working but if it's assign the IP
> > address itself you might want to disable the auto configure method anyway.
> 
> It should be replicapable in OpenVPN with DHCP (i.e. non-static addresses).

Unfortunately, the fix I provided introduces a regression.

https://lore.kernel.org/connman/66993511-8b3c-bf48-beaf-9ff9e6ee446b@gmail.com/T/#u

After reviewing what we do in the OpenVPN plugin I am pretty sure, we
don't enable DHCP on those links. This plugin is using
connman_provider_set_ipaddress() to set the method to
CONNMAN_IPCONFIG_METHOD_FIXED. Thus we don't enable DHCP on those
network interfaces.

I am not familiar with Hamachi but from a quick glance at the REAMDE I'd
say the real fix to this problem is pretty simple. ConnMan should ignore
the Hamachi interface: 'connmand -I ham0 ...'. ConnMan is trying to take
control over these devices and hence it enables DHCP (with IPv4LL as
fallback).

With this in mind I am going to revert the cb05780d86c3 ("ipconfig:
Don't add invalid gateway routes") commit as suggest by Geoffrey.

Daniel

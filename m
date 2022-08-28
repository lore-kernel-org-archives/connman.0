Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C64699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:03:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 267705E062;
	Sun, 28 Aug 2022 20:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661709792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sOff0zcPafwT4m7prAo5Gq+Vz9MoxjkqrUgBbCRdyHg=;
	b=MSE/XXdrMGvIRnTAg87gt2TlSjNbJyVppoG4bxntirB3l1GA7tytS436eRKrpcd+mxMK0Y
	MUshXq6p7ir7kNg+fVF0p0w5ROPe8xKxmUkuCxmFtw0xces5uS7dIw1Lt+l5xROUkZEiIg
	hPojfZsOiwoE/obzln20E1gvYObzd3meLdWWywen7vYc/2hk47w9mZ2XFOADioDrFXte/L
	MripKanD57Reb9/y8XZwO+vEskYURrqbij2yfibD2p2ZK6EOEegeiUygSrAWmzGnF41QDm
	ZJBlGYF2bxRPLngWaFB0xJsplUycnHwh8yOzA2Uzh3F3xDiTqr0F8FvAKe7DjQ==
Date: Sun, 28 Aug 2022 20:03:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828180311.ccczbttfdmteeyhi@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <4ab804a6-883c-ba5d-f495-cc8be368cc1e@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab804a6-883c-ba5d-f495-cc8be368cc1e@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 07:48:01PM +0200, i.Dark_Templar wrote:
> I don't do any manual configuration. Hamachi does it on it's own as far as
> I'm aware. I.e. it connects to network and assigns an address to network
> interface on it's own after that depending on network it connected to. I
> guess it might be similar to DHCP.

Right, so without an manual configuration (static IP) ConnMan starts the
DHCP client and if this fails it assigns the interface a link local
address. And we also try to set the GW for such an address. In my test
setup with OpenVPN I have fixed IPs assigned, hence I don't see this
problem. No idea how Hamachi is working but if it's assign the IP
address itself you might want to disable the auto configure method anyway.

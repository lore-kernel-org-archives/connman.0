Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3F7A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 07:37:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC0355CFE8;
	Mon, 14 Feb 2022 08:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644823872; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=L+59yYmDaa6P7qFIl4OKr2XhWlENlnf4ZxA7XviSJ9Y=;
	b=p+wiRTRS7c7ZVjKt1oib0i7N4svQoq4BGuEvJrFAi9c9A2N6jEebZ1N0PxRydRsm697rty
	pOukRmaijUGrkHNmoHnl+JTqXCnZF/GyZ4eRuSRpi/b8N/M+qBIY8c0eolvnxS51Aqy6c9
	w2JYYTekCAGLGxuH6emRYsgAlZkLBdU8bTMlTbwOBXOoikVndg0xExDMARDdszHHGrSJm5
	MuMrjC8cCaR7qPXkH51/StH0B7XQFGPClzTBLY3k9sBU3CARRK5C5iVE1ojv3jy5OHksj3
	lACl3QwXffBTScL0tmiDfBtMRY8cgkGOecwvwKV3ixbxYxpbzjth2b0WUf4S1g==
Date: Mon, 14 Feb 2022 08:31:10 +0100
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: connman issues with enlightenment since last upgrade to version
 1.41
Message-ID: <20220214073110.wrne4navzuyocjka@carbon.lan>
References: <CA+iibzDhfvFgjaUdKvXw8_WKcYwkzr5n0n0NFqOeEpU8ujqYpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzDhfvFgjaUdKvXw8_WKcYwkzr5n0n0NFqOeEpU8ujqYpw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Dania,

On Tue, Feb 08, 2022 at 06:17:15PM +0100, daniel antoine wrote:
> Hi gentlemen
> 
> I use a systemd linux distribution with enlightenment, conman as
> communication manager and iwd as wifi controler. Since the last
> upgrade at 1.14 I have observed
> two things:
> 
> First, the connman icons (wifi or ethernet) are not blue anymore and
> remain grey. When I look at the parameters wifi or ethernet are READY
> and not ONLINE . I notice that in the journal records that there is no
> more unknown route 82.165.8.211 as described in the archlinux wiki
> (unknown route on connection).
> 
> The connection itself is still functional. I can access internet.

ConnMan has two 'online' states. READY and ONLINE. The READY state means
the interface has been successfully configured (e.g. DHCP was
successful). Then ConnMan tries to figure out if a remote IP is
reachable (so there is an uplink to the internet) the will go to the
ONLINE state.

There a bunch of knobs which control the ONLINE check.

We had some changes in the ordering and updating logic for the service
list. It's possible there is something wrong. Could you post a log
output from ConnMan? Maybe I can spot what's wrong.

> Second, My laptop is connected via a wifi connection and I use virtual
> machines (virt-manager). When I start one of the VM, on the host an
> ethernet connection is opened and connected despite there is no
> ethernet cable connected.

Does ConnMan assign a IPv4 link local address (169.254.0.0/16)?

> The side effect of this is that there is no
> dns resolution in the virtual machine until I disconnect the ethernet
> connection on the host with econnman. I suppose that It has something
> to do with the fact that the host connections are READY and not ONLINE

Not sure if this is related to the above ONLINE check.

Daniel

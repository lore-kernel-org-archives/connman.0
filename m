Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C972
	for <connman@lists.linux.dev>; Wed, 29 Sep 2021 09:21:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCC6E60D89;
	Wed, 29 Sep 2021 11:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1632907310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rW7ez6BIV13QpqX6viYG6ehDwWmBPlvdpBCeqli5GAY=;
	b=t6puDP0OpvPBEnLOlCOJQKMX4+9YwnC18fakyeBDQjvjF72oEaDzjHX7OJ/19xYkGgupGa
	PE/9nBAKJGqvEytjD5mvkMjaFZGoN6b5Fczuuxy2woAZtj/TEydfoegwTTokqZFtC8SJoC
	N0d3eZaVEbG0ZHnXJfCaAXX3MtyYP9gqkDXmBaCb/R+xkpp5zxJStpS479BM64szdAmLSr
	mfIJU43iol5K5Cju7M+5pXFGVI9hok11y2oftsMgF0k7KeCjDocxJmvU3XpHGvxmuMLNvP
	0LaRlEbC6svVN9wp0sMBJUBSrgpvhEYo07jFRcVi+GPg0gfE7NCR2HDdv987hQ==
Date: Wed, 29 Sep 2021 11:21:50 +0200
From: Daniel Wagner <wagi@monom.org>
To: Salvatore Mazzarino <apocalipse89@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: connman in dual stack breaks connectivity
Message-ID: <20210929092150.cf2y4qobus5n5y7v@carbon.lan>
References: <CAJU6sMnMkDpMCMVKSZYD7rT8mqao5ALgDfeZgY=VAiP=HbY=Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJU6sMnMkDpMCMVKSZYD7rT8mqao5ALgDfeZgY=VAiP=HbY=Kg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Sep 28, 2021 at 03:31:19PM +0000, Salvatore Mazzarino wrote:
> I’m running connman in dual stack with the following configuration:
> 
>       [service_eth0]
>       Type=ethernet
>       MAC=[hidden]
>       IPv4=192.168.159.13/255.255.255.0/192.168.159.1
>       IPv6=2001:[hidden]:[hidden]:[hidden]::13/64/2001:[hidden]:[hidden]:1::1
>       IPv6.Privacy=enabled
>       Nameservers=192.168.159.1,1.1.1.1,2001:470:20::2
> 
> The problem is that I cannot ping to the Internet.

Unfortunatly, ConnMan's IPv6 implementation depends on the kernel
maintaining the interface and routing table for IPv6. The userspace
stack is missing features. If there is only one interface (e.g. no VPN
etc) things should work but as soon you have more than one interface
things break.It's a pretty messy situation.

> Here an example:
> 
> worker01 [~]$ ping6 google.com
> PING google.com (2a00:1450:4014:80c::200e): 56 data bytes
> --- google.com ping statistics ---
> 2 packets transmitted, 0 packets received, 100% packet loss
> 
> Weirdly also IPv4 is broken:

That is strange indeed. Check the IPv4 routing table if ConnMan screws
it up.

> worker01 [~]$ ping google.com
> PING google.com (2a00:1450:4014:80c::200e): 56 data bytes
> 
> Any other machine (not running connman) in the same IPv4/IPv6 subnets
> works fine.
> 
> Once I set IPV6=off, IPv4 connectivity gets back again.

Yeah, no surprise here :(

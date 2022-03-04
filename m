Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB4A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 08:56:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84CBC5D4AA;
	Fri,  4 Mar 2022 09:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646384188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OqExf34LPliDGhxstsoBrml8xxpnY6uK504lL37yUXE=;
	b=rZtUw41plXJVOV9ePwe61DQtwwiJLNKykoj2IlnoQxwMTs8x7CPoiUVLBk18j3oK05gVCC
	2w7RSVdMZ7gEH8MxZ33UUxH5bg8tIMBJeU0ahvLuGxEhWMb30XA9NJB5JCsgMzjgrdS1tZ
	y86x9YgnMu7nc4BIKciWkap8KQ/DuezmNn7ZpRyK9p5fj4Qw19H1FQ67IPG3Th94FQ4NS5
	VZSV2LaFLOJuTAgbbLe26ohhpN65IiQvDAjEWiV5fMazb2Q3e1dt5/5bp+a/keCj6+OLc7
	LDnXpK+h5hK5XODX1s8LvJz3tCD8O2kUI4gCaTpOEdhwjE98eQFvuqUcUmG/hw==
Date: Fri, 4 Mar 2022 09:56:28 +0100
From: Daniel Wagner <wagi@monom.org>
To: Nicky Geerts <nicky.geerts@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 0/2] timeserver not resolving ntp server
Message-ID: <20220304085628.eiwriua74hrrgl45@beryllium.lan>
References: <20220228124930.4010311-1-nicky.geerts@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228124930.4010311-1-nicky.geerts@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Nicky,

On Mon, Feb 28, 2022 at 01:49:28PM +0100, Nicky Geerts wrote:
> This is a series of fixes for an issue where the timeserver cannot
> resolve the ntp servers.
> 
> 1. when the UDP g_io_channel in the nameserver is closed or in an
> invalid state (for example by a misbehaving external DNS server, during
> a start up sequence), DNS resolve will fail for the ntp server, and
> won't ever be able to recover
> 
> 2. when a service switches from the autoconf link local address to an
> address configured by DHCP, the timeserver will drop the notification,
> and the nameservers will not be reloaded in the timeserver's resolv instance.

Thanks for the excellent problem description. It really helps. The
changes look good though they seem to have the wrong ident level. Could
you check if you have used tabs?

Thanks,
Daniel

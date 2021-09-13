Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2413FC4
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 07:05:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FABC5E3F1;
	Mon, 13 Sep 2021 09:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1631516704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g2km+q5WEFCOMlUY0eXYBr98KbeGRRFW5e9Ianu5KU8=;
	b=S5OPxPF9HKbqZjEF5ByI/W2PxRzZw/0JKpaiIlSI3VzRAHkT9jYdSITppyR7cEzAhQRjQz
	Vu1svIdu+ZbouyquH8p+hge3mWaT0+yCQ+U+r5SCbZtaQ8SarEBryIwejc5OP6n+eI4cnm
	g42PiA/AjLam2vhgFWHJlg70p++l17esou9ZXhU49o+WEAxetWvFjtH57UK9E2YUaQxvfP
	mAD/XTm/9k+1kIXsfvw9gELnb9cPlCPE7QRwjKWKBIbWfFYiQd0HvkcTXLaZusW0j8G4zz
	Yc5q1OPLf35o2X1nDbodfWJ/pGn8hEzBS1GEP08l509d7sEz7pKbsPP/ykyD3A==
Date: Mon, 13 Sep 2021 09:05:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: SIgnalPoll dbus function
Message-ID: <20210913070503.5vqlsuz3dwcy2jyo@beryllium.lan>
References: <CAOf5uwkzZU-vofxOZyNBDu=5emmkoewjPtAAZPhhapumKdh_gQ@mail.gmail.com>
 <CAOf5uwkQLTfdZBGvXwBUMEA4Lx00BuzL-uEJRDzrLWp4HFQXYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwkQLTfdZBGvXwBUMEA4Lx00BuzL-uEJRDzrLWp4HFQXYg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Sat, Sep 11, 2021 at 10:40:00AM +0200, Michael Nazzareno Trimarchi wrote:
> Hi all
> 
> I would like to know if is there a more simple way to get the bitrate
> of the link
> 
>  iw dev  wlp2s0 link
> Connected to d8:8a:dc:58:99:57 (on wlp2s0)
>     SSID: HUAWEI_B818_9952
>     freq: 5180
>     RX: 1592950584 bytes (727134 packets)
>     TX: 121351631 bytes (625159 packets)
>     signal: -56 dBm
>     rx bitrate: 585.1 MBit/s VHT-MCS 6 80MHz short GI VHT-NSS 2
>     tx bitrate: 650.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 2
> 
>     bss flags:    short-preamble short-slot-time
>     dtim period:    1
>     beacon int:    100
> 
> Some equivalents come with SignalPoll of dbus interface of
> wpa_supplicant. I have implemented already a way to put in the
> dictionary the frequency where we are connected because is already
> stored in the /var directory. Can this be added with a proper patch?

So one thing which we can't do is polling per default. There is the
Counter API which implements the polling feature for TX/RX
counters. Maybe it could be attached there, but the a quick look shows
it would need some surgery to make it fit, e.g. by making
__connman_service_notify accessible to the plugins as well and change
the stats arguments. Probably introducing a struct for this. Also the
notify function needs to be made a bit more smarted to report only real
updates, e.g. if you would just update the link stats in the wifi plugin
the RX/TX counters should not go backwards etc. I suggest to play with
it and send out a rough first version to see if this is going into the
right direction.

Thanks,
Daniel

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2A15A8
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 15:38:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47F095DFF4;
	Sun, 28 Aug 2022 17:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661701104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CGyx7zGtCzjiTc9T7Nc5ddLzy8+sl1cz1MLscU96xrk=;
	b=XR9Sn47zxg3Uthzmh30e4N32+qDnYlc4Q32wyfrHs+QnewDuiSt/RdV/lkph/GstF4zys3
	m5Ea5kROSc7t6FzWVlqRu2rkrMbriz/yVi/xFv+Z54yVNNgEYuZuGLyXnZBRatNAiqMjMh
	wD3b2QnYNifVBOje4KpSyinxoRQn4cdjT4oIKsMfOmbJZVqsRf0o5h7j+Bpbtqk8wIaVqI
	kN58yksJV1HSQB1ef4ULgVrvK8niyEA6nzsttdw5BG5tkE1aYPxw4jzTR5gkZIBozAo6vG
	oyjNQJaH/YqBusYGSqJiupN6RtjEnmJHfAg39Ykiz1WnL5fWKqkkdETecMWueA==
Date: Sun, 28 Aug 2022 17:38:22 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd <iwd@lists.01.org>,
	connman <connman@lists.linux.dev>
Subject: Re: iwd + connman
Message-ID: <20220828153822.pvyyttxknssey23c@beryllium.lan>
References: <CAA=hcWTmGCSQFEMABzUU742ZE-2LJNR38+B55Kzr3HrLjcOO-g@mail.gmail.com>
 <3dc4f487-0833-19d9-d4b7-8c6319d32411@gmail.com>
 <CAA=hcWT6xaJKWxmstpRznb+hY7PcwDSagm_n6udZ8VjMXw_p6A@mail.gmail.com>
 <02550a47-5d45-d165-4572-0542f5772532@gmail.com>
 <CAA=hcWRSKCUEcO+EnRgrk9D+dUxAubYjQAHEQjfgWTE0FaKNug@mail.gmail.com>
 <20220704092248.2qjehvz7f3f3dsii@beryllium.lan>
 <CAA=hcWRsNbm36yLt00bD7xuTEVkD=ApYt3JNYd66H7bw1JiSeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWRsNbm36yLt00bD7xuTEVkD=ApYt3JNYd66H7bw1JiSeQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Jul 18, 2022 at 12:31:09PM +1000, Jupiter wrote:
> >> But I don't think that is the cause of connman failing wifi detection,
> >> how is iwd and connman communicated on
> >> EnableNetworkConfiguration=false, I assume through dbus, right?
> >
> > No, this is not a D-Bus API. ConnMan will not set this.
> 
> Could you please elaborate how the ConnMan could figure out WiFi
> connection based on there being no direct connection and communication
> between the ConnMan and iwd?

ConnMan does lookup the device type on the interface index. But as far
my current understanding is, this is not the problem here.

> > The DHCP code in ConnMan doesn't really care about this detail. ConnMan
> > operates on interface index.
> 
> I set up /etc/connman/main.conf:
> 
> PreferredTechnologies = wifi,cellular
> SingleConnectedTechnology = true
> 
> The ConnMan was able to switch between the WiFi and cellular
> connection when I used wpa_supplicant, it is now incapable of
> switching WiFi and cellular connection in iwd. If it is based on
> interface index, here is my interfaces both mlan0 and wwan0 are
> connected, ConnMan is not able to turn off cellular when WiFi is
> connected, how does the SingleConnectedTechnology=true work with iwd?

It's the same logic. The ConnMan core code doesn't distinguish between
the plugins.

> > Currently, you can't use EnableNetworkConfiguration=true together with
> > ConnMan. This will not work.
> 
> That was the question I have asked for months about how to make
> EnableNetworkConfiguration=false work with ConnMan. Sadly if I set up
> EnableNetworkConfiguration=false, ConnMan was not able to set up WiFi
> network, if you believe the ConnMan is able to work with iwd
> EnableNetworkConfiguration=false, could you please elaborate how to
> debug it, I'll try to figure it out?

You would need to teach ConnMan that certain services don't need
DHCP. I estimate it a major effort to make this work. 

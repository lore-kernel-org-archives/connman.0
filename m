Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F77EF
	for <connman@lists.linux.dev>; Mon, 27 Feb 2023 07:34:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A440FDAD0D;
	Mon, 27 Feb 2023 08:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1677483250; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=B8GVg7P05T3dikgbh2kYtt+1Vqo7FGBKFkiuGN6DoZw=;
	b=es85uhVzBe9V6tv8IrLLKEW6kvLGQBjqxnKcBpPK4OOGAjOwP9nmf0OR6LkRiQJUI+1nTY
	VRckmTHmQ6j9CXfBAlbGVoUBBY0mH/7ASXFAwKowZhYpo4nOAxXtcSi2Xx6AYZ7BS76pAz
	Cw4184F/0RjrenJgfzBPIwGMUdI4//y13i0lgL8qi5bES/QCy0ylQ96ROCdegGHE2yYoi7
	M/W7RawMylLB2PcXd5pscXv9tHo8HE5BunynTXnEXX8M2RNJ8Fy3f37qdg5Ca/lWpjAnIa
	oJ7bn/awxoS+Nom7EMPpEGJYmg5dzgm6HeauA3J7vDAx1EO3TOfWrRfAMVh41w==
Date: Mon, 27 Feb 2023 08:34:09 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [RFC PATCH 0/9] Add association state for VPNs
Message-ID: <20230227073409.7jb4b6nq2gdnjtfy@carbon.lan>
References: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
 <20230102081007.jobeqdgzrzzwwwqx@beryllium.lan>
 <a69974f3-3a52-56ae-f50f-f876e1ee28cf@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69974f3-3a52-56ae-f50f-f876e1ee28cf@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

> I'm just thinking that which is the cleanest one and requires least amount
> of maintenance.

Honestely, I haven't looked at the code base for a long time. So I can't really
say. Usually, if I can't decide which interface works best, I prototype both and
see how they feel. It's always very hard to tell just by looking at it how good
the result will be.

> > > c) Furthermore, might any of the VPN plugins available (elsewhere) work
> > >     without accessing the VPN agent? The flow now requires to use vpn-agent.c
> > >     for processing and state transition. However, these cases should then use
> > >     the vpn_provider_set_state() directly, as most of the plugins now do in,
> > >     e.g., error cases.
> > 
> > That might be the case, but I don't think we should consider this as really an
> > argument to stop us from updating the code base.
> 
> Well, with the approach suggested above there would be a way for those
> plugins that do not use VPN agent to indicate that state needs to be
> transitioned to CONNECT at start. So when VPN agent is not needed, implement
> the callback to return 1/false into the VPN plugin.

Ah see, I am knowledge is pretty outdated here :)

> > I don't have any, right now. Let me quickly look though the patches. Though I
> > don't expect a lot of comments from my side.
> > 
> 
> I'll edit the patch set and send it as without RFC tag after I hear your
> thoughts on the matters I just wrote. And thanks for taking time in looking
> through these.

Great!

Thanks a lot!
Daniel

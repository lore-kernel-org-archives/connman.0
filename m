Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F42F32
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 18:36:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2F895D6DF;
	Thu, 14 Apr 2022 20:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649961401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=K/zNa3tJBOGdzAcZMBut++XLGGLaMn+HWDiUdDmFBV8=;
	b=syxiKOHfNyH5j2bly8ftsquSfKG+QvqLftJdpwZIvHe1Vnbw9bkNyQLPPhK1HCKX144C39
	hkufhPNVnILhcEbccSuUdtcRlQOLPS2RpkIdSBoIBHPvu4WgM67TRs/Z0bmY/lUjUJxsvX
	H2wa8ch3Dupws0NdjU+YrIm+FgW1FKwhttHwU1My4eCjEgzUFeZilknlFY/GUy54EmAFXO
	9o2VsYN2QKdCywI3zYMNmThWLpf+nDZjZauZZ606PJR2eD2VBvUQuDFZ0HJrNaupZDDJvJ
	S99aFeRGnM8Ph1UmmbM02Y2UnWaX2w+AEGHsvnrQcIN7dATPGJSfxYXiSIEcng==
Date: Thu, 14 Apr 2022 20:36:38 +0200
From: Daniel Wagner <wagi@monom.org>
To: corubba <corubba@gmx.de>
Cc: connman@lists.linux.dev
Subject: Re: Non-persistent IPv6 DUID issue
Message-ID: <20220414183638.4z2dx3lw6rwzkvgd@beryllium.lan>
References: <608c9e61-b916-7558-2c03-cabfd46910aa@gmx.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608c9e61-b916-7558-2c03-cabfd46910aa@gmx.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Tue, Mar 15, 2022 at 11:36:00PM +0100, corubba wrote:
> Hello,
> 
> I recently discovered a bug in connman v1.40 which effectively
> prevents it from getting an ipv6 address via stateless dhcpv6. My
> investigation revealed that this was because on every link-up connman
> will generate a new duid (dhcpv6 unique identifier) and request an
> address with it, which fails because the server won't have a address
> for that fresh duid. Normally the duid is generated once and kept/used
> for the lifetime of the service, which is also supported by the
> comment on `set_duid` [0]. I further pinpointed this change in
> behavior to commit 0f9e6af6 [1], which changed the start-point for
> config building from the old config to an empty one. While it has the
> nice side-effect of getting rid of unneeded or duplicate keys, it also
> throws away any existing duid which is the root cause of the issue. I
> also checked the most recent `master` branch and confirmed the issue
> still exists.
> 
> I cobbled together the patch below, which basically just copies over
> the duid from the old config to the new empty one in order to keep it;
> and I confirmed it fixes my issue. But full disclaimer: That is a
> quick'n'dirty solution, and probably not of mergable quality.
> 
> I am looking for advice and suggestions from more experienced
> contributors on how to fix this "properly". I am also not positive on
> what this finding means for the `*.DHCP.LastAddress` keys (which
> probably also get thrown away currently) in the context of stateful
> dhcp (v4 and v6) when you want to use it to re-request the last
> address again.

I started to look into the IPv6 implementation and after digging a bit
around I come the conclusion the current code is an pretty sad state. It
kind of works but not really good. I fear it needs a lot of refactoring
to get things working properly. I kind of lost interest on working on
this. If someone wants to dig into it, please be my guest. Probably not
what you wanted to hear. Sorry about that.

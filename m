Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE82F26
	for <connman@lists.linux.dev>; Thu, 24 Nov 2022 17:30:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBDFCE2FD9;
	Thu, 24 Nov 2022 18:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1669311012; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4muxBe3UXbV5uC5LgkMSdzDoZJLSMDW3iMvvL/HNEh0=;
	b=Dpo+qwOgmJHLIya2QB3CzTsIJOvCIK/H1y1/f8dk7QSkpxKN9ONxm/C1E20OH8SxKA5PEM
	XwHcmBJ36Vd5GP+o8XoiXt82PNrp7POgoi2pVwOy3qlpa96q6C6KINDNMdZweyvr3wKFSP
	aFWdLDbjjXcDz2HoOwh1uIcQfYBc4jRjcJZd4buycyeYJBVCz0GwB2sy2dcELl4QKw9wtx
	c1t1piyEVj2zRWUt8i4Avpgj0Ba/SpcFWNYVxZrt5wcMHk36X01b4SOAE3sUkix7njrLtX
	NtF/YBkBB1ERs/56XtiIxkmnLyPKwhaMb1VyaPn1aeEHzibPejJaCNNesMNQnw==
Date: Thu, 24 Nov 2022 18:30:09 +0100
From: Daniel Wagner <wagi@monom.org>
To: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Cc: connman@lists.linux.dev, john@metanate.com
Subject: Re: autoip address set/reset loop
Message-ID: <20221124173009.nntf42ayfgocsjzb@carbon>
References: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
 <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
 <ef0bc60e-2833-9e72-c4ff-5d7fa3838ce0@gmail.com>
 <20221124114529.w33mrgo26s5b7qgw@carbon>
 <431721b6-ac4e-dacb-d739-760e7c6e0bbd@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431721b6-ac4e-dacb-d739-760e7c6e0bbd@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Nov 24, 2022 at 05:34:09PM +0100, Geoffrey Van Landeghem wrote:
> When you say that such gateway address is a bug, then do you mean in
> general? Because I'd think that in case of IPv4LL at least you need
> some default route. The RFC also speaks about using 0.0.0.0 for
> forwarding rules: https://datatracker.ietf.org/doc/rfc3927/

I completely forgot all details about IPv4LL and now I start to remember
why it is so broken. We have the problem that we activate IPv4LL on
default and for the VPN interface this causes troubles.

> Note sure how to proceed next, do you mean we should add an extra
> check if our IPv4 is LL? Something like this function found in acd.c:
> 
> #define LINKLOCAL_ADDR 0xa9fe0000
> static bool is_link_local(uint32_t ip)
> {
>     return (ip & LINKLOCAL_ADDR) == LINKLOCAL_ADDR;
> }

Not sure if this would help. So if we need a default route for an IPv4LL
interface we should do this. But I just saw we have also the multihome
routing problem but let's ignore this for now.

Changing the default not to enable IPv4LL is also not really nice, as it
breaks the current behavior and this might be something embedded systems
are relying on to be active.

This leaves us the option to disable IPv4LL for the VPN interfaces. With
this we could revert the patch. Either we need to pass this info from
the vpn daemon to the core daemon or we can figure the 'subtype' of the
interface and just ignore those we don't like...

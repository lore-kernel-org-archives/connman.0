Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5B15A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 18:45:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21A3D5D362;
	Thu, 14 Apr 2022 20:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649961920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=W91VsZ8dXwmLbl+Cx1p1uAbuH8qwAJkAaWe/HdMNg+k=;
	b=FEvf79uZTnX2lTubfcgYSpvtHzAFJ3lOhdSbFn06JjgQPpv0O5uIm8ZvVvrz/MRdAC50kd
	/3t3t6QCrKcgoXiodAv66HP1tmyRWVBBKz9+P7qGt3pC2Oedcw3Lb8V+GZ47mp4CZm2opm
	lcKgiU2amiHvfz7EWUfCROSbtoqJ0UP8pNtCHlZqqMiKyNetwG+ysUy1UPE86JdaLuJ7NV
	H2LGY9LOAr+GT2MCm4cK05XINKzI7zbdRXBgxYtgHaK+7NBlr85aON9w58fu+TAoG0NcAG
	2sYTMcqCXKkPPShtGbSegrcGrpdN0gXoQ3g7dMIKVmaUcApOkDJekuytP82Lfw==
Date: Thu, 14 Apr 2022 20:45:19 +0200
From: Daniel Wagner <wagi@monom.org>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Message-ID: <20220414184519.7frygekryu5caiuc@beryllium.lan>
References: <AM5PR0901MB1633AB6BB661EEADB165A51DF2E99@AM5PR0901MB1633.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0901MB1633AB6BB661EEADB165A51DF2E99@AM5PR0901MB1633.eurprd09.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On Fri, Apr 08, 2022 at 03:53:53PM +0000, Thomas Bartosik wrote:
> Hi!
> 
> I'm struggling to get connman+openvpn running on a current Debian machine.
> 
> My Gentoo notebook works fine with nearly exactly the same versions:
> - connman 1.41
> -- DEBIAN: built this myself as I got "netlink: attribute type 1 has an invalid length" with the stock 1.36 .deb in the Debian 11 repo and thought that was the problem

Yes, those netlink message were corrupted due bugs in the code.

> --- config used: ./bootstrap && ./configure --enable-openvpn --prefix="" && CFLAGS="-march=native -O3" make -j4 && checkinstall --fstrans=no -D make install
> --- NB: the ./bootstrap step is missing in the README file
> -- GENTOO: this is the most recent stable version in the repo
> 
> - openvpn
> -- DEBIAN: openvpn 2.5.1 (official repo)
> -- GENTOO: openvpn 2.5.3 (official latest stable)
> 
> However, on Debian I get
> connmand[64470]    : rp_filter set to 2 (loose mode routing), old value was 0
> connmand[64470]    : rp_filter restored to 0

Debian has different defaults for the rp_filter. So this is just ConnMan
saying let's use the more relaxed routing filter.

> connmand[64470]    : notifier disconnect underflow
> connmand[64470]    : ipconfig state 6 ipconfig method 1
> openvpn[64488]     : event_wait : Interrupted system call (code=4)
> openvpn[64488]     : SIGTERM received, sending exit notification to peer
> connman-vpnd[64477]: pid 64488 was not killed, retrying after 2 sec

Hmm, connman-vpnd wants to kill openvpn, but why? Hmm, just a random
idea: are the capalities preventing a proper working? Try to drop all
the caps boundings in connman-vpn.service.

Daniel

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC39366
	for <connman@lists.linux.dev>; Mon, 26 Sep 2022 06:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 584065E3B7;
	Mon, 26 Sep 2022 08:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1664172916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h4qavElsngdofD/P9J5IFvmQr/inQrsJMeVnLNCalws=;
	b=0tTG5wK0vHiam/xdQSfRM0f1MVFbHFD2p7fzLtbYzdREpPatZX9cRA+l1zcLaybGTElr1C
	OMoMylaxi83MzA0f0HTdxn5ilJQFg7Bnb8xD8d2SqV/nf8aqdLk1faWKQh8+M/IWW2RlTK
	K0qjRPsq49TRp8XP645ItYG2mBlB9lPRQEg57xU7XQ3nEq+D8U5nCMKiuabRnFlWeVmGj6
	iczVajhhMyfGkbMnf2DCJpTu1WRO+2NzlBR2XODJokB2W6WvSj/Y0sGd0q6O5ekZZi5vwJ
	huTkmEjpn6tUvZkOIQ/n61S9qeMucOOAXQAkA2BZJ0YlN15KE3/fL+tFWE057g==
Date: Mon, 26 Sep 2022 08:15:15 +0200
From: Daniel Wagner <wagi@monom.org>
To: Pawel Bogucki <pawel.bogucki@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: ConnMan SplitRouting
Message-ID: <20220926061515.myv4tumert42uhu7@beryllium.lan>
References: <CABR2+XVsqQKTsm_GrQJHf5s5X9LNr9tCRG_GYx_Q9MvgePfGfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABR2+XVsqQKTsm_GrQJHf5s5X9LNr9tCRG_GYx_Q9MvgePfGfg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Sep 21, 2022 at 10:39:37PM +0100, Pawel Bogucki wrote:
> Can someone explain how it should be done so SplitRouting works? Or
> update the docs (I know no one likes that part)?

The splitting is enabled by reordering the services. The ordering can be
changed with the move-after/move-before D-Bus API. E.g

1. VPN Service
2. Ethernet Service

move-after VPN Service after Ethernet Service

1. Ethernet Service
2. VPN Service

will result in a split routing.

HTH,
Daniel

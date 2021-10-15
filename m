Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA72C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 06:53:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C0E2618C8;
	Fri, 15 Oct 2021 08:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634280831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fh0xqDUaDABlDF/8NBWjUXleUtLNxEF4zSqekRde3ho=;
	b=onWU0bQNDIbKK0LGGTr2eCcnM2X4408VuUKhuLAdr/a8CCxvz7J1q0Y3dxdArBlMfvoo7o
	XWHtpu35EMRWUctMy3OOw8zcYlf+rx10ylvkgCq7ogtPg3Www7RzPb4+HTkgwEEwBtYWzq
	VWxuAqXXLYRAMpTKCrrwOd4XOKVtcdi5jYnGvX8qcD7CANPb0xOd5X+ioon0wezZTHoWlT
	n+pk3XKxUURQFurlpAYvB64k/ggWjviESC6Er3xJttKR19ypN3ErCwr73RF0QzzU6ouuW/
	sH2+3H3jzDnmnFiksUhHNBWpXpiZ3pfI0R+7hhpg/KiP5BZH2jcnuUkoTWZXJw==
Date: Fri, 15 Oct 2021 08:53:50 +0200
From: Daniel Wagner <wagi@monom.org>
To: Julien Barrault <julien.barrault.external@overkiz.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
	connman@lists.linux.dev
Subject: Re: [PATCH 1/4] tethering: Reduce the number of parameters of
 tech_set_tethering
Message-ID: <20211015065350.wpf6qqcdfsmvt3q2@beryllium.lan>
References: <20211007213021.58712-1-michael@amarulasolutions.com>
 <65509ce0-a5d9-9161-7454-a93b8147c4ed@overkiz.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65509ce0-a5d9-9161-7454-a93b8147c4ed@overkiz.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Julien,

On Thu, Oct 14, 2021 at 08:31:04AM +0200, Julien Barrault wrote:
> I've tested these 4 patches, it seems to work perfectly

Thanks for testing. Could you retest the current HEAD. I've done some
stylistic changes, they should not change the patches but who knows :)

Thanks,
Daniel

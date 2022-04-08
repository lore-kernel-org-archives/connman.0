Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C5399
	for <connman@lists.linux.dev>; Fri,  8 Apr 2022 07:30:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22B645D6E2;
	Fri,  8 Apr 2022 09:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649402470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eR5z/IC6pjHSsu52FKOHhWl7VatUyTye+Ck5uRfH7AM=;
	b=hTCet6WpBgscy/o4VpLQr/PgRTWgW8dhygFbQqVpSdLZdqgRJtWxACu9MAR4+GSodh6qJi
	EUgPI9S0AS2MqFv7cn6/rnIuaqwQDCONyeGo+cJY5CicltKPBxv7S8wNykUYoP3BL/cyJJ
	JZjyeLU0zGIPpGc0rpi1Oi3EBNcGDjhYE7RsNzF0oDt6NpbHUJJuxx2ZufNUlCapeFFk/f
	HVJya2/cdrxv4dA+0YyA9Ogq8TyMwIzr7630h1GUkyR+gn34Spu+4drwVw/2+SvdTKDKoi
	AnW88NOkgEZniy42NKQ05FwzxJz4pd0qkqOfHm3R7JiXktz/UCWXME9+SU13bg==
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>,
	connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 0/4] Set regdom to follow timezone setting as optional feature
Date: Fri,  8 Apr 2022 09:20:19 +0200
Message-Id: <164940240736.15543.14003702769488337371.b4-ty@monom.org>
In-Reply-To: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
References: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 5 Apr 2022 17:31:12 +0300, Jussi Laakkonen wrote:
> This patchset adds an optional feature to make regdom follow the timezone set
> on the system. This feature is useful on systems where no cellular is available
> or there is no SIM present, as the regdom on WLAN would stay on default (US)
> and some channels would be unreachable. Enabling the "RegdomFollowsTimezone"
> config option makes Ofono plugin not to change regdom when the cellular network
> has indicated a change on country. By following the timezone, which can be
> also updated by the cellular stack if set to automatic configuration (might
> need a external service to do this), would then eventually propagate to ConnMan.
> 
> [...]

Applied, thanks!

[1/4] main: Add path to localtime to config options.
      commit: f035539d46ac23ccb8916ed7ae8d38ab553d32b1
[2/4] main: Add RegdomFollowsTimezone option for regdom changes
      commit: aaab2161b247588bbee32fefe775ef55acc69c4d
[3/4] timezone: Change regdom along timezone, use localtime config
      commit: bce73f1bdbf1aa6fc28d2f75b7780f4f1d8b0e3a
[4/4] ofono: Do not change regdom when it follows timezone
      commit: cb87ddd2f5905782b45c0e46277fcf7f32de16af

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7790173
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:11:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 239FE5CFE7;
	Tue, 25 Jan 2022 10:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101864; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7lIUlR2ApStG/w7et4TJXANnsYoYI87Rlv4yS0H/EZc=;
	b=Z/f/611UUd3Q8Hnif2w8RhEV88hBLmHxO/g0xpUD7Gw/FYXHnZOHCFh1aSddy9zvCyfe2x
	SoZfUBpd64dJXWGlcz/VDEX8Un3HGnuU1oClUnbPUQtQxliPxtq6VjQ7H4g3qZiOgc8coz
	X6Nr/OQkY88FSXFUDbL/OR8jeDxRBNqTORmuA6iqLAbXpE4/TKA78x1XHXSYRHAwpbj5Gk
	gaxDB+eucvjMjTlDDR3RP4CX6oLAy3D+T0s9Gro9TuDZ4xNywspcxJS1pUhRoKIHsIQONq
	1o6YGAW6l7WuV5XeYe+ZM4DnFQ46cyd7jq3Zclcbga1Nwl3hlV4bJyP3ycumGw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 0/5] dnsproxy: Add input validation checks
Date: Tue, 25 Jan 2022 10:10:57 +0100
Message-Id: <164310183482.5859.115642148699929952.b4-ty@monom.org>
In-Reply-To: <20220125090026.5108-1-wagi@monom.org>
References: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 25 Jan 2022 10:00:21 +0100, Daniel Wagner wrote:
> Matthias Gerstner was busy testing the dnsproxy code and found a bunch
> of bugs. With a lot of input and help from him we came up with the
> following patches.
> 
> dnsproxy.c is in a pretty bad shape and needs a complete rewrite with
> proper tests added. This will take time and brave soul to do so.
> Though things aren't that bad as there is the option to use
> systemd-resolved as DNS proxy. I haven't looked at the code of it but
> I am pretty sure it is way better than dnsproxy.c :)
> 
> [...]

Applied, thanks!

[1/5] main: Use g_strdup for online_check_ipv{4,6}_url config
      commit: 8bed0e22cb59468e773b247724a114d6764bd0a6
[2/5] dnsproxy: Update TCP length header
      commit: f65b6c233dd9f91723ea6993dca59fcf303d001b
[3/5] dnsproxy: Validate input data before using them
      commit: e5a313736e13c90d19085e953a26256a198e4950
[4/5] dnsproxy: Avoid 100 % busy loop in TCP server case
      commit: d8708b85c1e8fe25af7803e8a20cf20e7201d8a4
[5/5] dnsproxy: Keep timeout in TCP case even after connection is established
      commit: 5c34313a196515c80fe78a2862ad78174b985be5

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

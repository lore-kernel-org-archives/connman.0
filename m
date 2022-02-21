Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E257B
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:23:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C02815D3F8;
	Mon, 21 Feb 2022 09:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645431780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wAGdeQEbeula6vfcpWuyZ0PbXXqG5ZDicHhST7ocOmg=;
	b=kXfhWihJrQhN5m29uLSraphH3YSgsF3uAF+elR4ZnSxB+EfsD3TSsKx62sx0F2oIsRRiyy
	tRY9ArSmIj1EqMyu02P/sFdGhsRZvIbe4K6Fyi8CdkyPiqY6VnLfdB0UCJtIjK/wEWggwt
	jX8GnpVfee5/1IUeUADnGBI69fqP/ViYEJKTanLdHly21jvvBekTzGQfghphQ5YCZv+R90
	6tCB9gm7R8hJi8IVik8hvpno4HIEsx5QzrJzYttDHJ1RLTBczAjqilP31Q3WCy9EOBj3IP
	+v9zpWkU5Kb/e2QGKZBMqoAjv0x9bZpI7EMOWfCN/NHG6kZ326MwOPjZEjg4NA==
Date: Mon, 21 Feb 2022 09:23:00 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Fix typo in warning message when enabling
 AccessPoint mode
Message-ID: <20220221082300.wv6w6ngbc2lw6deq@beryllium.lan>
References: <20220214022043.523341-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214022043.523341-1-net147@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 14, 2022 at 01:20:43PM +1100, Jonathan Liu wrote:
> Fixes: 648ed549f0ac ("iwd: Add support for tethering")

Patch applied.

Thanks,
Daniel

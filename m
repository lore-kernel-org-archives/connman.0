Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F528E7
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:31:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FCDB5E064
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 20:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661711487;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=jqi6SgF2j0h72Yl6+IbOH5d8JDVkhaCqUMCeakyRHJ4=;
	b=UBMzkRT/mLkj9gZsyUdpytcoh3kifye6eUQMCIBJBEK10y/ez/AsDMRFZvAkA4Nestc+Ko
	sAgon2IEx6uT5WhvHYBSShkcqtFf2cEPooFZrd1wzh6I3k9Y5/VDnNTdnXiTuTCwXJKoqJ
	1OaTEZYzQ87WVP4ZwnTQgkOEx9NzkwGPFQCqALPS9Mv41+P7MWYXxKiWpb/zx8cRB57UJU
	D46MzZeeJ6sb69jUEzNbJaPdyLJRNnMTv1hWjQMK2YT85ywwJ0dlveUIAz7LxRlqaqb2kb
	JSzAO7qDRtE7g6s/i0bPMiSXzTC8/1FBxaJRtSDiJN9kqvhJ57MyXR7gozFTug==
Date: Sun, 28 Aug 2022 20:31:27 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] ipconfig: Don't add invalid gateway routes
Message-ID: <20220828183127.whie4qtfaanoifsg@beryllium.lan>
References: <20220828181052.27467-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828181052.27467-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 08:10:52PM +0200, Daniel Wagner wrote:
> When we assign an IPV4LL address we are calling
> __connman_ipconfig_gateway_add() with an invalid GW set. It's propably
> a safe bet to say NULL is never a valid GW, so let's filter it out for
> all callers.

applied

Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76928EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:40:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9CD5DE364;
	Tue, 11 Apr 2023 09:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=V83aSd9zS0RTQ+hyKRWzMMo11G/77Dv2IRRid7cCFPo=;
	b=zxlvzSrluhnUYfWmGaD2cNCUdbe8pzsyP9zA1eUkVk4NFWyTpvFvGb5i6xnTlp8h8CenYi
	f0/hV9yKHgdvlOO1OzhGHNWi9064X9vq3gf7tIxVuNJU1oVz7HCaWLtj+HPOlbypmU7OwJ
	R24+ty1GqahNJ5p7QWPMNzNpmwWlTFyf74HlWP08ylyQJLe3RQudRbd8lEczDhXTo74hsj
	B7bIUHpR2cuVNoEoeZioIjGTqcGm6NRyGtrPTbiMK3vKv5Ev4TLUrpnb689lPC5oNYKtmw
	S2Zk2/0T052mDdHazRgYJZStXKHCsdqTvAGHgvMzyz7v23xddE4KoD2YJCoRJA==
Date: Tue, 11 Apr 2023 09:40:09 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Polina Smirnova <moe.hwr@gmail.com>
Subject: Re: [PATCH] gdhcp: Verify and sanitize packet length first
Message-ID: <20230411074009.edz2ecwkamtqy2d3@beryllium.lan>
References: <20230411061945.8089-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411061945.8089-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Apr 11, 2023 at 08:19:45AM +0200, Daniel Wagner wrote:
> Avoid overwriting the read packet length after the initial test. Thus
> move all the length checks which depends on the total length first
> and do not use the total lenght from the IP packet afterwards.
> 
> Fixes CVE-2023-28488
> 
> Reported by Polina Smirnova <moe.hwr@gmail.com>

Patch applied.

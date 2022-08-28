Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF53214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:09:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DA4C5E02F;
	Sun, 28 Aug 2022 16:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661695766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=j2xk6eulw/V0JHweMfNhNfWjVJ9Y9sQX6DbS4b5lxtA=;
	b=NUkau4HQtyxL4WExhCCy16tleoNJhAxkcs61OJTA1JGm1pAwB5aLAmbKwuyrLXjiL8fAnq
	xegvucn1QaqR8LXV83HLVYf8vo2jRdA7LMwCgE6B50NjaO9zcENB2pWi227Bh3/Lb+sYEV
	3QJa9BQeuyqgGcjViyb3cLYUm5XZkFf8idPAM+Qic+VXLYPjyitlHhK6J+URq1AxdjqP6I
	O2g9axHG0S7+lfjbQ4SK3snrxChK5e+kL8IEIMR8m5CPdIulOGZQuhGPKkLka8eI+OBJkZ
	JjQsw+ZckSwmyzDHmjscC9t8JrZM1uEfP0dpz825OskH1yENgKdM/hkzVJGYNg==
Date: Sun, 28 Aug 2022 16:09:26 +0200
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Link always ready and don't pass online
Message-ID: <20220828140926.etfebtezdel5nvu4@beryllium.lan>
References: <CA+iibzBCG+F5P4q4T4wTwONcCzR5doDpzz=t-SgvFR0eqzKeKw@mail.gmail.com>
 <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzBU-cYMgLHD98nB-jBhnH-gG0V6n8Z1SkSkmJFrudCHBA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, Aug 27, 2022 at 02:41:05PM +0200, daniel antoine wrote:
> Hi
> 
> I have tested by using the file source
> https://www.kernel.org/pub/linux/network/connman/connman-1.41.tar.xz.
> The link has passed online . So I compiled by cloning the git untilI
> it failed on a faulty commit.
> The link doesn't pass online and stays ready when commit
> 416bfaff988882c553c672e5bfc2d4f648d29e8a (wispr update context portal
> references) is installed.

It seems this commit revealed some bugs. Not totally sure how this is
actually possible because it fixes resource leaks and UAF.

Anyway could you try if this patch[1] improves things? It looks like the
wispr/portal detection is doing something wrong.

[1] https://lore.kernel.org/connman/20220828135322.21582-1-wagi@monom.org/

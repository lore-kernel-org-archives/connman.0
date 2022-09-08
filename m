Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7D382
	for <connman@lists.linux.dev>; Thu,  8 Sep 2022 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
	:Content-Description; bh=Gl67yWHD6IXmV6ihsjC7VUjzUNv4K/ZGkwDxeHn/G+I=; b=qDqW
	lfFiINGFhq2RRiot3DupZche0rHGnUzlHX7d0avpxMtygbA9FgG2ofRtlOWM7vIuvkhditCLWWEdy
	US0IzuIXmmXi8cmAN1jqcuLrpZEEy7rovy5AweJBiI6+KBVMnAQqJnVWMUSqIip/Xp9EfCKM660mU
	bIrZXzd8x6QbMUaMvbBCrFCWkf0kIByP6TuAUVgCrb8R3ywBDvrtGvLj0Z37+od0Z3SCRYC/ilye2
	uHYaeIiGXGvr36h/V2EZDLwZ3nuNicza/vFO9yoe/LrW8c37fQ2PYeDafjO12OUaqwUP6uviXRT+N
	v59zWdGilTXHaaO2opYCtx2ev5mr4g==;
Received: from [81.174.171.191] (helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <john@metanate.com>)
	id 1oWIGn-0006bw-OJ;
	Thu, 08 Sep 2022 15:12:41 +0100
Date: Thu, 8 Sep 2022 15:12:41 +0100
From: John Keeping <john@metanate.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: No password prompt after wrong entry
Message-ID: <20220908151241.3fb95a89.john@metanate.com>
In-Reply-To: <ef8ef3d5-3786-6064-605b-7d668a8d92bb@collabora.com>
References: <ef8ef3d5-3786-6064-605b-7d668a8d92bb@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES

On Thu, 8 Sep 2022 10:52:11 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> I have a question regarding the expected behavior on connmanctl.
> 
> After trying to connect to a network using a wrong password, connman
> returns `connect-failed`. Further attempts to connect won't prompt for a
> new password, so it will use the same old wrong one and keep returning
> `connect-failed`.
> 
> After manually removing the network, re-connecting will prompt for a new
> password and the connection will succeed. Is this the expected behavior
> or it should automatically prompt after a wrong password entry?

What version of connman are you using?

There is a bug in 1.40 which was fixed by commit fe5c1436 ("agent:
Always inform upper layer via callback") that has precisely the symptoms
you're describing.

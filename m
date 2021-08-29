Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CA3FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:07:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20D405E433;
	Sun, 29 Aug 2021 21:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630264033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ER6LoxTg2F9WfWfA8r9GLGmUdJpTYzwqEq13MCvS07A=;
	b=AZrerPf385JCRF7wdghu3ffH3/1KGSHNEOoVpYOH1wpj/sCtnhIneS7Cs9lV72HpHJSHmB
	KaTx9rD56vq/x7ofJA8Ktfwd0hN/vBrDP+G0DlN99Bm12xuI/IxcWY8C6z2BBD6d9npHZg
	XB4JEY4AxqHsduMeqCIXbkrkb2DM8hHREhoEOR1+BVC+vxuif7TDk7XVYU4BRg7aHOvHXO
	WKRzOUXEr2QlJm/lariCFr1L5IT7Rl4ugOYpMF8mFyIqot0a7vcfIiJoDhglAChKho8CSg
	JkXaG3oO6OwjNJtZwPoGg+4f4X2h7ASqbbeYWx2AZDEmKU3MhDrt8JcBfj2KDQ==
Date: Sun, 29 Aug 2021 21:07:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix default service update on ready state
Message-ID: <20210829190711.3fcho47whyclr2id@beryllium.lan>
References: <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
 <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Wed, Aug 25, 2021 at 12:52:24PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > I propose to run my full test campaign again and check for a better solution
> > (or at least to describe the issues I am facing), after the completion of the topic
> > "service: Ignore state information in service reordering".
> I confirm this patch is still necessary, and still makes sense.

Right, after being absent for a while (sorry) and rereading my argument
in my last email I checked the code base again more closely. And I see
where my thinko is. We have to sort against the old default for the
preferred settings. Because we don't know yet the order according the
user's preference. After we have done that we update the default route.
Very tricky stuff.

Thanks for your patience.
Daniel

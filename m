Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B13FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 08:13:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 626895E30A;
	Mon, 30 Aug 2021 10:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630311206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eeY9vN2XHlkJglmeXfBueVb5dMH7FaMs0NnbxcaP1Io=;
	b=XIFZQ2zFGV8l/O1p3ENZLoloRz8CwJD1r10DN/qrbHKneJqZgH/BXYw8Vl1ynERo4OgrL7
	duWxneEbK3EMpGe6n+cdWM/p/sLc6CYBj5+ZXv8E8h7v99erT9bH+Iu2HEpdJTuzRHiczS
	bghEMfzwtNl+uFV4JD1zZszAPriM11QSlix3vPGp4obwFlHUBzSrIELZ4OKMkXre4Tf1fJ
	nwJFre9Y3awwm5N3Lc38yPWL4R0AMEhAhVL1S6B8h/hnTvQAbSC2jw1f5Kj+JbbuABaGfr
	COcWDkg+m7tvEWeTvodvVrwxy2NLyDYlfz9mkm+3TCavWWTxvNIKT2142g6aPw==
Date: Mon, 30 Aug 2021 10:13:25 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix default service update on ready state
Message-ID: <20210830081325.bt3qwlvsmjilhind@carbon.lan>
References: <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
 <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829190711.3fcho47whyclr2id@beryllium.lan>
 <MRZP264MB1544ED7B886A21B5AA73393693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544ED7B886A21B5AA73393693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Aug 30, 2021 at 07:31:12AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > Right, after being absent for a while (sorry) and rereading my argument
> > in my last email I checked the code base again more closely. And I see
> > where my thinko is. We have to sort against the old default for the
> > preferred settings. Because we don't know yet the order according the
> > user's preference. After we have done that we update the default route.
> > Very tricky stuff.
> 
> > Thanks for your patience.
> > Daniel
> 
> Great news Daniel, that we could finally converge, thank you for your time.

No problem. I know I am bottleneck with upstream work. Sorry about
that. Now I just hope we didn't introduce new regressions :)

Thanks,
Daniel

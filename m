Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1F72
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 08:44:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6CF15E30A;
	Mon, 30 Aug 2021 10:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630313048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=40Ko0UaAUB4vNS97k2ZpskQD2jUjTPGeJysihgjBThI=;
	b=iFH4wTMBEUt+WExkXPmgUz+yAy1QoRpKoj5IYGp8lNfpp+grREvhMW8YOcKnPWwDVe2BM1
	dX7cRwwrNafNBsNvkfPZOH2Jj+lwSI+4bsoSK7+TEXb93Fb3LIHTCEuLkQ6OSAuDAGZTZW
	AwKWlqzUofEg7lAubSFXheP6QkwKdAlxTOqZXEz8OkNkGWbL+E57qzdWOcAhnstAJkiR1C
	A3jd5tuBc5ZV0RUJImjsmWxi6aAHyKPPCZDVvbk/SOv5EiH61xHDjEDTMVj5oLtKOYr2eZ
	iRvIotwrqJJDCCxZwcK6vCwNrcCmr7gQZPDiYjX3iXyU9tFqjGQB9pC3w+IpkA==
Date: Mon, 30 Aug 2021 10:44:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix default service update on ready state
Message-ID: <20210830084407.yvfz7fzfzkqucepl@carbon.lan>
References: <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
 <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
 <MRZP264MB154494B92E616DB754E5F46A931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB15440F82FD624796E8AB394393C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210829190711.3fcho47whyclr2id@beryllium.lan>
 <MRZP264MB1544ED7B886A21B5AA73393693CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210830081325.bt3qwlvsmjilhind@carbon.lan>
 <MRZP264MB154443062A2A5FA083766E1F93CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154443062A2A5FA083766E1F93CB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Aug 30, 2021 at 08:28:29AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > No problem. I know I am bottleneck with upstream work. Sorry about
> > that. Now I just hope we didn't introduce new regressions :)
> 
> I can imagine such a big time-consumer it is!

Well, the main issue is lacking main power on this project. We are
clearly in the maintenance phase. Sometimes there is a new feature but
overall the development has pretty much stalled. I try to keep an eye on
the incoming patches but that's about it what I am able and willing to
spend on the project. I wouldn't mind if someone else wants to
maintain/develop this project but so far no one has showed reasonable
interest.

> The great news are that I have no more pending patches.

:)

> And it is right on time, because I don't know how much time
> I will keep working on a project integrating ConnMan.
> If I can, I will try to integrate iwd and run my full test campaign with it,
>  to check the regressions, if any.

Great to hear!

Thanks for your contributions,
Daniel

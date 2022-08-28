Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A253214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:21:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 569F75E04E;
	Sun, 28 Aug 2022 16:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661696486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gP7y/J+SLHPyQ+nVeOHZxvk/hk1stSGU7Uw2hUBm7Uk=;
	b=y2qvg8bYAWD5ilQEFiNKmkLpTewGBydLhytNZKr5PPLJs71xGCgRo747lxJe660nv63E3Z
	kbgf9RaFwx3X0TIgyRsuIfnR3zukvCKDlyAIa7Bas24OU3Fdsrrhgy0v8VcBfHaXvv/+0J
	zPtM+s3agN/h2mXz2j3hmRBxuWDdUsZzIqv2AH3LYOov6O/+B5F3CA+puH4YeIkRo9Ev8c
	Q+gWk7b9HmhKGUq3qwJ503y/MFlqK3e85axur2U8bmHi34wAucrOtC8sYFVHTnpv2IEDSr
	CEJuIWtiR798HhSYooBTHLgAkJDlZmz7npuApX5OSVU/fQgUhJ00S5Eb7M3mdQ==
Date: Sun, 28 Aug 2022 16:21:25 +0200
From: Daniel Wagner <wagi@monom.org>
To: Muhammad Hamza <muhammad_hamza@mentor.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] connman: implement network interface management
 techniques
Message-ID: <20220828142125.smvmt6dfqsvifdms@beryllium.lan>
References: <20220621160450.3401289-1-muhammad_hamza@mentor.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621160450.3401289-1-muhammad_hamza@mentor.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jun 21, 2022 at 09:04:50PM +0500, Muhammad Hamza wrote:
> This is required to obtain a managed network interface before connman
> tries to call cleanup_devices function, this will let connman
> create new routing table without bringing down the ethernet interface.

There is code in connman which should detect this scenario. If it
doesn't work you should look at it and figure out why it doesn't
work.

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFD23B5
	for <connman@lists.linux.dev>; Mon,  4 Jul 2022 09:26:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 383A25D837;
	Mon,  4 Jul 2022 11:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1656926787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=S5t3HpjgqaTZGr8Y+Dq85BXsUissElI/kIkxcoXP9rg=;
	b=eoDTRK4ySuhkpNfo9py+SQa4CKzEmut7Gfd7AxMkEtxucEW0WucwCpYASW7CZWKFPxQ/ay
	5ZM8F8QlSlszXvdakYwRj4a+weGmwdjhdxP72mEF6S1JmuI/XYN4nUuZKkg/kReG6LqaHl
	f8Fcjt6rtvm/7WniXR3L7gsRD55Pw4dndWMgmAaYoWDJnIP+q5R9PvsHmrpTJW6OXV5I+D
	rwEJYL/TULqvc1EG3LyTAWYH1wFR+4VWcL93tay491T3Th97IGQF3k25/9Jl2a5znq3jwh
	OpiAmHAuIklLgPTPE1vzKpMS7xU8ypHk3l3Q2RqrFvJRGNAPOc5Z9qoqFISP/w==
Date: Mon, 4 Jul 2022 11:26:26 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jupiter <jupiter.hce@gmail.com>
Cc: connman@lists.linux.dev, iwd <iwd@lists.01.org>
Subject: Re: iwd + connman
Message-ID: <20220704092626.r7sz7333agp5r6gs@beryllium.lan>
References: <CAA=hcWTmGCSQFEMABzUU742ZE-2LJNR38+B55Kzr3HrLjcOO-g@mail.gmail.com>
 <CAG17S_P6OaYseePAe_f9TZa6Q-DcC+T-Tmk9QSRsA8DOqPYgOg@mail.gmail.com>
 <CAA=hcWSj5TFgisTA8qM=y+C7-ckEMSHXYprgAU2KkDkPsU8qMg@mail.gmail.com>
 <CAA=hcWQbsLZQASJ-F3DeM2CxZBTtd-q2WExCUKEcP5FLnmbHbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQbsLZQASJ-F3DeM2CxZBTtd-q2WExCUKEcP5FLnmbHbA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 22, 2022 at 04:24:13PM +1000, Jupiter wrote:
> After replacing wpa_supplicant by iwd, connman could not detect WiFi
> connection any more, you and Denis both confirmed that using
> EnableNetworkConfiguration=false should let connman to take over dhcpc
> and to manage WiFi connection, what could I be missing?

Can't remember/find any ConnMan logs for this problem.

> Is it true that someone told me for wifi connection, it does not need
> connman, running iwd alone should be fine? If so, what is the
> advantage to running both connman and iwd for WiFi connection?

For WiFi only setups, don't bother running ConnMan. If you want Ethernet
and WiFi setups you could consider ConnMan.

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFE3FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:34:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EA0D60E52;
	Mon,  4 Oct 2021 08:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xlCIlO/VI2gpu43WntjzB9SpiMwQ5MNTnqfUwS0WTG8=;
	b=vwZ+3ZAFmXuL6mYLEfT3kvVweVxHAq+wO7Bl0vbUy7CivydWkL175sTo1HsirkY6wRfKfs
	fnw/pF8FFFC/nQBE/IwQL/TXk7rfn3OzB+pXcLbBvAyjc1qFSMC6IHILSNw9kEQIToZzMh
	RFotpsSe86d+YtT3cTBPs+wyZSCB5ovQGWgRH/om209WDz7Jw00hu8iYcYbijtJT7swf/r
	yv8RdpiiwPNscd+pe9n89NUIPDRM03sGSEl0POHoTpHnvzrcqGMil0ezqCe1UqqrU659Ea
	Kvquu3xYqxJGQjkqkHAfjbKcfMpFEUJjAQw3q/5w1ugtJEldshnFfe0zPi3avA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	"VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] iwd: Fix improper IPv4/6 attributes when disconnecting
Date: Mon,  4 Oct 2021 08:34:07 +0200
Message-Id: <163332924025.22211.8396936022812080972.b4-ty@monom.org>
In-Reply-To: <MRZP264MB15442C715B7A20922755637493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <MRZP264MB15442C715B7A20922755637493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 1 Oct 2021 12:17:20 +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> The Method, Address, Netmask and Gateway attributes of IPv4/6 Service
> property were not flushed at network disconnection, because its
> associating state was not reset.
> 

Applied, thanks!

[1/1] iwd: Fix improper IPv4/6 attributes when disconnecting
      commit: ea8a6b45cc489c59a08950eae86a09e1db02e316

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

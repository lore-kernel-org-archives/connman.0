Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4A15A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 18:47:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D61C65D7B9;
	Thu, 14 Apr 2022 20:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649962060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z16BTYAXpG2aJNY6Ck3SM9Dfds1Dy+3uxuSKUtbASJI=;
	b=T/3F/hXSb8uWD5KNODpIFtJhFw+jqKM2l9EpjADOA9W/5hgIqM1v5SSHYfsOfifb4a3ZFr
	WOa39NPqRWYiNY9QozMC4Y6wNwdXbFYu7heWNPZTbzlG/2n5HnFSYbyZ2zV9dbdTKQyLQR
	G/ApeXk5EWtLH1vYJZ8VlDJO+fOsKvEx729ByUCU4avsGqX03sXM9cZnu6W+8LA1Y4mbsK
	/qpObv/kkseIs7xsSlu0qRUyxt5nI1ik1nut+GcW8Y4RbrdDyDZTTk6Pjku96zyCfF72wh
	r6bu6nRJ/EBjdaKv0xVyQDt23fI/kTLDMK2smwYAK72XQvQx7RiQP1vcmHmR0w==
Date: Thu, 14 Apr 2022 20:47:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Fix connection with invalid passphrase format
Message-ID: <20220414184740.7yimogaa6nzopxfk@beryllium.lan>
References: <20220411075458.78136-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15441C29DB3B9AE00192133193EA9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15441C29DB3B9AE00192133193EA9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Apr 11, 2022 at 08:03:38AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> It is no more possible to connect to a secure network, after entering
> an invalid passphrase format, for example 64 characters.
> In this case, the user agent still needs to be called, to request a new
> passphrase.

Thanks, patch applied.

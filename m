Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1839173
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 16:46:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B97B95CFD1;
	Sun, 23 Jan 2022 17:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642956409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/4TgsKod5AtTjkt4DJKSaojpTN2w0tT9dFNlLdPNA6U=;
	b=Ia6+75bGdlKNh73fEuAR4ET9bOZd4yPVHZkX9CQmJu8NQF67K2UxqvoMajrv588kIOA8l7
	PAETR/INPUp+CtTYSA27R4C002FUGHgV677sKvmLfLR0D2F0HvTLzZqtiqpdacmqAehVGh
	zpKI+uEvHfXXxygAwxFHCWTdN3bhE91WSAWjxE8eqX+izMHwTIlt1PEVaBeo6hf985UaCt
	YwrXrIkQDuEG37631Xgs7lDgx1fgdk+CR9njwKyQCY8HrxQkxF3a+yCaIFbfVfj2213C/i
	QTFnGYDN6BhduR2Sosyrr5zsrROHJJcEoUoN/bRl089TCV7cqXnKPXClNRJPrw==
Date: Sun, 23 Jan 2022 17:46:46 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v3] service: Fix native connection with wrong passphrase
Message-ID: <20220123164646.fzmcfsav2tb7vpba@beryllium.lan>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220123132351.ppud4auaysfmcfx3@beryllium.lan>
 <MRZP264MB1544FAB6EF32AED6479EC82D935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544FAB6EF32AED6479EC82D935D9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Sun, Jan 23, 2022 at 02:14:31PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> For the formatting, as mentionned, it seems that
> gmail / office365 are both automatically reformating the messages,
> so I always add the original patch in attachment.

I used the patch from the attachment, not the email. I was not happy
with the indention levels and the useless brackets.

Daniel

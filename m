Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656A2C89
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 11:59:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17AE45E415;
	Wed,  6 Oct 2021 13:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633521570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f0pn3OAZW6LBTwYeIfkHHHLOWHfAHkwAfeI7fcODsl4=;
	b=FJXwM0E8V9carPcnJWrT1/d5UWOAjHcTCTwBM7Lnfg3kFwh0NZszygbmlJ1la6GKuyPFvh
	OxmoqT1qnIY2ascB0lDgwImcvVcJMnk9mYi1Kt1MxUFLZAu1xtB8RZw+eelyKak3KaDioM
	KeNUio2I8C1ngK9Z/MLPwEqvbun85PEbCcYdQZhsQmX2UYqruRtTLVNGhNsRY0TssvjHDk
	pOZDx4U5GPRczsRfa1WmPHGZk3hcsUdqBVaJRAp0qurUUgEpiAvLUg8O8ZKto1y9vQcihq
	q3IaAA3NnfALwusF/o55KepkN7YQVBMd1mS26VYQzGZmuBurEv03+mNdSGowbQ==
Date: Wed, 6 Oct 2021 13:59:27 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 2/3] iwd: Connection of hidden networks
Message-ID: <20211006115927.lfqei7bai5slvyup@carbon.fritz.box>
References: <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
 <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB1544E27898924DAB6CBBF9E793AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel

On Mon, Oct 04, 2021 at 09:10:47AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Implementation of hidden networks connection.

Please send them as new patch. Thanks.

> > +     iwds->hidden = NULL;
> >
> > I assume iwds->hidden is supposed to NULL, right? If it's not there is
> > bug? If this is the case it might be better to add a check and
> > warn/error.
> It is NOT supposed to be NULL here. Where do you think it has been reset
> before?

In this case, why do you not release the resources associated with the
pointer? Isn't this a leak?

> It only can be reset in case of errors in connect_hidden(), but the
> callback shall not be called in this case. In the other case, if the network
> is reached (good SSID, passphrase, ...), add_network() is called and hidden
> is processed. In the other hand, hidden is ignored. In all cases, to inform
> the end of the request, iwds->hidden shall be reset by cm_hidden_network_connect_cb.
> 
> > I skimmed through the rest of the patch. Most looks straight forward,
> > but I have to say the hidden network feature always screws up the code
> > base. Thought this is not your fault, it's the stupid spec.
> Indeed, it is a tricky subject. At least, I have succeeded to pass my network
> test campaign based on wpa-supplicant with this implementation and iwd 1.18.

Ah this is good to know!

Daniel

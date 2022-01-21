Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A929CA
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 07:53:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4DED5CFA4;
	Fri, 21 Jan 2022 08:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642751626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cyVlPvj8xnu+TTc/oBSMzw1TJh3kwCwOgJj+pBEKp1k=;
	b=N2UTI1IoZgrOriG7ggkyahhHvB1gsMohETnazxGrP/lkwl2mOag5BGqz6B/j1rHJIuaetD
	newiFioyS09R/yDj+ZPda22JqrA2wbjeO+rGBmDQ05dMXbCjFw2vl5ZHoZBbzPoFtZMlYR
	rQayTnnssrE7HW0HmjeQeL0paW/v/A/YEbLcjsfaO/enj+H/1fEgxT7iLMtjrXfjGhCB6L
	ytHbD6nWCXOGJ2Ln40pPBjagydx6o8u8zvRCMyOcREeHkm2l1jBhIweE2dZNeytepO3c+b
	dz9sUi+vs67oH+BhG9DVWEJxifJLK7BcLmwOmSoJmwQdmzz5OSvS8LpaEQtMOA==
Date: Fri, 21 Jan 2022 08:53:45 +0100
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Fix connection with no passphrase
Message-ID: <20220121075345.pab7lvyb2hfrfsos@beryllium.lan>
References: <20220118105214.1201110-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154494E627C59DCFE5854FC593589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwmgupp-oHt2a9jahxE9V9pYgw2VbNfsHa7g8o32WiPBqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwmgupp-oHt2a9jahxE9V9pYgw2VbNfsHa7g8o32WiPBqg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jan 18, 2022 at 12:03:12PM +0100, Michael Nazzareno Trimarchi wrote:
> On Tue, Jan 18, 2022 at 12:01 PM VAUTRIN Emmanuel (Canal Plus
> Prestataire) <Emmanuel.VAUTRIN@cpexterne.org> wrote:
> >
> > During a failing connection on a secure network with no passphrase,
> > agent_request_passphrase() crashes, trying to manipulate the value
> > of the "WiFi.Passphrase" key, which is null.

Patch applied.

> I don't know if we have some Reviewed-by: Michael Trimarchi
> <michael@amarulasolutions.com>

No, we didn't do this SoB & Co stuff so far. IIRC it is something Intel
sponsored projects do. Though this is project is complete independent by
now. I haven't really spend any time figuring out the legal stuff. Hence
I didn't wanted to start adding SoB. The reviewed tag seems not to touch
any of the legal stuff. Added it :)

Daniel

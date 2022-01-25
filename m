Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94347168
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 10:57:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B07265CFFB;
	Tue, 25 Jan 2022 11:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643108256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=loyv5x8CWo7M7GtSc92EeF9r8chb3PZHpLAGvFXAaYA=;
	b=Eff67pXGdQLcc5MnjbOeLU8UjA273XNrjdXNTxLYujlfYa4eKL0kv+4fKr/aRGy45pvcRp
	zIpA8dx+ySbr4QBSunCJcfdHYZXlsSXb5DiGaE6r9e+Ze6vM1zWFYtHNjwaLWeJFfPnVTv
	9P58XVYWmLcPPxavZJCRUhLg8Avvcp0q55UuO6AEAZ+ZEr5A5zirDWkpmSctE+qJcTBX6o
	jLKK0Koe3zA//pO4K1231dtxCtMsJwvKuhR28rPzhi34/jpebUX9F6aDfmGjzfli//bXI2
	+VH+ylBU9OKPOq4ihJ7bn8Fnc+RgNKYh0zvhcOpgUPpaxBTyIvgzHEEdqutdmg==
Date: Tue, 25 Jan 2022 11:57:34 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, iwd@lists.01.org
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Message-ID: <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Jan 25, 2022 at 10:43:22AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > I haven't made my mind up yet on this one. The problem I see with this
> > is that we start add glue logic which is hard to follow and I am not
> > sure if this is the right place for it. If you have some more info
> > what's happening I would love to hear.
> Indeed, Daniel it is a tricky subject.
> 
> The similar patch has already been applied for wpa_supplicant
> (cf commits referenced in the commit message), after a long discussion
> if I remember well.
> It is still necessary to manage the transitions between 3 known Wifi networks:
>  - formerly connected,
>  - currently connected,
>  - to be connected.
> In this case, they are 2 disconnections to take into account:
>  - of the currently connected
>  - of the formerly connected,  auto-connecting at the disconnection of
> the currently connected.

Let me add the iwd mailing list here. I'd like to know what we are
supposed to handle on the plugin layer.

For the iwd developers: Currently ConnMan's iwd plugin doesn't track any
networks state. It just forwards the connect/disconnect requests from
the core. Do we need to filter/serialize those?

Daniel

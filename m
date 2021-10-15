Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD712C81
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 09:25:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13FAD60F75;
	Fri, 15 Oct 2021 11:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634289913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hdgYK13uGoxuMSAgSJDsthjl8HaSmy4GXAzLJzx6+6k=;
	b=cdmsRHG8oBWwj2ACRSTwZyY+6ZvA0PpLNYg+l1iQ+FXQvZ4DrVDmm8f7bxK3zvkh78dmjf
	juQSg+3NZm7g/fAAmOaR8e+xjD/llxJ66o9/hT4TuKHymSc8KE8DG1LyqXZ2MR8+pWpJyv
	8hhAcMsvG6yRZFdbpGcWw8SW1BjePpBsrCK6XvfBUQcw6r7N/JNB5LE2DGddN8pn76lCQq
	YwBw83i/R9XstcHLcZdcf50HWCEJ37689I/1W2o0/g0NTMJsFl8Qj84M0akzQFnmRopLsb
	8pHgEM0Dzre1HkNB1o1h9JSfNGKVs5TTk6II+ni/wtlYsIRvk8Ou5ttn4yCFVw==
Date: Fri, 15 Oct 2021 11:25:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v1 0/3] Fixup clang error messages
Message-ID: <20211015092511.lipwpb6xqjgyahor@carbon.lan>
References: <20211012070648.28947-1-wagi@monom.org>
 <MRZP264MB154433CE695C2E97B02500D193B99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB154433CE695C2E97B02500D193B99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Oct 15, 2021 at 08:55:10AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > Based on Emmanuel's patches[1] I tried to get clang to compile
> > ConnMan.  -Wcast-align seems a bit too much for clang so I disabled it
> > for clang.  The rest are couple of fallouts. Nothing serious. Though I
> > was not able to reproduce the maybe-unitialized warnings.
> Strange that you have not faced the same compilation issues.

This is way it's good not all have the same toolchain running. So I am
not completely surprised I don't see it.

> Maybe it is related to the Yocto integration I am using.

I am using the clang from my distro (Tubmleweed). Maybe clang can be
configured to behave differently. No idea.

> Have you tried to activate maybe-uninitialized warning or do you think it is
> not necessary to check this one before providing patches?

Yes, I added maybe-uninitialized but still no report from clang. It's
totally fine to use different compile flags. But make sure you add them
to your commit message. For example the align-cast errors reported by
clang is something I'd likely be ignoring. Some of them make sense to
address but some are not in our hands, e.g. system include headers.

IIRC, your patch fixes a real problem. I was unhappy on the commit
message and all in on patch.

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4282C88
	for <connman@lists.linux.dev>; Mon, 18 Oct 2021 07:27:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5D605E41F;
	Mon, 18 Oct 2021 09:27:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634542024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FjRl3FZyKibBWYCK+xSVXmExyH+OxG19fYEak+Ozo7M=;
	b=DE6N3gCtHPMEFpUh9X9JbPPiFpq0AwDhu/pUs0knIHei/UpHkvCn3skTdxmY6qclFQ+FJk
	LtXfbI+ABOcLnDuA3ngNlpzwHN6rnAVozPZyAfWCW0AoeWN619G/M0wj34vnXL9NujNGAt
	qDIx6aH3NFXJfm6OZHtxGOiOdTIjfjP+OHYIfgm3rBQLG8Bf3EaYBQIr1qYt//6f6p4Ad/
	bShLm+G0k/iouINy2YQ3eZAaR4L4tYuUXa9zj8HVZwVTXkBXsirfXdoQkYyZ9waOn4t129
	j4VWpeJ38E/WWwZCLJn8qJpbMQEbyZn/Ey51SQ/dArFSQZRfEJbBUXHxPrBT0A==
Date: Mon, 18 Oct 2021 09:26:59 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] build: Fix compiler maybe-uninitialized warnings
Message-ID: <20211018072659.37ykm2awn7hevhlg@beryllium.lan>
References: <MRZP264MB15449CB6E42AF281B16F54FE93D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210913072719.3qlnsqjzplntm265@beryllium.lan>
 <MRZP264MB1544BB065A7FADD9BC38F69693D99@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210920072223.l4pgmhaqsfgee6m6@beryllium.lan>
 <MRZP264MB154402D3255D322D8E7CBC1F93A09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154402D3255D322D8E7CBC1F93A09@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Sep 20, 2021 at 08:15:26AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Hi Daniel,
> > My compiler doesn't report them (gcc11). What compiler do you use and
> > what are the compile flags?
> > (...)
> > BTW, I tried to trigger the warnings and I was not able to. Now I am
> > trying to fix up clang compile errors...
> It is on clang-12 (with  -Wall -Werror,, in order to provide clean patches),
> so you will probably face the problem. I let you finish your integration.
> As said in the title, you can try the -Werror=maybe-uninitialized flag.

I've tried again just to double check. The version of clang (12.0.1) I got
doesn't even know the compile flag.

  error: unknown warning option '-Werror=maybe-uninitialized'; did you mean '-Werror=uninitialized'?

Even adding '-Werror=uninitialized' didn't trigger the build failure.
Also the current head builds just fine with '-Wall -Werror'.

Anyway, could you please add some commit message to the patches
explaining the change.

Thanks,
Daniel

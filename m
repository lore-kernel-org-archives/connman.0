Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FC3FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 18:48:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86F4A5E358;
	Sun, 29 Aug 2021 20:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630262911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fZkuOlN0/Q27XCJHJL//IXvC37XyxvD7FS1IYfjz2iA=;
	b=TfQGAkIPs9MHyg0GWUibJOSn7rRjgrG5L9B3vnOoBkGU12bysSW4VRTnbJO/tTHzRQfODW
	msuxvkVFy6ZXrUmgmD6aLcbH7Mmo48iYw+RFb21PzQzBARgKLjN6B4xgrzeI+l+qeWTr0X
	5boncXAH4116A0noCZVw2HZMZlu0rSYq8TYRrGba+dSbdiThnOK64+/Tgx2Zw8NH6R21jq
	WQB+7ctVtMeXuzjMgm1ZdHDH0pER3yt+a5OMgmkrbSloVmdjoGhY040fV8TiS3jljIXaKO
	bFlHyhw1T/mS6wE2Yj0wpQqor0cJ2bU30nxUpxOuO67N7XwizOoaLb/w8azipA==
Date: Sun, 29 Aug 2021 20:48:30 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Ignore state information in service reordering
Message-ID: <20210829184830.ti3pzaz3nchpma7g@beryllium.lan>
References: <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
 <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210706071911.6rl5b2nrooy6lchd@beryllium.lan>
 <MRZP264MB1544E87C75134497E7EBC0D293C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544E87C75134497E7EBC0D293C69@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Wed, Aug 25, 2021 at 12:30:27PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > I need do to test
> > this a bit first though.
> 
> Was there any progress on this subject? Does it still require some clarification?

Terrible sorry for the long delay. Anyway, I tested this change and it
all looks good with VPN. I've applied the patch

Thanks,
Daniel

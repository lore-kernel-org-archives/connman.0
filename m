Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9782C82
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 13:14:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EAAD5CF37;
	Sun, 23 Jan 2022 14:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642943689; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OmUcTN/wyDahAa+mGWOWUIrDGu0fwVNd82DBqfkxWao=;
	b=rJCC06gWFoSmh7u7L1uk9jAgxPvxO8ZQeg3W0PhybUr4jW0ebzKewlWACFuBQxl/freZoq
	yftle3pQ7JLhM8AjHp8creLbLb8rKzNkzs4o5f32tMxjBawGq781+IFfbukEUbXPsvGH+K
	FmQr4Ue7Khc1qe2FIBLk+kEUVmyhMfLoTOSK2bneHQLbsGhmSATGxQpBUVObfF1pmNHZZf
	g7XvLxJ+VlMujilfK4+vL2+Z4/AriinOAFLl6IGdkPB4fVXfohcyRTXKKkdzB/9eoDSQau
	RqD4DJDM39Lkas4MJrZiolPhX0PAm+uXknEy+LLRvEQxWC2vf/81eXpAgNBKSQ==
Date: Sun, 23 Jan 2022 14:14:47 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, iwd@lists.01.org
Subject: Re: [PATCH] iwd: Mark only reachable networks as available
Message-ID: <20220123131447.yxpmf5y3ku6cefu4@beryllium.lan>
References: <20220118125207.1204244-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154437A17FE29544A015748A93589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220121075447.nazzfzcc5h2lcnv3@beryllium.lan>
 <MRZP264MB1544A373628E5F36B3800AA8935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544A373628E5F36B3800AA8935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Jan 21, 2022 at 09:43:04AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > Patch applied. I was not aware that iwd shows networks with no signal
> > strength. Thanks!
> 
> Great news, thank you Daniel!
> Indeed, it is really rare, but I have noticed that during some full test
> campaigns, what I have never noticed (during years) with wpa-supplicant.

Alright, let's add the iwd mailing list. Maybe it's a bug, no idea.


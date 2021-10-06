Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4C2C87
	for <connman@lists.linux.dev>; Wed,  6 Oct 2021 12:41:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D143D61819;
	Wed,  6 Oct 2021 14:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633524089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Gq1gHR+GNU6T3NFszHQsNFia+Qr8tGDRUKN4ir0+BLY=;
	b=04QaqzfICaui/3V9aoB9SIpMC9qlLyqq7asdncyYZFBSi+s1Nc0hwI9LlxKTF6svqpLm3f
	Svnlp+ARvIMM4NgziC15X2vxEMnBxzIjBEwYJUyLlH5UyWdbV4kvch8+9a1sLAv6ie+ay1
	/5oPmQ0O5dnU9R4DQ9hhgHCnbZTUuunqjLLDsfu90wP3Lj0qiCjdXcNtR8LlZpJZr8fw8X
	fi3k3dZM7Dfk48LxybZx0rK3oGsf3Bw9EP67OV67Mo7kc8rNrwI+49Q8fer1Oj4VKO21id
	3/olT+bDpcJXZKUWI83hpJCSZxJlykLwePaK76mZA3gRkoZ1tNsVq0+lagsBSw==
Date: Wed, 6 Oct 2021 14:41:27 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Report errors to user in native mode
Message-ID: <20211006124127.d2qsoc5i2xmzlmfl@carbon.fritz.box>
References: <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <163332924025.22211.16547270907956272336.b4-ty@monom.org>
 <MRZP264MB1544C9BDFA1AF5DC3557934493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <a95004bc-f142-5154-e288-0dbd57fdf900@monom.org>
 <MRZP264MB15444F04C90696ECF5AEEC4493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15444F04C90696ECF5AEEC4493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Oct 04, 2021 at 09:47:47AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> There are probably a lot of codes from wifi.c that still need to be adapted
> in iwd.c.

I really hope this is not the case.

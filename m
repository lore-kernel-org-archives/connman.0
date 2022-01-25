Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5291173
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:47:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD39D5CEE8;
	Tue, 25 Jan 2022 10:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643104043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ssu9tGvZYc3ERhVGNxLwBh/Ab2CjYOmkNelaJ+pJtZ4=;
	b=n1FgG76ARgZYUR9+rXEYIBDLv6X7AGO3SeFmbQqO3V4u4MpxJckqJnlU+8IvbzgyTJRYR4
	5UzS93Wq1PYNPoqBKyqqrqZzCDudGBuDcdrv9nEoUjWds6+6E8mNnjPm05+Sozf0cPccQY
	C9xmnc3dLX7gt2GeRHjVsRxHzQ9MsPPem3KRDnMsRHyLpS4iKRtEW3uxWlrOOgN28BdSjr
	bUsyav1r2bghPnPzyVoHqcocQVR7K4cbUUzvz9/KMR+jWnNaE+pEM61Xr0YkAjK9d+zmj1
	ObfjFyuVu1AOg8dtjQNT/Z/qMb7QPxwyrWpVTlLXcT+BBYgKNuU+q7e+gbIPOw==
Date: Tue, 25 Jan 2022 10:47:22 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] unit: Fix missing declarations in test-iptables
Message-ID: <20220125094722.xq4c3dpii3z4vn3p@beryllium.lan>
References: <20220124093515.7166-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544E155AD12B597E4474458935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544E155AD12B597E4474458935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Jan 24, 2022 at 09:38:59AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> gcc reports with:
> 
>  unit/test-iptables.c:72:5: error: no previous declaration for 'xt_match_parse' [-Werror=missing-declarations]
>   72 | int xt_match_parse(int c, char **argv, int invert, unsigned int *flags,
>      |     ^~~~~~~~~~~~~~
>  unit/test-iptables.c:78:5: error: no previous declaration for 'xt_target_parse' [-Werror=missing-declarations]
>   78 | int xt_target_parse(int c, char **argv, int invert, unsigned int *flags,
>      |     ^~~~~~~~~~~~~~~

Patch applied.

Thanks,
Daniel

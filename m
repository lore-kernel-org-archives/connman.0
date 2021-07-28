Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167613481
	for <connman@lists.linux.dev>; Wed, 28 Jul 2021 06:45:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46C6F61634
	for <connman@lists.linux.dev>; Wed, 28 Jul 2021 08:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1627454710;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=pdh8RaLLrr3AGdNmcVUQwOfv/Gz8GMzMSHpub6jvYZA=;
	b=Qfb4Vn+ygkJuSc1c4sxDdz0QVECyo955FT6F5NPkMaBwN820ME9fMdnDPUX0ilNGvriCZV
	sS8vy7WG6rbVtwDV40pxcoD6penhBNwOVkCcnq4T39yic8rijiCavh1z0sc58+JAC+yc9r
	nH9CwBCK6sot22eCrcp41jBD6+X5wFh1DkK8KH4lpTkIQ4PIPsmiloDPFNUNVSXutdDaBx
	6rDypgGcGJ9IX2fUg/CI+bxFTGZcnFrOSHF8APzrYcuxXINZCSM4hsuSoqRa8URnvjJ+Mv
	EaD0u0JgCigu54DfE2uNIvFpv2CMYB1GY3rCFiEGF2FqIIm6gMylyYhVUFoHgQ==
Date: Wed, 28 Jul 2021 08:45:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] gdhcp: Do not process missing DHCP_SERVER_ID fields
Message-ID: <20210728064508.saghknjrrl46aybn@beryllium.lan>
References: <20210726072958.23281-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726072958.23281-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Jul 26, 2021 at 09:29:58AM +0200, Daniel Wagner wrote:
> The DHCP might send an invalid DHCP response with a missing
> DHCP_SERVER_ID field. In this case just abort the processing and
> return to the idle loop.
> 
> Reported by Mike Evdokimov.

Patch applied.

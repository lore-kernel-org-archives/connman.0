Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5628EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:20:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97557DB017;
	Tue, 11 Apr 2023 09:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681197606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=D/iQO5ccji+QlXIFCz/YD4tNUEPUKf8aAuqk7aw7Goc=;
	b=rqD73pXY9P33/5AaPpOQKbTV/f8d5Er+r4trjDHRz33zaR8q/gyg1h3uBLsub9x49Y+6EA
	N4ztqW9BM3wSewYrFXpRM8MMDwmlsoPTotSN2div9x8HAoaT+G/OzjLSpmRRPYztZw8AhW
	adI9zYAmy2N2EmX3O6Y5M0woQTtVCrGj+em9ry/8c1O6jFv+YujngfH5PGenIbB58rMIwJ
	OQNxV2N4DDalBJfuXxCcJD1aicZHh860AnVgQp8+VSfxvHsGCLCFPrtLp7m3ksIhEdUQK3
	NgJMZ1uGdV/cik4mCB1seydWAPNjPGfxxQ1DoDN4Ni4c3LZR2zRisQZkZsi99w==
Date: Tue, 11 Apr 2023 09:20:01 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] network: Keep failure state after disconnection
Message-ID: <20230411072001.emdwmpudvggcuopi@beryllium.lan>
References: <MRZP264MB15448014A6E161ADFD0A280793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544A26A7D6EBCEB14A0B59793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544A26A7D6EBCEB14A0B59793AF9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

I've applied the patch. Let's see what it breaks this time.

Thanks,
Daniel

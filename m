Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540A3FEA
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 08:41:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 673935E368;
	Mon,  4 Oct 2021 10:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633336878; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6XTnAMmS1YqNLK4BsyXcgkFVCaSq7Hwmpb8QCPjKKJY=;
	b=TUzdkD1TZHDrOLox1h+pm/rIdPxJhurNMUeRsjgvg7AcnO+m9iONEqYsHBSW/TjvydBVwY
	CIg5Y3IQDI4zihRerc/Yc2OhD7tuYVUhMBjW7N0ituRROnhcE6fzOfHnUsDrTOynL74gG8
	zQlkoSE1iOxveL6/SwDixMirU//f8/Yb+yLLG61Ppj+RPb7V0PdWHX84eN82g6gya4aPFj
	t2pGSCVOYfJVO6FTfMPz1+xdp5pkoMI8k2rOeRoncqZ46P/4tVdam17aDZqlqtvqi57xr0
	d5G/ZoYG0Oj+d+GeZIrRK9kR2vzVjWl1mbrF0Ujsc6yr2xzYtOFhdNWj3C5XuA==
Message-ID: <a95004bc-f142-5154-e288-0dbd57fdf900@monom.org>
Date: Mon, 4 Oct 2021 10:41:16 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] service: Report errors to user in native mode
Content-Language: en-US
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
 <Emmanuel.VAUTRIN@cpexterne.org>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <MRZP264MB1544E59B5B25F0CF95C7A07993AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <163332924025.22211.16547270907956272336.b4-ty@monom.org>
 <MRZP264MB1544C9BDFA1AF5DC3557934493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <MRZP264MB1544C9BDFA1AF5DC3557934493AE9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 04.10.21 10:08, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
>> Applied, thanks!
> Great news for this patch and the others! Thank you Daniel!

I was blocked doing the stable-rt update, hence I had no cycles left on
ConnMan. Now since the stable-rt release is out the door I try to get
the clang fixes sorted out as next.

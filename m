Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DE3FE6
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:18:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C168F5E30A;
	Mon,  4 Oct 2021 08:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633328317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6P9ckytGo42PgJzeQ0VXTGwFgmEDbk49tnS3YMzjvgY=;
	b=0GxqRCQmasOBLtFeEiYGV3F9LlQrcYKhezw2KdYAj2kwLpAjXiHqfdxcEkIfUaRKUBAqx1
	0cCJTHer5XE1Na47Y3w9mcfyvjeYMzgOoyhQQDvhe0Xn07fVMVCAN2BUgfV/cWcyPy+EDr
	ILRxPXyjdhzdyqFQ0e+Av7NmPKu1VIbHpFfqjZhdIetfKXtliFjiq/vecDL13TdJPnU4lN
	snI/jgHZKkTif7gUWhSZdBbamdHXC5CuDqW8POm1VdIeGWWucsLWmKZaijwqI5muJs3eOD
	j4+SQNBGeFGwMgh1zBhc/9HvueUVFYqkQGlHG2vVGQ90L2dL5aRcaibCoTeEkQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	"VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] iwd: Fix missing Ethernet attributes
Date: Mon,  4 Oct 2021 08:18:30 +0200
Message-Id: <163332826307.17185.10768727071680873765.b4-ty@monom.org>
In-Reply-To: <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <MRZP264MB1544A93191E9041F8D1C61C393AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 1 Oct 2021 12:13:49 +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> The Interface, Address and MTU attributes of Ethernet Service property
> were not retrieved because the interface index was specified to late
> (at network connection instead of creation), preventing the access
> to the corresponding ipconfig.
> 

Applied, thanks!

[1/1] iwd: Fix missing Ethernet attributes
      commit: dd7d4be53b9a6ca58cf8880d605fb5711ba5325b

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

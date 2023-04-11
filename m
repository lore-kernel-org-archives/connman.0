Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6552F26
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:40:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18072DE3E2;
	Tue, 11 Apr 2023 09:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198855; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l4PbiwZ7i5k5ex7ndiwNuyKpXiwv7Th2whwNzAg1cig=;
	b=jmXFBMuDgJi56+g6KB6ewj/naxbj6esdm+AbpUgqbvnFM6QeaROIyGaX/kCdNV8PJOJXn5
	nC3aDdzmK4OqT0r0y5Uz1ny6NAUNKqOzF3FUQ33D+G5TUuPvsKVuct7HwNwTT0toMag6dw
	GnYQmR4FuBznmbJ3SOCanvXq+Q7YOFWheUWm84GmdJxxeZpsOiHb166Xh/R1kvVM0Hztny
	HvsIZHvgVl9xZyjjOvb69pDImMf9PSCE5QOvZTW2hOlvk2KJH5OO3zPUNmn9Oxk2x+Y+ro
	++jLza5Cuem3R0BPiURLXCIEwhPEh3ianxRM6f27gTsnDVl3Dr4kWsCZhwdg5A==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Jonathan Liu <net147@gmail.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] rtnl: Ignore adding/removing interface to/from bridge
Date: Tue, 11 Apr 2023 09:40:51 +0200
Message-Id: <168119884409.12976.791407165164565939.b4-ty@monom.org>
In-Reply-To: <20230401235919.111754-1-net147@gmail.com>
References: <20230401235919.111754-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On Sun, 02 Apr 2023 09:59:19 +1000, Jonathan Liu wrote:
> Avoids wifi interface being removed and added again when tethering is
> disabled.
> 

Applied, thanks!

[1/1] rtnl: Ignore adding/removing interface to/from bridge
      commit: 64ba5d457c77ebb65b0a23910d26089973fb6ce7

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

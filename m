Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF372CA8
	for <connman@lists.linux.dev>; Tue, 26 Oct 2021 07:05:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A56DD5E41F;
	Tue, 26 Oct 2021 09:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1635231907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7UcgTRccGBH7QYO98zTn/2hHFkXqThMSLzKV/n54TNQ=;
	b=is02TWYz/KuMb3sz3SMvO2o7oNa9gfBFXh6DeL0kVY8bQd6F1nhGC4kF0Lc+8i73mO+1AE
	+80zS4wYJzqjeEknksZCeIok9sGj2luAXi9/fQ7Zo5nicm2XWCDhA+M3wAs/K/mA9Lxrzp
	+NSi5KlNEyJR7L7mEJ4896AXFZfHp99gKW3btWm3nY4Xg5lJ8JaMxrISmMTPtiw5VFAV1r
	hjLprrql6syRU2s/AUqJziyAbFeMw/yFvPbNVIQ2rP6zK5ULZ3zJH3enyIMRr0PuK/JnxQ
	CSWW2nvA2bbCvI/i9H7iZ2bqGjO/poWftBoVbf8JljbwUcsLTKTcIFwxnB7+6A==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Michael Trimarchi <michael@amarulasolutions.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] tether: Fix connman_technology_get_wifi_tethering
Date: Tue, 26 Oct 2021 09:05:06 +0200
Message-Id: <163523189560.6082.12628534147697557953.b4-ty@monom.org>
In-Reply-To: <20211023214953.5606-1-michael@amarulasolutions.com>
References: <20211023214953.5606-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 23 Oct 2021 21:49:53 +0000, Michael Trimarchi wrote:
> The function is called from tethering, so the tethering is not
> yet enabled. We need to workaround in order to get the right
> value
> 
> 

Applied, thanks!

[1/1] tether: Fix connman_technology_get_wifi_tethering
      commit: bc26ab84e4a77950104c6c60609b549b9ce2830f

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

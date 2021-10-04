Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56D3FF4
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:34:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73D20617D6;
	Mon,  4 Oct 2021 08:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CVoODY6n+HFqxMqGaCYNTn+ZA0iKrar0VJp5qwXGLqA=;
	b=RRQkOKw1/mc92kz7OUqgjU3KQ55A8zxUT76Lc3GsdP2cm2zVOFL36/Juw9sV1rYWs8egTg
	vNMlmQh+929VuJibFfcdbg/CbwE+tkTVTWFTUKQYI+SApuqU9PowVVg6cIgg4lZubYtJtE
	QKUSJCg90uzw1RtGfULB40XH3cSzqOlROJYnNkjtr5k0t67+QEkhfRfzHD4FZfmGBCngo8
	8yi2fInWw6MzMmGnjQV02K074ltb2Ww/zP/zdVWaR2FHZW4jATjF+9NOfXhCPeGGxmpiRk
	qMjsTwRExldIEQIXZBpyrynh5NUtH6qrLcp0A5cUTqEt8NB/euULqv2oZTdJVw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	"VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] iwd: Fix timeout error on new connection
Date: Mon,  4 Oct 2021 08:34:08 +0200
Message-Id: <163332924025.22211.10756413438388718853.b4-ty@monom.org>
In-Reply-To: <MRZP264MB1544D8BAECCC6E7436D85D4F93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
References: <MRZP264MB1544D8BAECCC6E7436D85D4F93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 1 Oct 2021 12:18:32 +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Before connecting to a new network, the currenty connected one shall be
> disconnected, what always failed with "Operation timeout" error, as
> the disconnection seemed not completed, cm_network_disconnect
> returning -EINPROGRESS on success.
> 

Applied, thanks!

[1/1] iwd: Fix timeout error on new connection
      commit: c07d5b11f122d2115b9f466f3106c144c315dede

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

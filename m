Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87232C8B
	for <connman@lists.linux.dev>; Wed, 20 Oct 2021 06:08:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7ABF65E359;
	Wed, 20 Oct 2021 08:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634710102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5nUUZP/ybB+ca3olpk9GhBPo08edYJfrMcrYexpwQ2k=;
	b=MMkmK3bqWFzXu0+HpMEEm/gQl5Yv+CqibgRKK1AjrpaFzMX+peWHVH6x5NzxKw7r0Bn7o+
	VDeOW1wCmJI40J8O9AGD0smeQNIbsEh4pKOXNHAqBXIYM+iasQ1jvoqpC8LfaShWe9KZnK
	OVYqhNzaCNn1ZaFBYdOUX17fAd+0begvXoebbrJbspNFyV4tiCWsvfvSDby/AY/HzWWawh
	f3rNGaId7X92mLkXo+fuWxNPyZYMs+giTHNVrpDJUDxWzpUOuHbQc6HImYDc5qOVb1TyNw
	ODycqUrFyFgZDf2Huxem/fdnShRZoHrWPhsh99oSgaTTwlkV8ppCynn8IFljNQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
Cc: Daniel Wagner <wagi@monom.org>,
	Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: Re: [PATCH 1/3] build: Cleanup of iwd provision_service_wifi()
Date: Wed, 20 Oct 2021 08:08:16 +0200
Message-Id: <163471007023.5510.6880163764440514969.b4-ty@monom.org>
In-Reply-To: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
References: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 18 Oct 2021 10:16:00 +0200, Emmanuel VAUTRIN wrote:
> gcc reports with:
> 
>  src/config.c: In function 'try_provision_service':
>  src/config.c:1421:3: error: 'ssid' may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
>   1421 |   provision_service_wifi(config, service, network,
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1422 |        ssid, ssid_len);
>        |        ~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/3] build: Cleanup of iwd provision_service_wifi()
      commit: a75b0693ace6e226cfc15e0a1534f7e2cbf3f47c
[2/3] build: Fix uninitialized errors in iptables tests
      commit: dff52fff9b26065e433fedb73ed259d82f06ac73
[3/3] build: Fix uninitialized false positive in dnsproxy
      commit: fdbdaab520726afdb07cc042eb159392aa4fc9d6

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

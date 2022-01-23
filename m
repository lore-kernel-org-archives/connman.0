Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EA2C82
	for <connman@lists.linux.dev>; Sun, 23 Jan 2022 13:23:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1B4B5CF90;
	Sun, 23 Jan 2022 14:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642944231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Hv5rVwbHMnwPsBvxu1M8s1ik94ZKHldhf0RH9EcH1yM=;
	b=pc9zMcLxcSLSyUNKmUKrWxwzuAgjBPziBdXHJeB9LxnxqGOWxqKq9v66so5vxo1NosmorD
	wmlu+U9pfFPedEuOjweKxslrgPj6hyv5Ow579RrgKfd1FXfXQfsrFj+7TgS5LqoZq5/XVi
	aevpXQPuLg8R7QQFcmERwpbuvCE1MyN6q906rNydCAdaBQqh6K7JSGH3/eVOeOVUzp2WY/
	VSFWc+9Xnkvb04jZGTmXtRYUrY0DcTXxwCU/76C38unxOEtdN92I2X9baO9SDL+4mqXLQV
	/ipVHduJjvSvE9fewGqOB/YKpXGNmeD8m36qC3Hp4Zf575NbGG1IbqgG9F55bw==
Date: Sun, 23 Jan 2022 14:23:51 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v3] service: Fix native connection with wrong passphrase
Message-ID: <20220123132351.ppud4auaysfmcfx3@beryllium.lan>
References: <20220121102736.3323889-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544B85627F19D2599911150935B9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Jan 21, 2022 at 10:36:52AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When a native connection fails with a wrong passphrase, the user still
> needs to be informed, via the agent.
> However, in this case, the associated service is automatically
> disconnected, canceling the pending agent requests.
> The invalid key error shall be reported before this cancellation.
> 
> Commit b9a0a039ccc5 ("service: Report errors to user in native mode")

Patch applied after reformatting slightly.

Thanks,
Daniel

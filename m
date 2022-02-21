Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642372569
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 16:44:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6278A5D3FB;
	Mon, 21 Feb 2022 17:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645461883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UhHK6Ug1FN6/6RbmR1fd0DSXZb5vGz51XuNOmxucnXg=;
	b=AgvV9IhwUbNWJXs1MqDh5XFyELF8MFbA7cHBW/u0lNvQFV6wcV6kiG/gMW8IXo/DQkmzpN
	cw9Qpcam1yYXROQGoUewjhTDTMabS90tFf0JetOGLjIV4v9PhFJKz+dg++WR0sPHzfR6Ax
	vuc/ZoKtFkFIt/5ch9RJi637JZH4TW3rb/nZTWzUXJTmER2n9Zw0OT2Jzb9ZcmZMFB+iW7
	5ObSeaJWOZzznBQvgln0d/xHCLY3kTGpy1gwp6Ycih/mMBEX5jWFEOzydlq0Vxv+xfzWsu
	vslMlrvmOZran0zzmqepDuJJxT3LNIs1zf29nLpwho+aw+VNW7HbK4rBVCygvA==
Date: Mon, 21 Feb 2022 17:44:42 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Denis Kenzior <denkenz@gmail.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Message-ID: <20220221164442.gsg6krtdalemte62@carbon.lan>
References: <20220124085336.3641685-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB154447165B86A88033C533B8935E9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125095014.eafpxusdnc62mbjp@beryllium.lan>
 <MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
 <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
 <MRZP264MB154403938B0F44F5C05841D8932C9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544C7DAF7A0AA3942D9FC1C933A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Mon, Feb 21, 2022 at 09:10:09AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Do you need more information about this subject?

Yes, Dennis asked you:

  Is there a particular scenario which isn't working?

As I said previously, I don't like the patch as it add complex logic to
the plugin. I would prefer we really understand what is not working as
expected. Maybe this is something which can be easily addressed in iwd
directly?

Daniel

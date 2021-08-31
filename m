Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD693FC2
	for <connman@lists.linux.dev>; Tue, 31 Aug 2021 06:58:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F03C25E3F6;
	Tue, 31 Aug 2021 08:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630393085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+HAUlGYCwhmmKCHZH+N4RYfa9BQZtoVbyb+TikQLhrA=;
	b=SYVgRUMItxNB8DQz3sUMONC/eDeYWOnn0NeEOZPkU96ojXRf+yEYpwah0bDDVvtTKIbDkL
	eZNcAMFyUDg8v93mAUtMWdV0Ug6CFMKET/ru8uQThDUDlMgq1jAYE/frzcxh+pLh9P+1yC
	3iqB+D0MqwJdrD6Xla2UDKGJP472z2P7V9q5XSgHEOv1GbQJyywbBV5GzrANJyi35eRP/V
	XBDDkGaoaJrFfCSuijSuLL9mmgVhSbr9KGBfRj/mNbMxZd9g1f1zaphh9DWVTRboDUIXon
	ZpefpaoN+OuiXHSrNw2VTA+1kb5qrveK8FoqeAPV130ho7brmIVKQyRTJV73Gg==
Date: Tue, 31 Aug 2021 08:58:01 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] documentation of new openconnect input fields
Message-ID: <20210831065801.bnyoxetffyhc2z7y@beryllium.lan>
References: <6068893.KbCWHUxhU6@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6068893.KbCWHUxhU6@latitudemachine>
X-Last-TLS-Session-Version: TLSv1.3

Hi Lukáš,

On Tue, Aug 31, 2021 at 07:22:47AM +0200, Lukáš Karas wrote:
> Here is documentation of new openconnect input fields.
> 
>  - authentication group (OpenConnect.Group)
>  - second password (OpenConnect.SecondPassword, OpenConnect.UseSecondPassword)

Patch applied.

Thanks a lot!
Daniel

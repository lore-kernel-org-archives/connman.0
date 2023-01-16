Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B41363
	for <connman@lists.linux.dev>; Mon, 16 Jan 2023 07:57:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 097F9DAC50;
	Mon, 16 Jan 2023 08:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1673855836; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Uh9ra74bn5GSEfLHHlTeNxshwf2At3YaeXYapD8+5BI=;
	b=neePDYJZB3BYiXfCApYE4v6uxw0hqGdHPJoxcuBmEoxMEhzNYcpp7howOcKkXTWiND4rLU
	Jczlij46AkJ9QfUzmgRchx4n4arRttvMckUybSXYR4a5006S80GgJPyJ9n0FYOtBqWbLEx
	FHYkj1pRe1fWfZ++sp6O/sOfEIkHqbS5EqfXQs7iu1Fuh3k8mww94c/+CWyuFSXz9OBJKo
	J4TfwC21Un2XHkbu+96iT0aQJ+QjZtnKmVyojh8jiaZ8CnDvEkrpNsXi4qGll5Q3ugqTQR
	KgbB7zQj3mPUJWhzbRiVH0kQHnQYdxA6xX1SUIooQ26EwcMjBb2fwPGxEJonpA==
Date: Mon, 16 Jan 2023 08:57:15 +0100
From: Daniel Wagner <wagi@monom.org>
To: "Stahl, Michael" <mstahl@moba.de>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: dhcp-client with fallback IP
Message-ID: <20230116075715.4hoi4vref43e5vdq@beryllium.lan>
References: <AM9PR09MB4756C6950B763CC9F2A8887CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
 <AM9PR09MB47564FE0CAD5E5553184F12CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR09MB47564FE0CAD5E5553184F12CDBFF9@AM9PR09MB4756.eurprd09.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Tue, Jan 10, 2023 at 05:43:49AM +0000, Stahl, Michael wrote:
> is there a posibility to configure connman to use dhcp-client

ConnMan uses only the build in DHCP client and has no support to use an external
DHCP client.

> and in case of timeout or x retries use a static IP (fallback)?

ConnMan has currently only support to fallback to IPv4LL and not a static IP. If
someone is willing to provide the patches, I am glad to review them.

Thanks,
Daniel

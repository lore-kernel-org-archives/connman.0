Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AF72
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 18:27:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2EC160F52;
	Sun, 29 Aug 2021 20:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630261655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=F2UxTb9Iq46FDsMWP1sexE94vlIlDijwbVopHzYy8vM=;
	b=RY9CibDGohU+tlVlI3HacTJUsTG/gktJzJPgfjZBwHssJUlgmtVH5d0CMZidw2WguLtYDG
	IDPOjur8MbP3fRr40XoN2gOxvNIm2PK0NWGW6LRkkn5SIbrrMAExZEOGlE88jBRO9wt98F
	w9WRHP2BKZrhhUeBme09GbIGYG7HAZlkXOCuLmXLW/G6V2PTRr/Z5u4dVMm3pRB4b6oqan
	xgqUmDjCzr89FjyGI+RVP7tukUG91BfInbf/K5Ykc1indJCPKoj0Ist0VREVE2O0KA4dfX
	uJJdedn68htRq3IdVhOSQnZHqXxSpA+hgIA6OlrVgZWI7mhLUPQ6dTe7BKzGJg==
Date: Sun, 29 Aug 2021 20:27:35 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
Message-ID: <20210829182735.yfulxx4f2lwrhxlw@beryllium.lan>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
 <5f76dcbc-8e93-61fe-8d7b-6b0aa7bcb786@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f76dcbc-8e93-61fe-8d7b-6b0aa7bcb786@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Aug 19, 2021 at 03:40:04PM +0300, Jussi Laakkonen wrote:
> But the issue is about VPN agent usage actually which is caused by the
> different - and quite possibly invalid use of VPN agent in our case. We
> always have an agent connected so that is our OS specific case which after
> all these years I completely forgot. But after checking with AntiX the issue
> is completely different. I need to dig into that again.

So the patches are no needed?

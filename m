Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6E3FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 08:11:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 490DB5E358;
	Mon, 30 Aug 2021 10:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630311094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2+Og8kgba4mVjbKtyptI5I7HxvGryXrzwy8nOj4UMHw=;
	b=Pq2dkGJYMReHKKyL50Y78qRXG86zLu9FVQgxgl1KX2AbcYmwJ9jhKEbc51Tfo9FrBM0IAR
	KJC/zeWEYNOBNQ/TxPqgDNGK9CfmAIzBMud8rn/xKSI8WDemjXl7A3MOxK0ovwMf7uzKgO
	iYsa9hvERmgBxfCvnTWkIAuA2DFySvEJI8K+k6AAYRg9pl8muvq/HMrQ9qBzb+FtDMzCO7
	eM11/f8v58TMGtaYx9vvJ91xxNtKFQ9L+/azXtwq5AUEvYxZzJXjzzRw+KWHyZCHSoQU2F
	ZWbQLIW9FMvWsuqZb42V0ElvsORPjxIl5fJR2o/eviR0Wo2/DoEEeLLP+eY2xQ==
Date: Mon, 30 Aug 2021 10:11:32 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
Message-ID: <20210830081132.kknkwxejkjek7vtx@carbon.lan>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
 <5f76dcbc-8e93-61fe-8d7b-6b0aa7bcb786@jolla.com>
 <20210829182735.yfulxx4f2lwrhxlw@beryllium.lan>
 <5eae634b-1abd-a752-7a11-9255b051ed8c@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eae634b-1abd-a752-7a11-9255b051ed8c@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Mon, Aug 30, 2021 at 09:59:59AM +0300, Jussi Laakkonen wrote:
> Sorry for the confusion. I think they're needed in order to let vpnd know
> the state connmand is in. The issue was in relying a VPN agent being present
> at all times which was a misunderstanding from our behalf because in our
> case VPNs cannot be connected without an agent.

Alright, I'll give the patches a quick test with my VPN use cases
later, just to make sure.

> So yes, I've updated the patches [PATCH v3 1/2] and [PATCH v2 2/2] last
> week, as I took another look on the old code noticed some issues to fix as
> well, which are included in the patches.

Ah okay.

> Do you want me to send them as one new patch set again or do you have some
> comments on the contents of the patches?

The look good IIRC. But yes please, send them as new patches again. If
possible not attached to this thread, this makes it way simpler to pick
them up from the mailing list.

Daniel

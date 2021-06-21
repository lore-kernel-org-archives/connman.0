Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004E71
	for <connman@lists.linux.dev>; Mon, 21 Jun 2021 07:30:03 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 537AA50064D;
	Mon, 21 Jun 2021 09:30:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 230F65002C0;
	Mon, 21 Jun 2021 09:30:01 +0200 (CEST)
Date: Mon, 21 Jun 2021 09:30:00 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix preferred service reordering on ready state
Message-ID: <20210621073000.uz23zb7bv2qmchrh@beryllium.lan>
References: <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
 <PR1PR02MB47943483C93F21149F412B96930E9@PR1PR02MB4794.eurprd02.prod.outlook.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR1PR02MB47943483C93F21149F412B96930E9@PR1PR02MB4794.eurprd02.prod.outlook.com>

Hi,

On Thu, Jun 17, 2021 at 10:22:18AM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > The thing is that I've been doing similar work on our fork and the end 
> > result turned out to be fixing the sorting of the services.
> Great.
> 
> > It does not anyways seem to be quite feasible to first let the sorting re-arrange 
> > services, then with these changes make exceptions based on a specific 
> > state, which then will change after the services are again sorted?
> > I haven't submitted our changes to upstream just mainly because of 
> > historic reasons there is a bit of a different approach in use with 
> > service.c. This hopefully changes when there is time to check all things 
> > and get the fork closer to upstream. Our for does involve a slightly 
> > stricter approach [...]
> > and the unit tests (that are not yet 100% complete) [...]
> I have no opinion about that, my knowledge of this part is to light,
> and I have just a limited time to spend on it. I let Daniel check this
> part.

The whole sorting logic is a overloaded with corner cases. So I am very
careful with any change in this area.

> > But since this is about allowing to follow the preferred technologies 
> > list that is being set why not do it in the place where the list is 
> > already utilized for sorting? I mean that as there is a clear reference 
> > to prefer online over ready state so the preferred technologies list 
> > should be as an exception in this regard.
> > Your approach works but I'm not sure if there are some corner cases 
> > induced by this approach. These are my notes on this matter, I hope you 
> > consider this proposition.
> As first step, I have just proposed a direct fix based on current implementation
> (also fixing the service state update notification), in order to limit
> regressions and quickly be integrated.
> In my opinion, the second step will consist in a more consequent work,
> based directly on the sorting itself, what Daniel has probably also started
> by his side, but of course, I let him decide the best way to follow. If required,
> I can try spending some time to test the final solution based on your both works.

There were already not trivial fixes for this section of the code
[1]. It clearly shows that there a lot of corner cases to be
considered. While Emmanuel's change looks innocent, I can't really say
it doesn't have any unwanted side effects. As Jussi points out, the
initial problem is clearly in service_compare() not utilizing the
PreferredTechnologies setting. My suggestion is to use fix first the
sorting as this seems to be something we can agree on it.

Can we agree on this one:

   https://lore.kernel.org/connman/20210621072036.302-1-wagi@monom.org/

? And fix the remaining problems in tiny steps?

Thanks,
Daniel

[1]
5bd396590fdf ("service: Send state changed signal after downgrading state")
82c0faebfe4d ("service: Notify leaving online state when downgrading it to ready")

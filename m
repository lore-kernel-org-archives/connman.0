Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC3168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 07:41:04 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id C5CE6500587;
	Fri,  2 Jul 2021 09:41:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id 9084F500289;
	Fri,  2 Jul 2021 09:41:02 +0200 (CEST)
Date: Fri, 2 Jul 2021 09:41:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Fix default service update on ready state
Message-ID: <20210702074102.7rmohctvgqzzn6fb@beryllium.lan>
References: <PR1PR02MB47948663CF8C18C7FD1AAC6693089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210624080757.722whwmmwrnzffvb@beryllium.lan>
 <PR1PR02MB479436EEC3170C99AF90C46E93079@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702072703.ye5a33wi7jk6qbyf@beryllium.lan>

Hi Emmanuel,

On Fri, Jul 02, 2021 at 09:27:03AM +0200, Daniel Wagner wrote:
> > > This is needed on top of my reorder patch?
> > Indeed.
> 
> Okay, this one is easy to understand. Patch applied.

After looking at your other patches I dropped the patch.

By moving default_changed() after

	def_service = connman_service_get_default();
	service_update_preferred_order(def_service, service, new_state);

the result is the code doesn't make sense anymore. Why calling
service_update_preferred_order *before* we change the default?

This is the very reason I am pushing back against these changes. They
look innocent and might even work for some cases, but anyone later
looking at this code will scratch his head and will say "this doesn't
make sense". Also The commit message saying "the default shall be
re-evaluated" doesn't help either. You need to explain why you need to
change the order and why service_update_preferred_order() should operate
on the 'outdated' default route.

Thanks,
Daniel

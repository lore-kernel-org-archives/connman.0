Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85970
	for <connman@lists.linux.dev>; Wed,  9 Jun 2021 06:54:11 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 41044500517;
	Wed,  9 Jun 2021 08:54:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 0A4645002C0;
	Wed,  9 Jun 2021 08:54:03 +0200 (CEST)
Date: Wed, 9 Jun 2021 08:54:02 +0200
From: Daniel Wagner <wagi@monom.org>
To: Andrei Datcu <datcuandrei@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Manager::ServicesChanged properties
Message-ID: <20210609065402.xy2ggiiv3ohcccqo@beryllium.lan>
References: <CAAmFs7nJNeKJG0Bitgwy4dpautH9hV1pCiSRiHoj8fX_b5ksvg@mail.gmail.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmFs7nJNeKJG0Bitgwy4dpautH9hV1pCiSRiHoj8fX_b5ksvg@mail.gmail.com>

Hi Andrei,

On Thu, Jun 03, 2021 at 03:04:10PM +0300, Andrei Datcu wrote:
> Currently, the documentation states that
> 
> The dictionary with the properties might be empty in case none of
> the properties have changed. Or only contains the
> properties that have changed.
> For newly added services the whole set of properties will be present.
> 
> 
> Yet, the final paragraph also says:
> 
> This signal will only be triggered when the sort
> order of the service list or the number of services
> changes. It will not be emitted if only a property
> of the service object changes.
> 
> 
> Combining the two rules, I understand that the props dictionary is
> either empty (for existing services) or it either contains the entire
> props dict of the newly added service.
> 
> My question:
> 
> Since by inspecting the code (service.c::service_send_changed) this
> seems to currently be the case, is there any particular reason why the
> documentation doesn't state it explicitly?

Don't know, but I suspect Marcel wanted to stress the points
independently.

> Was there ever the possibility to get a partial dictionary?

As far I understand the current situation, this is not the case.

> If not, would you consider a
> patch to the documentation to make it clearer for the future?

Yes sure, please just send a patch.

Thanks,
Daniel

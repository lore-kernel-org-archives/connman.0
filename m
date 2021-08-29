Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50B29CA
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:37:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C2B660F52;
	Sun, 29 Aug 2021 21:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630265873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=juC1Ib8TMJksL8ZnnRvt+KBOy81XTdC+gJ2kuzBZBjU=;
	b=phvz9pIP28nWv3zeR/pG2baspVQyyuECWlOM0yuU8Aqj2e3fqsLN1PNueF8QZmToq9PvOW
	Fmf1mzZ9DayCdch3RZuKl6lMtXiFEwA7uE9WdXWnlBKy00iV4rq8fnrBI6RSlmmwWityna
	osGYqcvTfisqB9PE5i03Howz80w74RuafrBEYwxfktP7PrIx2nChhwm6NYqUwCjL4yfh9r
	buiCeRBtbhD9Z6IG4GSUs1FdBuuMyM6PbqpUOX2BSsh/gKmTcOJinbw6qYENSRRqUFN9Nb
	rvHcz2tL56K6nDxMe4EE+L9tAaK5Rd6QaFLNEzV3p36wabpInbl4IqMFGktzoQ==
Date: Sun, 29 Aug 2021 21:37:52 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Athimoolam Rajkumar <Rajkumar.A2@in.bosch.com>
Subject: Re: [PATCH] network: Do not disconnect decice on network connect
Message-ID: <20210829193752.kbxqmvvqr2nwvpeu@beryllium.lan>
References: <20210829193240.19095-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829193240.19095-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 29, 2021 at 09:32:40PM +0200, Daniel Wagner wrote:
> Initially, commit 3b6dd9aa9030 ("Add support for disconnecting
> networks first") introduce the __connman_device_disconnect() in
> __connman_network_connect(). It was there to allow autoconnect to
> work. The initial code was checking if only one device should be
> connected:
> 
>     mode = connman_device_get_mode(network->device);
>     if (mode == CONNMAN_DEVICE_MODE_NETWORK_SINGLE)
>             __connman_device_disconnect(network->device);
> 
> The service state machine has evolved over the time and this
> check is now part of the main service state machine. Though
> the code snippet in __connman_network_connect() was updated
> (the mode bits got removed) the disconnect was not removed.
> 
> For 1:1 mapping between device and network this is no issues. But in
> the case of oFono we can have several APN/networks per device. Due to
> this disconnect call it's not possible to have several networks per
> device. Let's remove it.

I've updated the commit message slightly and applied the patch.

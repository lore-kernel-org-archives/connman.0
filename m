Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5983214
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 14:13:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A8625DE8B;
	Sun, 28 Aug 2022 16:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661696034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ot6XBEY8TYO/BVYDjndBsktQBKvFSgxWxSnWbRMfJE0=;
	b=MLN0N/YBYckC4T2dII9PVV8/+BwIkjQuwoKgL2rqKqWFSts0dJSwOHETMt2rIGjLqJ0lib
	ySOWtEvmMKy+3nZftoG1EBw4QKTn7aI7/Wp6H4357nD+gBnR9zs/wm/I6Di8i3+K5By2lo
	y/E6qOkSX8EDoaMq2tBAzRNfLlr1rqO1tYjkVcp5xA0zpPyHPJIKwb8sxYBuxYLZbX3Mp0
	5rFb1MEhugR0/aex7xIz15AFzyjkB5HZ8B0MCOiLSkToVMfuJ93lTXqOOYhgvw2s6MnriQ
	orx2JpZYnxunBh75q8VIXFS/icF8ivei0xx0QnyL1EWqL9bk3HAwQd2iFRGV9g==
Date: Sun, 28 Aug 2022 16:13:54 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: Service state change is not emitted on net.connman.Service
Message-ID: <20220828141354.3aav75s2jn2hkbpc@beryllium.lan>
References: <4df95b51-0da9-6bf1-967f-17bfe8cbf782@jirutka.cz>
 <20220711074551.m5ohm74noepd4s45@beryllium>
 <7711ed9c-9f7c-75d8-9be8-dc205af13022@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7711ed9c-9f7c-75d8-9be8-dc205af13022@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On Wed, Jul 13, 2022 at 03:23:21AM +0200, Jakub Jirutka wrote:
> I’m beginning to think that throwing away the PropertyChanged signals within
> 100 ms wasn’t the original intention. It’s a result of two requirements that
> are implemented in a contradictory way:
> 
> 1. Don’t send ServicesChanged right after each change, but aggregate the
> changes within 100 ms interval and order service removals first.
> 2. Avoid sending PropertyChanged for a service before the ServicesChanged
> signal with this service listed is sent.
> 
> I would start by asking if both of these requirements are still valid.
> Why sending PropertyChanged before the service is announced in
> ServicesChanged is a problem?
> 
> If these two requirements still apply, what about postponing PropertyChanged
> instead of throwing them away, i.e. accumulate them in a queue and send
> after the related ServicesChanged is sent?

I came to the same conclusion. Those requirements are contradicting
each other. The 100ms requirement sounds like a fix for an UI which
can't handle it correctly. I think I would just remove the 100ms thing
:)

Daniel




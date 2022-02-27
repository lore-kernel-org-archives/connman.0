Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AB4A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 18:12:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 572545D44E;
	Sun, 27 Feb 2022 19:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645985554; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JIdXE2VhliJe09ryMr8Vst/dI8XHvfm4xxEVDlms93g=;
	b=Jenhi8JL3HXehRK3Ec1rtKAzpThfLM43Pu24uTIZW81UJJ4Pge6QMJZGjGGCkelrVX4L8+
	76r4eiHuZtZCbsAVxX2LDFeCMj4wvwGjdY5E5xP8cgleELCqHYhpaT+RHG3gJIBdwrRZWX
	qdsK5rF656/U7dLnA0HtjYcQodwy8BctXoz2Upux76+FWbCFttO1pNP72uLunbb6oo3iSt
	De3AC8vok0dhshtdPNtCA3Dtd0CrZID8VwwE5bRWFXqDmu9V4ZmjuBvpyn/HonhOFhg6HG
	UO7lFNEjigFg4CT3n/9xrp6O1GHX7QMA/WdPpMAVx63ZcxiHKQ4s24pNwcsLHQ==
Date: Sun, 27 Feb 2022 19:12:34 +0100
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Pipping <sebastian@pipping.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Fix vpn/vpn-polkit.policy parse error
Message-ID: <20220227181234.riqz6x2bpbbo66jj@beryllium.lan>
References: <292dd348-fc58-11a8-c97e-30fdb7f48a00@pipping.org>
 <20220227175351.md4r7hx5gywluhds@beryllium.lan>
 <7448580f-b35f-e0cd-a5c1-60ac1359d53d@pipping.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7448580f-b35f-e0cd-a5c1-60ac1359d53d@pipping.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Feb 27, 2022 at 06:58:30PM +0100, Sebastian Pipping wrote:
> I just went to https://git.kernel.org/pub/scm/network/connman/connman.git/
> and I don't see the patch anywhere, also not in the related Git clone.  Did
> you push?  Am I looking at the wrong place?

I am sending the patches out immediately when I go through the mail
box, when reach the end I do the push. So you it's likely you get the
mail before it appears on the korg (the url is correct). Also it usually
takes a few minutes to sync everything on git servers, so another source
of delay. In the meantime, it should be there.

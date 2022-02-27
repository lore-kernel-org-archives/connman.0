Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290A4A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:53:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C19015D3D6;
	Sun, 27 Feb 2022 18:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645984431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IFp09EpUeQ3VXeGdy6FkQJGAzsCIFx20/P6ZMomotq4=;
	b=RWojT5gIZ9fpOQ37Fkpyw+BuHl8KMBPlaCU93FRKu58zkRmO5j7moM7vvw6/CzDxP1IyMb
	/L7f46MuzWE3/Q5yji+ES7ZuIFASDuxrqOn+2JUjER2I35KGZNvsN2XFZIzw/t7PcYBqf7
	8R9NfJt7Um7AJscu2uKlzTybaJUgs69VxWO56JnjyyHNev8jMt/6LbQbSjeXuzYZaigfrK
	kOrkHtQNRvQg5heMnvwrLpRrRZSuITlot7kQJBI+9B/G+kWPFbWo7bksMv509YQQpU4LV1
	OQUD4zuee2RNKgVOOOzgGd8aLMsZTq9QQQR7kmrCiXCpm6yJB+vHvDvZEuMyHg==
Date: Sun, 27 Feb 2022 18:53:51 +0100
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Pipping <sebastian@pipping.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Fix vpn/vpn-polkit.policy parse error
Message-ID: <20220227175351.md4r7hx5gywluhds@beryllium.lan>
References: <292dd348-fc58-11a8-c97e-30fdb7f48a00@pipping.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292dd348-fc58-11a8-c97e-30fdb7f48a00@pipping.org>
X-Last-TLS-Session-Version: TLSv1.3

Hi Sebastian

On Mon, Feb 21, 2022 at 07:03:04PM +0100, Sebastian Pipping wrote:
> Hello connmon list,
> 
> 
> the USBGuard ticket at [1] and a search for "auth_self_keep_session"
> (leading to [2]) made me find that connman had the same problem as USBGuard,
> where Polkit would discard the whole policy file due to a "parse error"
> caused by use of by now unsupported value "auth_self_keep_session".
> Attached is my proposed patch for review. What do you think?

Thanks for the patch. Applied.

I was wondering why I never seen this problem but then I think I just
don't have the policy installed at all.

Thanks for hunting this down.
Daniel

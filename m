Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2415A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 19:05:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A5AD5D174;
	Thu, 14 Apr 2022 21:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649963115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=V5S4EF4nsJUZA3tgh/Eerq5CSIjd7yYU7+e5fwhIi4U=;
	b=R1yqdMcZgTbhTZb4BcNIuwcjiCjFEjrGdHp2aMXMA4J6XvV950a9bFojF5Mt8AMtuCZoml
	qYzu60NMd/om4e+Q8jfLTgH3y+69qZxYkQWb3kZz48/PikAp0PkBa6Knnv2QtjPNlMvbfS
	H3gEG+QczvHmu9G2cr2JcsBhGmW/FLIDlAuYB2jmKoDbk1h09ltbLDeSF4u7dX38BIBQgL
	nu2bO45nmedvPRhNocpMYOf6gnXTIwgsIJvvDaoOQfTgZVWEU2SgkOyqjWqwfHsW8Xl1zU
	6OotMUOyAAJ4wQXnKfc2TK+0ziA/Bx/kfli+rK1rt3qdQwxtARijLziD76S9/w==
Date: Thu, 14 Apr 2022 21:05:15 +0200
From: Daniel Wagner <wagi@monom.org>
To: Jakub Jirutka <jakub@jirutka.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] timeserver: Add EnableNTPClient option to connman.conf
Message-ID: <20220414190515.toyyuk55zylrq25g@beryllium.lan>
References: <20220414001208.4026-1-jakub@jirutka.cz>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414001208.4026-1-jakub@jirutka.cz>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On Thu, Apr 14, 2022 at 02:12:08AM +0200, Jakub Jirutka wrote:
> The builtin NTP client can now only be disabled via DBus or manually
> editing the state file /var/lib/connman/settings
> (`TimeUpdates = "manual"`). These options are not optimal for a setup
> where a standalone NTP client is used.
> 
> The approach for disabling NTP client (in timeserver.c) is based on the
> existing code for handling state setting `TimeUpdates = "manual"`.
> 
> I originally wanted to implement this using CLI option, just
> like --nodnsproxy, but after reading the message from Daniel Wagner
> on ML (Unification to connman configuration? Now it 3 separated places)
> regarding --nodnsproxy, I concluded that the config file is preferred.

I am not against the idea to have the default configurable via the
config file, but please make just the default behavior so that the D-Bus
API still works (unless I read your patch wrong).

Thanks,
Daniel

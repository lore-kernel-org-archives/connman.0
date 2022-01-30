Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569162CA5
	for <connman@lists.linux.dev>; Sun, 30 Jan 2022 14:51:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DE115CFFF;
	Sun, 30 Jan 2022 15:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643554271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g6m9He1bs/hJNWT3pIvgPEKh81kPwVAlDp611dv5Qb0=;
	b=NqMlAm3nYnAqATdV96YHGltMj+1yAqjA1td5S7BKa3pgJCk+CaiEURSy4rCQB85FJdCCu8
	tpqcW/ckqcIUBQYIqYKH5ydlFAnTZAUZuxCIIgMqCkhdYm+jdFUvu5UQyudizHDNxL/i2s
	cnsg0G3azQsMpdOfc+VpFktpzq38+nyS5HKWsejG8BYNgd7cPRiVRgszUjZK62bTgjk311
	kFRjklylyfUcg9M4yKof6038/+02HZZZj9MDY0RYcrQCBw98gZn0ISBFGNlL3RUrcdK1v7
	qQldfO6vhgxWWV6iYMwG8ErhOFkww1+vERdPyOC2tJCfcghBmVCUlVPmQ4B33w==
Date: Sun, 30 Jan 2022 15:51:10 +0100
From: Daniel Wagner <wagi@monom.org>
To: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Cc: connman@lists.linux.dev
Subject: Re: Unification to connman configuration? Now it 3 separated places.
Message-ID: <20220130145110.ax6aio73c6le7xrk@beryllium.lan>
References: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69350dd-6028-841f-8f0a-069cb4ec16d1@protonmail.ch>
X-Last-TLS-Session-Version: TLSv1.3

Hi Piotr,

On Wed, Jan 26, 2022 at 10:40:19PM +0000, Piotr Karbowski wrote:
> 
> Currently there are three places where one configure connman:
> 
> - Command line arguments to deamon
> - /etc/connman/main.conf file
> - /var/lib/connman/settings
> 
> Which is quite a hassle to maintain.

Yes, indeed. Let's start with the simplest one:

- /var/lib/connman/settings

This is file is under control of ConnMan. The user is not supposed to
edit. But it keeps the default settings how ConnMan should behave when
started for the first time. I suppose we could add those defaults
settings to /etc/connman/main.conf.

- /etc/connman/main.conf file

This contains the more 'static' configuration bits for ConnMan. I think
we need a config file for the defaults. Don think we get away without one.

> To go with actual examples
> 
> - disable dns proxy -- only via command line argument.

This should go into the /etc/connman/main.conf. This should be fairly
simple to do as well.

> - disable hostname updates via dhcp -- /etc/connman/main.conf file
> - disable NTP client -- /var/lib/connman/settings file
> 
> Would it be possible to unify those into a single interface?

Yes sure. 

For any global default setting we should add/move it to main.conf. The
difficult bits are the dynamic bits for newly discovered services.

Daniel

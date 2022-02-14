Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9F7A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 15:40:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8B5F5D342;
	Mon, 14 Feb 2022 16:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1644853256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UG30tT2v8bl0m2rDwe8itnB+1xW8/BzWNrjo+zeTDTA=;
	b=sv1RjdgW8Fa5LJvHhOBGedBpPUsYcc7P2VdWLJku5cNK0HlWi9RSVwihg8vlV8w4s/djb+
	x5GvQKJhNM7Tl09ZSKBnUOBpMHJqc+iSApOZImlqDEokIYJNQ3XBtuvB4GiLfTnM+nXgwV
	bxG3b08UScTz2Wla/0XDWUV/ib1KQitOVvdWCZ1/g2NTGYZ4V5MTssrBiN9GDFx3hiXhTV
	+7f8y527soCY2l+XwtDkAPhOZgR0ha2TcVR5WQP9mKlipb5pnsdwSvBsQ9CR1rhI2IFP2J
	sbPLdw2IDBFeHSYTdDoQkE0Bz5HvfbTHCDyXV++Sr7B1jQlRNnJdBdMCeSh3bw==
Date: Mon, 14 Feb 2022 16:40:55 +0100
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev, Emmanuel.VAUTRIN@cpexterne.org
Subject: Re: connman issues with enlightenment since last upgrade to version
 1.41
Message-ID: <20220214154055.fllggqazrspg222w@carbon.lan>
References: <CA+iibzD638TEqqCJ+c2_KvRaeXST745nwq+N1a8MvZtvxUzQ-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzD638TEqqCJ+c2_KvRaeXST745nwq+N1a8MvZtvxUzQ-A@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Feb 14, 2022 at 11:39:23AM +0100, daniel antoine wrote:
> Finally I have reloaded the version 1.41 and have created a
> /etc/connman/main.conf file with
> [General]
> EnableOnlineCheck=true
> 
> Now everything works, The icons are blue, the interfaces online, and
> the dns problem has disappeared. It seems that EnableOnlineCheck is
> turned false by default despite the fact that in the git in the
> src/make.c EnableOnlineCheck is set to true.

That is strange indeed as the default should be true. I'll look if I can
reproduce this locally.

> I don't want to worry you anymore with that.

Thanks for letting us know!

Daniel

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD32CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:31:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C7BE5CD17;
	Sun, 19 Dec 2021 18:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639935074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9+hm6ElcGhjpm/8dY6Trx39mbW1sp/0n+LSo/meWrQk=;
	b=JfXdIOpuTIfv8lNLJkLXUBxDd7YesmHkgP+jAZ9CK5so0ABHjbdwDEeAzQa9i3nhvwh4r1
	+vKIk1oT2O/I8+TdsRQ+I7IqBu1WwcRBX3kEmmglThxj1Jl7deGBrCTy3UAZdmqz4EP2mO
	Plihx0qRikiCQdDMSaFsBtxLJhbe7KiJu20Ytpe9q49RxMYSVhyDwRxQMzsIomlQP3nIQ3
	w7JpW9hugqQ8C0MZCZORhjyA5H+sKVdsjzYS9aAeNHIO3qqxAYU9lVdXURhnlRDJ0wjYFN
	sw6X6a7ejRlA6iS9Kh4+GWsiL5hzBcLZwciT0koVvMwDkomas2Qs5lgqYBBVOg==
Date: Sun, 19 Dec 2021 18:31:14 +0100
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Klaus Ethgen <klaus@ethgen.ch>, connman@lists.linux.dev
Subject: Re: Too many wlans
Message-ID: <20211219173114.nmbtxjmzxee2izbk@beryllium.lan>
References: <Ya4LuuATLuB7waD6@ikki.ethgen.ch>
 <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
 <CAOf5uwnvYzk0ZX3Ca_FSQLM4sf4mp_UtBStoUcdoeH9L8DJvOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwnvYzk0ZX3Ca_FSQLM4sf4mp_UtBStoUcdoeH9L8DJvOQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Dec 19, 2021 at 06:23:55PM +0100, Michael Nazzareno Trimarchi wrote:
> > I think by deleting all known networks and previously corrupted? entry
> > got removed which prevented the proper working before.
> >
> 
> I have respin the patches on network removal. I will send

That would be great. IIRC the patch was almost ready.

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6D3FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 07:09:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0E3760E52;
	Mon,  4 Oct 2021 09:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633331347; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IQ8dCXUA+YH5EBHe7fc4ZzIICbGnEZC3JG/Ypa01UCk=;
	b=euPPmIwC2yUMEN5YKTKFpCL6dZRdLXrOOM3hGGPOuP2/ONsB6TJ4gstbdo4uKNxwXt1jS/
	YHIpZGAqzddss8MaKRQoDY6ruZHmFFzvaArF42gGSY9OJ3FRfBdiFTovBgXgV5Vl4N35nV
	TupAlhJ8DzB+SNK2aVXvfZcAGAaKdrYPvaVXYrHkxA8CZw05AQvNJ9muEZonTiPTC9zc20
	BYebFk/ar3ULObuNwsiAE5u4vtIeOPZ2yMDZrpy9/q3NPghg7Gw3VfMkwob0wQYxJk7y2z
	7Y7GNDIrQP4d8KC6rP/RVuySSS004vhV8Wz9D5sfoam9+2gzVMJFCWmRq4u1dQ==
Date: Mon, 4 Oct 2021 09:09:06 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: HENRIET Vivien <vivien.henriet@overkiz.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] wifi: Choose a random channel when opening an ap
Message-ID: <20211004070906.625dlmzqv57r7mac@beryllium.lan>
References: <20210923124429.1123-1-v.henriet@overkiz.com>
 <bd9eda8f-02c8-7ae0-7fa7-5bf8b2127db8@overkiz.com>
 <20210929091641.fg4v7pbol2nysgrd@carbon.lan>
 <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwmft+2ToGW8cOVF9_5S-S4G6Jc5CgjgZk=VtJPBd0aAQg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Mon, Oct 04, 2021 at 08:45:57AM +0200, Michael Nazzareno Trimarchi wrote:
> > Generally I would like to avoid adding more config option if there is a
> > way to figure it out.
> >
> 
> I have sent a patch long time ago in order to add the possibility to
> set the frequency of access point. Can I resend?

Oh, my bad. Sure please resend.

Thanks,
Daniel

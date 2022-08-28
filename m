Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CF4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:21:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56E955E05D;
	Sun, 28 Aug 2022 20:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661710903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cpAgjVBq5MKj1JywU8z/lWyLje0lOK1KPcCQiDn00G4=;
	b=n0xRQ60X8vo2pci+ZreCqbVA5jLZNtjcXwtaKfC7j/ryWf9DiUNIlf62Kong1xabxeohN5
	XidTOCzDFgT+aHNV92/SK1+efmyx5GQO1s0mbHDIDxcPZ8MYyjq3pf+X+GSLzK/eO4TtZM
	UFpn5Lml0LqxhiOFn5asVySKEwzjif8VXw5ynY3VnzZm/ZZrMMOI11JRAiZ5JFkKgjIegx
	3wZy1emJDcmXiuaFja3plroC9NvXYCvX8m0ZXHtc4XVlo/EM2sQm0KrxOa6DD8zQSz86oJ
	o+z+Wz7dz5rJjL+Ny9Gz3chhdUPJWzcZBl4HL8qOlhOwmSdpEvh4l9c8RhI6gg==
Date: Sun, 28 Aug 2022 20:21:42 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828182142.dcssj6t2m5ebdsgb@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
 <20220828180009.xifu45ui3qa7pckn@beryllium.lan>
 <20220828180807.jqq26kcm7ev3ukdv@beryllium.lan>
 <6016001e-b5db-a05c-0265-53eeec857e11@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6016001e-b5db-a05c-0265-53eeec857e11@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 08:19:10PM +0200, i.Dark_Templar wrote:
> 28.08.2022 20:08, Daniel Wagner пишет:
> > I suppose we could make __connman_ipconfig_gateway_add() a bit more
> > restrictive:
> > 
> > diff --git a/src/ipconfig.c b/src/ipconfig.c
> > index 34b1724a22bb..9f17f4989ea8 100644
> > --- a/src/ipconfig.c
> > +++ b/src/ipconfig.c
> > @@ -1172,7 +1172,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
> >   	DBG("");
> > -	if (!ipconfig->address)
> > +	if (!ipconfig->address || !ipconfig->address->gateway)
> >   		return -EINVAL;
> >   	service = __connman_service_lookup_from_index(ipconfig->index);
> 
> This version looks working with Hamachi. Thanks a lot!
> 
> I'll check it with OpenVPN a few days later. If it doesn't work I'll send
> another email. But I expect it to work too.

Cool thanks for the quick test. I'll go ahead and apply the patch.

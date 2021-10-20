Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2502C8B
	for <connman@lists.linux.dev>; Wed, 20 Oct 2021 06:13:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 752125E359;
	Wed, 20 Oct 2021 08:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634710393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/QUTAmNXJtPdzm0k9OJxjMneidGzp5i91D/u2VLclgs=;
	b=WgUB50wXEcrRmZS5EPWkolDNBmivB1f/Lt9AXtDBRt2iUgq12if6Z54jroxb7qPJYhiB9K
	MlUjoSgs70SRT398rzm0D/edRQJQ8y8hNG0+vA+4dOgg1X9/0IgxDvfbacBTwCxC9JuCOf
	fGOXQBwn8z8YNEVEzLT84QBJzMO210nTcnCGECBz8AC48TkI+RKbfRbvssDZzdPybHPPIk
	82hvs6vcvsFlTwo6Dsci8HvQmHua7shqrcpkS0JSwKODir+J4HfdPq0t3zkY5qtBKZ4v3m
	ddD9jQMwHXX0bP/LtLrT1ATK/aIQope3A9lpDUA7BktIX9AuqZhzdJp/EAuBVQ==
Date: Wed, 20 Oct 2021 08:13:13 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev, Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
Cc: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: Re: [PATCH 1/3] build: Cleanup of iwd provision_service_wifi()
Message-ID: <20211020061313.y66v5tgyv5li3qjv@carbon.lan>
References: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
 <163471007023.5510.6880163764440514969.b4-ty@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163471007023.5510.6880163764440514969.b4-ty@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanual

On Wed, Oct 20, 2021 at 08:08:16AM +0200, Daniel Wagner wrote:
> On Mon, 18 Oct 2021 10:16:00 +0200, Emmanuel VAUTRIN wrote:

Thanks for updating your setup. I could pick up these patches via b4 and
process them easily. Really appreciated you took the time to setup it!

> > gcc reports with:

Ahaaa, I thought -Werror=maybe-uninitialized was for clang. Stupid me...

> >  src/config.c: In function 'try_provision_service':
> >  src/config.c:1421:3: error: 'ssid' may be used uninitialized in this
> > function [-Werror=maybe-uninitialized]
> >   1421 |   provision_service_wifi(config, service, network,
> >        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   1422 |        ssid, ssid_len);
> >        |        ~~~~~~~~~~~~~~~
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] build: Cleanup of iwd provision_service_wifi()
>       commit: a75b0693ace6e226cfc15e0a1534f7e2cbf3f47c
> [2/3] build: Fix uninitialized errors in iptables tests
>       commit: dff52fff9b26065e433fedb73ed259d82f06ac73
> [3/3] build: Fix uninitialized false positive in dnsproxy
>       commit: fdbdaab520726afdb07cc042eb159392aa4fc9d6

BTW, I updated the prefix of the commit title, so the SHAs don't match.

Thanks,
Daniel

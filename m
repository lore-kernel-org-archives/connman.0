Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F659
	for <connman@lists.linux.dev>; Mon, 24 Oct 2022 06:59:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D63C61C65;
	Mon, 24 Oct 2022 08:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1666594329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rh/sX5UXRqFK6Qfcxoq9xGLTdejw/bR3VSt4lcPCO6k=;
	b=eN1QVDQ92jLrAYsf5RBNsfj0gr7isneVN42BEndi8hitc0xKRklQjsLX+2ZP//huJ5AYV+
	REmhq3u7tyvBLIenLAouxLWv/gwufzTJRdvKOIcQ+Nxgnw5PQRbwJPt8dMlooU/Kdk8KT7
	1MT2AsxLuHLJLju2/46LaCkCghicNE/g64l6bt+yeoQy821xJNqkWaf+yQpr5eO3WOUPwd
	EOzn/msq2w3bT28W1KuBY9u49bA66fixDzSHpb1Qk5nqO0aAz5HzGaKiWCvqMfqAOe1Hro
	7QcUNqdCFrn9VFWHN9ANEJvJl90k7ywyTvqHWobZhnZbTByfy4P0q+ecWZVBsA==
Date: Mon, 24 Oct 2022 08:52:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: Christophe Ronco <c.ronco@kerlink.fr>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 0/1] Enable Fallback DNS server when server is created
Message-ID: <20221024065207.ap3yghsbalv5j7fg@beryllium.lan>
References: <20221011095641.19310-1-c.ronco@kerlink.fr>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011095641.19310-1-c.ronco@kerlink.fr>
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Tue, Oct 11, 2022 at 11:56:40AM +0200, Christophe Ronco wrote:
> I have a DHCP server that do not send DNS servers along with IP address.
> I use the FallbackNameservers option in main.conf to handle this case.
> 
> After a board reboot or a connman restart, Fallback DNS servers are correctly
> displayed in service properties but DNS requests still fail.
> If I disconnect and reconnect the service, DNS requests are OK.
> 
> DNS requests fail because Fallback servers are not enabled.
> 
> They are not enabled because when dnsproxy_default_changed is called, DNS
> servers are not created yet and enable_fallback does not do anything.
> Then when servers are created in create_server (dnsproxy.c), they are not
> enabled because they are fallback servers.
> 
> I made a patch to change the behavior in create_server and enable Fallback
> server if there is no other DNS servers.

Patch applied. Thanks!
Daniel

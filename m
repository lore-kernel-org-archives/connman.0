Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8C38E2
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 09:20:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3157F5CD3D;
	Mon,  7 Mar 2022 10:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646644814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TD5i+5QYHa4yOASESo03APSXeiA3EWvuGM0XS30zr58=;
	b=IyvIoGz6CoBHiKfX3G2pk2/fDCZ+I4c8tTkebzEe4s4TwrrbjAhGKrLbnNdkkzVpFMLhSK
	UruoQQKxJmc09xXwvpaUpVfHbkwsr5pI3FZb1k5RQovbMVhsw6J3KKlJlVlVoqPLzJv6CJ
	dmPIGUyx1JIQq4QLdyvgKnn4eD73+nS/FuQd/GeYL4q/ksmJbQ7eWbcfEOdLypOfIekuFp
	OCLUUnpqZYGsa/pHN6e5VW/NRD46vGbN269mL1BpfH0Wuxgj3ul+TmP452EfU4Vw+AQl+T
	ssstEwmJTq7bWcqtryM/M7kzCBryYtA7KRo4YovUo7wjQl0OhMNKau+LH3O/bQ==
Date: Mon, 7 Mar 2022 10:20:13 +0100
From: Daniel Wagner <wagi@monom.org>
To: Nicky Geerts <nicky.geerts@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 2/2] timeserver: include the reason why a timeserver sync
 is requested
Message-ID: <20220307092013.t4s3belmfkhfxe4s@beryllium.lan>
References: <20220228124930.4010311-1-nicky.geerts@gmail.com>
 <20220307084432.62446-3-nicky.geerts@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307084432.62446-3-nicky.geerts@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Mar 07, 2022 at 09:44:32AM +0100, Nicky Geerts wrote:
> Except for the initial connman_timeserver_start call, and potential
> updated of the default service, all subsequent calls to resynchronise
> the timeserver are blocked because of the check whether service equals
> ts_service in __connman_timeserver_sync.
> 
> DHCP updates, which could replace the timeserver and nameservers, and state
> change updates are ignored.
> 
> As previously suggested by Daniel Wagner on Nov 19th 2019 in a mail to
> Vivien Henriet, it would be best to pass the reason of the sync call,
> and add the logic in __connman_timeserver_sync.

Patch applied.

FWIW, I added a few newlines so the lines are not over 80 chars.

Thanks,
Daniel

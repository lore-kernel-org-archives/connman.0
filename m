Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B938E2
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 09:19:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B78745CD08;
	Mon,  7 Mar 2022 10:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646644741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n2bfSpqY3s9GTiBwqx5jOLxMTqS6xoj9LzarbEqaUq0=;
	b=eOgU8LiBek1Ok8jgJue5JdlXKdtpumKQvtfpWe37TscAcor8J/bMgzkl2T/PPs0l56SNtA
	6dhowXMhs/6Mxd+Cz9eGn03MWiT+MLp0lo7mNoRDet0LiXq6dyyW+pII7zlyJhnkGQezSO
	IZ8hjpPXKsdGCiXtBL4PkqxLJ0eTqg/LFXq9whsgMeXBfuTsaIvJb1Tt897kvhDWwuv0NI
	UsmYtSjlFpsk9APAy4Iydv/2DU/2yU289i71BL3j7HFma/mpLbcXhQbIKyyAMr+ZiGcTuy
	bU+x8iTaCiGD2/hsvHXPe0eRswMk7TKE1YtEZLIUwssnj1qop/GiWV7QzI7sXg==
Date: Mon, 7 Mar 2022 10:19:01 +0100
From: Daniel Wagner <wagi@monom.org>
To: Nicky Geerts <nicky.geerts@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 1/2] timeserver: refresh the nameservers before each
 lookup
Message-ID: <20220307091901.qnipr6x3vanzldh7@beryllium.lan>
References: <20220228124930.4010311-1-nicky.geerts@gmail.com>
 <20220307084432.62446-2-nicky.geerts@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307084432.62446-2-nicky.geerts@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Nicky,

On Mon, Mar 07, 2022 at 09:44:31AM +0100, Nicky Geerts wrote:
> There is a possibility where the UDP channel connections in the resolv
> instance are being closed because of how the external DNS service might
> respond, and are never opened again.  The DNS resolve will keep failing,
> and there is no automatic recovery from this.
> 
> Similar to the behavior of the WISPR module, refresh the nameservers in
> the resolv instance before each DNS request.

Patch applied.

I had to fix a few small fix though:

src/timeserver.c: In function ‘ts_reset’:
src/timeserver.c:398:13: error: unused variable ‘i’ [-Werror=unused-variable]
  398 |         int i;
      |             ^
src/timeserver.c: In function ‘timeserver_start’:
src/timeserver.c:471:13: error: unused variable ‘i’ [-Werror=unused-variable]
  471 |         int i;
      |             ^

and couple of white space damages.

Thanks,
Daniel

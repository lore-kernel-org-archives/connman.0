Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3172
	for <connman@lists.linux.dev>; Fri, 26 Nov 2021 16:34:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 845E0619C1;
	Fri, 26 Nov 2021 17:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1637944453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+98ImBKmrnN/gS+ubCma465YvV1i217rJDtPMRFWIfY=;
	b=JNHAPFFB74Q16kaZcIY7va0SME9RJ9QG5upEEd9jyBCDrWQLl9MiM/bDv9BjQkggrWXNuh
	Zlbz14Qf908SnmJ/4O5NekRtnFxMrLroQXDhlQwEZURMEs33yRjwRPZhzQ4pV+TLFz+lxr
	Xun55y1nkfaTQyKNidzZMIpc0/OA2bLKxnzCjFZB/Y8KeUfZyWMMl8pP9q2CHUisb9BIdb
	oUQwD2Q6IHUZjUiA4nwZA++976Rk5FKZ6Z+7AKTSOHThXumgq88Gi6xkLM4+Xsob2tzgEP
	GKrqiNrvuoWegc88n+lu7tFQC4KU8lkef1QHilyy8u8LC4e5IivymNde3GZ/XQ==
Date: Fri, 26 Nov 2021 17:33:59 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: Christian Taedcke <christian.taedcke@lemonbeat.com>,
	connman@lists.linux.dev
Subject: Re: [PATCH] ipconfig: Do not enable/disable ipv6 for all ifs
Message-ID: <20211126163359.amyhyvf4tvwjc5g6@carbon>
References: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
 <eaf58704-04c3-b6be-54b9-88ef707f95d2@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf58704-04c3-b6be-54b9-88ef707f95d2@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Nov 22, 2021 at 05:10:09PM +0200, Jussi Laakkonen wrote:
> Good find. This indeed fixes this particular issue, IPv6 does seem to get
> disabled after removing a USB ethernet device. Surprising side effect.
> 
> With a quick glance I cannot see any problems related to this, I'm not 100%
> sure if there is a case where this disable_ipv6() is used via
> __connman_ipconfig_disable_ipv6() to completely disable IPv6, Daniel?

Good question. Need to dig into it when I am back from holiday :)

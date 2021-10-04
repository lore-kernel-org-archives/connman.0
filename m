Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC63FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:32:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C07065E30A;
	Mon,  4 Oct 2021 08:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=48Q9eDpCmxSnBeKMdMbGi6iihh5Ss4A6WNoa2NNlnXU=;
	b=gWC7v/whEdvk6yoJi3ohjq1JesDYKLVMqta/6CNIJ0SrAJZwrZR1GrOZYHFmL9mNNFpmsU
	LJZ8//c8cMqpeVLMRpvjx7NY86NH3XkmafHc51JcqyCya/o/AcsatZNjxe3eWhxarDiDMN
	hcJia1gRul/tFUuepRAj/rt1WEn7PaL9Kb4+lnQ/8Do6f0lshMGWNGlXNCkVxN6ArsWxXj
	5BgDi5NESUZxYD3YUmmf9DPRGDZEF2FqMrS0TwqbjmYpBgwdD4xz0Yu0DgqTon1WSS5ge/
	TSCebUVARVFD54MU52p6cxThHzSf5Aj8YrSXkufUXvf4iMYgcseK7HEv5m1EGA==
Date: Mon, 4 Oct 2021 08:32:14 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 1/2] iwd: Set the network index add_network
Message-ID: <20211004063214.r4a2ie5njhk4y7hz@beryllium.lan>
References: <20211001122607.34360-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001122607.34360-1-michael@amarulasolutions.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On Fri, Oct 01, 2021 at 12:26:06PM +0000, Michael Trimarchi wrote:
> In order to have compatibility with wpa_supplicant
> configuration and fill the dictionary as was before
> we need to set index not when the wireless is connected
> but when it's registered. This allow to understand
> what wireless card is using each services

I've applied the version from Emmanuel. Hope that is okay.

Thanks,
Daniel

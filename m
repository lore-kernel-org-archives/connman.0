Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC815A7
	for <connman@lists.linux.dev>; Thu, 14 Apr 2022 19:01:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7111F5D7E1;
	Thu, 14 Apr 2022 21:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1649962897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iZbwdWXg99J4aIJXkEcnGybVgUv5ndwYCazoP4o6jv8=;
	b=r8WNr5jO/DVeYukStYXBNRpruUjzfh/gYje0gkiz9vKmdIzg9HVuRADQcKink3jNDxinQZ
	nCUDOQ5S/d9ojzBg4nZ6d8rSo7nqTE0+t9gpNvdbYrrn3NysB7ELHchiaiGRB2Sc6YShh/
	sh8jLC8ux1bv8lR2KOk2+kjEiaiZ7UCboFzfdPrLWwiVjT0mzIBlP6OUinZ8EEWs5VH/Kf
	RKrtH/l7zqiLwa0X7bD0qgBuoH5brICvE6MqHJfcq/he05JEoQ9zd67J9+gCF8d1JoMng5
	aGHq7y55smJTc4/EjV+Wh6BeOPuzfdsFmQDRPzCAbKDPTnUvW5SWj/Ba8MHCGg==
Date: Thu, 14 Apr 2022 21:01:36 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ryan Smith <ryan.smith@density.io>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v1 2/2] wispr: Fix online check when using WPAD/PAC
Message-ID: <20220414190136.zebsvyjysfyem3tz@beryllium.lan>
References: <20220411173217.505144-1-ryan.smith@density.io>
 <20220411173217.505144-2-ryan.smith@density.io>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411173217.505144-2-ryan.smith@density.io>
X-Last-TLS-Session-Version: TLSv1.3

Hi Rayn,

On Mon, Apr 11, 2022 at 11:32:17AM -0600, Ryan Smith wrote:
> A PAC file can return multiple proxies in response to a query.
> They are separated by a semicolon and, possibly, a space.
> 
> 'PROXY proxy1.example.com:3128; PROXY proxy2.example.com; DIRECT'
> 
> Currently, this is not handled, and the inclusion of more than
> one proxy causes the online check to fail. This fix parses the
> first proxy in the list and uses it.

Patch patches applied. I took the liberty and refactored parse_proxy()
slighly to much the style. Also we are still stuck pre C99 (I know...)
so the declaration have to go to the beginning of the block.

Please let me know if I screwed it up.

Thanks,
Daniel

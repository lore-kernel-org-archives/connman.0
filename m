Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81AA31
	for <connman@lists.linux.dev>; Thu,  3 Nov 2022 08:16:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8724161D75;
	Thu,  3 Nov 2022 09:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1667463407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vLBiQG2y0GH/CMBOwOdXPc1G2qk3IQDk+sGZ3+t2bsM=;
	b=s4s/JHPE6psIfhsoq12LCdVxhqL9RxHygweWqjFQ6JvD+r3q6Z7gKehzp7kPxCNoA4cKHj
	SjC/H6UpMofZkJBeJCZr92szRvrA+R0lhRxVqKvVsnD1HjCGVy2OPUS0lDBHWU07apn8UY
	3RCh+//yG277+jHyoEK7Ks+t33P5/4nR7u/yp5yk9rZyQUcbIv6pvSedhHunMbaD5CV8oE
	j6lLtvc9NsI85bWtrTy2e3B/9KUS65cKaLZAl52W6+WpdJCsSJtC2Hs2oB3qof76X+NvNc
	4hmHMYS8DvUxrhgakPhv4pCHkUCpCOI2clszgYpiovtD0bEiDTeDECUcriA9iQ==
Date: Thu, 3 Nov 2022 09:16:46 +0100
From: Daniel Wagner <wagi@monom.org>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Getting currently configured upstream DNS server
Message-ID: <20221103081646.pffl5mewgoehptru@beryllium.lan>
References: <c34932cf-6f39-8391-471d-7629a1b448ed@goeg.at>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34932cf-6f39-8391-471d-7629a1b448ed@goeg.at>
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On Thu, Nov 03, 2022 at 07:50:36AM +0000, Thomas Bartosik wrote:
> How do I get the upstream DNS server (i.e. the one pushed by the VPN
> server in my case) that connman contacts itself?

Not sure what you mean with 'How do I get'. Do want to read the
configuration from an application or do you mean to use the DNS server?

The later should work out of the box. When the DNS configuration is
pushed to ConnMan it will use it for the link. Note if the VPN tunnel is
not the default route ConnMan will prefer the default DNS server unless
the search domain matches with the VPN tunnel settings

Daniel

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E3A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 07:01:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D85A5D96E;
	Wed, 25 May 2022 09:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653462107; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8zI2K2vxZksNNnkXT6Tn8AupgmBvHgZ9LUZAkxaOXz4=;
	b=uiYohygs7hMhUCMNMXIb6PfTxYI5d9gKK4PwzL7iJFuNu7XYodz8/JL7N/fnXcwzSX6EbU
	EifUJj6vRqJ/VOwU10GsyXUfcZnrnm7jRI80tbAq1FGaZb5Ips5rNk/sNsNtWjOWLFqKmA
	8D8U8bxPhKQA/qK0udCXzbxmMqPPZ4mZsnJrYJUCmxUdTjCgwKHbHx2AeGGCTCn9DdsVNC
	NjqsX+jfHFUK1MgQj1hJ8kEPPvmiqa5ToFovDXSN6j0+HGZhzIGs8fidbpfQLWWEB06I5b
	QUnSZ/YENsff7D3+tvpouJaOAYJVE1RoU5sR8hdRPUJ2fxs+s2s/OeGFegqf1g==
Date: Wed, 25 May 2022 09:01:46 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: dnsproxy: first round of refactoring, TCP bugfix
Message-ID: <20220525070110.xx3pfx6fo3mdfhsy@beryllium.lan>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419103501.30553-1-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

On Tue, Apr 19, 2022 at 12:34:49PM +0200, Matthias Gerstner wrote:
> This is a first iteration of refactoring the dnsproxy codebase. It is no major
> change of the code structure yet, more a local refactoring of each function
> trying to make the existing code more readable and less redundant.
> 
> Part of this is also improved testing capability, minor fixes of bugs
> encountered during refactoring and a bugfix of the TCP protocol operation if
> domain name appending is in effect.

Nice work. A few nits from my side. The cleanup generally looks good.

Though we need set the C standard to C99 I suppose:


src/dnsproxy.c: In function ‘refresh_dns_entry’:
src/dnsproxy.c:394:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
  394 |         int age = 1;
      |         ^~~

and my compiler complained about a few things:

src/dnsproxy.c:410:25: error: comparison of integer expressions of different signedness: ‘size_t’ {aka ‘long unsigned int’} and ‘int’ [-Werror=sign-compare]
  410 |         if (entry->hits > age)
      |                         ^
src/dnsproxy.c: In function ‘update_cached_ttl’:
src/dnsproxy.c:432:17: error: comparison of integer expressions of different signedness: ‘int’ and ‘long unsigned int’ [-Werror=sign-compare]
  432 |         if (len < sizeof(struct domain_question) + 1)
      |                 ^
[...]

BTW, since this contribution is major I would suggest you add your
copyright statement to the file as well.

Thanks,
Daniel

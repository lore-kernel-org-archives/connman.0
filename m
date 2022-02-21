Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D12568
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:49:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7B895D2B7;
	Mon, 21 Feb 2022 09:49:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645433357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yMa5dHN+cNaaE5WdgblWN6AjZvKhTBA+NDfobq9rRRo=;
	b=d+oVQK59KaTRro7IotL8ohgGh2HZpN4a70l+zgnh6KdIIJ6rpDCmSf2S36LK8l8oK/J4Qf
	5vq3vYI195Eh8crjtBntPwl5kyueMRNaDwqbwjVaRS3AQstSECYkAy9FsiLKsT11+qRD/k
	M+xNsnoV5i0G6oEUUCDUwG9LVm8NPsglalJQvJX4T4pwZMtWIdznzdYNUj8qw1XkdpFEDe
	/XsQTK1KXnYkJ9bpaPFJH/XRz+hdJd+8SYutBzbhF8BCYAroPX3FyWHpYW11pE18R81JEc
	SRCYSnBOcd0kMrgKNMWSEWEZuTvuIKsJlxuXPwf2yTrNcudgL/he4aiodWKpgQ==
Date: Mon, 21 Feb 2022 09:49:17 +0100
From: Daniel Wagner <wagi@monom.org>
To: matthias.gerstner@suse.de
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 4/7] .gitignore: also ignore backup configure script
Message-ID: <20220221084917.o6jmvcmhmy2xxpzj@beryllium.lan>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
 <20220217113113.24088-5-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113113.24088-5-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Feb 17, 2022 at 12:31:10PM +0100, matthias.gerstner@suse.de wrote:
> From: Matthias Gerstner <matthias.gerstner@suse.de>
> 
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index cd7d8810..4e0c0aa7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -15,6 +15,7 @@ config.log
>  config.status
>  config.sub
>  configure
> +configure~

I have changed this to a more generic *~

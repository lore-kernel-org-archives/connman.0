Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D5A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 06:51:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1C175D91F;
	Wed, 25 May 2022 08:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653461111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FnRL7qilr8LKHs59CvLAN6PKwC8tpiuokCDxKaRLs0s=;
	b=cIUCCbqWHzSpagJu2GoBNu3x4RBdqGKA2xwIb61rS2BnZr1iGm8904zV9M/FnwNYsmFzUR
	gKJPK1xW+rQ/cp40OnxjApUrM3YDcF3uSTXUCQu17cgxJ6ptjIvNVKiGpQNwfDM97eAws9
	YCAugv/T20hzto9ORVM5JE3rPNsudJcXhst24kCCy1PxozwKU2b9A6LNSOIPDqb1JQyVyZ
	ED/39buiu28PC7R2GiWvoH+GRpE0p3eEoElP5xyhcY8C1TOlm0mPkJp7XZIk5Oo6S2ft8u
	JhMB/NRo6eMd683RhAJkd22F+M20Grv9Gia/cAJsc96ScT912hJP4kcxXvTuOg==
Date: Wed, 25 May 2022 08:45:09 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 03/12] dnsproxy: refactoring of update_cached_ttl() and
 append_data()
Message-ID: <20220525064509.6oohjixx3laz2plg@beryllium.lan>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
 <20220419103501.30553-4-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419103501.30553-4-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Apr 19, 2022 at 12:34:52PM +0200, Matthias Gerstner wrote:
> +	ptr += DNS_HEADER_SIZE;
> +	len -= DNS_HEADER_SIZE;

here the  'sizeof(struct ...)' is hidden in the define

> +
> +	if (len < sizeof(struct domain_question) + 1)
> +		return;
>  
> -	/* skip the query, which is a name and 2 16 bit words */
> -	l = dns_name_length(c);
> -	c += l;
> -	len -= l;
> -	c += 4;
> -	len -= 4;
> +	/* skip the query, which is a name and a struct domain_question */
> +	size_t name_len = dns_name_length(ptr);
> +
> +	ptr += name_len + sizeof(struct domain_question);

and here we have the sizeof(struct ...). Personally I prefer the later
over the former because I don't have to lookup what the define is
doing. But then I do understand that it a good name of a define helps to
read. So just pick one version of it.

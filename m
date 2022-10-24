Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811A659
	for <connman@lists.linux.dev>; Mon, 24 Oct 2022 06:59:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5350061C65;
	Mon, 24 Oct 2022 08:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1666594774; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zp/VDZTTzIVWpCkWVcl18LlDQp4pAsF8k9B8OLtLYYA=;
	b=oQhkfuKDO2frbPR+PQeR+4Nyj0eGMrl0shPyJYVTggXaYIzgWt5cUB4pP5XZNZ07vWc6W1
	8QbEP9tj2+G9Rftvj8taoIF8I9hOjnY1jsA7+/KOaGlzkSdCxgKRV5D9mzGHEPlrYR99tX
	1bQRiTE0HBCXF2ot9U2iIbwssKJlRVFmoVAQzbsT3iaUOJGWzl9fGDhN21jJE0gpzX8+J4
	G6m8tiaSsdpp0dHZ8LdWA0Sr1AWfqSBJstGWhwg3po94KTM3RotZ05g4bNs86tntYZmJW2
	ZNyoT6T5NeKwGDpmuOZDKl6wjPS8JhSQWnBgcjsLnvPsKc8DzkWInXajJrdSEg==
Date: Mon, 24 Oct 2022 08:59:33 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 03/16] dnsproxy: first bits of refactoring data types,
 global variables, simpler functions
Message-ID: <20221024065933.c4u7i4ugrsy7gkk7@beryllium.lan>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
 <20221018084746.21959-4-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018084746.21959-4-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

> -static void send_cached_response(int sk, unsigned char *buf, int len,
> +static void send_cached_response(int sk, unsigned char *ptr, int len,
>  				const struct sockaddr *to, socklen_t tolen,
>  				int protocol, int id, uint16_t answers, int ttl)
>  {
> -	struct domain_hdr *hdr;
> -	unsigned char *ptr = buf;
> -	int err, offset, dns_len, adj_len = len - 2;
> +	struct domain_hdr *hdr = (void *) (ptr + offset);
> +	int offset, dns_len;
>  
>  	/*
>  	 * The cached packet contains always the TCP offset (two bytes)
> @@ -449,8 +469,6 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
>  	if (len < 12)
>  		return;
>  
> -	hdr = (void *) (ptr + offset);

Moving this bit to the declaration section of the fiction is obviously
incorrect. Compiler agrees. I moved it back.

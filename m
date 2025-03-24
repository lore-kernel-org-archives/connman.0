Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96519F421
	for <connman@lists.linux.dev>; Mon, 24 Mar 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855319; cv=none; b=pV49Qyyu8uknr8KgYzDZddCE/jz31IQv8RaVnfEqyHwQTW5OZC4Q4EX3N1BVb9XTJk0rD+O811Y6Mg81rlUOYZDJNwhDHOU2qnlbti8sPsoLoUCtaZThDY6QlresgwCOLqa32X3+g8NQT3m33n0OfReQjcEj5FSyfCaHE2pXHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855319; c=relaxed/simple;
	bh=qzfM6DxsExdvPGnbKoVi0yJ1n2p8Exf/+7rEg1rvikQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IWhZfOYLUO0Kgqcxx2Lo8in472vyTUedLLP2O1IH3ox0hWXI3ECSTInXJIV8C9I0/jykqGx/40SpSY3gPzrqgV4JIuW8ycXNDpb0DMCsz/kDrcVLf3GEk157aEz2FMiZWmLOKAJp1143VKx6XuNtaiGjSMhgCmb/0X9zf+fXSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDZYbjyR; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDZYbjyR"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c16e658f4so952031a34.1
        for <connman@lists.linux.dev>; Mon, 24 Mar 2025 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855317; x=1743460117; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRJm/EQBxNELy15uImKQ8bSRl1YBtyKSnzX14Uzcocc=;
        b=IDZYbjyRc8O9T6IBdvamLabIv7CAEUWR+Hc01NZ+RPnagA8DE840B6Qjws02sxU8Db
         zw5Knl4j21QLpcEJFkhsnN/76N+o+JoDf7CmxK69ZjlekB3q3B28nChKu20Mg/YhH+rI
         lIYTpZiOU+MY00mtw8m+HiE9MMLMHanF2xzgFNs2OoHiGWkC57ZAIUyVkHJoJ3VUDkjR
         kEdlakoOc3h01iVfBN04MJIuC6l+nq66V8WxvkrVNXZEn73dAdHVvb18x9+phyi9NPmS
         iFq3k0BB92tbpl9trwqBrZ03hO0Avq//vkEkvoyNqkl6b3hNixej7iSjpZ892VJqlbYE
         nFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855317; x=1743460117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRJm/EQBxNELy15uImKQ8bSRl1YBtyKSnzX14Uzcocc=;
        b=MFVWLf7j4avEiyhRYb7xr1K7zCn99Hm37Ps1WbczfEBLwZFNELthOnTq/aUq9QsFwI
         d8CSyix9vCbxAIx75lYbaul87OGW3wswYnxgGOvLr74U+jR+DRjYf+oD1gqF9Sg8ATV7
         fy8sDlUmU4N9MqPUbzuimRXamuqaV3TR78WbiGbAc4j0HpNqXuJPSE91MNGpyuVz48In
         jPbxJekD8mhDI8Ii1FR8ctU5qMFlv+gbEdJDRDdZsOK1wZiXEfh/TbicaCx9EFplHE2v
         DuOALDtShPLcWLXaLjY41oo9batHF+6QHcF4MdVWQOAszAhtgisN7KsoEr4TZHexCkJM
         MZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWmz4yAnknMA9HJz+d19A/Sgx9dghk0BzFzEX3wMC0oI4LS3NhgMThcz6gmcZl9Dw9W6QOhGldx@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1OZZ68WhHR+kr9m58BajH2/nLn9174470o5RY4hLUVyNbS1/h
	nzDsgcA9qmDmBLAda7hOwrEJHkfFqpmv1Kr0wCedlQjt0BlvgDi/
X-Gm-Gg: ASbGnctAAsNihWdVg22qCDBNU53zEy2Yf+LPGY7OCL/ItBiK+0nxk8MrEQ3wG9lLslS
	7ecW9ZoFmjTXS6eycHuA1lTclbHw4MbUqiQpFp2+KFD0FpJ49hwrC1uepJe2QU3FcSrmq0iBoe4
	ntxfKktNuUBTOqXq3lD4ZihQS2C9Rn61bpFvJjrY49oJVtp4pYdTJeayxPONYY7BB+T/tSR+bsw
	ARfJMu+GuvhEpVUBcwFVFFT2pjn71lxAQ2wCSHrtNVcm9QK4den9xy9Auc+i/1SXj9EPACbgzZx
	rxs/Ld8s0HcwOOfMpiMR/bpN7MQHSfMZx5jq/LDWqFQ/DI73Lp6GU7ZUJIHCDGXcStamOO3GkJK
	UzPHV+lsZFQ==
X-Google-Smtp-Source: AGHT+IF+ZCwU+YydkOMqT8s3m70mE6mRwaa1asG/Flk/Ns68VC+xZV0J8jkzus9t9ZVWfopyvP5vVA==
X-Received: by 2002:a05:6830:6407:b0:72a:f44b:13ed with SMTP id 46e09a7af769-72c0ae50ae4mr10078672a34.2.1742855316541;
        Mon, 24 Mar 2025 15:28:36 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c0abb94d8sm1705184a34.17.2025.03.24.15.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:28:36 -0700 (PDT)
Message-ID: <7bd42384-c15b-4216-a601-ac18849ce72f@gmail.com>
Date: Mon, 24 Mar 2025 17:28:35 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/18] gweb: Adopt optional, immutable GError instance
 for GWeb result errors.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <cover.1742513884.git.gerickson@nuovations.com>
 <4e2b089631711aaa48079f8a63b74f61d28c9eae.1742513884.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4e2b089631711aaa48079f8a63b74f61d28c9eae.1742513884.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 3/20/25 6:39 PM, Grant Erickson wrote:
> In the following instances, GWeb can fail before initiating or while
> processing a web request:
> 
>    1. TCP connection timeout to the remote server peer.
>    2. Decoding a chunked response.
>    3. Non-successful events (that is, G_IO_NVAL, G_IO_ERR, or G_IO_HUP)
>       from 'g_io_add_watch'.
>    4. GResolve "host not found" DNS forward resolution failure.
>    5. Transport creation failure from 'create_transport'.
> 
> Rather than trying to overload 'GWEB_HTTP_STATUS_CODE_' error
> enumerations from actual web server responses for these non-response
> or response-in-progress failures, the signature of 'GWebResultFunc' is
> amended to take an optional pointer to an immutable GError instance
> which describes one of the five errors above on a GWeb request
> failure.

This looks so much better, a few nits:

> ---
>   gweb/gweb.c      | 125 +++++++++++++++++++++++++++++++++++------------
>   gweb/gweb.h      |   2 +-
>   src/6to4.c       |   3 +-
>   src/wispr.c      |   5 +-
>   tools/web-test.c |   2 +-
>   tools/wispr.c    |   2 +-
>   6 files changed, 101 insertions(+), 38 deletions(-)
> 

<snip>

> @@ -233,9 +233,14 @@ static inline void call_route_func(struct web_session *session)
>   static gboolean connect_timeout_cb(gpointer user_data)
>   {
>   	struct web_session *session = user_data;
> +	g_autofree char *message = NULL;
> +	GError *local_error = NULL;

Could you use:

g_autoptr(GError) local_error = NULL;

...

> +
> +	message = g_strdup_printf("connect timeout to %s after %ums",
> +		session->address, g_web_get_connect_timeout(session->web));
>   
> -	debug(session->web, "session %p connect timeout after %ums",
> -			session, g_web_get_connect_timeout(session->web));
> +	debug(session->web, "session %p %s",
> +			session, message);
>   
>   	session->connect_timeout = 0;
>   
> @@ -244,7 +249,14 @@ static gboolean connect_timeout_cb(gpointer user_data)
>   	session->result.buffer = NULL;
>   	session->result.length = 0;
>   
> -	call_result_func(session, GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
> +	local_error = g_error_new_literal(G_IO_ERROR,
> +					G_IO_ERROR_TIMED_OUT,
> +					message);
> +
> +	call_result_func(session, local_error);
> +
> +	if (local_error)
> +		g_error_free(local_error);

And avoid this if statement completely.

>   
>   	return G_SOURCE_REMOVE;
>   }
> @@ -1020,6 +1030,8 @@ static int handle_body(struct web_session *session,
>   				const guint8 *buf, gsize len)
>   {
>   	int err;
> +	g_autofree char *message = NULL;
> +	GError *local_error = NULL;

Ditto here

>   
>   	debug(session->web, "[body] length %zu", len);
>   
> @@ -1027,19 +1039,28 @@ static int handle_body(struct web_session *session,
>   		if (len > 0) {
>   			session->result.buffer = buf;
>   			session->result.length = len;
> -			call_result_func(session,
> -				GWEB_HTTP_STATUS_CODE_UNKNOWN);
> +			call_result_func(session, NULL);
>   		}
>   		return 0;
>   	}
>   
>   	err = decode_chunked(session, buf, len);
>   	if (err < 0) {
> -		debug(session->web, "Error in chunk decode %d", err);
> +		message = g_strdup_printf("Error in chunk decode %d", err);
> +
> +		debug(session->web, message);
>   
>   		session->result.buffer = NULL;
>   		session->result.length = 0;
> -		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
> +
> +		local_error = g_error_new_literal(G_WEB_ERROR,
> +			G_WEB_ERROR_CHUNK_DECODE,
> +			message);
> +
> +		call_result_func(session, local_error);
> +
> +		if (local_error)
> +			g_error_free(local_error);

Ditto

>   	}
>   
>   	return err;

<snip>

> @@ -1255,6 +1274,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
>   	struct web_session *session = user_data;
>   	gsize bytes_read;
>   	GIOStatus status;
> +	GError *local_error = NULL;

And here

>   
>   	/* We received some data or condition, cancel the connect timeout. */
>   
> @@ -1270,7 +1290,14 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
>   		session->result.buffer = NULL;
>   		session->result.length = 0;
>   
> -		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
> +		local_error = g_error_new_literal(G_IO_ERROR,
> +			g_io_error_from_errno(EIO),
> +			g_strerror(EIO));
> +
> +		call_result_func(session, local_error);
> +
> +		if (local_error)
> +			g_error_free(local_error);

Ditto

>   
>   		return FALSE;
>   	}
> @@ -2288,6 +2315,8 @@ static void handle_resolved_address(struct web_session *session)
>   	struct addrinfo hints;
>   	g_autofree char *port;
>   	int ret;
> +	g_autofree char *message = NULL;
> +	GError *local_error = NULL;
>   
>   	debug(session->web, "address %s", session->address);
>   
> @@ -2303,16 +2332,35 @@ static void handle_resolved_address(struct web_session *session)
>   	port = g_strdup_printf("%u", session->port);
>   	ret = getaddrinfo(session->address, port, &hints, &session->addr);
>   	if (ret != 0 || !session->addr) {
> -		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
> -		return;
> +		message = g_strdup_printf("could not resolve %s: %s",
> +			session->address,
> +			gai_strerror(ret));

Maybe consider dropping 'message' variable entirely and using g_set_error or 
g_error_new?

> +
> +		local_error = g_error_new_literal(G_WEB_ERROR,
> +			G_WEB_ERROR_HOST_NOT_FOUND,
> +			message);
> +
> +		call_result_func(session, local_error);
> +
> +		goto done;
>   	}
>   
>   	call_route_func(session);
>   
> -	if (create_transport(session) < 0) {
> -		call_result_func(session, GWEB_HTTP_STATUS_CODE_CONFLICT);
> -		return;
> +	ret = create_transport(session);
> +	if (ret < 0) {
> +		local_error = g_error_new_literal(G_IO_ERROR,
> +						g_io_error_from_errno(ret),
> +						g_strerror(ret));
> +
> +		call_result_func(session, local_error);
> +
> +		goto done;

nit: The above line is not needed

>   	}
> +
> + done:
> +	if (local_error)
> +		g_error_free(local_error);
>   }
>   
>   static gboolean already_resolved(gpointer data)
> @@ -2329,9 +2377,22 @@ static void resolv_result(GResolvResultStatus status,
>   					char **results, gpointer user_data)
>   {
>   	struct web_session *session = user_data;
> +	g_autofree char *message = NULL;
> +	GError *local_error = NULL;
>   
>   	if (!results || !results[0]) {
> -		call_result_func(session, GWEB_HTTP_STATUS_CODE_NOT_FOUND);
> +		message = g_strdup_printf("could not resolve %s",
> +			session->host);
> +
> +		local_error = g_error_new_literal(G_WEB_ERROR,
> +				G_WEB_ERROR_HOST_NOT_FOUND,
> +				message);
> +

Same here, consider dropping 'message' entirely and using g_set_error or g_error_new

> +		call_result_func(session, local_error);
> +
> +		if (local_error)
> +			g_error_free(local_error);
> +
>   		return;
>   	}
>   

Regards,
-Denis

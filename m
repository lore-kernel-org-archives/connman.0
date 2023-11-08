Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826F6AAB
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK3KK7cq"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ce2c5b2154so4101396a34.3
        for <connman@lists.linux.dev>; Tue, 07 Nov 2023 20:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699419119; x=1700023919; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGUuf0bt345S1zfUQDJ4yRolkr9hA5cWZthKhCdordk=;
        b=eK3KK7cqCQsm9Aq6s6T1vLJmN9uGripwMGulqCakZWK+5R3zKDV4YV87OQTAyl0i0X
         ALNg8T/4T0PuaVsOoB0Pa1xftD+j8fYS4xFnrm7Bf/p+seCP4aKGsRHezvkBvK3HJWGd
         Iqdc8jFA32V+6f93h54rV/SWw3ww9N0r91dma+tFUZ9uIoYyaTLByvyj2bSHjNqtBJgl
         xVI4oOhUT+2NXcVUCrmZ9fSJGPnTtTFFGYN2/U2ZMSSAPsPBbe83G6wVy3FNVU2GE9Hg
         AVCbaAovBbMq3JwIJibLoFb9QuIcKditCY+2DWHXprKVku20G9ChXDfucltbMi1EnXJP
         6hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699419119; x=1700023919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGUuf0bt345S1zfUQDJ4yRolkr9hA5cWZthKhCdordk=;
        b=HBwJXWXiMoOcf5woZovrRzytE7GpkIF9y81913JHd5IiWt1oK6AAsyXas9hpbHEw3Y
         abJW+FMosHQdUEDwI+aHHRAgapvtkLmam1o+NsGamuu3GcZQpoN40nPwcpv+TuEg5s2P
         1Mkt6uShoYLZPm7H0GPe2wCLZNEKL/9jBSL21STpQvqCNb6yyWTVxa0fjRG9zM3lDkVg
         WPXPEx34E06GrlNmubiRo7a5ha9Piz+WXK9FZZ8KvGAioWKEpqVhNe9+aDoBFs9u3HND
         exdbW979nx7havYI42O204soYYfLuIlHVQtMCttn/tXwrLqXF4meyLMBFkc0ZagnKgLX
         b6QQ==
X-Gm-Message-State: AOJu0YzoGfKQ1pn6tG3WsCvNtXFF87Ia7Kb35y4kXGEi52tHQ0dAYsdf
	lxsH5BUegBFo8Kyd8UYv6Kxr5iq/dO4=
X-Google-Smtp-Source: AGHT+IE5ToCfBdHjfZfavaAtWOhaGAihffXpeRx1L4oWiTUKUMS/jWwQNSGvF/YdKYWHRd9Mh/W9vg==
X-Received: by 2002:a9d:7343:0:b0:6b7:518a:1672 with SMTP id l3-20020a9d7343000000b006b7518a1672mr928935otk.34.1699419119497;
        Tue, 07 Nov 2023 20:51:59 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05683022fa00b006ce2fce83cbsm1816151otc.25.2023.11.07.20.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 20:51:59 -0800 (PST)
Message-ID: <6cb6beb7-73f1-4743-bff6-f822ae282786@gmail.com>
Date: Tue, 7 Nov 2023 22:51:57 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v3] gweb: Refactor 'parse_request_and_proxy_urls'.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <538FAB81-E180-4D6D-B405-150F8553F843@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <538FAB81-E180-4D6D-B405-150F8553F843@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 11/7/23 17:19, Grant Erickson wrote:
> Prior to this change, 'parse_request_and_proxy_urls' failed to correctly
> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
> 
>      http://[2001:db8:4006:812::200e]:8080/online/status.html
> 
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change, such URLs
> resulted in the brackets and the IPv6 address being passed to GResolv
> which, unsurprisingly, failed to successfully forward resolve since the
> resulting host was neither a valid host name nor a valid IPv6 address.
> 
> As a result, support for such RFC 2732-compliant bracketed IPv6 addresses
> has been added with this change which refactors the previously-monolithic
> 'parse_request_and_proxy_urls' into several, focused functions:
> 
>      * parse_request_and_proxy_urls
>          - parse_request_url
>              o parse_url_components
>                  + parse_url_scheme
>                      > parse_url_scheme_with_default
>                  + parse_url_host_and_port
>                      > parse_url_host
>                      > parse_url_port
>                  + parse_url_path
>          - parse_proxy_url
> 
> In particular, 'parse_url_host' is the new function responsible for parsing
> the host and correctly handling one of seven possible combinations of host
> and port, two of which include bracketed IPv6 addresses.
> 
> In addition, 'parse_url_host' will now return an error on an empty, non-
> existent host and 'parse_url_port' will return an error on invalid, out-of-
> range ports.
> ---
>   gweb/gweb.c | 495 +++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 431 insertions(+), 64 deletions(-)
> 
> diff --git a/gweb/gweb.c b/gweb/gweb.c
> index 4d464cf2..ae5706d4 100644
> --- a/gweb/gweb.c
> +++ b/gweb/gweb.c
> @@ -1107,101 +1107,468 @@ static int create_transport(struct web_session *session)
>   	return 0;
>   }
>   
> -static int parse_request_and_proxy_urls(struct web_session *session,
> -				const char *url, const char *proxy)
> +static int parse_url_scheme_with_default(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **scheme,
> +						const char *default_scheme)
>   {
> -	char *scheme, *host, *port, *path;
> +	static const char * const scheme_delimiter = "://";
> +	static const size_t scheme_delimiter_length = 3;
> +	const char *result;
> +	size_t remaining_length;
> +	size_t scheme_length = 0;
>   
> -	scheme = g_strdup(url);
> -	if (!scheme)
> +	if (!url || !url_length || !cursor)
>   		return -EINVAL;
>   
> -	host = strstr(scheme, "://");
> -	if (host) {
> -		*host = '\0';
> -		host += 3;
> +	remaining_length = url_length - (size_t)(*cursor - url);
> +	if (remaining_length) {
> +		result = memmem(*cursor,
> +					remaining_length,
> +					scheme_delimiter,
> +					scheme_delimiter_length);
> +		if (result) {
> +			scheme_length = (size_t)(result - *cursor);
>   
> -		if (strcasecmp(scheme, "https") == 0) {
> -			session->port = 443;
> -			session->flags |= SESSION_FLAG_USE_TLS;
> -		} else if (strcasecmp(scheme, "http") == 0) {
> -			session->port = 80;
> -		} else {
> -			g_free(scheme);
> +			if (scheme)
> +				*scheme = g_strndup(*cursor, scheme_length);
> +
> +			*cursor += scheme_length + scheme_delimiter_length;
> +		} else if (scheme && default_scheme) {

So I'm really trying to understand why this default_scheme is useful and 
self-documenting, but failing so far.  All I see is a single call site for 
parse_url_scheme_with_default() which always passes a NULL as the 
default_scheme.  So this branch is always dead as far as my brain is concerned. 
Why is this useful? Help?

> +			scheme_length = strlen(default_scheme);
> +
> +			*scheme = g_strndup(default_scheme, scheme_length);
> +		} else if (scheme)
> +			*scheme = NULL;

Since all g_* functions gracefully accept NULL, this could be simplified to:
	else if (scheme)
		*scheme = g_strdup(default_scheme)

> +	} else if (scheme)
> +		*scheme = NULL;

How does the caller know whether scheme is empty because it wasn't present, or 
empty because the passed in string was empty?  Does the caller care? If the 
caller cares, then this maybe should be a return -ENOENT?  If the caller doesn't 
care, then why not do something like:

	if (remaining_length) {
		result = memmem(...);
		if (result) {
			...
		}
	}

	if (scheme && !scheme_length)
		*scheme = g_strdup(default_scheme);

> +
> +	return 0;
> +}
> +
> +static int parse_url_scheme(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **scheme)
> +{
> +	const char * const default_scheme = NULL;
> +
> +	return parse_url_scheme_with_default(url,
> +		url_length,
> +		cursor,
> +		scheme,
> +		default_scheme);
> +}
> +
> +static int parse_url_host(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **host)
> +{
> +	size_t remaining_length;
> +	size_t host_length	= 0;
> +	const char *result;
> +	const char *opening_bracket;
> +	const char *closing_bracket;
> +
> +	if (!url || !url_length || !cursor)
> +		return -EINVAL;
> +
> +	/*
> +	 * Since it's the easiest to detect, first rule out an IPv6
> +	 * address. The only reliably way to do so is to search for the
> +	 * delimiting '[' and ']'. Searching for ':' may yield one of the
> +	 * other forms above (for example, (2), (5), or (7).
> +	 */
> +
> +	remaining_length = url_length - (size_t)(*cursor - url);
> +
> +	opening_bracket = memchr(*cursor, '[', remaining_length);
> +	if (opening_bracket) {
> +		/*
> +		 * We found an opening bracket; this might be an IPv6
> +		 * address. Search for its peer closing bracket.
> +		 */
> +
> +		remaining_length = url_length - (size_t)(opening_bracket - url);
> +
> +		closing_bracket = memchr(opening_bracket,
> +								']',
> +								remaining_length);
> +		if (!closing_bracket)
>   			return -EINVAL;
> -		}
> +
> +		/*
> +		 * Assign the first character of the IPv6 address after the
> +		 * opening bracket up to, but not including, the closing
> +		 * bracket to the host name.
> +		 */
> +
> +		host_length = (size_t)(closing_bracket - opening_bracket) - 1;

Why do you need the cast here?  closing bracket is always after opening bracket, 
so the result of the subtraction is always positive.

> +
> +		if (host_length && host)
> +			*host = g_strndup(opening_bracket + 1, host_length);

Should host_length of 0 be treated as an error right away instead of advancing 
the cursor first?

> +
> +		/* Move the parsing cursor past the closing bracket. */
> +
> +		*cursor = closing_bracket + 1;
>   	} else {
> -		host = scheme;
> -		session->port = 80;
> +		/*
> +		 * At this point, we either have an IPv4 address or a host
> +		 * name, maybe with a port.
> +		 *
> +		 * Whether we have a port or not, we definitively know where
> +		 * the IPv4 address or host name ends. If we have a port, it
> +		 * ends at the port delimiter, ':'. If we don't have a port,
> +		 * then it ends at the end of the string or at the path
> +		 * delimiter, if any.
> +		 */
> +
> +		result = memchr(*cursor, ':', remaining_length);
> +		if (result) {
> +			/*
> +			 * There is a port and an IPv4 address or a host name.
> +			 * Assign the latter to the host and handle the port
> +			 * later.
> +			 */
> +
> +			host_length = (size_t)(result - *cursor);
> +
> +			if (host_length && host)
> +				*host = g_strndup(*cursor, host_length);
> +
> +			*cursor += host_length;
> +		} else {
> +			/*
> +			 * There is no port, just an IPv4 address or a host name,
> +			 * potentially followed by a path.
> +			 */
> +
> +			result = memchr(*cursor, '/', remaining_length);
> +			if (result)
> +				host_length = (size_t)(result - *cursor);
> +			else
> +				host_length = remaining_length;
> +
> +			if (host)
> +				*host = g_strndup(*cursor, host_length);
> +
> +			*cursor += host_length;
> +		}

This seems rather long winded.  Remember doc/coding-style item O2.  Why not 
something like:

result = memchr(*cursor, ':', remaining_length);
if (!result)
	result = memchr(*cursor, '/', remaining_length);

if (result)
	host_length = ...
else
	host_length = ...

if (!host_length)
	return -EINVAL;

*cursor += host_length;

>   	}
>   
> -	path = strchr(host, '/');
> -	if (path)
> -		*(path++) = '\0';
> +	if (!host_length)
> +		return -EINVAL;
>   
> -	if (!proxy)
> -		session->request = g_strdup_printf("/%s", path ? path : "");
> -	else
> -		session->request = g_strdup(url);
> +	return 0;
> +}
>   
> -	port = strrchr(host, ':');
> -	if (port) {
> -		char *end;
> -		int tmp = strtol(port + 1, &end, 10);
> +static int parse_url_port(const char *url, size_t url_length,
> +						const char **cursor,
> +						int16_t *port)
> +{
> +	static char port_delimiter = ':';
> +	static const size_t port_delimiter_length = 1;
> +	const char *result;
> +	size_t remaining_length;
> +	size_t port_length = 0;
> +	char *end;
> +	unsigned long tmp_port;
> +
> +	if (!url || !url_length || !cursor)
> +		return -EINVAL;
>   
> -		if (*end == '\0') {
> -			*port = '\0';
> -			session->port = tmp;
> -		}
> +	remaining_length = url_length - (size_t)(*cursor - url);
>   
> -		if (!proxy)
> -			session->host = g_strdup(host);
> +	result = memchr(*cursor, port_delimiter, remaining_length);
> +	if (result) {
> +		tmp_port = strtoul(result + port_delimiter_length, &end, 10);
> +		if (tmp_port == ULONG_MAX)
> +			return -ERANGE;
> +		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
> +			return -ERANGE;
> +		else if (result + port_delimiter_length == end)
> +			return -EINVAL;
> +
> +		if (*end != '\0')
> +			port_length = remaining_length;

Why does it matter whether *end is the end of the string or not?

>   		else
> -			session->host = g_strdup_printf("%s:%u", host, tmp);
> +			port_length = end - (result + port_delimiter_length);

Can't the else clause be used in both cases?

> +
> +		*cursor += port_length;
>   	} else
> -		session->host = g_strdup(host);
> +		tmp_port = -1;
>   
> -	g_free(scheme);
> +	if (port)
> +		*port = (int16_t)tmp_port;
>   
> -	if (!proxy)
> -		return 0;
> +	return 0;
> +}
>   
> -	scheme = g_strdup(proxy);
> -	if (!scheme)
> +static int parse_url_host_and_port(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **host,
> +						int16_t *port)
> +{
> +	g_autofree char *temp_host = NULL;
> +	int err = 0;
> +
> +	if (!url || !url_length || !cursor)
>   		return -EINVAL;
>   
> -	host = strstr(proxy, "://");
> +	/* Attempt to handle the host component. */
> +
> +	err = parse_url_host(url, url_length, cursor, &temp_host);
> +	if (err != 0)
> +		goto done;
> +
> +	/* Attempt to handle the port component. */
> +
> +	err = parse_url_port(url, url_length, cursor, port);
> +	if (err != 0)
> +		goto done;
> +
>   	if (host) {
> -		*host = '\0';
> -		host += 3;
> +		*host = temp_host;
> +		temp_host = NULL;
> +	}
>   
> -		if (strcasecmp(scheme, "http") != 0) {
> -			g_free(scheme);
> -			return -EINVAL;
> +done:
> +	return err;
> +}
> +
> +static int parse_url_path(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **path)
> +{
> +	static char path_delimiter = '/';
> +	static const size_t path_delimiter_length = 1;
> +	const char *result;
> +	size_t remaining_length;
> +	size_t path_length = 0;
> +
> +	if (!url || !url_length || !cursor)
> +		return -EINVAL;
> +
> +	remaining_length = url_length - (size_t)(*cursor - url);
> +
> +	result = memchr(*cursor, path_delimiter, remaining_length);
> +	if (result) {
> +		path_length = url_length - (size_t)(result + path_delimiter_length - url);
> +
> +		if (path)
> +			*path = g_strndup(result + path_delimiter_length, path_length);

Looks like you're running over > 80 chars here.

> +
> +		*cursor += path_length + path_delimiter_length;
> +	} else if (path)
> +		*path = NULL;
> +
> +	return 0;
> +}
> +
> +static int parse_url_components(const char *url,
> +						char **scheme,
> +						char **host,
> +						int16_t *port,
> +						char **path)
> +{
> +	size_t total_length;
> +	const char *p;
> +	g_autofree char *temp_scheme = NULL;
> +	g_autofree char *temp_host = NULL;
> +	int err = 0;
> +
> +	if (!url)
> +		return -EINVAL;
> +
> +	p = url;
> +
> +	total_length = strlen(p);
> +	if (!total_length)
> +		return -EINVAL;
> +
> +	/* Skip any leading space, if any. */
> +
> +	while ((p < (url + total_length)) && g_ascii_isspace(*p))

while (g_ascii_isspace(*p))?  The first check is redundant I think?

> +		p++;
> +

Maybe check that strlen(p) is not 0 at this point?  In theory one can do:

err = parse_url_scheme(p, strlen(p), &p, &temp_scheme);

> +	/* Attempt to handle the scheme component. */
> +
> +	err = parse_url_scheme(url, total_length, &p, &temp_scheme);
> +	if (err != 0)
> +		goto done;
> +
> +	/* Attempt to handle the host component. */
> +
> +	err = parse_url_host_and_port(url, total_length, &p, &temp_host, port);
> +	if (err != 0)
> +		goto done;
> +
> +	/* Attempt to handle the path component. */
> +
> +	err = parse_url_path(url, total_length, &p, path);
> +	if (err != 0)
> +		goto done;
> +
> +	if (scheme) {
> +		*scheme = temp_scheme;
> +		temp_scheme = NULL;

You could use g_steal_pointer here to make this even simpler:

if (scheme)
	*scheme = g_steal_pointer(&temp_scheme);

> +	}
> +
> +	if (host) {
> +		*host = temp_host;
> +		temp_host = NULL;
> +	}
> +
> +done:
> +	return err;
> +}
> +
> +static int parse_request_url(struct web_session *session,
> +				const char *request_url, bool has_proxy_url)
> +{
> +	g_autofree char *scheme = NULL;
> +	g_autofree char *host = NULL;
> +	g_autofree char *path = NULL;
> +	int16_t port = -1;
> +	int err = 0;
> +
> +	if (!session || !request_url)
> +		return -EINVAL;
> +
> +	/* Parse the request URL components. */
> +
> +	err = parse_url_components(request_url,
> +							   &scheme,
> +							   &host,
> +							   &port,
> +							   &path);

The whitespacing here is really weird.

> +	if (err != 0)
> +		goto done;
> +
> +	/*
> +	 * Handle the URL scheme, if any, for the session, defaulting to
> +	 * the "http" scheme and port 80.
> +	 */
> +
> +	if (scheme) {
> +		if (strcasecmp(scheme, "https") == 0)
> +			session->port = 443;
> +		else if (strcasecmp(scheme, "http") == 0)
> +			session->port = 80;

The old code is guilty of this, but the preferred way is to use 
g_ascii_strcasecmp since the POSIX version is locale dependent.

> +		else {
> +			err = -EINVAL;
> +			goto done;
>   		}
>   	} else
> -		host = scheme;
> +		session->port = 80;
>   
> -	path = strchr(host, '/');
> -	if (path)
> -		*(path++) = '\0';
> +	/* Handle the URL host and port, if any, for the session. */
>   
> -	port = strrchr(host, ':');
> -	if (port) {
> -		char *end;
> -		int tmp = strtol(port + 1, &end, 10);
> +	if (port != -1) {
> +		session->port = port;
>   
> -		if (*end == '\0') {
> -			*port = '\0';
> -			session->port = tmp;
> -		}
> +		if (!has_proxy_url)
> +			session->host = g_strdup(host);
> +		else
> +			session->host = g_strdup_printf("%s:%u", host, port);
> +	} else
> +		session->host = g_strdup(host);
> +
> +	/* Handle the URL path, if any, for the session. */
> +
> +	if (!has_proxy_url)
> +		session->request = g_strdup_printf("/%s", path ? path : "");
> +	else
> +		session->request = g_strdup(request_url);
> +
> +done:
> +	return err;
> +}
> +
> +static int parse_proxy_url(struct web_session *session, const char *proxy_url)
> +{
> +	size_t proxy_length;
> +	const char *p;
> +	g_autofree char *scheme = NULL;
> +	g_autofree char *host = NULL;
> +	int16_t port = -1;
> +	int err = 0;
> +
> +	if (!session || !proxy_url)
> +		return -EINVAL;
> +
> +	/*
> +	 * Parse the proxy URL scheme, host, and port, the only three
> +	 * components we care about.
> +	 */
> +
> +	p = proxy_url;
> +	proxy_length = strlen(p);
> +
> +	err = parse_url_scheme(proxy_url,
> +						   proxy_length,
> +						   &p,
> +						   &scheme);

Again the whitespace format is pretty strange

> +	if (err != 0)
> +		goto done;
> +
> +	err = parse_url_host_and_port(proxy_url,
> +								  proxy_length,
> +								  &p,
> +								  &host,
> +								  &port);

And here

> +	if (err != 0)
> +		goto done;
> +
> +	/*
> +	 * Handle the proxy URL scheme, if any, for the session. Only
> +	 * "http" is allowed.
> +	 */
> +
> +	if (scheme && strcasecmp(scheme, "http") != 0) {
> +		err = -EINVAL;
> +		goto done;
>   	}
>   
> -	session->address = g_strdup(host);
> +	/*
> +	 * Handle the proxy URL host and port for the session.
> +	 */
>   
> -	g_free(scheme);
> +	if (host)
> +		session->address = host;
>   
> -	return 0;
> +	if (port != -1)
> +		session->port = port;
> +
> +done:
> +	return err;
> +}
> +
> +static int parse_request_and_proxy_urls(struct web_session *session,
> +				const char *url, const char *proxy)
> +{
> +	const bool has_proxy_url = (proxy != NULL);
> +	int err = 0;
> +
> +	if (!session || !url)
> +		return -EINVAL;
> +
> +    /* Parse and handle the request URL */
> +
> +	err = parse_request_url(session, url, has_proxy_url);
> +	if (err != 0)
> +		goto done;
> +
> +	if (!has_proxy_url)
> +		goto done;
> +
> +    /* Parse and handle the proxy URL */
> +
> +	err = parse_proxy_url(session, proxy);
> +	if (err != 0)
> +		goto done;
> +
> +done:
> +	return err;
>   }
>   
>   static void handle_resolved_address(struct web_session *session)

Regards,
-Denis

Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C1AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhq3t1l/"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ce2fc858feso3047050a34.3
        for <connman@lists.linux.dev>; Tue, 07 Nov 2023 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699370828; x=1699975628; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gzh4IBj2ti1/0htdefwdyGc7SXSq69h/RDqBpZdb8Ms=;
        b=Nhq3t1l/aoGY8TZyx/PEJU9PVk+MPjfmvge2HoVnQ7PFfOMIC/ug7OZPWJtEf3i18S
         LidazVK25Hw85GJEs/uMQG8GVNLVsSTpAOoGGA2n+4DI2WxABXxGj+M+XY8k0DuGkdGX
         2rafHoqmFVem9JFtR9P5v6cPtKHu5Xu+Z+LpsjYz902A5HgxpwdBsfz3xO87uDQ79YpA
         xZLVmptmIx5F4rCDFCGFl9yN7/H2gRX9X8qEzEVKofFK83MCJkmHmgE4i3MFhOwBC+w4
         pJeEWbTJUyBFhwSjUsEBQjxdNr/PV3ij/bYepw3/rPLhtuNilmPHVflS4jWMPqtfhRjj
         +wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370828; x=1699975628;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzh4IBj2ti1/0htdefwdyGc7SXSq69h/RDqBpZdb8Ms=;
        b=j8W2FJzh93b7srA/nc+JYhuSCWPTlyUNIP0Mc25PxCSfcCaM9HA8XJOv0XsKWiRtBW
         CNprpWEYhnHw50Yd8HzgQr3oQpO5cQ4ScRZGweDUd9Bb5fETHmX66JI5fJbVLT1Aq0Y+
         9wsjnoo4+bWF62Q7lWmfUhHXVtBFamFAhqnNuRdOGEKWkqKyKW8jJYfzoFBGvLO7XP3D
         dfheZ82wwKaCIrX8uHo3BZIXHVPadC81prahbSw58n6IVDeN87DvnOXVHc5cWj6e/GVy
         1yY+JWe4o6w7YLaQaygJZBK1AJbFRlgDLKa4z62uxB7p2p7V+TioI/dtnofPmjPNOImx
         7xxQ==
X-Gm-Message-State: AOJu0YzOJtB9N/gh6UxXZxL0Qp4F4zBLvOyx9WDsZcRY9iQdpLGTRmw8
	lkM/1nxBQjUggZ5ihPPz05/P02fzoDQ=
X-Google-Smtp-Source: AGHT+IHG23gtYQv/QMVYZY5HbQkClE9KFX0iNKpxaR8kLMZlQMfUFZgsXqGo5cvnTwbUfHijHFc1eg==
X-Received: by 2002:a05:6830:3105:b0:6d2:e1fc:f39b with SMTP id b5-20020a056830310500b006d2e1fcf39bmr33830551ots.0.1699370827795;
        Tue, 07 Nov 2023 07:27:07 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w10-20020a056830060a00b006ce33ba6474sm1602086oti.4.2023.11.07.07.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:27:07 -0800 (PST)
Message-ID: <321bbd59-0a7b-4624-8e7f-71f94356d14e@gmail.com>
Date: Tue, 7 Nov 2023 09:27:05 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 11/7/23 01:58, Grant Erickson wrote:
> Prior to this change, 'parse_request_and_proxy_urls' failed to correctly
> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
> 
>      http://[2001:db8:4006:812::200e]:8080/online/status.html
> 
> Such bracketing is necessary when using IPv6 addresses to disambiguate
> the host component from the port component due to the presence of the
> colon (':') in IPv6 addresses. As such, prior to this change,  such URLs
> resulted in the brackets and the IPv6 address being passed to gresolv
> which, unsurprisingly, failed to successfully forward resolve since the
> resulting host was neither a valid host name nor a valid IPv6 address.
> 
> As a result, support for such RFC 2732-compliant bracketed IPv6 addresses
> has been added with this change which refactors the previously-monolithic
> parse_request_and_proxy_urls into several, focused functions:
> 
>      * parse_request_and_proxy_urls
>          - parse_url_components
>              o parse_url_scheme
>                  + parse_url_scheme_with_default
>              o parse_url_host_and_port
>                  + parse_url_host
>                  + parse_url_port
>              o parse_url_path
> 
> In particular, 'parse_url_host' is the new function responsible for parsing
> the host and correctly handling one of seven possible combinations of host
> and port, two of which include bracketed IPv6  addresses.
> 
> In addition, 'parse_url_host' will now return an error on an empty, non-
> existent host and 'parse_url_port' will return an error on invalid, out-of-
> range ports.
> ---
>   gweb/gweb.c | 491 ++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 436 insertions(+), 55 deletions(-)
> 

Just a couple of quick comments, haven't delved into the patch itself

<snip>

> +static int parse_url_scheme_with_default(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **scheme,
> +						const char *default_scheme)
> +{
> +	static const char * const scheme_delimiter = "://";
> +	static const size_t scheme_delimiter_length = 3;
> +	const char *result;
> +	size_t remaining_length;
> +	size_t scheme_length = 0;
> +
> +	if (!url || !url_length || !cursor)
> +		return -EINVAL;
> +
> +	remaining_length = (url_length - (size_t)(*cursor - url));

Extra parens around the right side expression are not needed

> +	if (remaining_length) {
> +		result = (const char *)memmem(*cursor,

This cast is likely unneeded.

> +							remaining_length,
> +							scheme_delimiter,
> +							scheme_delimiter_length);
> +		if (result) {
> +			scheme_length = (size_t)(result - *cursor);
> +
> +			if (scheme) {
> +				*scheme = g_strndup(*cursor, scheme_length);

g_strndup does not fail.

> +				if (!*scheme)
> +					return -ENOMEM;
> +			}
> +
> +			*cursor += scheme_length + scheme_delimiter_length;
> +		} else if (scheme && default_scheme) {
> +			scheme_length = strlen(default_scheme);
> +
> +			*cursor += scheme_length;
> +
> +			*scheme = g_strndup(default_scheme, scheme_length);
> +			if (!*scheme)
> +				return -ENOMEM;

As above.

> +		} else if (scheme)
> +			*scheme = NULL;
> +	} else if (scheme)
> +		*scheme = NULL;
> +
> +	return 0;
> +}
> +
> +static int parse_url_scheme(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **scheme)
> +{
> +	const char * const default_scheme = NULL;

const pointer to a const char? Why bother?  Also, why even have this parameter 
if it is always NULL?

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
> +	// Since it's the easiest to detect, first rule out an IPv6
> +	// address. The only reliably way to do so is to search for the
> +	// delimiting '[' and ']'. Searching for ':' may yield one of the
> +	// other forms above (for example, (2), (5), or (7).

This is not the preferred comment style for a multi-line comment.

> +
> +	remaining_length = (url_length - (size_t)(*cursor - url));
> +
> +	opening_bracket = (const char *)memchr(*cursor, '[', remaining_length);
> +	if (opening_bracket) {
> +		// We found an opening bracket; this might be an IPv6
> +		// address. Search for its peer closing bracket.
> +
> +		remaining_length = (url_length - (size_t)(opening_bracket - url));
> +
> +		closing_bracket = (const char *)memchr(opening_bracket,
> +									']',
> +									remaining_length);
> +		if (!closing_bracket)
> +			return -EINVAL;
> +
> +		// Assign the first character of the IPv6 address after the
> +		// opening bracket up to, but not including, the closing
> +		// bracket to the host name.
> +

As above

> +		host_length = (size_t)(closing_bracket - opening_bracket) - 1;
> +
> +		if (host) {
> +			*host = g_strndup(opening_bracket + 1, host_length);
> +			if (!*host)
> +				return -ENOMEM;
> +		}
> +
> +		// Move the parsing cursor past the closing bracket.
> +
> +		*cursor = closing_bracket + 1;
> +	} else {
> +		// At this point, we either have an IPv4 address or a host
> +		// name, maybe with a port.
> +		//
> +		// Whether we have a port or not, we definitively know where
> +		// the IPv4 address or host name ends. If we have a port, it
> +		// ends at the port delimiter, ':'. If we don't have a port,
> +		// then it ends at the end of the string or at the path
> +		// delimiter, if any.
> +
> +		result = (const char *)memchr(*cursor, ':', remaining_length);
> +		if (result) {
> +			// There is a port and an IPv4 address or a host name.
> +			// Assign the latter to the host and handle the port
> +			// later.
> +
> +			host_length = (size_t)(result - *cursor);
> +
> +			if (host) {
> +				*host = g_strndup(*cursor, host_length);
> +				if (!*host)
> +					return -ENOMEM;
> +			}
> +
> +			*cursor += host_length;
> +		} else {
> +			// There is no port, just an IPv4 address or a host name,
> +			// potentially followed by a path.
> +
> +			result = (const char *)memchr(*cursor, '/', remaining_length);
> +			if (result)
> +				host_length = (size_t)(result - *cursor);
> +			else
> +				host_length = remaining_length;
> +
> +			if (host) {
> +				*host = g_strndup(*cursor, host_length);
> +				if (!*host)
> +					return -ENOMEM;
> +			}
> +
> +			*cursor += host_length;
> +		}
> +	}
> +
> +	if (!host_length)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
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
> +
> +	remaining_length = (url_length - (size_t)(*cursor - url));
> +
> +	result = (const char *)memchr(*cursor, port_delimiter, remaining_length);
> +	if (result) {
> +		tmp_port = strtoul(result + port_delimiter_length, &end, 10);
> +		if (tmp_port == ULONG_MAX)
> +			return -ERANGE;
> +		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
> +			return -ERANGE;
> +		else if (result + 1 == end)
> +			return -EINVAL;

I wish we could use ell's l_safe_atou here.

> +
> +		if (*end != '\0')
> +			port_length = remaining_length;
> +		else
> +			port_length = end - (result + port_delimiter_length);
> +
> +		*cursor += port_length;
> +	} else
> +		tmp_port = -1;
> +
> +	if (port)
> +		*port = (int16_t)tmp_port;
> +
> +	return 0;
> +}
> +
> +static int parse_url_host_and_port(const char *url, size_t url_length,
> +						const char **cursor,
> +						char **host,
> +						int16_t *port)
> +{
> +	int err;
> +
> +	if (!url || !url_length || !cursor)
> +		return -EINVAL;
> +
> +	// Attempt to handle the host component.
> +
> +	err = parse_url_host(url, url_length, cursor, host);
> +	if (err != 0)
> +		return err;
> +
> +	// Attempt to handle the port component.
> +
> +	err = parse_url_port(url, url_length, cursor, port);
> +	if (err != 0) {
> +		if (host) {
> +			g_free(*host);
> +			*host = NULL;
> +		}
> +
> +		return err;
> +	}
> +
> +	return 0;
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
> +	remaining_length = (url_length - (size_t)(*cursor - url));
> +
> +	result = (const char *)memchr(*cursor, path_delimiter, remaining_length);
> +	if (result) {
> +		path_length = (url_length - (size_t)(result + path_delimiter_length - url));
> +
> +		if (path) {
> +			*path = g_strndup(result + path_delimiter_length, path_length);
> +			if (!*path)
> +				return -ENOMEM;
> +		}
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
> +	int err;
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
> +	// Skip any leading space, if any.
> +
> +	while ((p < (url + total_length)) && isspace(*p))

g_ascii_ is preferred here.

> +		p++;
> +
> +	// Attempt to handle the scheme component.
> +
> +	err = parse_url_scheme(url, total_length, &p, scheme);
> +	if (err != 0)
> +		return err;

Why not make a temporary to hold scheme using g_autofree and only assign *scheme 
on success?

> +
> +	// Attempt to handle the host component.
> +
> +	err = parse_url_host_and_port(url, total_length, &p, host, port);
> +	if (err != 0) {
> +		if (scheme) {
> +			g_free(*scheme);
> +			*scheme = NULL;
> +		}

Removes the need for this ugliness.  Or use a goto.

> +
> +		return err;
> +	}
> +
> +	// Attempt to handle the path component.
> +
> +	err = parse_url_path(url, total_length, &p, path);
> +	if (err != 0) {
> +		if (scheme) {
> +			g_free(*scheme);
> +			*scheme = NULL;
> +		}
> +
> +		if (host) {
> +			g_free(*host);
> +			*host = NULL;
> +		}
> +

Ditto here.

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>   static int parse_request_and_proxy_urls(struct web_session *session,
>   				const char *url, const char *proxy)
>   {
> -	char *scheme, *host, *port, *path;
> +	size_t proxy_length;
> +	const char *p;
> +	char *scheme = NULL;
> +	char *host = NULL;
> +	char *path = NULL;
> +	int16_t port = -1;
> +	int err;
>   
> -	scheme = g_strdup(url);
> -	if (!scheme)
> +	if (!session || !url)
>   		return -EINVAL;
>   
> -	host = strstr(scheme, "://");
> -	if (host) {
> -		*host = '\0';
> -		host += 3;
> +	p = url;
> +
> +	// Parse the URL components.
> +
> +	err = parse_url_components(url,
> +							   &scheme,
> +							   &host,
> +							   &port,
> +							   &path);
> +	if (err != 0) {
> +		g_free(scheme);
> +		g_free(host);
> +		g_free(path);
> +

Our preference is to never have side effects in functions so such code is never 
necessary.  It seems you follow this philosophy in parse_url_components, so why 
do this here?

> +		return err;
> +	}
> +
> +	// Handle the URL scheme, if any, for the session, defaulting to
> +	// the "http" scheme and port 80.
>   
> +	if (scheme) {
>   		if (strcasecmp(scheme, "https") == 0) {
>   			session->port = 443;
> -			session->flags |= SESSION_FLAG_USE_TLS;
>   		} else if (strcasecmp(scheme, "http") == 0) {
>   			session->port = 80;
>   		} else {
>   			g_free(scheme);
> +			g_free(host);
> +			g_free(path);
>   			return -EINVAL;
>   		}
> +
> +		g_free(scheme);
>   	} else {
> -		host = scheme;
>   		session->port = 80;
>   	}
>   
> -	path = strchr(host, '/');
> -	if (path)
> -		*(path++) = '\0';
> +	// Handle the URL host and port, if any, for the session.
>   
> -	if (!proxy)
> -		session->request = g_strdup_printf("/%s", path ? path : "");
> -	else
> -		session->request = g_strdup(url);
> -
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
> -
> -		if (!proxy)
> +		if (!proxy) {
>   			session->host = g_strdup(host);
> -		else
> -			session->host = g_strdup_printf("%s:%u", host, tmp);
> -	} else
> +			if (!session->host) {
> +				g_free(host);
> +				g_free(path);
> +				return -ENOMEM;
> +			}
> +		} else {
> +			session->host = g_strdup_printf("%s:%u", host, port);
> +			if (!session->host) {
> +				g_free(host);
> +				g_free(path);
> +				return -ENOMEM;
> +			}
> +		}
> +	} else {
>   		session->host = g_strdup(host);
> +		if (!session->host) {
> +			g_free(host);
> +			g_free(path);
> +			return -ENOMEM;
> +		}
> +	}
>   
> -	g_free(scheme);
> +	// Handle the URL path, if any, for the session.
> +
> +	if (!proxy) {
> +		session->request = g_strdup_printf("/%s", path ? path : "");
> +		if (!session->request) {
> +			g_free(host);
> +			g_free(path);
> +			return -ENOMEM;
> +		}
> +	} else {
> +		session->request = g_strdup(url);
> +		if (!session->request) {
> +			g_free(host);
> +			g_free(path);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	g_free(host);
> +	g_free(path);
>   
>   	if (!proxy)
>   		return 0;
>   
> -	scheme = g_strdup(proxy);
> -	if (!scheme)
> -		return -EINVAL;
> +	// Parse the proxy scheme, host, and port, the only three
> +	// components we care about.
> +
> +	p = proxy;
> +	proxy_length = strlen(p);
> +
> +	err = parse_url_scheme(proxy,
> +						   proxy_length,
> +						   &p,
> +						   &scheme);
> +	if (err != 0)
> +		return err;
> +
> +	err = parse_url_host_and_port(proxy,
> +								  proxy_length,
> +								  &p,
> +								  &host,
> +								  &port);
> +	if (err != 0) {
> +		g_free(scheme);
> +
> +		return err;
> +	}
>   
> -	host = strstr(proxy, "://");
> -	if (host) {
> -		*host = '\0';
> -		host += 3;
> +	// Handle the proxy URL scheme, if any, for the session. Only
> +	// "http" is allowed.
>   
> +	if (scheme) {
>   		if (strcasecmp(scheme, "http") != 0) {
>   			g_free(scheme);
> +			g_free(host);
>   			return -EINVAL;
>   		}
> -	} else
> -		host = scheme;
> -
> -	path = strchr(host, '/');
> -	if (path)
> -		*(path++) = '\0';
> -
> -	port = strrchr(host, ':');
> -	if (port) {
> -		char *end;
> -		int tmp = strtol(port + 1, &end, 10);
>   
> -		if (*end == '\0') {
> -			*port = '\0';
> -			session->port = tmp;
> -		}
> +		g_free(scheme);
>   	}
>   
> -	session->address = g_strdup(host);
> +	// Handle the proxy URL host and port for the session.
> +
> +	if (host)
> +		session->address = host;
>   
> -	g_free(scheme);
> +	if (port != -1)
> +		session->port = port;
>   
>   	return 0;
>   }

Regards,
-Denis

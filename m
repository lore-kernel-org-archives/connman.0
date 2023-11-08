Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89330342
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0AB5373315;
	Wed,  8 Nov 2023 12:08:29 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74] (unknown [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 76F5173328;
	Wed,  8 Nov 2023 12:08:28 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/3 v3] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <6cb6beb7-73f1-4743-bff6-f822ae282786@gmail.com>
Date: Wed, 8 Nov 2023 09:08:27 -0800
Cc: connman@lists.linux.dev,
 Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBB34102-662F-49AC-A11F-7E92A455C5D9@nuovations.com>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <538FAB81-E180-4D6D-B405-150F8553F843@nuovations.com>
 <6cb6beb7-73f1-4743-bff6-f822ae282786@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Denis,

Please see inline below.

On Nov 7, 2023, at 8:51 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/7/23 17:19, Grant Erickson wrote:
>> Prior to this change, 'parse_request_and_proxy_urls' failed to =
correctly
>> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
>>     http://[2001:db8:4006:812::200e]:8080/online/status.html
>> Such bracketing is necessary when using IPv6 addresses to =
disambiguate
>> the host component from the port component due to the presence of the
>> colon (':') in IPv6 addresses. As such, prior to this change, such =
URLs
>> resulted in the brackets and the IPv6 address being passed to GResolv
>> which, unsurprisingly, failed to successfully forward resolve since =
the
>> resulting host was neither a valid host name nor a valid IPv6 =
address.
>> As a result, support for such RFC 2732-compliant bracketed IPv6 =
addresses
>> has been added with this change which refactors the =
previously-monolithic
>> 'parse_request_and_proxy_urls' into several, focused functions:
>>=20
>>     * parse_request_and_proxy_urls
>>         - parse_request_url
>>             o parse_url_components
>>                 + parse_url_scheme
>>                     > parse_url_scheme_with_default
>>                 + parse_url_host_and_port
>>                     > parse_url_host
>>                     > parse_url_port
>>                 + parse_url_path
>>         - parse_proxy_url
>>=20
>> In particular, 'parse_url_host' is the new function responsible for =
parsing
>> the host and correctly handling one of seven possible combinations of =
host
>> and port, two of which include bracketed IPv6 addresses.
>> In addition, 'parse_url_host' will now return an error on an empty, =
non-
>> existent host and 'parse_url_port' will return an error on invalid, =
out-of-
>> range ports.
>> ---
>=20
> So I'm really trying to understand why this default_scheme is useful =
and self-documenting, but failing so far.  All I see is a single call =
site for parse_url_scheme_with_default() which always passes a NULL as =
the default_scheme.  So this branch is always dead as far as my brain is =
concerned. Why is this useful? Help?

In the original embodiment of the implementation, =
=E2=80=98parse_request_and_proxy_urls=E2=80=99 directly invoked =
=E2=80=98parse_url_scheme_with_default=E2=80=99, =E2=80=98parse_url_host=E2=
=80=99, =E2=80=98parse_url_port=E2=80=99, and =E2=80=98parse_url_path=E2=80=
=99. In particular, it called =E2=80=98parse_url_scheme_with_default=E2=80=
=99 since it had the logic to deal with the case where =E2=80=9Chttp://=E2=
=80=9D was not in the URL and passed =E2=80=9Chttp=E2=80=9D as the =
default.

Later, I refactored it again to add =E2=80=98parse_url_components=E2=80=99=
 and have =E2=80=98parse_request_and_proxy_urls=E2=80=99 (now just =
=E2=80=98parse_request_url=E2=80=99) invoke that. In that refactor, I =
just kept =E2=80=98parse_url_scheme_with_default=E2=80=99 as-is and =
wrapped it with =E2=80=98parse_url_scheme=E2=80=99 with a =E2=80=99NULL=E2=
=80=99 default scheme.

At this point, I could either just eliminate =
=E2=80=98parse_url_scheme_with_default=E2=80=99 or modify =
=E2=80=98parse_url_components=E2=80=99 to pass the default scheme all =
the way through. I=E2=80=99ve no strong opinions one way or another.

>> +			scheme_length =3D strlen(default_scheme);
>> +
>> +			*scheme =3D g_strndup(default_scheme, =
scheme_length);
>> +		} else if (scheme)
>> +			*scheme =3D NULL;
>=20
> Since all g_* functions gracefully accept NULL, this could be =
simplified to:
> 	else if (scheme)
> 		*scheme =3D g_strdup(default_scheme)

Noted. I=E2=80=99ll fold this in if we opt to keep =
'parse_url_scheme_with_default=E2=80=99.

>> +static int parse_url_host(const char *url, size_t url_length,
>> +						const char **cursor,
>> +						char **host)
>> +{
>> +	size_t remaining_length;
>> +	size_t host_length	=3D 0;
>> +	const char *result;
>> +	const char *opening_bracket;
>> +	const char *closing_bracket;
>> +
>> +	if (!url || !url_length || !cursor)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Since it's the easiest to detect, first rule out an IPv6
>> +	 * address. The only reliably way to do so is to search for the
>> +	 * delimiting '[' and ']'. Searching for ':' may yield one of =
the
>> +	 * other forms above (for example, (2), (5), or (7).
>> +	 */
>> +
>> +	remaining_length =3D url_length - (size_t)(*cursor - url);
>> +
>> +	opening_bracket =3D memchr(*cursor, '[', remaining_length);
>> +	if (opening_bracket) {
>> +		/*
>> +		 * We found an opening bracket; this might be an IPv6
>> +		 * address. Search for its peer closing bracket.
>> +		 */
>> +
>> +		remaining_length =3D url_length - =
(size_t)(opening_bracket - url);
>> +
>> +		closing_bracket =3D memchr(opening_bracket,
>> +								']',
>> +								=
remaining_length);
>> +		if (!closing_bracket)
>>  			return -EINVAL;
>> -		}
>> +
>> +		/*
>> +		 * Assign the first character of the IPv6 address after =
the
>> +		 * opening bracket up to, but not including, the closing
>> +		 * bracket to the host name.
>> +		 */
>> +
>> +		host_length =3D (size_t)(closing_bracket - =
opening_bracket) - 1;
>=20
> Why do you need the cast here?  closing bracket is always after =
opening bracket, so the result of the subtraction is always positive.

I=E2=80=99ll re-evaluate it; however, IIRC, one of clang or GCC =
complained about the cast.

>> +
>> +		if (host_length && host)
>> +			*host =3D g_strndup(opening_bracket + 1, =
host_length);
>=20
> Should host_length of 0 be treated as an error right away instead of =
advancing the cursor first?

An early exit could be done; although I could also see an argument for:

    if (!host_length)
        err =3D -EINVAL;
    else
        *cursor +=3D host_length

    return err;

at the end to consolidate such a check / cursor advance in a single =
place, shortening the blocks / cases above.

>> +		/* Move the parsing cursor past the closing bracket. */
>> +
>> +		*cursor =3D closing_bracket + 1;
>>  	} else {
>> -		host =3D scheme;
>> -		session->port =3D 80;
>> +		/*
>> +		 * At this point, we either have an IPv4 address or a =
host
>> +		 * name, maybe with a port.
>> +		 *
>> +		 * Whether we have a port or not, we definitively know =
where
>> +		 * the IPv4 address or host name ends. If we have a =
port, it
>> +		 * ends at the port delimiter, ':'. If we don't have a =
port,
>> +		 * then it ends at the end of the string or at the path
>> +		 * delimiter, if any.
>> +		 */
>> +
>> +		result =3D memchr(*cursor, ':', remaining_length);
>> +		if (result) {
>> +			/*
>> +			 * There is a port and an IPv4 address or a host =
name.
>> +			 * Assign the latter to the host and handle the =
port
>> +			 * later.
>> +			 */
>> +
>> +			host_length =3D (size_t)(result - *cursor);
>> +
>> +			if (host_length && host)
>> +				*host =3D g_strndup(*cursor, =
host_length);
>> +
>> +			*cursor +=3D host_length;
>> +		} else {
>> +			/*
>> +			 * There is no port, just an IPv4 address or a =
host name,
>> +			 * potentially followed by a path.
>> +			 */
>> +
>> +			result =3D memchr(*cursor, '/', =
remaining_length);
>> +			if (result)
>> +				host_length =3D (size_t)(result - =
*cursor);
>> +			else
>> +				host_length =3D remaining_length;
>> +
>> +			if (host)
>> +				*host =3D g_strndup(*cursor, =
host_length);
>> +
>> +			*cursor +=3D host_length;
>> +		}
>=20
> This seems rather long winded.  Remember doc/coding-style item O2.  =
Why not something like:
>=20
> result =3D memchr(*cursor, ':', remaining_length);
> if (!result)
> 	result =3D memchr(*cursor, '/', remaining_length);
>=20
> if (result)
> 	host_length =3D ...
> else
> 	host_length =3D ...
>=20
> if (!host_length)
> 	return -EINVAL;
>=20
> *cursor +=3D host_length;

Agreed. The above comment feels like we are iterating in the same =
direction here.

>=20
>>  	}
>>  -	path =3D strchr(host, '/');
>> -	if (path)
>> -		*(path++) =3D '\0';
>> +	if (!host_length)
>> +		return -EINVAL;
>>  -	if (!proxy)
>> -		session->request =3D g_strdup_printf("/%s", path ? path =
: "");
>> -	else
>> -		session->request =3D g_strdup(url);
>> +	return 0;
>> +}
>>  -	port =3D strrchr(host, ':');
>> -	if (port) {
>> -		char *end;
>> -		int tmp =3D strtol(port + 1, &end, 10);
>> +static int parse_url_port(const char *url, size_t url_length,
>> +						const char **cursor,
>> +						int16_t *port)
>> +{
>> +	static char port_delimiter =3D ':';
>> +	static const size_t port_delimiter_length =3D 1;
>> +	const char *result;
>> +	size_t remaining_length;
>> +	size_t port_length =3D 0;
>> +	char *end;
>> +	unsigned long tmp_port;
>> +
>> +	if (!url || !url_length || !cursor)
>> +		return -EINVAL;
>>  -		if (*end =3D=3D '\0') {
>> -			*port =3D '\0';
>> -			session->port =3D tmp;
>> -		}
>> +	remaining_length =3D url_length - (size_t)(*cursor - url);
>>  -		if (!proxy)
>> -			session->host =3D g_strdup(host);
>> +	result =3D memchr(*cursor, port_delimiter, remaining_length);
>> +	if (result) {
>> +		tmp_port =3D strtoul(result + port_delimiter_length, =
&end, 10);
>> +		if (tmp_port =3D=3D ULONG_MAX)
>> +			return -ERANGE;
>> +		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
>> +			return -ERANGE;
>> +		else if (result + port_delimiter_length =3D=3D end)
>> +			return -EINVAL;
>> +
>> +		if (*end !=3D '\0')
>> +			port_length =3D remaining_length;
>=20
> Why does it matter whether *end is the end of the string or not?

I believe this was preserving a vestige of some of the original port =
parsing logic. I wasn=E2=80=99t sure why the original author handled =
that case uniquely, so I preserved it. I believe the else case handles =
things generally.

>>  		else
>> +			port_length =3D end - (result + =
port_delimiter_length);
>=20
> Can't the else clause be used in both cases?

Confirmed, see above.

>=20
>> +
>> +		*cursor +=3D port_length;
>>  	} else
>> -		session->host =3D g_strdup(host);
>> +		tmp_port =3D -1;
>>  -	g_free(scheme);
>> +	if (port)
>> +		*port =3D (int16_t)tmp_port;
>>  -	if (!proxy)
>> -		return 0;
>> +	return 0;
>> +}
>>  -	scheme =3D g_strdup(proxy);
>> -	if (!scheme)
>> +static int parse_url_host_and_port(const char *url, size_t =
url_length,
>> +						const char **cursor,
>> +						char **host,
>> +						int16_t *port)
>> +{
>> +	g_autofree char *temp_host =3D NULL;
>> +	int err =3D 0;
>> +
>> +	if (!url || !url_length || !cursor)
>>  		return -EINVAL;
>>  -	host =3D strstr(proxy, "://");
>> +	/* Attempt to handle the host component. */
>> +
>> +	err =3D parse_url_host(url, url_length, cursor, &temp_host);
>> +	if (err !=3D 0)
>> +		goto done;
>> +
>> +	/* Attempt to handle the port component. */
>> +
>> +	err =3D parse_url_port(url, url_length, cursor, port);
>> +	if (err !=3D 0)
>> +		goto done;
>> +
>>  	if (host) {
>> -		*host =3D '\0';
>> -		host +=3D 3;
>> +		*host =3D temp_host;
>> +		temp_host =3D NULL;
>> +	}
>>  -		if (strcasecmp(scheme, "http") !=3D 0) {
>> -			g_free(scheme);
>> -			return -EINVAL;
>> +done:
>> +	return err;
>> +}
>> +
>> +static int parse_url_path(const char *url, size_t url_length,
>> +						const char **cursor,
>> +						char **path)
>> +{
>> +	static char path_delimiter =3D '/';
>> +	static const size_t path_delimiter_length =3D 1;
>> +	const char *result;
>> +	size_t remaining_length;
>> +	size_t path_length =3D 0;
>> +
>> +	if (!url || !url_length || !cursor)
>> +		return -EINVAL;
>> +
>> +	remaining_length =3D url_length - (size_t)(*cursor - url);
>> +
>> +	result =3D memchr(*cursor, path_delimiter, remaining_length);
>> +	if (result) {
>> +		path_length =3D url_length - (size_t)(result + =
path_delimiter_length - url);
>> +
>> +		if (path)
>> +			*path =3D g_strndup(result + =
path_delimiter_length, path_length);
>=20
> Looks like you're running over > 80 chars here.

checkpatch.pl warns at 100 though the coding style docs mention 80. =
Which takes precedence?

Either way, I=E2=80=99ll re-wrap this.

>=20
>> +
>> +		*cursor +=3D path_length + path_delimiter_length;
>> +	} else if (path)
>> +		*path =3D NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int parse_url_components(const char *url,
>> +						char **scheme,
>> +						char **host,
>> +						int16_t *port,
>> +						char **path)
>> +{
>> +	size_t total_length;
>> +	const char *p;
>> +	g_autofree char *temp_scheme =3D NULL;
>> +	g_autofree char *temp_host =3D NULL;
>> +	int err =3D 0;
>> +
>> +	if (!url)
>> +		return -EINVAL;
>> +
>> +	p =3D url;
>> +
>> +	total_length =3D strlen(p);
>> +	if (!total_length)
>> +		return -EINVAL;
>> +
>> +	/* Skip any leading space, if any. */
>> +
>> +	while ((p < (url + total_length)) && g_ascii_isspace(*p))
>=20
> while (g_ascii_isspace(*p))?  The first check is redundant I think?

Agreed, in this case. The original implementation I was adapting from =
was on a non-null-terminated string, so the && check was necessary to =
not overrun the string length. With null-termination, it is redundant =
and unnecessary. I=E2=80=99ll eliminate it.

>> +	/* Attempt to handle the scheme component. */
>> +
>> +	err =3D parse_url_scheme(url, total_length, &p, &temp_scheme);
>> +	if (err !=3D 0)
>> +		goto done;
>> +
>> +	/* Attempt to handle the host component. */
>> +
>> +	err =3D parse_url_host_and_port(url, total_length, &p, =
&temp_host, port);
>> +	if (err !=3D 0)
>> +		goto done;
>> +
>> +	/* Attempt to handle the path component. */
>> +
>> +	err =3D parse_url_path(url, total_length, &p, path);
>> +	if (err !=3D 0)
>> +		goto done;
>> +
>> +	if (scheme) {
>> +		*scheme =3D temp_scheme;
>> +		temp_scheme =3D NULL;
>=20
> You could use g_steal_pointer here to make this even simpler:
>=20
> if (scheme)
> 	*scheme =3D g_steal_pointer(&temp_scheme);

In the versions of glib I was / am working against, 2.64 and 2.72, =
g_steal_pointer seemed to refuse to work on anything other than a =
variable declared with g_autoptr. It=E2=80=99s entirely possible I was =
misusing the API, however. Let me re-evaluate.

>> +	err =3D parse_url_components(request_url,
>> +							   &scheme,
>> +							   &host,
>> +							   &port,
>> +							   &path);
>=20
> The whitespacing here is really weird.

Will rectify.

>> +	if (scheme) {
>> +		if (strcasecmp(scheme, "https") =3D=3D 0)
>> +			session->port =3D 443;
>> +		else if (strcasecmp(scheme, "http") =3D=3D 0)
>> +			session->port =3D 80;
>=20
> The old code is guilty of this, but the preferred way is to use =
g_ascii_strcasecmp since the POSIX version is locale dependent.

Will rectify.

>> +	err =3D parse_url_scheme(proxy_url,
>> +						   proxy_length,
>> +						   &p,
>> +						   &scheme);
>=20
> Again the whitespace format is pretty strange

Will rectify.

>> +	if (err !=3D 0)
>> +		goto done;
>> +
>> +	err =3D parse_url_host_and_port(proxy_url,
>> +								  =
proxy_length,
>> +								  &p,
>> +								  &host,
>> +								  =
&port);
>=20
> And here

Will rectify.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


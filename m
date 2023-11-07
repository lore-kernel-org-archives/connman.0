Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72D328C2
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C523E7326A;
	Tue,  7 Nov 2023 11:41:28 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5E6C1732D2;
	Tue,  7 Nov 2023 11:41:28 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <321bbd59-0a7b-4624-8e7f-71f94356d14e@gmail.com>
Date: Tue, 7 Nov 2023 08:41:27 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD6AA3D4-E59E-47A4-BEA1-578BC55F30D7@nuovations.com>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <321bbd59-0a7b-4624-8e7f-71f94356d14e@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Denis,

Thanks for the quick and directive feedback; please see below.

On Nov 7, 2023, at 7:27 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/7/23 01:58, Grant Erickson wrote:
>> Prior to this change, 'parse_request_and_proxy_urls' failed to =
correctly
>> handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:
>>     http://[2001:db8:4006:812::200e]:8080/online/status.html
>> Such bracketing is necessary when using IPv6 addresses to =
disambiguate
>> the host component from the port component due to the presence of the
>> colon (':') in IPv6 addresses. As such, prior to this change,  such =
URLs
>> resulted in the brackets and the IPv6 address being passed to gresolv
>> which, unsurprisingly, failed to successfully forward resolve since =
the
>> resulting host was neither a valid host name nor a valid IPv6 =
address.
>> As a result, support for such RFC 2732-compliant bracketed IPv6 =
addresses
>> has been added with this change which refactors the =
previously-monolithic
>> parse_request_and_proxy_urls into several, focused functions:
>>=20
>> [ =E2=80=A6 ]
>>=20
>> In particular, 'parse_url_host' is the new function responsible for =
parsing
>> the host and correctly handling one of seven possible combinations of =
host
>> and port, two of which include bracketed IPv6  addresses.
>> In addition, 'parse_url_host' will now return an error on an empty, =
non-
>> existent host and 'parse_url_port' will return an error on invalid, =
out-of-
>> range ports.
>> ---
>>  gweb/gweb.c | 491 =
++++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 436 insertions(+), 55 deletions(-)
>=20
> Just a couple of quick comments, haven't delved into the patch itself
>=20
> <snip>
>=20
>> +static int parse_url_scheme_with_default(const char *url, size_t =
url_length,
>> +						const char **cursor,
>> +						char **scheme,
>> +						const char =
*default_scheme)
>> +{
>> +	static const char * const scheme_delimiter =3D "://";
>> +	static const size_t scheme_delimiter_length =3D 3;
>> +	const char *result;
>> +	size_t remaining_length;
>> +	size_t scheme_length =3D 0;
>> +
>> +	if (!url || !url_length || !cursor)
>> +		return -EINVAL;
>> +
>> +	remaining_length =3D (url_length - (size_t)(*cursor - url));
>=20
> Extra parens around the right side expression are not needed

Will revise.
>=20
>> +	if (remaining_length) {
>> +		result =3D (const char *)memmem(*cursor,
>=20
> This cast is likely unneeded.

Will investigate.

>> +							=
remaining_length,
>> +							=
scheme_delimiter,
>> +							=
scheme_delimiter_length);
>> +		if (result) {
>> +			scheme_length =3D (size_t)(result - *cursor);
>> +
>> +			if (scheme) {
>> +				*scheme =3D g_strndup(*cursor, =
scheme_length);
>=20
> g_strndup does not fail.

It=E2=80=99s based on malloc and if I run rlimits (such as with monit) =
or other infrastructure, malloc will fail and consequently, g_strndup =
will fail, correct?

I struggled with this one. There seems to be countervailing style on =
this front. In some places, malloc-backed allocators are checking for =
null and returning -ENOMEM, in other places they are checking and are =
returning -EINVAL (including the prior implementation of parse_url), and =
in other places, there are no checks.

Is there a preferred, go-forward style?

>> +static int parse_url_scheme(const char *url, size_t url_length,
>> +						const char **cursor,
>> +						char **scheme)
>> +{
>> +	const char * const default_scheme =3D NULL;
>=20
> const pointer to a const char? Why bother?  Also, why even have this =
parameter if it is always NULL?

Self-documenting code. Once you know the code base, great. If you =
don=E2=80=99t, then you have to go search for the declaration of what =
the NULL parameter is and what the implications of NULL are.

As expressed here, it=E2=80=99s immediately clear that the parameter is =
the default scheme. The compiler optimizes it out, so it costs nothing =
and provides the self-documenting benefit.

>> +	// Since it's the easiest to detect, first rule out an IPv6
>> +	// address. The only reliably way to do so is to search for the
>> +	// delimiting '[' and ']'. Searching for ':' may yield one of =
the
>> +	// other forms above (for example, (2), (5), or (7).
>=20
> This is not the preferred comment style for a multi-line comment.

Will update these. Should checkpatch.pl be updated to cover this since =
it did not flag it?

>> +	result =3D (const char *)memchr(*cursor, port_delimiter, =
remaining_length);
>> +	if (result) {
>> +		tmp_port =3D strtoul(result + port_delimiter_length, =
&end, 10);
>> +		if (tmp_port =3D=3D ULONG_MAX)
>> +			return -ERANGE;
>> +		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
>> +			return -ERANGE;
>> +		else if (result + 1 =3D=3D end)
>> +			return -EINVAL;
>=20
> I wish we could use ell's l_safe_atou here.

Agreed. In just about every package I=E2=80=99ve ever done, I wrap =
strto* and family and eliminate the need to callers to handle this sort =
of detail.

ELL would be nice to leverage, except that it doesn=E2=80=99t appear to =
work (compile) with linux-4.9.212 and the glibc-2.28 I need to leverage =
for the current project.

>> +static int parse_url_components(const char *url,
>> +						char **scheme,
>> +						char **host,
>> +						int16_t *port,
>> +						char **path)
>> +{
>> +	size_t total_length;
>> +	const char *p;
>> +	int err;
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
>> +	// Skip any leading space, if any.
>> +
>> +	while ((p < (url + total_length)) && isspace(*p))
>=20
> g_ascii_ is preferred here.

Will update.

>> +	// Attempt to handle the scheme component.
>> +
>> +	err =3D parse_url_scheme(url, total_length, &p, scheme);
>> +	if (err !=3D 0)
>> +		return err;
>=20
> Why not make a temporary to hold scheme using g_autofree and only =
assign *scheme on success?

I=E2=80=99m not previously-familiar with g_autofree and do not note any =
current uses of it in the code base. Happy to take a look.

>> +	// Attempt to handle the host component.
>> +
>> +	err =3D parse_url_host_and_port(url, total_length, &p, host, =
port);
>> +	if (err !=3D 0) {
>> +		if (scheme) {
>> +			g_free(*scheme);
>> +			*scheme =3D NULL;
>> +		}
>=20
> Removes the need for this ugliness.  Or use a goto.

My preferred style is single points of return at the end of a function =
with gotos from non-happy-path exceptions. This seems to be counter to =
the preferred style across the rest of the code base (though there are =
some exceptions).

Happy to revisit and reformat.

>=20
>> +
>> +		return err;
>> +	}
>> +
>> +	// Attempt to handle the path component.
>> +
>> +	err =3D parse_url_path(url, total_length, &p, path);
>> +	if (err !=3D 0) {
>> +		if (scheme) {
>> +			g_free(*scheme);
>> +			*scheme =3D NULL;
>> +		}
>> +
>> +		if (host) {
>> +			g_free(*host);
>> +			*host =3D NULL;
>> +		}
>> +
>=20
> Ditto here.
>=20
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int parse_request_and_proxy_urls(struct web_session *session,
>>  				const char *url, const char *proxy)
>>  {
>>=20
>> [ =E2=80=A6 ]
>>=20
>> +
>> +	// Parse the URL components.
>> +
>> +	err =3D parse_url_components(url,
>> +							   &scheme,
>> +							   &host,
>> +							   &port,
>> +							   &path);
>> +	if (err !=3D 0) {
>> +		g_free(scheme);
>> +		g_free(host);
>> +		g_free(path);
>> +
>=20
> Our preference is to never have side effects in functions so such code =
is never necessary.  It seems you follow this philosophy in =
parse_url_components, so why do this here?

This may have been a vestige of an initial pass as I worked through =
test-case development. I=E2=80=99ll eliminate these and re-run through =
the test cases, analyzers, and sanitizers.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB281BDEE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0BA78730EE;
	Sat, 11 Nov 2023 12:47:23 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7BBBE73106;
	Sat, 11 Nov 2023 12:47:22 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH v6 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <D7CD4553-EAFB-4A13-8847-668F8E909424@nuovations.com>
Date: Sat, 11 Nov 2023 09:47:21 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F91C98F6-5CFF-4A53-B364-5A56C77D1BA4@nuovations.com>
References: <D7CD4553-EAFB-4A13-8847-668F8E909424@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Prior to this change, 'parse_request_and_proxy_urls' failed to correctly
handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:

    http://[2001:db8:4006:812::200e]:8080/online/status.html

Such bracketing is necessary when using IPv6 addresses to disambiguate
the host component from the port component due to the presence of the
colon (':') in IPv6 addresses. As such, prior to this change, such URLs
resulted in the brackets and the IPv6 address being passed to GResolv
which, unsurprisingly, failed to successfully forward resolve since the
resulting host was neither a valid host name nor a valid IPv6 address.

As a result, support for such RFC 2732-compliant bracketed IPv6
addresses has been added with this change which refactors the
previously-monolithic 'parse_request_and_proxy_urls' into several,
focused functions:

    * parse_request_and_proxy_urls
        - parse_request_url
            o parse_url_components
                + parse_url_scheme
                + parse_url_host_and_port
                    * parse_url_host
                    * parse_url_port
                + parse_url_path
        - parse_proxy_url

In particular, 'parse_url_host' is the new function responsible for
parsing the host and correctly handling one of seven possible
combinations of host and port, two of which include bracketed IPv6
addresses.

In addition, 'parse_url_host' will now return an error on an empty,
non-existent host and 'parse_url_port' will return an error on invalid,
out-of-range ports.
---
 gweb/gweb.c | 455 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 390 insertions(+), 65 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index b68ec123438f..16980b0e6a4e 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1110,101 +1110,426 @@ static int create_transport(struct web_session =
*session)
 	return 0;
 }
=20
-static int parse_request_and_proxy_urls(struct web_session *session,
-				const char *url, const char *proxy)
+static int parse_url_scheme(const char *url, size_t url_length,
+						const char **cursor,
+						char **scheme)
 {
-	char *scheme, *host, *port, *path;
+	static const char * const scheme_delimiter =3D "://";
+	static const size_t scheme_delimiter_length =3D 3;
+	const char *result;
+	size_t remaining_length;
+	size_t scheme_length =3D 0;
=20
-	scheme =3D g_strdup(url);
-	if (!scheme)
+	if (!url || !url_length || !cursor)
 		return -EINVAL;
=20
-	host =3D strstr(scheme, "://");
-	if (host) {
-		*host =3D '\0';
-		host +=3D 3;
+	remaining_length =3D url_length - (size_t)(*cursor - url);
+	if (remaining_length) {
+		result =3D memmem(*cursor,
+					remaining_length,
+					scheme_delimiter,
+					scheme_delimiter_length);
+		if (result) {
+			scheme_length =3D (size_t)(result - *cursor);
=20
-		if (strcasecmp(scheme, "https") =3D=3D 0) {
-			session->port =3D 443;
-			session->flags |=3D SESSION_FLAG_USE_TLS;
-		} else if (strcasecmp(scheme, "http") =3D=3D 0) {
-			session->port =3D 80;
-		} else {
-			g_free(scheme);
+			if (scheme)
+				*scheme =3D g_strndup(*cursor, =
scheme_length);
+
+			*cursor +=3D scheme_length + =
scheme_delimiter_length;
+		} else if (scheme)
+			*scheme =3D NULL;
+	} else if (scheme)
+		*scheme =3D NULL;
+
+	return 0;
+}
+
+static int parse_url_host(const char *url, size_t url_length,
+						const char **cursor,
+						char **host)
+{
+	static char port_delimiter =3D ':';
+	static char path_delimiter =3D '/';
+	size_t remaining_length;
+	size_t host_length	=3D 0;
+	const char *result;
+	const char *opening_bracket;
+	const char *closing_bracket;
+	int err =3D 0;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	/*
+	 * Since it's the easiest to detect, first rule out an IPv6
+	 * address. The only reliably way to do so is to search for the
+	 * delimiting '[' and ']'. Searching for ':' may incorrectly =
yield
+	 * one of the other forms above (for example, (2), (5), or (7)).
+	 */
+	remaining_length =3D url_length - (size_t)(*cursor - url);
+
+	opening_bracket =3D memchr(*cursor, '[', remaining_length);
+	if (opening_bracket) {
+		/*
+		 * We found an opening bracket; this might be an IPv6
+		 * address. Search for its peer closing bracket.
+		 */
+		remaining_length =3D url_length - =
(size_t)(opening_bracket - url);
+
+		closing_bracket =3D memchr(opening_bracket,
+								']',
+								=
remaining_length);
+		if (!closing_bracket)
 			return -EINVAL;
-		}
+
+		/*
+		 * Assign the first character of the IPv6 address after =
the
+		 * opening bracket up to, but not including, the closing
+		 * bracket to the host name.
+		 */
+		host_length =3D closing_bracket - opening_bracket - 1;
+
+		if (host_length && host)
+			*host =3D g_strndup(opening_bracket + 1, =
host_length);
 	} else {
-		host =3D scheme;
-		session->port =3D 80;
-	}
+		/*
+		 * At this point, we either have an IPv4 address or a =
host
+		 * name, maybe with a port and maybe with a path.
+		 *
+		 * Whether we have a port or not, we definitively know =
where
+		 * the IPv4 address or host name ends. If we have a =
port, it
+		 * ends at the port delimiter, ':'. If we don't have a =
port,
+		 * then it ends at the end of the string or at the path
+		 * delimiter, if any.
+		 */
+		result =3D memchr(*cursor, port_delimiter, =
remaining_length);
+
+		/*
+		 * There was no port delimiter; attempt to find a path
+		 * delimiter.
+		 */
+		if (!result)
+			result =3D memchr(*cursor, path_delimiter, =
remaining_length);
+
+		/*
+		 * Whether stopping at the port or path delimiter, if we =
had a
+		 * result, the end of the host is the span from the =
cursor to
+		 * that result. Otherwise, it is simply the remaining =
length
+		 * of the string.
+		 */
+		if (result)
+			host_length =3D result - *cursor;
+		else
+			host_length =3D remaining_length;
=20
-	path =3D strchr(host, '/');
-	if (path)
-		*(path++) =3D '\0';
+		if (host_length && host)
+			*host =3D g_strndup(*cursor, host_length);
+	}
=20
-	if (!proxy)
-		session->request =3D g_strdup_printf("/%s", path ? path =
: "");
+	if (!host_length)
+		err =3D -EINVAL;
 	else
-		session->request =3D g_strdup(url);
+		*cursor +=3D host_length;
+
+	return err;
+}
+
+static int parse_url_port(const char *url, size_t url_length,
+						const char **cursor,
+						int16_t *port)
+{
+	static char port_delimiter =3D ':';
+	static const size_t port_delimiter_length =3D 1;
+	const char *result;
+	size_t remaining_length;
+	size_t port_length =3D 0;
+	char *end;
+	unsigned long tmp_port;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	remaining_length =3D url_length - (size_t)(*cursor - url);
+
+	result =3D memchr(*cursor, port_delimiter, remaining_length);
+	if (result) {
+		tmp_port =3D strtoul(result + port_delimiter_length, =
&end, 10);
+		if (tmp_port =3D=3D ULONG_MAX)
+			return -ERANGE;
+		else if (tmp_port > UINT16_MAX)
+			return -ERANGE;
+		else if (result + port_delimiter_length =3D=3D end)
+			return -EINVAL;
=20
-	port =3D strrchr(host, ':');
-	if (port) {
-		char *end;
-		int tmp =3D strtol(port + 1, &end, 10);
+		port_length =3D end - (result + port_delimiter_length);
=20
-		if (*end =3D=3D '\0') {
-			*port =3D '\0';
-			session->port =3D tmp;
+		*cursor +=3D port_length;
+	} else
+		tmp_port =3D -1;
+
+	if (port)
+		*port =3D (int16_t)tmp_port;
+
+	return 0;
+}
+
+static int parse_url_host_and_port(const char *url, size_t url_length,
+						const char **cursor,
+						char **host,
+						int16_t *port)
+{
+	g_autofree char *temp_host =3D NULL;
+	int err =3D 0;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	/* Attempt to handle the host component. */
+
+	err =3D parse_url_host(url, url_length, cursor, &temp_host);
+	if (err !=3D 0)
+		goto done;
+
+	/* Attempt to handle the port component. */
+
+	err =3D parse_url_port(url, url_length, cursor, port);
+	if (err !=3D 0)
+		goto done;
+
+	if (host)
+		*host =3D g_steal_pointer(&temp_host);
+
+done:
+	return err;
+}
+
+static int parse_url_path(const char *url, size_t url_length,
+						const char **cursor,
+						char **path)
+{
+	static char path_delimiter =3D '/';
+	static const size_t path_delimiter_length =3D 1;
+	const char *result;
+	size_t remaining_length;
+	size_t path_length =3D 0;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	remaining_length =3D url_length - (size_t)(*cursor - url);
+
+	result =3D memchr(*cursor, path_delimiter, remaining_length);
+	if (result) {
+		path_length =3D url_length -
+			(size_t)(result + path_delimiter_length - url);
+
+		if (path)
+			*path =3D g_strndup(result + =
path_delimiter_length, path_length);
+
+		*cursor +=3D path_length + path_delimiter_length;
+	} else if (path)
+		*path =3D NULL;
+
+	return 0;
+}
+
+static int parse_url_components(const char *url,
+						char **scheme,
+						char **host,
+						int16_t *port,
+						char **path)
+{
+	size_t total_length;
+	const char *p;
+	g_autofree char *temp_scheme =3D NULL;
+	g_autofree char *temp_host =3D NULL;
+	int err =3D 0;
+
+	if (!url)
+		return -EINVAL;
+
+	p =3D url;
+
+	total_length =3D strlen(p);
+	if (!total_length)
+		return -EINVAL;
+
+	/* Skip any leading space, if any. */
+
+	while (g_ascii_isspace(*p))
+		p++;
+
+	/* Attempt to handle the scheme component. */
+
+	err =3D parse_url_scheme(url, total_length, &p, &temp_scheme);
+	if (err !=3D 0)
+		goto done;
+
+	/* Attempt to handle the host component. */
+
+	err =3D parse_url_host_and_port(url, total_length, &p, =
&temp_host, port);
+	if (err !=3D 0)
+		goto done;
+
+	/* Attempt to handle the path component. */
+
+	err =3D parse_url_path(url, total_length, &p, path);
+	if (err !=3D 0)
+		goto done;
+
+	if (scheme)
+		*scheme =3D g_steal_pointer(&temp_scheme);
+
+	if (host)
+		*host =3D g_steal_pointer(&temp_host);
+
+done:
+	return err;
+}
+
+static int parse_request_url(struct web_session *session,
+				const char *request_url, bool =
has_proxy_url)
+{
+	g_autofree char *scheme =3D NULL;
+	g_autofree char *host =3D NULL;
+	g_autofree char *path =3D NULL;
+	int16_t port =3D -1;
+	int err =3D 0;
+
+	if (!session || !request_url)
+		return -EINVAL;
+
+	/* Parse the request URL components. */
+
+	err =3D parse_url_components(request_url,
+			&scheme,
+			&host,
+			&port,
+			&path);
+	if (err !=3D 0)
+		goto done;
+
+	/*
+	 * Handle the URL scheme, if any, for the session, defaulting to
+	 * the "http" scheme and port 80.
+	 */
+	if (scheme) {
+		if (g_ascii_strcasecmp(scheme, "https") =3D=3D 0)
+			session->port =3D 443;
+		else if (g_ascii_strcasecmp(scheme, "http") =3D=3D 0)
+			session->port =3D 80;
+		else {
+			err =3D -EINVAL;
+			goto done;
 		}
+	} else
+		session->port =3D 80;
+
+	/* Handle the URL host and port, if any, for the session. */
=20
-		if (!proxy)
+	if (port !=3D -1) {
+		session->port =3D port;
+
+		if (!has_proxy_url)
 			session->host =3D g_strdup(host);
 		else
-			session->host =3D g_strdup_printf("%s:%u", host, =
tmp);
+			session->host =3D g_strdup_printf("%s:%u", host, =
port);
 	} else
 		session->host =3D g_strdup(host);
=20
-	g_free(scheme);
+	/* Handle the URL path, if any, for the session. */
=20
-	if (!proxy)
-		return 0;
+	if (!has_proxy_url)
+		session->request =3D g_strdup_printf("/%s", path ? path =
: "");
+	else
+		session->request =3D g_strdup(request_url);
+
+done:
+	return err;
+}
=20
-	scheme =3D g_strdup(proxy);
-	if (!scheme)
+static int parse_proxy_url(struct web_session *session, const char =
*proxy_url)
+{
+	const char *p;
+	size_t proxy_length;
+	g_autofree char *scheme =3D NULL;
+	g_autofree char *host =3D NULL;
+	int16_t port =3D -1;
+	int err =3D 0;
+
+	if (!session || !proxy_url)
 		return -EINVAL;
=20
-	host =3D strstr(proxy, "://");
-	if (host) {
-		*host =3D '\0';
-		host +=3D 3;
+	/*
+	 * Parse the proxy URL scheme, host, and port, the only three
+	 * components we care about.
+	 */
+	p =3D proxy_url;
+	proxy_length =3D strlen(p);
+
+	err =3D parse_url_scheme(proxy_url,
+			proxy_length,
+			&p,
+			&scheme);
+	if (err !=3D 0)
+		goto done;
+
+	err =3D parse_url_host_and_port(proxy_url,
+			proxy_length,
+			&p,
+			&host,
+			&port);
+	if (err !=3D 0)
+		goto done;
+
+	/*
+	 * Handle the proxy URL scheme, if any, for the session. Only
+	 * "http" is allowed.
+	 */
+	if (scheme && g_ascii_strcasecmp(scheme, "http") !=3D 0) {
+		err =3D -EINVAL;
+		goto done;
+	}
=20
-		if (strcasecmp(scheme, "http") !=3D 0) {
-			g_free(scheme);
-			return -EINVAL;
-		}
-	} else
-		host =3D scheme;
+	/*
+	 * Handle the proxy URL host and port for the session.
+	 */
+	if (host)
+		session->address =3D host;
=20
-	path =3D strchr(host, '/');
-	if (path)
-		*(path++) =3D '\0';
+	if (port !=3D -1)
+		session->port =3D port;
=20
-	port =3D strrchr(host, ':');
-	if (port) {
-		char *end;
-		int tmp =3D strtol(port + 1, &end, 10);
+done:
+	return err;
+}
=20
-		if (*end =3D=3D '\0') {
-			*port =3D '\0';
-			session->port =3D tmp;
-		}
-	}
+static int parse_request_and_proxy_urls(struct web_session *session,
+				const char *url, const char *proxy)
+{
+	const bool has_proxy_url =3D (proxy !=3D NULL);
+	int err =3D 0;
=20
-	session->address =3D g_strdup(host);
+	if (!session || !url)
+		return -EINVAL;
=20
-	g_free(scheme);
+	/* Parse and handle the request URL */
=20
-	return 0;
+	err =3D parse_request_url(session, url, has_proxy_url);
+	if (err !=3D 0)
+		goto done;
+
+	if (!has_proxy_url)
+		goto done;
+
+	/* Parse and handle the proxy URL */
+
+	err =3D parse_proxy_url(session, proxy);
+	if (err !=3D 0)
+		goto done;
+
+done:
+	return err;
 }
=20
 static void handle_resolved_address(struct web_session *session)
--=20
2.42.0


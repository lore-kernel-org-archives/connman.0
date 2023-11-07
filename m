Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9858C12D
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D9436731C2
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:58:38 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8CCEA7328E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 02:58:38 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
Date: Mon, 6 Nov 2023 23:58:38 -0800
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
Message-Id: <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Prior to this change, 'parse_request_and_proxy_urls' failed to correctly
handle RFC 2732-compliant URLs with bracketed IPv6 addresses such as:

    http://[2001:db8:4006:812::200e]:8080/online/status.html

Such bracketing is necessary when using IPv6 addresses to disambiguate
the host component from the port component due to the presence of the
colon (':') in IPv6 addresses. As such, prior to this change,  such URLs
resulted in the brackets and the IPv6 address being passed to gresolv
which, unsurprisingly, failed to successfully forward resolve since the
resulting host was neither a valid host name nor a valid IPv6 address.

As a result, support for such RFC 2732-compliant bracketed IPv6 =
addresses
has been added with this change which refactors the =
previously-monolithic
parse_request_and_proxy_urls into several, focused functions:

    * parse_request_and_proxy_urls
        - parse_url_components
            o parse_url_scheme
                + parse_url_scheme_with_default
            o parse_url_host_and_port
                + parse_url_host
                + parse_url_port
            o parse_url_path

In particular, 'parse_url_host' is the new function responsible for =
parsing
the host and correctly handling one of seven possible combinations of =
host
and port, two of which include bracketed IPv6  addresses.

In addition, 'parse_url_host' will now return an error on an empty, non-
existent host and 'parse_url_port' will return an error on invalid, =
out-of-
range ports.
---
 gweb/gweb.c | 491 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 436 insertions(+), 55 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4d464cf2..2a4e6fab 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -23,6 +23,7 @@
 #include <config.h>
 #endif
=20
+#include <ctype.h>
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -1107,99 +1108,479 @@ static int create_transport(struct web_session =
*session)
 	return 0;
 }
=20
+static int parse_url_scheme_with_default(const char *url, size_t =
url_length,
+						const char **cursor,
+						char **scheme,
+						const char =
*default_scheme)
+{
+	static const char * const scheme_delimiter =3D "://";
+	static const size_t scheme_delimiter_length =3D 3;
+	const char *result;
+	size_t remaining_length;
+	size_t scheme_length =3D 0;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	remaining_length =3D (url_length - (size_t)(*cursor - url));
+	if (remaining_length) {
+		result =3D (const char *)memmem(*cursor,
+							=
remaining_length,
+							=
scheme_delimiter,
+							=
scheme_delimiter_length);
+		if (result) {
+			scheme_length =3D (size_t)(result - *cursor);
+
+			if (scheme) {
+				*scheme =3D g_strndup(*cursor, =
scheme_length);
+				if (!*scheme)
+					return -ENOMEM;
+			}
+
+			*cursor +=3D scheme_length + =
scheme_delimiter_length;
+		} else if (scheme && default_scheme) {
+			scheme_length =3D strlen(default_scheme);
+
+			*cursor +=3D scheme_length;
+
+			*scheme =3D g_strndup(default_scheme, =
scheme_length);
+			if (!*scheme)
+				return -ENOMEM;
+		} else if (scheme)
+			*scheme =3D NULL;
+	} else if (scheme)
+		*scheme =3D NULL;
+
+	return 0;
+}
+
+static int parse_url_scheme(const char *url, size_t url_length,
+						const char **cursor,
+						char **scheme)
+{
+	const char * const default_scheme =3D NULL;
+
+	return parse_url_scheme_with_default(url,
+		url_length,
+		cursor,
+		scheme,
+		default_scheme);
+}
+
+static int parse_url_host(const char *url, size_t url_length,
+						const char **cursor,
+						char **host)
+{
+	size_t remaining_length;
+	size_t host_length	=3D 0;
+	const char *result;
+	const char *opening_bracket;
+	const char *closing_bracket;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	// Since it's the easiest to detect, first rule out an IPv6
+	// address. The only reliably way to do so is to search for the
+	// delimiting '[' and ']'. Searching for ':' may yield one of =
the
+	// other forms above (for example, (2), (5), or (7).
+
+	remaining_length =3D (url_length - (size_t)(*cursor - url));
+
+	opening_bracket =3D (const char *)memchr(*cursor, '[', =
remaining_length);
+	if (opening_bracket) {
+		// We found an opening bracket; this might be an IPv6
+		// address. Search for its peer closing bracket.
+
+		remaining_length =3D (url_length - =
(size_t)(opening_bracket - url));
+
+		closing_bracket =3D (const char =
*)memchr(opening_bracket,
+									=
']',
+									=
remaining_length);
+		if (!closing_bracket)
+			return -EINVAL;
+
+		// Assign the first character of the IPv6 address after =
the
+		// opening bracket up to, but not including, the closing
+		// bracket to the host name.
+
+		host_length =3D (size_t)(closing_bracket - =
opening_bracket) - 1;
+
+		if (host) {
+			*host =3D g_strndup(opening_bracket + 1, =
host_length);
+			if (!*host)
+				return -ENOMEM;
+		}
+
+		// Move the parsing cursor past the closing bracket.
+
+		*cursor =3D closing_bracket + 1;
+	} else {
+		// At this point, we either have an IPv4 address or a =
host
+		// name, maybe with a port.
+		//
+		// Whether we have a port or not, we definitively know =
where
+		// the IPv4 address or host name ends. If we have a =
port, it
+		// ends at the port delimiter, ':'. If we don't have a =
port,
+		// then it ends at the end of the string or at the path
+		// delimiter, if any.
+
+		result =3D (const char *)memchr(*cursor, ':', =
remaining_length);
+		if (result) {
+			// There is a port and an IPv4 address or a host =
name.
+			// Assign the latter to the host and handle the =
port
+			// later.
+
+			host_length =3D (size_t)(result - *cursor);
+
+			if (host) {
+				*host =3D g_strndup(*cursor, =
host_length);
+				if (!*host)
+					return -ENOMEM;
+			}
+
+			*cursor +=3D host_length;
+		} else {
+			// There is no port, just an IPv4 address or a =
host name,
+			// potentially followed by a path.
+
+			result =3D (const char *)memchr(*cursor, '/', =
remaining_length);
+			if (result)
+				host_length =3D (size_t)(result - =
*cursor);
+			else
+				host_length =3D remaining_length;
+
+			if (host) {
+				*host =3D g_strndup(*cursor, =
host_length);
+				if (!*host)
+					return -ENOMEM;
+			}
+
+			*cursor +=3D host_length;
+		}
+	}
+
+	if (!host_length)
+		return -EINVAL;
+
+	return 0;
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
+	remaining_length =3D (url_length - (size_t)(*cursor - url));
+
+	result =3D (const char *)memchr(*cursor, port_delimiter, =
remaining_length);
+	if (result) {
+		tmp_port =3D strtoul(result + port_delimiter_length, =
&end, 10);
+		if (tmp_port =3D=3D ULONG_MAX)
+			return -ERANGE;
+		else if (tmp_port < 0 || tmp_port > UINT16_MAX)
+			return -ERANGE;
+		else if (result + 1 =3D=3D end)
+			return -EINVAL;
+
+		if (*end !=3D '\0')
+			port_length =3D remaining_length;
+		else
+			port_length =3D end - (result + =
port_delimiter_length);
+
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
+	int err;
+
+	if (!url || !url_length || !cursor)
+		return -EINVAL;
+
+	// Attempt to handle the host component.
+
+	err =3D parse_url_host(url, url_length, cursor, host);
+	if (err !=3D 0)
+		return err;
+
+	// Attempt to handle the port component.
+
+	err =3D parse_url_port(url, url_length, cursor, port);
+	if (err !=3D 0) {
+		if (host) {
+			g_free(*host);
+			*host =3D NULL;
+		}
+
+		return err;
+	}
+
+	return 0;
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
+	remaining_length =3D (url_length - (size_t)(*cursor - url));
+
+	result =3D (const char *)memchr(*cursor, path_delimiter, =
remaining_length);
+	if (result) {
+		path_length =3D (url_length - (size_t)(result + =
path_delimiter_length - url));
+
+		if (path) {
+			*path =3D g_strndup(result + =
path_delimiter_length, path_length);
+			if (!*path)
+				return -ENOMEM;
+		}
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
+	int err;
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
+	// Skip any leading space, if any.
+
+	while ((p < (url + total_length)) && isspace(*p))
+		p++;
+
+	// Attempt to handle the scheme component.
+
+	err =3D parse_url_scheme(url, total_length, &p, scheme);
+	if (err !=3D 0)
+		return err;
+
+	// Attempt to handle the host component.
+
+	err =3D parse_url_host_and_port(url, total_length, &p, host, =
port);
+	if (err !=3D 0) {
+		if (scheme) {
+			g_free(*scheme);
+			*scheme =3D NULL;
+		}
+
+		return err;
+	}
+
+	// Attempt to handle the path component.
+
+	err =3D parse_url_path(url, total_length, &p, path);
+	if (err !=3D 0) {
+		if (scheme) {
+			g_free(*scheme);
+			*scheme =3D NULL;
+		}
+
+		if (host) {
+			g_free(*host);
+			*host =3D NULL;
+		}
+
+		return err;
+	}
+
+	return 0;
+}
+
 static int parse_request_and_proxy_urls(struct web_session *session,
 				const char *url, const char *proxy)
 {
-	char *scheme, *host, *port, *path;
+	size_t proxy_length;
+	const char *p;
+	char *scheme =3D NULL;
+	char *host =3D NULL;
+	char *path =3D NULL;
+	int16_t port =3D -1;
+	int err;
=20
-	scheme =3D g_strdup(url);
-	if (!scheme)
+	if (!session || !url)
 		return -EINVAL;
=20
-	host =3D strstr(scheme, "://");
-	if (host) {
-		*host =3D '\0';
-		host +=3D 3;
+	p =3D url;
+
+	// Parse the URL components.
+
+	err =3D parse_url_components(url,
+							   &scheme,
+							   &host,
+							   &port,
+							   &path);
+	if (err !=3D 0) {
+		g_free(scheme);
+		g_free(host);
+		g_free(path);
+
+		return err;
+	}
+
+	// Handle the URL scheme, if any, for the session, defaulting to
+	// the "http" scheme and port 80.
=20
+	if (scheme) {
 		if (strcasecmp(scheme, "https") =3D=3D 0) {
 			session->port =3D 443;
-			session->flags |=3D SESSION_FLAG_USE_TLS;
 		} else if (strcasecmp(scheme, "http") =3D=3D 0) {
 			session->port =3D 80;
 		} else {
 			g_free(scheme);
+			g_free(host);
+			g_free(path);
 			return -EINVAL;
 		}
+
+		g_free(scheme);
 	} else {
-		host =3D scheme;
 		session->port =3D 80;
 	}
=20
-	path =3D strchr(host, '/');
-	if (path)
-		*(path++) =3D '\0';
+	// Handle the URL host and port, if any, for the session.
=20
-	if (!proxy)
-		session->request =3D g_strdup_printf("/%s", path ? path =
: "");
-	else
-		session->request =3D g_strdup(url);
-
-	port =3D strrchr(host, ':');
-	if (port) {
-		char *end;
-		int tmp =3D strtol(port + 1, &end, 10);
+	if (port !=3D -1) {
+		session->port =3D port;
=20
-		if (*end =3D=3D '\0') {
-			*port =3D '\0';
-			session->port =3D tmp;
-		}
-
-		if (!proxy)
+		if (!proxy) {
 			session->host =3D g_strdup(host);
-		else
-			session->host =3D g_strdup_printf("%s:%u", host, =
tmp);
-	} else
+			if (!session->host) {
+				g_free(host);
+				g_free(path);
+				return -ENOMEM;
+			}
+		} else {
+			session->host =3D g_strdup_printf("%s:%u", host, =
port);
+			if (!session->host) {
+				g_free(host);
+				g_free(path);
+				return -ENOMEM;
+			}
+		}
+	} else {
 		session->host =3D g_strdup(host);
+		if (!session->host) {
+			g_free(host);
+			g_free(path);
+			return -ENOMEM;
+		}
+	}
=20
-	g_free(scheme);
+	// Handle the URL path, if any, for the session.
+
+	if (!proxy) {
+		session->request =3D g_strdup_printf("/%s", path ? path =
: "");
+		if (!session->request) {
+			g_free(host);
+			g_free(path);
+			return -ENOMEM;
+		}
+	} else {
+		session->request =3D g_strdup(url);
+		if (!session->request) {
+			g_free(host);
+			g_free(path);
+			return -ENOMEM;
+		}
+	}
+
+	g_free(host);
+	g_free(path);
=20
 	if (!proxy)
 		return 0;
=20
-	scheme =3D g_strdup(proxy);
-	if (!scheme)
-		return -EINVAL;
+	// Parse the proxy scheme, host, and port, the only three
+	// components we care about.
+
+	p =3D proxy;
+	proxy_length =3D strlen(p);
+
+	err =3D parse_url_scheme(proxy,
+						   proxy_length,
+						   &p,
+						   &scheme);
+	if (err !=3D 0)
+		return err;
+
+	err =3D parse_url_host_and_port(proxy,
+								  =
proxy_length,
+								  &p,
+								  &host,
+								  =
&port);
+	if (err !=3D 0) {
+		g_free(scheme);
+
+		return err;
+	}
=20
-	host =3D strstr(proxy, "://");
-	if (host) {
-		*host =3D '\0';
-		host +=3D 3;
+	// Handle the proxy URL scheme, if any, for the session. Only
+	// "http" is allowed.
=20
+	if (scheme) {
 		if (strcasecmp(scheme, "http") !=3D 0) {
 			g_free(scheme);
+			g_free(host);
 			return -EINVAL;
 		}
-	} else
-		host =3D scheme;
-
-	path =3D strchr(host, '/');
-	if (path)
-		*(path++) =3D '\0';
-
-	port =3D strrchr(host, ':');
-	if (port) {
-		char *end;
-		int tmp =3D strtol(port + 1, &end, 10);
=20
-		if (*end =3D=3D '\0') {
-			*port =3D '\0';
-			session->port =3D tmp;
-		}
+		g_free(scheme);
 	}
=20
-	session->address =3D g_strdup(host);
+	// Handle the proxy URL host and port for the session.
+
+	if (host)
+		session->address =3D host;
=20
-	g_free(scheme);
+	if (port !=3D -1)
+		session->port =3D port;
=20
 	return 0;
 }
--=20
2.42.0


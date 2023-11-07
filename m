Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3D210B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B34DA730EF
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 17:54:22 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 669C673100
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 17:54:22 -0500 (EST)
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
Subject: [PATCH 3/3 v2] gweb: Add documentation to URL parsing functions.
Date: Tue, 7 Nov 2023 14:54:22 -0800
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <D1441574-E298-4CA2-B316-40DD1789E4A6@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <D1441574-E298-4CA2-B316-40DD1789E4A6@nuovations.com>
Message-Id: <7D22A1A1-7A39-4537-B216-CD16A5D0077E@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the following URL parsing functions:

    * parse_request_and_proxy_urls
         - parse_request_url
            o parse_url_components
                + parse_url_scheme
                    > parse_url_scheme_with_default
                + parse_url_host_and_port
                    > parse_url_host
                    > parse_url_port
                + parse_url_path
         - parse_proxy_url
---
 gweb/gweb.c | 433 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 433 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 772b291e..1baa0df2 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1107,6 +1107,46 @@ static int create_transport(struct web_session =
*session)
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the scheme component from a URL with an
+ *    optional default fallback.
+ *
+ *  This attempts to parse the scheme component from the specified URL
+ *  of the provided length at the specified cursor point in the
+ *  URL. If a scheme cannot be parsed, the provided optional default
+ *  fallback is used. If provided, the parsed scheme is copied and
+ *  assigned to @a scheme.
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *scheme, if provided, on success.
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the scheme component.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the scheme. On
+ *                                  success, this is updated to the
+ *                                  first byte past the parsed scheme.
+ *  @param[in,out]  scheme          An optional pointer to storage to
+ *                                  assign a copy of the parsed scheme
+ *                                  on success.
+ *  @param[in]      default_scheme  An optional pointer to the =
immutable
+ *                                  null-terminated C string to use of
+ *                                  a scheme cannot be parsed from @a
+ *                                  url at @a cursor.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, or @a
+ *                    cursor was null.
+ *
+ *  @sa parse_url_scheme
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_scheme_with_default(const char *url, size_t =
url_length,
 						const char **cursor,
 						char **scheme,
@@ -1146,6 +1186,40 @@ static int parse_url_scheme_with_default(const =
char *url, size_t url_length,
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the scheme component from a URL.
+ *
+ *  This attempts to parse the scheme component from the specified URL
+ *  of the provided length at the specified cursor point in the
+ *  URL. If provided, the parsed scheme is copied and
+ *  assigned to @a scheme.
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *scheme, if provided, on success.
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the scheme component.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the scheme. On
+ *                                  success, this is updated to the
+ *                                  first byte past the parsed scheme.
+ *  @param[in,out]  scheme          An optional pointer to storage to
+ *                                  assign a copy of the parsed scheme
+ *                                  on success.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, or @a
+ *                    cursor was null.
+ *
+ *  @sa parse_url_scheme_with_default
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_scheme(const char *url, size_t url_length,
 						const char **cursor,
 						char **scheme)
@@ -1159,6 +1233,51 @@ static int parse_url_scheme(const char *url, =
size_t url_length,
 		default_scheme);
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the host component from a URL.
+ *
+ *  This attempts to parse the host component from the specified
+ *  URL of the provided length at the specified cursor point in the
+ *  URL. If provided, the parsed host is copied and assigned to @a
+ *  host.
+ *
+ *  Compliant with RFC 2732, the format of the host component of the
+ *  URL may be one of the following:
+ *
+ *    1. "[\<IPv6 Address>]"
+ *    2. "[\<IPv6 Address>]:<Port>"
+ *    4. "\<IPv4 Address>"
+ *    5. "\<IPv4 Address>:<Port>"
+ *    6. "\<Host Name>"
+ *    7. "\<Host Name>:<Port>"
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *host, if provided, on success.
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the host component.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the host. On
+ *                                  success, this is updated to the
+ *                                  first byte past the parsed host.
+ *  @param[in,out]  host            An optional pointer to storage to
+ *                                  assign a copy of the parsed host
+ *                                  on success.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, @a
+ *                    cursor was null, or if the host portion of @a
+ *                    url is malformed.
+ *
+ *  @sa parse_url_host_and_port
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_host(const char *url, size_t url_length,
 						const char **cursor,
 						char **host)
@@ -1264,6 +1383,50 @@ static int parse_url_host(const char *url, size_t =
url_length,
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the port component from a URL.
+ *
+ *  This attempts to parse the port component from the specified URL
+ *  of the provided length at the specified cursor point in the
+ *  URL. If provided, the parsed port is assigned to @a port.
+ *
+ *  Compliant with RFC 2732, the format of the host component of the
+ *  URL may be one of the following:
+ *
+ *    1. "[\<IPv6 Address>]"
+ *    2. "[\<IPv6 Address>]:<Port>"
+ *    4. "\<IPv4 Address>"
+ *    5. "\<IPv4 Address>:<Port>"
+ *    6. "\<Host Name>"
+ *    7. "\<Host Name>:<Port>"
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the port component.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the port. On
+ *                                  success, this is updated to the
+ *                                  first byte past the parsed port.
+ *  @param[in,out]  port            An optional pointer to storage to
+ *                                  assign the parsed port on
+ *                                  success. On failure or absence of
+ *                                  a port to parsed, this is assigned
+ *                                  -1.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, @a
+ *                    cursor was null, or if there were no characters
+ *                    to parse after the port delimiter (':').
+ *  @retval  -ERANGE  If the parsed port was outside of the range [0,
+ *                    65535], inclusive.
+ *
+ *  @sa parse_url_host_and_port
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_port(const char *url, size_t url_length,
 						const char **cursor,
 						int16_t *port)
@@ -1306,6 +1469,61 @@ static int parse_url_port(const char *url, size_t =
url_length,
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the host and port components from a URL.
+ *
+ *  This attempts to parse the host and port components from the
+ *  specified URL of the provided length at the specified cursor point
+ *  in the URL. If provided, the parsed host is copied and assigned to
+ *  @a host and, if provided, the parsed port is assigned to @a port.
+ *
+ *  Compliant with RFC 2732, the format of the host component of the
+ *  URL may be one of the following:
+ *
+ *    1. "[\<IPv6 Address>]"
+ *    2. "[\<IPv6 Address>]:<Port>"
+ *    4. "\<IPv4 Address>"
+ *    5. "\<IPv4 Address>:<Port>"
+ *    6. "\<Host Name>"
+ *    7. "\<Host Name>:<Port>"
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *host, if provided, on success.
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the host and port components.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the host and
+ *                                  port. On success, this is updated
+ *                                  to the first byte past the parsed
+ *                                  host or port, if present.
+ *  @param[in,out]  host            An optional pointer to storage to
+ *                                  assign a copy of the parsed host
+ *                                  on success.
+ *  @param[in,out]  port            An optional pointer to storage to
+ *                                  assign the parsed port on
+ *                                  success. On failure or absence of
+ *                                  a port to parsed, this is assigned
+ *                                  -1.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, @a
+ *                    cursor was null, if the host portion of @a url
+ *                    is malformed, or if there were no characters to
+ *                    parse after the port delimiter (':').
+ *  @retval  -ERANGE  If the parsed port was outside of the range [0,
+ *                    65535], inclusive.
+ *
+ *  @sa parse_url_host
+ *  @sa parse_url_port
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_host_and_port(const char *url, size_t url_length,
 						const char **cursor,
 						char **host,
@@ -1338,6 +1556,39 @@ done:
 	return err;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the path component from a URL.
+ *
+ *  This attempts to parse the path component from the specified
+ *  URL of the provided length at the specified cursor point in the
+ *  URL. If provided, the parsed path is copied and assigned to @a
+ *  path.
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to @a *path, if provided, on success.
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the path component.
+ *  @param[in]      url_length      The length, in bytes, of @a url.
+ *  @param[in,out]  cursor          A pointer to the current parsing
+ *                                  position within @a url at which to
+ *                                  start parsing the path. On
+ *                                  success, this is updated to the
+ *                                  first byte past the parsed path.
+ *  @param[in,out]  path            An optional pointer to storage to
+ *                                  assign a copy of the parsed path
+ *                                  on success.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url_length was zero, or @a
+ *                    cursor was null.
+ *
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_path(const char *url, size_t url_length,
 						const char **cursor,
 						char **path)
@@ -1368,6 +1619,60 @@ static int parse_url_path(const char *url, size_t =
url_length,
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the scheme, host, port, and path components
+ *    from a URL.
+ *
+ *  This attempts to parse the scheme, host, port, and path components
+ *  from the specified URL. If provided, the parsed scheme, host and
+ *  path are copied and assigned to @a scheme, @a host, and @a path,
+ *  respective and the parsed port is assigned to @a port.
+ *
+ *  Compliant with RFC 2732, the format of the host component of the
+ *  URL may be one of the following:
+ *
+ *    1. "[\<IPv6 Address>]"
+ *    2. "[\<IPv6 Address>]:<Port>"
+ *    4. "\<IPv4 Address>"
+ *    5. "\<IPv4 Address>:<Port>"
+ *    6. "\<Host Name>"
+ *    7. "\<Host Name>:<Port>"
+ *
+ *  @param[in]      url             A pointer to the immutable null-
+ *                                  terminated C string from which to
+ *                                  parse the scheme component.
+ *  @param[in,out]  scheme          An optional pointer to storage to
+ *                                  assign a copy of the parsed scheme
+ *                                  on success.
+ *  @param[in,out]  host            An optional pointer to storage to
+ *                                  assign a copy of the parsed host
+ *                                  on success.
+ *  @param[in,out]  port            An optional pointer to storage to
+ *                                  assign the parsed port on
+ *                                  success. On failure or absence of
+ *                                  a port to parsed, this is assigned
+ *                                  -1.
+ *  @param[in,out]  path            An optional pointer to storage to
+ *                                  assign a copy of the parsed path
+ *                                  on success.
+ *
+ *  @retval  0        If successful.
+ *  @retavl  -EINVAL  If @a url was null, @a url length was zero, if
+ *                    the host portion of @a url is malformed, or if
+ *                    there were no characters to parse after the port
+ *                    delimiter (':').
+ *  @retval  -ERANGE  If the parsed port was outside of the range [0,
+ *                    65535], inclusive.
+ *
+ *  @sa parse_url_scheme_with_default
+ *  @sa parse_url_scheme
+ *  @sa parse_url_host
+ *  @sa parse_url_port
+ *  @sa parse_url_host_and_port
+ *  @sa parse_url_path
+ *
+ */
 static int parse_url_components(const char *url,
 						char **scheme,
 						char **host,
@@ -1426,6 +1731,46 @@ done:
 	return err;
 }
=20
+/**
+ *	@brief
+ *	  Attempt to parse the request URL for the web request session.
+ *
+ *	This attempts to parse the specified request URL for the =
specified
+ *	web request session. =46rom the request URL, the scheme is =
parsed,
+ *	mapped and assigned to the @a session port field and the host =
and
+ *	path are parsed, copied, and assigned to the host and request
+ *	fields, respectively.
+ *
+ *	Compliant with RFC 2732, the format of the host component of the
+ *	request and proxy URLs may be one of the following:
+ *
+ *	  1. "[\<IPv6 Address>]"
+ *	  2. "[\<IPv6 Address>]:<Port>"
+ *	  4. "\<IPv4 Address>"
+ *	  5. "\<IPv4 Address>:<Port>"
+ *	  6. "\<Host Name>"
+ *	  7. "\<Host Name>:<Port>"
+ *
+ *	@note
+ *	  The caller is responsible for deallocating the memory assigned
+ *	  to the @a session host, request, and address fields.
+ *
+ *	@param[in,out]	session	     A pointer to the mutable web =
session
+ *							     request =
object to be populated from
+ *							     @a url and, =
if provided, @a proxy. On
+ *							     success, =
the session port, host,
+ *							     request, =
and address fields will be
+ *							     populated =
from the parsed request URL.
+ *	@param[in]		request_url  A pointer to the immutable =
null-
+ *							     terminated =
C string containing the
+ *							     request URL =
to parse.
+ *
+ *	@retval	 0		  If successful.
+ *	@retval	 -EINVAL  If @request_url was not a valid URL.
+ *
+ *  @sa parse_url_components
+ *
+ */
 static int parse_request_url(struct web_session *session,
 				const char *request_url, bool =
has_proxy_url)
 {
@@ -1488,6 +1833,46 @@ done:
     return err;
 }
=20
+/**
+ *	@brief
+ *	  Attempt to parse the proxy URL for the web request session.
+ *
+ *	This attempts to parse the specified proxy URL for the specified
+ *	web request session. =46rom the proxy URL, the port component is
+ *	parsed and assigned to the @a session port field and the host
+ *	component is parsed, copied, and assigned to the address field.
+ *
+ *	Compliant with RFC 2732, the format of the host component of the
+ *	request and proxy URLs may be one of the following:
+ *
+ *	  1. "[\<IPv6 Address>]"
+ *	  2. "[\<IPv6 Address>]:<Port>"
+ *	  4. "\<IPv4 Address>"
+ *	  5. "\<IPv4 Address>:<Port>"
+ *	  6. "\<Host Name>"
+ *	  7. "\<Host Name>:<Port>"
+ *
+ *	@note
+ *	  The caller is responsible for deallocating the memory assigned
+ *	  to the @a session address field.
+ *
+ *	@param[in,out]	session	     A pointer to the mutable web =
session
+ *							     request =
object to be populated from
+ *							     @a url and, =
if provided, @a proxy. On
+ *							     success, =
the session port and address
+ *							     fields will =
be populated from the
+ *							     parsed =
proxy URL.
+ *	@param[in]		proxy_url    A pointer to the immutable =
null-
+ *							     terminated =
C string containing the
+ *							     web proxy =
URL to parse.
+ *
+ *	@retval	 0		  If successful.
+ *	@retval	 -EINVAL  If @a proxy_url was not a valid URL.
+ *
+ *  @sa parse_url_scheme
+ *  @sa parse_url_host_and_port
+ *
+ */
 static int parse_proxy_url(struct web_session *session, const char =
*proxy_url)
 {
 	size_t proxy_length;
@@ -1547,6 +1932,54 @@ done:
     return err;
 }
=20
+/**
+ *  @brief
+ *    Attempt to parse the request and proxy URLs for the web request
+ *    session.
+ *
+ *  This attempts to parse the specified request and optional proxy
+ *  URL for the specified web request session. =46rom the request URL,
+ *  the scheme is parsed, mapped and assigned to the @a session port
+ *  field and the host and path are parsed, copied, and assigned to
+ *  the host and request fields, respectively. =46rom the proxy URL, if
+ *  present, the port component is parsed and assigned to the @a
+ *  session port field and the host component is parsed, copied, and
+ *  assigned to the address field.
+ *
+ *  Compliant with RFC 2732, the format of the host component of the
+ *  request and proxy URLs may be one of the following:
+ *
+ *    1. "[\<IPv6 Address>]"
+ *    2. "[\<IPv6 Address>]:<Port>"
+ *    4. "\<IPv4 Address>"
+ *    5. "\<IPv4 Address>:<Port>"
+ *    6. "\<Host Name>"
+ *    7. "\<Host Name>:<Port>"
+ *
+ *  @note
+ *    The caller is responsible for deallocating the memory assigned
+ *    to the @a session host, request, and address fields.
+ *
+ *  @param[in,out]  session  A pointer to the mutable web session =
request
+ *                           object to be populated from @a url and,
+ *                           if provided, @a proxy. On success, the
+ *                           session port, host, request, and address
+ *                           fields will be populated from the parsed
+ *                           request URL and/or proxy URLs.
+ *  @param[in]      url      A pointer to the immutable null-terminated
+ *                           C string containing the request URL to
+ *                           parse.
+ *  @param[in]      proxy    An optional pointer to the immutable null-
+ *                           terminated C string containing the web
+ *                           proxy URL, if any, to parse.
+ *
+ *  @retval  0         If successful.
+ *  @retval  -EINVAL  If @url was not a valid URL.
+ *
+ *  @sa parse_request_url
+ *  @sa parse_proxy_url
+ *
+ */
 static int parse_request_and_proxy_urls(struct web_session *session,
 				const char *url, const char *proxy)
 {
--=20
2.42.0


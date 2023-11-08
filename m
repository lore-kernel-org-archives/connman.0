Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDD3457E
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 285C47317A;
	Wed,  8 Nov 2023 13:38:12 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74] (unknown [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9232F731AC;
	Wed,  8 Nov 2023 13:38:11 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 3/3 v4] gweb: Add documentation to URL parsing functions.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <7D22A1A1-7A39-4537-B216-CD16A5D0077E@nuovations.com>
Date: Wed, 8 Nov 2023 10:38:10 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B70C444E-96A4-4E33-B6F6-463F2008D434@nuovations.com>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <D1441574-E298-4CA2-B316-40DD1789E4A6@nuovations.com>
 <7D22A1A1-7A39-4537-B216-CD16A5D0077E@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the following URL parsing functions:

    * parse_request_and_proxy_urls
        - parse_request_url
            o parse_url_components
                + parse_url_scheme
                + parse_url_host_and_port
                    * parse_url_host
                    * parse_url_port
                + parse_url_path
        - parse_proxy_url
---
 gweb/gweb.c | 398 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 398 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0bf52e1b..17237698 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1107,6 +1107,40 @@ static int create_transport(struct web_session =
*session)
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
+ *  @param[in]      url             A pointer to the immutable string,
+ *                                  of length @a url_length, from
+ *                                  which to parse the scheme
+ *                                  component.
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
+ *  @sa parse_url_components
+ *
+ */
 static int parse_url_scheme(const char *url, size_t url_length,
 						const char **cursor,
 						char **scheme)
@@ -1141,6 +1175,52 @@ static int parse_url_scheme(const char *url, =
size_t url_length,
 	return 0;
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
+ *  @param[in]      url             A pointer to the immutable string,
+ *                                  of length @a url_length, from
+ *                                  which to parse the host
+ *                                  component.
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
@@ -1231,6 +1311,51 @@ static int parse_url_host(const char *url, size_t =
url_length,
 	return err;
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
+ *  @param[in]      url             A pointer to the immutable string,
+ *                                  of length @a url_length, from
+ *                                  which to parse the port
+ *                                  component.
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
@@ -1270,6 +1395,62 @@ static int parse_url_port(const char *url, size_t =
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
+ *  @param[in]      url             A pointer to the immutable string,
+ *                                  of length @a url_length, from
+ *                                  which to parse the host and port
+ *                                  components.
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
@@ -1300,6 +1481,40 @@ done:
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
+ *  @param[in]      url             A pointer to the immutable string,
+ *                                  of length @a url_length, from
+ *                                  which to parse the path
+ *                                  component.
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
@@ -1330,6 +1545,61 @@ static int parse_url_path(const char *url, size_t =
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
+ *                                  parse the scheme, host, port, and
+ *                                  path components.
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
@@ -1384,6 +1654,46 @@ done:
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
@@ -1445,6 +1755,46 @@ done:
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
 	const char *p;
@@ -1501,6 +1851,54 @@ done:
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


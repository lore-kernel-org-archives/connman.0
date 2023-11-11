Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9791B28C
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 84BBD730FB
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:36 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3B3E573122
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:36 -0500 (EST)
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
Subject: [PATCH 4/8] gweb: Add documentation to TCP connect timeout-related
 functions.
Date: Sat, 11 Nov 2023 10:59:36 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <39D91814-3E36-4DD1-A16A-C8ED4C637103@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds function documentation to the following TCP connect timeout-
related functions:

    * connect_timeout_cb
    * add_connect_timeout
    * cancel_connect_timeout
    * close_session_transport
    * connect_session_transport
    * g_web_set_connect_timeout
    * g_web_get_connect_timeout
---
 gweb/gweb.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 584f0106c5ee..1463b588d411 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -177,6 +177,27 @@ static inline void call_route_func(struct =
web_session *session)
 				session->web->index, =
session->user_data);
 }
=20
+/**
+ *  @brief
+ *    Handle a TCP connection timeout.
+ *
+ *  This callback handles a TCP connection timeout for a GWeb
+ *  connection. The session transport is closed and the GWeb
+ *  transaction is terminated with
+ *  #GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT status.
+ *
+ *  param[in,out]  user_data  A pointer to the mutable GWeb session
+ *                            for which the TCP connection timed out.
+ *
+ *  @returns
+ *    G_SOURCE_REMOVE (that is, FALSE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa add_connect_timeout
+ *  @sa cancel_connect_timeout
+ *
+ */
 static gboolean connect_timeout_cb(gpointer user_data)
 {
 	struct web_session *session =3D user_data;
@@ -196,6 +217,30 @@ static gboolean connect_timeout_cb(gpointer =
user_data)
 	return G_SOURCE_REMOVE;
 }
=20
+/**
+ *  @brief
+ *    Add a TCP connection timeout.
+ *
+ *  This attempts to add TCP connection timeout and callback to the
+ *  specified GWeb session. The timeout is successfully added if @a
+ *  session is non-null and @a timeout_ms is greater than zero.
+ *
+ *  @param[in,out]  session     A pointer to the mutable GWeb session
+ *                              to add the TCP connection timeout
+ *                              callback to.
+ *  param[in]       timeout_ms  The time, in milliseconds, for the TCP
+ *                              connection timeout. Connections that
+ *                              take longer than this will be
+ *                              aborted. A value of zero ('0')
+ *                              indicates that no explicit connection
+ *                              timeout will be used, leaving the
+ *                              timeout to the underlying operating
+ *                              system and its network stack.
+ *
+ *  @sa cancel_connect_timeout
+ *  @sa connect_timeout_cb
+ *
+ */
 static void add_connect_timeout(struct web_session *session,
 						guint timeout_ms)
 {
@@ -208,6 +253,22 @@ static void add_connect_timeout(struct web_session =
*session,
 				connect_timeout_cb, session);
 }
=20
+/**
+ *  @brief
+ *    Cancel a TCP connection timeout.
+ *
+ *  This attempts to cancel a TCP connection timeout and callback from
+ *  the specified GWeb session. The timeout is successfully cancelled
+ *  if @a session is non-null and its associated connect timeout
+ *  identifier is valid.
+ *
+ *  @param[in,out]  session     A pointer to the mutable GWeb session
+ *                              on which to cancel the TCP connection
+ *                              timeout.
+ *
+ *  @sa add_connect_timeout
+ *
+ */
 static void cancel_connect_timeout(struct web_session *session)
 {
 	if (!session)
@@ -221,6 +282,21 @@ static void cancel_connect_timeout(struct =
web_session *session)
 	}
 }
=20
+/**
+ *  @brief
+ *    Close the TCP transport a GWeb sesssion.
+ *
+ *  This closes the TCP transport associated with the specified GWeb
+ *  session, removing its transport and send watches and releasing the
+ *  reference to the transport channel.
+ *
+ *  @param[in,out]  session     A pointer to the mutable GWeb session
+ *                              for which to close the session
+ *                              transport.
+ *
+ *  @sa connect_session_transport
+ *
+ */
 static void close_session_transport(struct web_session *session)
 {
 	if (!session)
@@ -531,6 +607,28 @@ bool g_web_get_close_connection(GWeb *web)
 	return web->close_connection;
 }
=20
+/**
+ *  @brief
+ *    Set the TCP connection timeout.
+ *
+ *  This sets the TCP connection timeout, in milliseconds, for the
+ *  specified GWeb object.
+ *
+ *  param[in,out]  web         A pointer to the mutable GWeb object
+ *                             for which the TCP connection timeout is
+ *                             to be set.
+ *  param[in]      timeout_ms  The time, in milliseconds, for the TCP
+ *                             connection timeout. Connections that
+ *                             take longer than this will be
+ *                             aborted. A value of zero ('0')
+ *                             indicates that no explicit connection
+ *                             timeout will be used, leaving the
+ *                             timeout to the underlying operating
+ *                             system and its network stack.
+ *
+ *  @sa g_web_get_connect_timeout
+ *
+ */
 void g_web_set_connect_timeout(GWeb *web, guint timeout_ms)
 {
 	if (!web)
@@ -541,6 +639,26 @@ void g_web_set_connect_timeout(GWeb *web, guint =
timeout_ms)
 	web->connect_timeout_ms =3D timeout_ms;
 }
=20
+/**
+ *  @brief
+ *    Set the TCP connection timeout.
+ *
+ *  This sets the TCP connection timeout, in milliseconds, for the
+ *  specified GWeb object.
+ *
+ *  param[in]  web             A pointer to the immutable GWeb object
+ *                             for which the TCP connection timeout is
+ *                             to be returned.
+ *
+ *  @returns
+ *    The TCP connection timeout, in milliseconds. A value of zero
+ *    ('0') indicates that no explicit connection timeout has been
+ *    set, leaving the timeout to the underlying operating system and
+ *    its network stack.
+ *
+ *  @sa g_web_set_connect_timeout
+ *
+ */
 guint g_web_get_connect_timeout(const GWeb *web)
 {
 	guint timeout_ms =3D 0;
@@ -1126,6 +1244,39 @@ static inline int bind_socket(int sk, int index, =
int family)
 	return err;
 }
=20
+/**
+ *  @brief
+ *    Establish TCP connection for a GWeb session.
+ *
+ *  This attempts to establish a TCP connection for the specified GWeb
+ *  session with the session-specified address family, peer address,
+ *  and bound network interface.
+ *
+ *  @param[in,out]  session             A pointer to the mutable GWeb
+ *                                      session for which to establish
+ *                                      the session transport.
+ *  param[in]       connect_timeout_ms  The time, in milliseconds, for
+ *                                      the TCP connection timeout.
+ *                                      Connections that take longer
+ *                                      than this will be aborted. A
+ *                                      value of zero ('0') indicates
+ *                                      that no explicit connection
+ *                                      timeout will be used, leaving
+ *                                      the timeout to the underlying
+ *                                      operating system and its
+ *                                      network stack.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EIO     If a socket could not be created for the =
specified
+ *                    session address family, the socket could not be
+ *                    bound to the specified session network
+ *                    interface, or the socket could not connect to
+ *                    the specified session peer address.
+ *  @retval  -ENOMEM  If a GLib transport channel could not be created.
+ *
+ *  @sa close_session_transport
+ *
+ */
 static int connect_session_transport(struct web_session *session,
 			guint connect_timeout_ms)
 {
--=20
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7131B28C
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 147B27310B
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:58:37 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D31717313E
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:58:36 -0500 (EST)
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
Subject: [PATCH 1/8] gweb: Add TCP connect timeout member and getter/setter.
Date: Sat, 11 Nov 2023 10:58:35 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <E2D57708-0805-45A0-A839-68531357F06D@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a TCP connect timeout member, getter, and setter. =
Collectively,
these manage the TCP connection timeout, in milliseconds, for a =
specified
GWeb object. Connections that take longer than this will be aborted. A
value of zero ('0') indicates that no explicit connection timeout will =
be
used, leaving the timeout to the underlying operating system and its
network stack.
---
 gweb/gweb.c | 24 ++++++++++++++++++++++++
 gweb/gweb.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 65c075d2128e..bc0aa7a801a6 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -124,6 +124,7 @@ struct _GWeb {
 	char *user_agent_profile;
 	char *http_version;
 	bool close_connection;
+	guint connect_timeout_ms;
=20
 	GWebDebugFunc debug_func;
 	gpointer debug_data;
@@ -445,6 +446,29 @@ bool g_web_get_close_connection(GWeb *web)
 	return web->close_connection;
 }
=20
+void g_web_set_connect_timeout(GWeb *web, guint timeout_ms)
+{
+	if (!web)
+		return;
+
+	debug(web, "timeout %ums", timeout_ms);
+
+	web->connect_timeout_ms =3D timeout_ms;
+}
+
+guint g_web_get_connect_timeout(const GWeb *web)
+{
+	guint timeout_ms =3D 0;
+
+	if (!web)
+		goto done;
+
+	timeout_ms =3D web->connect_timeout_ms;
+
+done:
+	return timeout_ms;
+}
+
 static inline void call_result_func(struct web_session *session, =
guint16 status)
 {
=20
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 8a6304e3014f..3c50979cfd0a 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -142,6 +142,9 @@ bool g_web_set_ua_profile(GWeb *web, const char =
*profile);
=20
 bool g_web_set_http_version(GWeb *web, const char *version);
=20
+void g_web_set_connect_timeout(GWeb *web, guint timeout_ms);
+guint g_web_get_connect_timeout(const GWeb *web);
+
 void g_web_set_close_connection(GWeb *web, bool enabled);
 bool g_web_get_close_connection(GWeb *web);
=20
--=20
2.42.0


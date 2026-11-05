Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.34.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883716;
	b=AXlQ134h1REqU2asfGvM13ufstP3+4gdtMAkGuGHN3fgr4gqClnObk7mZPeH+CFgN6CL
	 gtYxvcFMkY9POFNJijFw9wS6bfIdkpKdOndGpU9JwfaOmCf9Gf4jnW8T642hst9rneUrA
	 uorC2FknswHu9Kblug9bdwqgocZNGEvREC99N28zYPkvw8Bv4rKYpJuSoy4MJ8IXhJ+cF
	 5j4tUXe1HSsfvi5F43FE+hN8lQG//RUkd74sfaSdmA7wzQxOL72j67YrpTgKVnfQEenf6
	 bRV7aQcAeoZDMKtOvX5ZgbVshI119dIib0quEQpKuF2L1y5bOlamrXCD+T7bYE0NJaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883716;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=VnQsjrdGeFJUalrcFHVRqhdAOqAJ4Z+ynLWfXimNQPY=;
	b=iyL5/6XhxwxiN7fXj0uh4Doi90YjWnHaMwoGODksAeHc6oJ5MvJpO3KjU6hFxJFIhzO5
	 baT0NMGXJxq0HDRyfml56l0a+zVHU5vDoPsKwTmHp8MDJma+78HmEDmy+QAmVy/J7CATD
	 u0wkG7lb8nFGCLtQGqXoXAdSsZveijUadYQ4v2aOOGt2IhwnTQz2iXxNc6uPiUSjHRlDq
	 3iozIJ76eObO5qrxcEj/sK3wUTz5qjkpHRPmNMPMc/9kfz+97OeGtxeJhJjMxzoEi1Zsl
	 /ChoQZzcGXKQC0zBk8b5lLXI3C/DJTEG3JVRY89dQL/Ire4pW1YPxrIfvC1nGw/VDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.34.219
Received: from 15.mo23.mail-out.ovh.net (15.mo23.mail-out.ovh.net [46.105.34.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC2606A31B
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29FC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.111.182.245])
	by mo23.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wh51wSz7xYS
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:52 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 2/6] doh: Add DNS over HTTPS transport
Date: Thu, 5 Nov 2026 13:01:41 +0000
Message-ID: <20261105130145.523935-3-email@samnazarko.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105130145.523935-1-email@samnazarko.co.uk>
References: <20261105130145.523935-1-email@samnazarko.co.uk>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CAS10.indiv.local (172.16.1.10) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9097271247401308140
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE7MEMjp5e6KnSuACOnQKOVSS+vnWAdzKyO+OWuX1bSUWeKSqTIOfIByW8chDLZa9OSmotBXMI7pbBYK0s7Wq9dViKsoJYUMZfW4oX1muKV6ROEYK4UtWfYPVwZzTFgcwCoy/iNAXySeu+IsIuX73qCq6c/XDnjXKh/C655zqJwNbAou71Zo4CHEaIwJuuYFztpu6fdIG3KrQqCKpI09vQUVMBjpc8LRbOTCkrXWbY4YJcjVx6ZM+rw4LQMCf37bq2Aenata1dVtn9vAO5cFE2hG2pBJJu13af/ueGWX2yOa8s6tjPKmfZeSB2FYJ5Y1zoL8ODwu5vIdOX8okO2uz0DAl/0LtOAHzSf09+HEggxoVF10KLP2gPbXjI6LwRhzur2ks+UEOsaJx0WRCLpxfoSqMp9zyhR4pLmVcq3ryQfah/QShdrETNvAzfai8jBso5Dq2aiVdQ6IG6Q6urwSR3P2e/iYlmR8URoLiwkTPK8fXq/pakgtY4oJsyeJ6CoEhU/XKh/JAOmnZbH1Vzgqpe6uDEE/e3QRVSPE6u2nXe9zwLu3gDOdsdaXANwY4g21LPonnu6YlsJcMF5LceF1t0IB10zhPzPfXbY9QtgbOwMrNUDNx/KDXqUX+O2t3tWwCUmB88nLfRmsa9hsS3Z+yaeVBbOhoV1Rg2UCpnZI0oK+w

Add an RFC 8484 client for the DNS proxy. Queries are POSTed as
application/dns-message on a single HTTP/2 connection per server,
using nghttp2 for the HTTP/2 framing and GnuTLS for TLS 1.2 or newer.
HTTP/2 is required: Quad9, Mullvad, DNS4EU and CIRA refuse DoH over
HTTP/1.1, while every public resolver tested supports HTTP/2.

The server certificate is verified against the system trust store,
including IP address SANs for URLs such as https://1.1.1.1/dns-query,
on every handshake and before any query is sent. Devices without a
real time clock boot with a stale time and need DNS to fix it, so
while the kernel clock is not synchronised a certificate that is only
outside its validity period is accepted once the chain and the name
have been verified again with time checks disabled. Such sessions are
not kept for resumption.

Servers are backed off from 30 seconds up to 30 minutes when they
cannot be reached, stop responding on a connection or answer with an
HTTP 5xx or 429 status; a slow or rejected query on its own does not
count against the server. Requests lost on a reused connection that
the server closed, or refused by a GOAWAY, are retried once. Host
names without known addresses are resolved through the DNS proxy
itself, which forwards those lookups in plain text.

A table of public resolvers known to serve DoH on the same addresses
as their plain DNS service allows upgrading a server configured by
address to DoH without changing who answers the queries. All entries
were checked to answer DoH over HTTP/2 with a valid certificate.

GnuTLS 3.4.2 and nghttp2 1.33.0 or newer are now required by the
internal DNS backend; older nghttp2 releases cannot attach data to
requests that are still queued.
---
 Makefile.am   |    6 +-
 configure.ac  |    9 +
 src/connman.h |   19 +
 src/doh.c     | 1873 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1904 insertions(+), 3 deletions(-)
 create mode 100644 src/doh.c

diff --git a/Makefile.am b/Makefile.am
index 23c5dabe..36c7ecda 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -132,7 +132,7 @@ src_connmand_SOURCES =3D $(gdhcp_sources) $(gweb_source=
s) $(stats_sources) \
 			src/acd.c
=20
 if INTERNAL_DNS_BACKEND
-src_connmand_SOURCES +=3D src/dnsproxy.c
+src_connmand_SOURCES +=3D src/dnsproxy.c src/doh.c
 endif
 if SYSTEMD_RESOLVED_DNS_BACKEND
 src_connmand_SOURCES +=3D src/dns-systemd-resolved.c
@@ -140,7 +140,7 @@ endif
=20
 src_connmand_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GIO_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
-			-lresolv -ldl -lrt
+			@NGHTTP2_LIBS@ -lresolv -ldl -lrt
=20
 src_connmand_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/connman.ver
@@ -252,7 +252,7 @@ AM_CPPFLAGS =3D -I$(builddir)/include -I$(builddir)/src=
 -I$(srcdir)/gdbus
 endif
=20
 src_connmand_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
-				@GNUTLS_CFLAGS@ $(builtin_cflags) \
+				@GNUTLS_CFLAGS@ @NGHTTP2_CFLAGS@ $(builtin_cflags) \
 				-DCONNMAN_PLUGIN_BUILTIN \
 				-DSTATEDIR=3D\""$(statedir)"\" \
 				-DPLUGINDIR=3D\""$(build_plugindir)"\" \
diff --git a/configure.ac b/configure.ac
index dc52cf7e..bc688996 100644
--- a/configure.ac
+++ b/configure.ac
@@ -550,5 +550,14 @@ AM_CONDITIONAL(INTERNAL_DNS_BACKEND, test "${dns_backe=
nd}" =3D "internal")
 AM_CONDITIONAL(SYSTEMD_RESOLVED_DNS_BACKEND, test "${dns_backend}" =3D "sy=
stemd-resolved")
 AC_MSG_RESULT(${dns_backend})
=20
+if (test "${dns_backend}" =3D "internal"); then
+	PKG_CHECK_MODULES(GNUTLS, gnutls >=3D 3.4.2, dummy=3Dyes,
+		AC_MSG_ERROR(GnuTLS >=3D 3.4.2 is required for DNS over HTTPS))
+	PKG_CHECK_MODULES(NGHTTP2, libnghttp2 >=3D 1.33.0, dummy=3Dyes,
+		AC_MSG_ERROR(nghttp2 library is required for DNS over HTTPS))
+fi
+AC_SUBST(NGHTTP2_CFLAGS)
+AC_SUBST(NGHTTP2_LIBS)
+
 AC_CONFIG_FILES(Makefile include/version.h)
 AC_OUTPUT
diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..73532b66 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -1025,6 +1025,25 @@ int __connman_dnsproxy_remove(int index, const char =
*domain, const char *server)
 int __connman_dnsproxy_set_mdns(int index, bool enabled);
 void __connman_dnsproxy_set_listen_port(unsigned int port);
=20
+struct doh_server;
+
+typedef void (*connman_doh_reply_cb_t)(int err, const unsigned char *reply=
,
+					size_t len, void *user_data);
+
+int __connman_doh_init(unsigned int dns_port);
+void __connman_doh_cleanup(void);
+bool __connman_doh_url_is_valid(const char *url);
+struct doh_server *__connman_doh_server_new(const char *url);
+struct doh_server *__connman_doh_server_new_for_address(const char *addres=
s);
+void __connman_doh_server_free(struct doh_server *server);
+const char *__connman_doh_server_get_url(const struct doh_server *server);
+const char *__connman_doh_server_get_host(const struct doh_server *server)=
;
+bool __connman_doh_server_is_available(const struct doh_server *server);
+void __connman_doh_server_reset(struct doh_server *server);
+int __connman_doh_send(struct doh_server *server, const unsigned char *msg=
,
+				size_t len, connman_doh_reply_cb_t callback,
+				void *user_data);
+
 int __connman_6to4_probe(struct connman_service *service);
 void __connman_6to4_remove(struct connman_ipconfig *ipconfig);
 int __connman_6to4_check(struct connman_ipconfig *ipconfig);
diff --git a/src/doh.c b/src/doh.c
new file mode 100644
index 00000000..9a664dba
--- /dev/null
+++ b/src/doh.c
@@ -0,0 +1,1873 @@
+/*
+ *
+ *  Connection Manager
+ *
+ *  Copyright (C) 2026  Sam G Nazarko. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+/*
+ * DNS over HTTPS (RFC 8484) transport used by the DNS proxy.
+ *
+ * Queries are sent as POST requests with the application/dns-message
+ * media type over a single HTTP/2 connection per server. The connection
+ * is protected by TLS 1.2 or newer and the server certificate is verified
+ * against the system trust store before any query is sent.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <sys/socket.h>
+#include <sys/timex.h>
+
+#include <glib.h>
+#include <gnutls/gnutls.h>
+#include <gnutls/x509.h>
+#include <nghttp2/nghttp2.h>
+
+#include <gweb/gresolv.h>
+
+#include "connman.h"
+
+#define DOH_PORT		443
+#define DOH_PATH		"/dns-query"
+#define DOH_MAX_URL		512
+#define DOH_MAX_QUEUED		128
+#define DOH_MAX_MESSAGE		65535
+#define DOH_MAX_BUFFERED	65536
+#define DOH_TLS_CHUNK		16384
+#define DOH_QUERY_TIMEOUT	3	/* seconds */
+#define DOH_CONNECT_TIMEOUT	3	/* seconds */
+#define DOH_IDLE_TIMEOUT	30	/* seconds */
+#define DOH_BACKOFF_MIN		30	/* seconds */
+#define DOH_BACKOFF_MAX		(30 * 60)
+#define DOH_RESOLVE_INTERVAL	(60 * 60)
+#define DOH_RESOLVE_RETRY	60
+#define DOH_DNS_HEADER_SIZE	12
+
+#define DOH_PRIORITY "NORMAL:-VERS-ALL:+VERS-TLS1.3:+VERS-TLS1.2"
+
+#if NGHTTP2_VERSION_NUM >=3D 0x013e00
+typedef nghttp2_ssize doh_ssize_t;
+typedef nghttp2_data_provider2 doh_data_provider;
+#define doh_h2_set_send_callback nghttp2_session_callbacks_set_send_callba=
ck2
+#define doh_h2_mem_recv nghttp2_session_mem_recv2
+#define doh_h2_submit_request nghttp2_submit_request2
+#else
+typedef ssize_t doh_ssize_t;
+typedef nghttp2_data_provider doh_data_provider;
+#define doh_h2_set_send_callback nghttp2_session_callbacks_set_send_callba=
ck
+#define doh_h2_mem_recv nghttp2_session_mem_recv
+#define doh_h2_submit_request nghttp2_submit_request
+#endif
+
+/*
+ * Public resolvers known to serve DoH on the same addresses as their
+ * plain DNS service, so that a server configured by address can be
+ * upgraded without changing who resolves the queries. The table also
+ * provides bootstrap addresses for these host names.
+ */
+static const struct doh_provider {
+	const char *host;
+	const char *path;
+	const char *addresses[5];
+} doh_providers[] =3D {
+	{ "cloudflare-dns.com", "/dns-query",
+		{ "1.1.1.1", "1.0.0.1",
+		  "2606:4700:4700::1111", "2606:4700:4700::1001" } },
+	{ "security.cloudflare-dns.com", "/dns-query",
+		{ "1.1.1.2", "1.0.0.2",
+		  "2606:4700:4700::1112", "2606:4700:4700::1002" } },
+	{ "family.cloudflare-dns.com", "/dns-query",
+		{ "1.1.1.3", "1.0.0.3",
+		  "2606:4700:4700::1113", "2606:4700:4700::1003" } },
+	{ "dns.google", "/dns-query",
+		{ "8.8.8.8", "8.8.4.4",
+		  "2001:4860:4860::8888", "2001:4860:4860::8844" } },
+	{ "dns.quad9.net", "/dns-query",
+		{ "9.9.9.9", "149.112.112.112",
+		  "2620:fe::fe", "2620:fe::9" } },
+	{ "dns10.quad9.net", "/dns-query",
+		{ "9.9.9.10", "149.112.112.10",
+		  "2620:fe::10", "2620:fe::fe:10" } },
+	{ "dns11.quad9.net", "/dns-query",
+		{ "9.9.9.11", "149.112.112.11",
+		  "2620:fe::11", "2620:fe::fe:11" } },
+	{ "dns.adguard-dns.com", "/dns-query",
+		{ "94.140.14.14", "94.140.15.15",
+		  "2a10:50c0::ad1:ff", "2a10:50c0::ad2:ff" } },
+	{ "family.adguard-dns.com", "/dns-query",
+		{ "94.140.14.15", "94.140.15.16",
+		  "2a10:50c0::bad1:ff", "2a10:50c0::bad2:ff" } },
+	{ "unfiltered.adguard-dns.com", "/dns-query",
+		{ "94.140.14.140", "94.140.14.141",
+		  "2a10:50c0::1:ff", "2a10:50c0::2:ff" } },
+	{ "doh.opendns.com", "/dns-query",
+		{ "208.67.222.222", "208.67.220.220",
+		  "2620:119:35::35", "2620:119:53::53" } },
+	{ "doh.familyshield.opendns.com", "/dns-query",
+		{ "208.67.222.123", "208.67.220.123",
+		  "2620:119:35::123", "2620:119:53::123" } },
+	{ "doh.cleanbrowsing.org", "/doh/family-filter/",
+		{ "185.228.168.168", "185.228.169.168",
+		  "2a0d:2a00:1::", "2a0d:2a00:2::" } },
+	{ "doh.cleanbrowsing.org", "/doh/adult-filter/",
+		{ "185.228.168.10", "185.228.169.11",
+		  "2a0d:2a00:1::1", "2a0d:2a00:2::1" } },
+	{ "doh.cleanbrowsing.org", "/doh/security-filter/",
+		{ "185.228.168.9", "185.228.169.9",
+		  "2a0d:2a00:1::2", "2a0d:2a00:2::2" } },
+	{ "protective.joindns4.eu", "/dns-query",
+		{ "86.54.11.1", "86.54.11.201",
+		  "2a13:1001::86:54:11:1", "2a13:1001::86:54:11:201" } },
+	{ "unfiltered.joindns4.eu", "/dns-query",
+		{ "86.54.11.100", "86.54.11.200",
+		  "2a13:1001::86:54:11:100", "2a13:1001::86:54:11:200" } },
+};
+
+enum doh_conn_state {
+	DOH_CONN_CONNECTING,
+	DOH_CONN_HANDSHAKE,
+	DOH_CONN_READY,
+	DOH_CONN_CLOSING,	/* GOAWAY received, no new streams */
+};
+
+struct doh_server {
+	char *url;
+	char *host;		/* DNS name or numeric address */
+	char *authority;	/* :authority pseudo-header */
+	char *path;		/* :path pseudo-header */
+	uint16_t port;
+	bool numeric;		/* host is an address: no SNI */
+	char **addresses;	/* numeric addresses to connect to */
+	bool fixed_addresses;	/* from the URL or the provider table */
+	gint64 addresses_expire;
+	guint resolve_id;
+	unsigned int next_address;
+	unsigned int connect_failures;
+	GSList *conns;
+	GQueue *queue;		/* queries waiting for a connection */
+	guint kick;
+	unsigned int failures;
+	gint64 retry_after;
+	gnutls_datum_t session_data;
+};
+
+struct doh_conn {
+	struct doh_server *server;
+	enum doh_conn_state state;
+	int fd;
+	GIOChannel *channel;
+	guint watch;
+	guint timer;
+	gnutls_session_t session;
+	nghttp2_session *h2;
+	GByteArray *out;	/* HTTP/2 output not yet given to TLS */
+	uint8_t *pending;	/* chunk GnuTLS is currently writing */
+	size_t pending_len;
+	size_t pending_off;
+	GSList *queries;
+	unsigned int replies;
+	gint64 last_rx;		/* monotonic, microseconds */
+	bool time_tolerated;	/* certificate outside its validity */
+};
+
+struct doh_query {
+	struct doh_server *server;
+	struct doh_conn *conn;
+	int32_t stream_id;
+	uint8_t *msg;
+	size_t msg_len;
+	size_t msg_sent;
+	uint8_t id[2];
+	GByteArray *reply;
+	unsigned int status;
+	bool dns_message;
+	bool retried;
+	gint64 started;		/* monotonic, microseconds */
+	guint timeout;
+	connman_doh_reply_cb_t callback;
+	void *user_data;
+};
+
+static gnutls_certificate_credentials_t credentials;
+static nghttp2_session_callbacks *h2_callbacks;
+static GResolv *bootstrap;
+static uint16_t bootstrap_port =3D 53;
+
+static void server_schedule(struct doh_server *server);
+static void conn_failed(struct doh_conn *conn, int err);
+static void conn_update(struct doh_conn *conn);
+
+static gint64 now_seconds(void)
+{
+	return g_get_monotonic_time() / G_USEC_PER_SEC;
+}
+
+static bool same_address(const char *a, const char *b)
+{
+	unsigned char addr_a[sizeof(struct in6_addr)];
+	unsigned char addr_b[sizeof(struct in6_addr)];
+
+	if (inet_pton(AF_INET, a, addr_a) =3D=3D 1)
+		return inet_pton(AF_INET, b, addr_b) =3D=3D 1 &&
+			memcmp(addr_a, addr_b, sizeof(struct in_addr)) =3D=3D 0;
+
+	if (inet_pton(AF_INET6, a, addr_a) =3D=3D 1)
+		return inet_pton(AF_INET6, b, addr_b) =3D=3D 1 &&
+			memcmp(addr_a, addr_b, sizeof(struct in6_addr)) =3D=3D 0;
+
+	return false;
+}
+
+static bool is_address(const char *str)
+{
+	struct in6_addr addr;
+
+	return inet_pton(AF_INET, str, &addr) =3D=3D 1 ||
+		inet_pton(AF_INET6, str, &addr) =3D=3D 1;
+}
+
+static const struct doh_provider *provider_by_address(const char *address,
+						unsigned int *index)
+{
+	for (size_t i =3D 0; i < G_N_ELEMENTS(doh_providers); i++) {
+		const struct doh_provider *provider =3D &doh_providers[i];
+
+		for (unsigned int j =3D 0; j < G_N_ELEMENTS(provider->addresses) &&
+					provider->addresses[j]; j++) {
+			if (same_address(provider->addresses[j], address)) {
+				*index =3D j;
+				return provider;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static const struct doh_provider *provider_by_host(const char *host)
+{
+	for (size_t i =3D 0; i < G_N_ELEMENTS(doh_providers); i++) {
+		if (g_ascii_strcasecmp(doh_providers[i].host, host) =3D=3D 0)
+			return &doh_providers[i];
+	}
+
+	return NULL;
+}
+
+static char **provider_addresses(const struct doh_provider *provider,
+					unsigned int first)
+{
+	GPtrArray *addresses =3D g_ptr_array_new();
+
+	g_ptr_array_add(addresses, g_strdup(provider->addresses[first]));
+
+	for (unsigned int i =3D 0; i < G_N_ELEMENTS(provider->addresses) &&
+					provider->addresses[i]; i++) {
+		if (i !=3D first)
+			g_ptr_array_add(addresses,
+					g_strdup(provider->addresses[i]));
+	}
+
+	g_ptr_array_add(addresses, NULL);
+
+	return (char **) g_ptr_array_free(addresses, FALSE);
+}
+
+static bool valid_host_name(const char *host)
+{
+	size_t len =3D strlen(host), label =3D 0;
+
+	if (len =3D=3D 0 || len > 253)
+		return false;
+
+	for (size_t i =3D 0; i < len; i++) {
+		if (host[i] =3D=3D '.') {
+			if (label =3D=3D 0)
+				return false;
+
+			label =3D 0;
+			continue;
+		}
+
+		if (!g_ascii_isalnum(host[i]) && host[i] !=3D '-' &&
+							host[i] !=3D '_')
+			return false;
+
+		if (++label > 63)
+			return false;
+	}
+
+	return label > 0;
+}
+
+static bool valid_path(const char *path)
+{
+	if (path[0] !=3D '/')
+		return false;
+
+	for (; *path; path++) {
+		if (*path <=3D ' ' || *path >=3D 0x7f || *path =3D=3D '#')
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Parse https://host[:port][/path] into the server. The RFC 8484 URI
+ * template variable {?dns} is accepted and ignored since only POST is
+ * used.
+ */
+static int parse_url(struct doh_server *server, const char *url)
+{
+	g_autofree char *copy =3D NULL;
+	const char *authority, *host_end, *port_str =3D NULL;
+	char *path, *template, *host;
+	unsigned long port =3D DOH_PORT;
+
+	if (!url || strlen(url) > DOH_MAX_URL ||
+			g_ascii_strncasecmp(url, "https://", 8) !=3D 0)
+		return -EINVAL;
+
+	copy =3D g_strdup(url + 8);
+
+	template =3D strstr(copy, "{?dns}");
+	if (template) {
+		if (template[6] !=3D '\0')
+			return -EINVAL;
+
+		*template =3D '\0';
+	}
+
+	path =3D strchr(copy, '/');
+	if (path) {
+		if (!valid_path(path))
+			return -EINVAL;
+
+		server->path =3D g_strdup(path);
+		*path =3D '\0';
+	} else {
+		server->path =3D g_strdup(DOH_PATH);
+	}
+
+	authority =3D copy;
+	if (strpbrk(authority, "@?#"))
+		return -EINVAL;
+
+	if (authority[0] =3D=3D '[') {
+		host_end =3D strchr(authority, ']');
+		if (!host_end)
+			return -EINVAL;
+
+		host =3D g_strndup(authority + 1, host_end - authority - 1);
+		if (host_end[1] =3D=3D ':')
+			port_str =3D host_end + 2;
+		else if (host_end[1] !=3D '\0') {
+			g_free(host);
+			return -EINVAL;
+		}
+
+		server->host =3D host;
+
+		if (!strchr(host, ':') || !is_address(host))
+			return -EINVAL;
+	} else {
+		host_end =3D strchr(authority, ':');
+		if (host_end) {
+			port_str =3D host_end + 1;
+			host =3D g_strndup(authority, host_end - authority);
+		} else {
+			host =3D g_strdup(authority);
+		}
+
+		server->host =3D g_ascii_strdown(host, -1);
+		g_free(host);
+
+		if (server->host[0] &&
+			server->host[strlen(server->host) - 1] =3D=3D '.')
+			server->host[strlen(server->host) - 1] =3D '\0';
+
+		if (strchr(server->host, ':') ||
+				(!is_address(server->host) &&
+				!valid_host_name(server->host)))
+			return -EINVAL;
+	}
+
+	if (port_str) {
+		char *end;
+
+		if (!g_ascii_isdigit(port_str[0]))
+			return -EINVAL;
+
+		port =3D strtoul(port_str, &end, 10);
+		if (*end !=3D '\0' || port =3D=3D 0 || port > 65535)
+			return -EINVAL;
+	}
+
+	server->port =3D port;
+	server->numeric =3D is_address(server->host);
+
+	if (strchr(server->host, ':'))
+		server->authority =3D port =3D=3D DOH_PORT ?
+			g_strdup_printf("[%s]", server->host) :
+			g_strdup_printf("[%s]:%lu", server->host, port);
+	else
+		server->authority =3D port =3D=3D DOH_PORT ?
+			g_strdup(server->host) :
+			g_strdup_printf("%s:%lu", server->host, port);
+
+	server->url =3D g_strdup_printf("https://%s%s", server->authority,
+							server->path);
+
+	return 0;
+}
+
+bool __connman_doh_url_is_valid(const char *url)
+{
+	struct doh_server server =3D { 0 };
+	int err =3D parse_url(&server, url);
+
+	g_free(server.url);
+	g_free(server.host);
+	g_free(server.authority);
+	g_free(server.path);
+
+	return err =3D=3D 0;
+}
+
+static bool load_credentials(void)
+{
+	gnutls_certificate_credentials_t creds;
+	int ret;
+
+	if (credentials)
+		return true;
+
+	if (gnutls_certificate_allocate_credentials(&creds) < 0)
+		return false;
+
+	ret =3D gnutls_certificate_set_x509_system_trust(creds);
+	if (ret <=3D 0) {
+		connman_error("DNS over HTTPS: no trusted CA certificates: %s",
+				ret < 0 ? gnutls_strerror(ret) : "none found");
+		gnutls_certificate_free_credentials(creds);
+		return false;
+	}
+
+	DBG("loaded %d trusted CA certificates", ret);
+
+	credentials =3D creds;
+
+	return true;
+}
+
+static bool clock_synchronized(void)
+{
+	struct timex tx;
+	int state;
+
+	memset(&tx, 0, sizeof(tx));
+
+	state =3D adjtimex(&tx);
+	if (state < 0)
+		return true;
+
+	return state !=3D TIME_ERROR && !(tx.status & STA_UNSYNC);
+}
+
+/*
+ * Verify the peer's chain and name against the system trust store with
+ * the validity periods ignored. A status of GNUTLS_CERT_INVALID alone
+ * may also mean that a signature could not be checked at all, so the
+ * time related status bits must not be trusted on their own.
+ */
+static int verify_ignoring_time(struct doh_conn *conn)
+{
+	gnutls_typed_vdata_st name =3D {
+		.type =3D GNUTLS_DT_DNS_HOSTNAME,
+		.data =3D (unsigned char *) conn->server->host,
+	};
+	gnutls_x509_trust_list_t trust;
+	const gnutls_datum_t *peers;
+	gnutls_x509_crt_t *chain;
+	unsigned int count =3D 0, status =3D 1, i;
+
+	peers =3D gnutls_certificate_get_peers(conn->session, &count);
+	if (!peers || count =3D=3D 0)
+		return -EACCES;
+
+	gnutls_certificate_get_trust_list(credentials, &trust);
+
+	chain =3D g_new0(gnutls_x509_crt_t, count);
+
+	for (i =3D 0; i < count; i++) {
+		if (gnutls_x509_crt_init(&chain[i]) < 0 ||
+				gnutls_x509_crt_import(chain[i], &peers[i],
+						GNUTLS_X509_FMT_DER) < 0)
+			goto out;
+	}
+
+	if (gnutls_x509_trust_list_verify_crt2(trust, chain, count, &name, 1,
+				GNUTLS_VERIFY_DISABLE_TIME_CHECKS |
+				GNUTLS_VERIFY_DISABLE_TRUSTED_TIME_CHECKS,
+				&status, NULL) < 0)
+		status =3D 1;
+
+out:
+	for (i =3D 0; i < count; i++) {
+		if (chain[i])
+			gnutls_x509_crt_deinit(chain[i]);
+	}
+	g_free(chain);
+
+	return status =3D=3D 0 ? 0 : -EACCES;
+}
+
+/* Every handshake is verified, including resumed sessions */
+static int conn_verify(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	unsigned int status =3D 0;
+	gnutls_datum_t out;
+	int ret;
+
+	ret =3D gnutls_certificate_verify_peers3(conn->session, server->host,
+								&status);
+	if (ret < 0) {
+		connman_warn("DNS over HTTPS: cannot verify %s: %s",
+					server->host, gnutls_strerror(ret));
+		return -EACCES;
+	}
+
+	if (status =3D=3D 0)
+		return 0;
+
+	/*
+	 * Devices without a real time clock boot with a stale time and
+	 * cannot synchronise it without DNS. Until the kernel clock is
+	 * synchronised accept a certificate that is only outside of its
+	 * validity period, after checking the chain and the name again.
+	 * Such sessions are never resumed later.
+	 */
+	if (!(status & ~(GNUTLS_CERT_INVALID | GNUTLS_CERT_EXPIRED |
+					GNUTLS_CERT_NOT_ACTIVATED)) &&
+			(status & (GNUTLS_CERT_EXPIRED |
+					GNUTLS_CERT_NOT_ACTIVATED)) &&
+			!clock_synchronized() &&
+			verify_ignoring_time(conn) =3D=3D 0) {
+		connman_warn_once("DNS over HTTPS: system clock not "
+			"synchronised, ignoring certificate validity period");
+
+		conn->time_tolerated =3D true;
+		gnutls_free(server->session_data.data);
+		server->session_data.data =3D NULL;
+		server->session_data.size =3D 0;
+
+		return 0;
+	}
+
+	if (gnutls_certificate_verification_status_print(status,
+				gnutls_certificate_type_get(conn->session),
+				&out, 0) =3D=3D 0) {
+		connman_warn("DNS over HTTPS: certificate of %s rejected: %s",
+					server->host, (const char *) out.data);
+		gnutls_free(out.data);
+	}
+
+	return -EACCES;
+}
+
+static void query_free(struct doh_query *query)
+{
+	if (query->timeout)
+		g_source_remove(query->timeout);
+
+	g_byte_array_free(query->reply, TRUE);
+	g_free(query->msg);
+	g_free(query);
+}
+
+static void query_complete(struct doh_query *query, int err)
+{
+	const unsigned char *reply =3D NULL;
+	size_t len =3D 0;
+
+	if (!err) {
+		memcpy(query->reply->data, query->id, sizeof(query->id));
+		reply =3D query->reply->data;
+		len =3D query->reply->len;
+	}
+
+	query->callback(err, reply, len, query->user_data);
+	query_free(query);
+}
+
+static void query_reset(struct doh_query *query)
+{
+	g_byte_array_set_size(query->reply, 0);
+	query->msg_sent =3D 0;
+	query->status =3D 0;
+	query->dns_message =3D false;
+}
+
+static void query_detach(struct doh_query *query)
+{
+	struct doh_conn *conn =3D query->conn;
+
+	if (!conn)
+		return;
+
+	conn->queries =3D g_slist_remove(conn->queries, query);
+
+	if (conn->h2 && query->stream_id > 0)
+		nghttp2_session_set_stream_user_data(conn->h2,
+						query->stream_id, NULL);
+
+	query->conn =3D NULL;
+	query->stream_id =3D 0;
+}
+
+static void server_succeeded(struct doh_server *server)
+{
+	if (server->failures)
+		connman_info("DNS over HTTPS server %s is reachable again",
+								server->url);
+
+	server->failures =3D 0;
+	server->retry_after =3D 0;
+}
+
+/* Back off from the server and fail every query waiting for it */
+static void server_failed(struct doh_server *server, int err)
+{
+	struct doh_query *query;
+	unsigned int delay;
+	GQueue *queue;
+
+	server->failures++;
+
+	delay =3D DOH_BACKOFF_MIN << MIN(server->failures - 1, 6);
+	if (delay > DOH_BACKOFF_MAX)
+		delay =3D DOH_BACKOFF_MAX;
+
+	server->retry_after =3D now_seconds() + delay;
+
+	if (server->failures =3D=3D 1)
+		connman_warn("DNS over HTTPS server %s failed: %s",
+					server->url, strerror(-err));
+
+	DBG("server %s failures %u retry in %u s", server->url,
+						server->failures, delay);
+
+	/*
+	 * The callbacks may send new queries to this server, so complete
+	 * a detached copy of the queue.
+	 */
+	queue =3D server->queue;
+	server->queue =3D g_queue_new();
+
+	while ((query =3D g_queue_pop_head(queue)))
+		query_complete(query, err);
+
+	g_queue_free(queue);
+}
+
+static void conn_close(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	GSList *list;
+
+	DBG("conn %p server %s", conn, server->host);
+
+	server->conns =3D g_slist_remove(server->conns, conn);
+
+	/* Queries still owned by the connection go back to the queue */
+	for (list =3D conn->queries; list; list =3D list->next) {
+		struct doh_query *query =3D list->data;
+
+		query->conn =3D NULL;
+		query->stream_id =3D 0;
+		query_reset(query);
+		g_queue_push_head(server->queue, query);
+	}
+	g_slist_free(conn->queries);
+
+	if (conn->watch)
+		g_source_remove(conn->watch);
+
+	if (conn->timer)
+		g_source_remove(conn->timer);
+
+	if (conn->h2)
+		nghttp2_session_del(conn->h2);
+
+	if (conn->session) {
+		if (conn->state =3D=3D DOH_CONN_READY ||
+				conn->state =3D=3D DOH_CONN_CLOSING)
+			gnutls_bye(conn->session, GNUTLS_SHUT_WR);
+
+		gnutls_deinit(conn->session);
+	}
+
+	if (conn->channel)
+		g_io_channel_unref(conn->channel);
+
+	close(conn->fd);
+
+	g_byte_array_free(conn->out, TRUE);
+	g_free(conn->pending);
+	g_free(conn);
+}
+
+static gboolean conn_setup_timeout(gpointer user_data)
+{
+	struct doh_conn *conn =3D user_data;
+
+	conn->timer =3D 0;
+
+	conn_failed(conn, -ETIMEDOUT);
+
+	return FALSE;
+}
+
+static gboolean conn_idle_timeout(gpointer user_data)
+{
+	struct doh_conn *conn =3D user_data;
+
+	conn->timer =3D 0;
+
+	DBG("closing idle connection to %s", conn->server->host);
+
+	conn_close(conn);
+
+	return FALSE;
+}
+
+static void conn_failed(struct doh_conn *conn, int err)
+{
+	struct doh_server *server =3D conn->server;
+	bool established =3D conn->state =3D=3D DOH_CONN_READY ||
+				conn->state =3D=3D DOH_CONN_CLOSING;
+	bool reused =3D conn->replies > 0;
+	GSList *queries =3D conn->queries, *failed =3D NULL, *retry =3D NULL, *li=
st;
+	unsigned int count;
+
+	DBG("conn %p server %s err %d", conn, server->host, err);
+
+	conn->queries =3D NULL;
+	conn_close(conn);
+
+	if (!established) {
+		count =3D g_strv_length(server->addresses);
+
+		server->next_address++;
+
+		/* Try the remaining addresses before giving up */
+		if (++server->connect_failures < count) {
+			server_schedule(server);
+			return;
+		}
+
+		server->connect_failures =3D 0;
+		server_failed(server, err);
+		return;
+	}
+
+	for (list =3D queries; list; list =3D list->next) {
+		struct doh_query *query =3D list->data;
+
+		query->conn =3D NULL;
+		query->stream_id =3D 0;
+
+		/*
+		 * A reused connection may have been closed by the server
+		 * just as the query was sent; retry once on a new one.
+		 */
+		if (reused && !query->retried && query->reply->len =3D=3D 0) {
+			query->retried =3D true;
+			query_reset(query);
+			retry =3D g_slist_prepend(retry, query);
+		} else {
+			failed =3D g_slist_prepend(failed, query);
+		}
+	}
+	g_slist_free(queries);
+
+	/* Back off only when queries were lost, before queueing retries */
+	if (failed) {
+		server_failed(server, err);
+
+		for (list =3D failed; list; list =3D list->next)
+			query_complete(list->data, err);
+
+		g_slist_free(failed);
+	}
+
+	for (list =3D retry; list; list =3D list->next)
+		g_queue_push_head(server->queue, list->data);
+
+	g_slist_free(retry);
+
+	server_schedule(server);
+}
+
+static gboolean query_timeout(gpointer user_data)
+{
+	struct doh_query *query =3D user_data;
+	struct doh_server *server =3D query->server;
+	struct doh_conn *conn =3D query->conn;
+
+	query->timeout =3D 0;
+
+	DBG("query %p timed out on %s", query, server->host);
+
+	if (conn) {
+		bool unresponsive =3D conn->last_rx < query->started;
+
+		nghttp2_submit_rst_stream(conn->h2, NGHTTP2_FLAG_NONE,
+					query->stream_id, NGHTTP2_CANCEL);
+		query_detach(query);
+
+		/*
+		 * Nothing was received since the query was sent, so the
+		 * connection is dead; conn_failed() retries or fails the
+		 * other queries and backs off when needed. Otherwise only
+		 * this name is slow and the server is fine.
+		 */
+		if (unresponsive)
+			conn_failed(conn, -ETIMEDOUT);
+		else
+			conn_update(conn);
+	} else {
+		g_queue_remove(server->queue, query);
+	}
+
+	query_complete(query, -ETIMEDOUT);
+
+	return FALSE;
+}
+
+static doh_ssize_t h2_send(nghttp2_session *session, const uint8_t *data,
+				size_t length, int flags, void *user_data)
+{
+	struct doh_conn *conn =3D user_data;
+
+	if (conn->out->len >=3D DOH_MAX_BUFFERED)
+		return NGHTTP2_ERR_WOULDBLOCK;
+
+	g_byte_array_append(conn->out, data, length);
+
+	return length;
+}
+
+static doh_ssize_t h2_read_body(nghttp2_session *session, int32_t stream_i=
d,
+				uint8_t *buf, size_t length,
+				uint32_t *data_flags,
+				nghttp2_data_source *source, void *user_data)
+{
+	struct doh_query *query;
+	size_t len;
+
+	query =3D nghttp2_session_get_stream_user_data(session, stream_id);
+	if (!query)
+		return NGHTTP2_ERR_TEMPORAL_CALLBACK_FAILURE;
+
+	len =3D MIN(length, query->msg_len - query->msg_sent);
+	memcpy(buf, query->msg + query->msg_sent, len);
+	query->msg_sent +=3D len;
+
+	if (query->msg_sent =3D=3D query->msg_len)
+		*data_flags |=3D NGHTTP2_DATA_FLAG_EOF;
+
+	return len;
+}
+
+static int h2_on_header(nghttp2_session *session, const nghttp2_frame *fra=
me,
+			const uint8_t *name, size_t namelen,
+			const uint8_t *value, size_t valuelen,
+			uint8_t flags, void *user_data)
+{
+	static const char media_type[] =3D "application/dns-message";
+	const size_t media_len =3D sizeof(media_type) - 1;
+	struct doh_query *query;
+
+	if (frame->hd.type !=3D NGHTTP2_HEADERS)
+		return 0;
+
+	query =3D nghttp2_session_get_stream_user_data(session,
+							frame->hd.stream_id);
+	if (!query)
+		return 0;
+
+	if (namelen =3D=3D 7 && memcmp(name, ":status", 7) =3D=3D 0) {
+		query->status =3D 0;
+
+		if (valuelen =3D=3D 3 && g_ascii_isdigit(value[0]) &&
+				g_ascii_isdigit(value[1]) &&
+				g_ascii_isdigit(value[2]))
+			query->status =3D (value[0] - '0') * 100 +
+				(value[1] - '0') * 10 + (value[2] - '0');
+	} else if (namelen =3D=3D 12 && memcmp(name, "content-type", 12) =3D=3D 0=
) {
+		query->dns_message =3D valuelen >=3D media_len &&
+			g_ascii_strncasecmp((const char *) value, media_type,
+							media_len) =3D=3D 0 &&
+			(valuelen =3D=3D media_len || value[media_len] =3D=3D ';' ||
+					value[media_len] =3D=3D ' ');
+	}
+
+	return 0;
+}
+
+static int h2_on_data_chunk(nghttp2_session *session, uint8_t flags,
+				int32_t stream_id, const uint8_t *data,
+				size_t len, void *user_data)
+{
+	struct doh_query *query;
+
+	query =3D nghttp2_session_get_stream_user_data(session, stream_id);
+	if (!query)
+		return 0;
+
+	if (query->reply->len + len > DOH_MAX_MESSAGE) {
+		nghttp2_submit_rst_stream(session, NGHTTP2_FLAG_NONE,
+					stream_id, NGHTTP2_CANCEL);
+		query->status =3D 0;
+		return 0;
+	}
+
+	g_byte_array_append(query->reply, data, len);
+
+	return 0;
+}
+
+static int h2_on_frame_recv(nghttp2_session *session,
+				const nghttp2_frame *frame, void *user_data)
+{
+	struct doh_conn *conn =3D user_data;
+
+	if (frame->hd.type =3D=3D NGHTTP2_GOAWAY &&
+				conn->state =3D=3D DOH_CONN_READY) {
+		DBG("GOAWAY from %s", conn->server->host);
+
+		conn->state =3D DOH_CONN_CLOSING;
+		server_schedule(conn->server);
+	}
+
+	return 0;
+}
+
+static int h2_on_stream_close(nghttp2_session *session, int32_t stream_id,
+				uint32_t error_code, void *user_data)
+{
+	struct doh_conn *conn =3D user_data;
+	struct doh_server *server =3D conn->server;
+	struct doh_query *query;
+	const uint8_t *reply;
+	int err =3D 0;
+
+	query =3D nghttp2_session_get_stream_user_data(session, stream_id);
+	if (!query)
+		return 0;
+
+	query_detach(query);
+
+	/* The server did not process the stream, so it is safe to retry */
+	if (error_code =3D=3D NGHTTP2_REFUSED_STREAM && !query->retried) {
+		query->retried =3D true;
+		query_reset(query);
+		g_queue_push_head(server->queue, query);
+		server_schedule(server);
+		return 0;
+	}
+
+	reply =3D query->reply->data;
+
+	if (error_code !=3D NGHTTP2_NO_ERROR)
+		err =3D -ECONNRESET;
+	else if (query->status !=3D 200 || !query->dns_message)
+		err =3D -EPROTO;
+	else if (query->reply->len < DOH_DNS_HEADER_SIZE ||
+						!(reply[2] & 0x80))
+		err =3D -EBADMSG;
+
+	if (err) {
+		DBG("query %p on %s failed: status %u error %u", query,
+				server->host, query->status, error_code);
+
+		/* Other errors are about this query, not the server */
+		if (query->status >=3D 500 || query->status =3D=3D 429)
+			server_failed(server, err);
+
+		query_complete(query, err);
+		return 0;
+	}
+
+	conn->replies++;
+	server_succeeded(server);
+	query_complete(query, 0);
+
+	return 0;
+}
+
+static void conn_store_session(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	gnutls_datum_t data;
+
+	if (conn->time_tolerated)
+		return;
+
+	if (gnutls_session_get_data2(conn->session, &data) < 0)
+		return;
+
+	gnutls_free(server->session_data.data);
+	server->session_data =3D data;
+}
+
+static int conn_flush(struct doh_conn *conn)
+{
+	ssize_t ret;
+
+	while (conn->pending || conn->out->len) {
+		if (!conn->pending) {
+			conn->pending_len =3D MIN(conn->out->len, DOH_TLS_CHUNK);
+			conn->pending =3D g_malloc(conn->pending_len);
+			memcpy(conn->pending, conn->out->data,
+						conn->pending_len);
+			conn->pending_off =3D 0;
+			g_byte_array_remove_range(conn->out, 0,
+						conn->pending_len);
+		}
+
+		/*
+		 * GnuTLS needs exactly the same arguments again after
+		 * GNUTLS_E_AGAIN, hence the separate pending chunk.
+		 */
+		ret =3D gnutls_record_send(conn->session,
+				conn->pending + conn->pending_off,
+				conn->pending_len - conn->pending_off);
+		if (ret =3D=3D GNUTLS_E_AGAIN || ret =3D=3D GNUTLS_E_INTERRUPTED)
+			return 0;
+
+		if (ret < 0) {
+			DBG("send to %s failed: %s", conn->server->host,
+						gnutls_strerror(ret));
+			return -EIO;
+		}
+
+		conn->pending_off +=3D ret;
+		if (conn->pending_off =3D=3D conn->pending_len) {
+			g_free(conn->pending);
+			conn->pending =3D NULL;
+		}
+	}
+
+	return 0;
+}
+
+static int conn_write(struct doh_conn *conn)
+{
+	int ret;
+
+	ret =3D nghttp2_session_send(conn->h2);
+	if (ret !=3D 0) {
+		DBG("HTTP/2 send error: %s", nghttp2_strerror(ret));
+		return -EPROTO;
+	}
+
+	return conn_flush(conn);
+}
+
+static int conn_read(struct doh_conn *conn)
+{
+	uint8_t buf[4096];
+
+	while (true) {
+		ssize_t len =3D gnutls_record_recv(conn->session, buf,
+								sizeof(buf));
+		if (len > 0) {
+			doh_ssize_t ret;
+
+			conn->last_rx =3D g_get_monotonic_time();
+
+			ret =3D doh_h2_mem_recv(conn->h2, buf, len);
+			if (ret < 0) {
+				DBG("HTTP/2 error: %s",
+					nghttp2_strerror((int) ret));
+				return -EPROTO;
+			}
+
+			continue;
+		}
+
+		if (len =3D=3D GNUTLS_E_AGAIN)
+			return 0;
+
+		if (len =3D=3D 0 || len =3D=3D GNUTLS_E_PREMATURE_TERMINATION)
+			return -ECONNRESET;
+
+		if (!gnutls_error_is_fatal(len))
+			continue;
+
+		DBG("receive from %s failed: %s", conn->server->host,
+						gnutls_strerror(len));
+		return -EIO;
+	}
+}
+
+static gboolean conn_event(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data);
+
+static void conn_watch(struct doh_conn *conn, GIOCondition cond)
+{
+	if (conn->watch)
+		g_source_remove(conn->watch);
+
+	conn->watch =3D g_io_add_watch(conn->channel,
+				cond | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				conn_event, conn);
+}
+
+/*
+ * Flush pending output and decide what to wait for next. Closes the
+ * connection once HTTP/2 has nothing left to do on it.
+ */
+static void conn_update(struct doh_conn *conn)
+{
+	GIOCondition cond =3D G_IO_IN;
+	int err;
+
+	err =3D conn_write(conn);
+	if (err < 0) {
+		conn_failed(conn, err);
+		return;
+	}
+
+	if (!nghttp2_session_want_read(conn->h2) &&
+			!nghttp2_session_want_write(conn->h2) &&
+			!conn->pending && !conn->out->len) {
+		struct doh_server *server =3D conn->server;
+
+		/* The session ended, e.g. after a protocol error */
+		if (conn->queries) {
+			conn_failed(conn, -EPROTO);
+			return;
+		}
+
+		conn_close(conn);
+		server_schedule(server);
+		return;
+	}
+
+	if (conn->pending || conn->out->len ||
+			nghttp2_session_want_write(conn->h2))
+		cond |=3D G_IO_OUT;
+
+	if (conn->state =3D=3D DOH_CONN_READY) {
+		if (conn->queries && conn->timer) {
+			g_source_remove(conn->timer);
+			conn->timer =3D 0;
+		} else if (!conn->queries && !conn->timer) {
+			conn->timer =3D g_timeout_add_seconds(DOH_IDLE_TIMEOUT,
+						conn_idle_timeout, conn);
+		}
+	}
+
+	conn_watch(conn, cond);
+}
+
+static void set_header(nghttp2_nv *header, const char *name,
+							const char *value)
+{
+	header->name =3D (uint8_t *) name;
+	header->value =3D (uint8_t *) value;
+	header->namelen =3D strlen(name);
+	header->valuelen =3D strlen(value);
+	header->flags =3D NGHTTP2_NV_FLAG_NONE;
+}
+
+static int conn_submit(struct doh_conn *conn, struct doh_query *query)
+{
+	struct doh_server *server =3D conn->server;
+	doh_data_provider provider =3D {
+		.read_callback =3D h2_read_body,
+	};
+	nghttp2_nv headers[7];
+	char length[8];
+	int32_t stream_id;
+
+	snprintf(length, sizeof(length), "%zu", query->msg_len);
+
+	set_header(&headers[0], ":method", "POST");
+	set_header(&headers[1], ":scheme", "https");
+	set_header(&headers[2], ":authority", server->authority);
+	set_header(&headers[3], ":path", server->path);
+	set_header(&headers[4], "accept", "application/dns-message");
+	set_header(&headers[5], "content-type", "application/dns-message");
+	set_header(&headers[6], "content-length", length);
+
+	stream_id =3D doh_h2_submit_request(conn->h2, NULL, headers,
+				G_N_ELEMENTS(headers), &provider, query);
+	if (stream_id < 0) {
+		DBG("cannot submit request to %s: %s", server->host,
+					nghttp2_strerror(stream_id));
+		return -EIO;
+	}
+
+	query->conn =3D conn;
+	query->stream_id =3D stream_id;
+	query->started =3D g_get_monotonic_time();
+	conn->queries =3D g_slist_prepend(conn->queries, query);
+
+	return 0;
+}
+
+static struct doh_conn *server_current_conn(struct doh_server *server)
+{
+	for (GSList *list =3D server->conns; list; list =3D list->next) {
+		struct doh_conn *conn =3D list->data;
+
+		if (conn->state !=3D DOH_CONN_CLOSING)
+			return conn;
+	}
+
+	return NULL;
+}
+
+static int conn_start_tls(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	gnutls_datum_t alpn =3D { (unsigned char *) "h2", 2 };
+	int ret;
+
+	if (!load_credentials())
+		return -ENOKEY;
+
+	ret =3D gnutls_init(&conn->session, GNUTLS_CLIENT | GNUTLS_NONBLOCK |
+							GNUTLS_NO_SIGNAL);
+	if (ret < 0) {
+		conn->session =3D NULL;
+		return -ENOMEM;
+	}
+
+	if (gnutls_priority_set_direct(conn->session, DOH_PRIORITY,
+								NULL) < 0)
+		gnutls_set_default_priority(conn->session);
+
+	gnutls_credentials_set(conn->session, GNUTLS_CRD_CERTIFICATE,
+								credentials);
+
+	if (!server->numeric)
+		gnutls_server_name_set(conn->session, GNUTLS_NAME_DNS,
+					server->host, strlen(server->host));
+
+	gnutls_alpn_set_protocols(conn->session, &alpn, 1,
+						GNUTLS_ALPN_MANDATORY);
+
+	if (server->session_data.size)
+		gnutls_session_set_data(conn->session,
+					server->session_data.data,
+					server->session_data.size);
+
+	gnutls_handshake_set_timeout(conn->session,
+					GNUTLS_INDEFINITE_TIMEOUT);
+	gnutls_transport_set_int(conn->session, conn->fd);
+
+	return 0;
+}
+
+static int conn_start_h2(struct doh_conn *conn)
+{
+	nghttp2_settings_entry settings[] =3D {
+		{ NGHTTP2_SETTINGS_ENABLE_PUSH, 0 },
+		{ NGHTTP2_SETTINGS_MAX_CONCURRENT_STREAMS, 100 },
+	};
+
+	if (nghttp2_session_client_new(&conn->h2, h2_callbacks, conn) !=3D 0)
+		return -ENOMEM;
+
+	if (nghttp2_submit_settings(conn->h2, NGHTTP2_FLAG_NONE, settings,
+					G_N_ELEMENTS(settings)) !=3D 0)
+		return -EIO;
+
+	return 0;
+}
+
+/* Hand the queued queries to a ready connection */
+static void conn_submit_queued(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	struct doh_query *query;
+
+	while ((query =3D g_queue_pop_head(server->queue))) {
+		if (conn_submit(conn, query) < 0) {
+			g_queue_push_head(server->queue, query);
+			conn->state =3D DOH_CONN_CLOSING;
+			server_schedule(server);
+			break;
+		}
+	}
+}
+
+static void conn_handshake(struct doh_conn *conn)
+{
+	struct doh_server *server =3D conn->server;
+	gnutls_datum_t alpn;
+	int ret, err;
+
+	do {
+		ret =3D gnutls_handshake(conn->session);
+	} while (ret < 0 && ret !=3D GNUTLS_E_AGAIN &&
+					!gnutls_error_is_fatal(ret));
+
+	if (ret =3D=3D GNUTLS_E_AGAIN) {
+		conn_watch(conn, gnutls_record_get_direction(conn->session) ?
+							G_IO_OUT : G_IO_IN);
+		return;
+	}
+
+	if (ret < 0) {
+		connman_warn("DNS over HTTPS: TLS handshake with %s failed: "
+				"%s", server->host, gnutls_strerror(ret));
+		conn_failed(conn, -ECONNABORTED);
+		return;
+	}
+
+	err =3D conn_verify(conn);
+	if (err < 0) {
+		conn_failed(conn, err);
+		return;
+	}
+
+	if (gnutls_alpn_get_selected_protocol(conn->session, &alpn) < 0 ||
+			alpn.size !=3D 2 || memcmp(alpn.data, "h2", 2) !=3D 0) {
+		connman_warn("DNS over HTTPS: %s does not support HTTP/2",
+								server->host);
+		conn_failed(conn, -EPROTONOSUPPORT);
+		return;
+	}
+
+	err =3D conn_start_h2(conn);
+	if (err < 0) {
+		conn_failed(conn, err);
+		return;
+	}
+
+	DBG("connected to %s%s", server->host,
+		gnutls_session_is_resumed(conn->session) ? " (resumed)" : "");
+
+	g_source_remove(conn->timer);
+	conn->timer =3D 0;
+	conn->state =3D DOH_CONN_READY;
+	conn->last_rx =3D g_get_monotonic_time();
+	server->connect_failures =3D 0;
+
+	conn_submit_queued(conn);
+	conn_update(conn);
+}
+
+static void conn_connected(struct doh_conn *conn)
+{
+	socklen_t len =3D sizeof(int);
+	int err =3D 0;
+
+	if (getsockopt(conn->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
+		err =3D errno;
+
+	if (err) {
+		DBG("connect to %s failed: %s", conn->server->host,
+							strerror(err));
+		conn_failed(conn, -err);
+		return;
+	}
+
+	err =3D conn_start_tls(conn);
+	if (err < 0) {
+		conn_failed(conn, err);
+		return;
+	}
+
+	conn->state =3D DOH_CONN_HANDSHAKE;
+	conn_handshake(conn);
+}
+
+static gboolean conn_event(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct doh_conn *conn =3D user_data;
+	unsigned int replies;
+	int err;
+
+	conn->watch =3D 0;
+
+	switch (conn->state) {
+	case DOH_CONN_CONNECTING:
+		conn_connected(conn);
+		break;
+	case DOH_CONN_HANDSHAKE:
+		conn_handshake(conn);
+		break;
+	case DOH_CONN_READY:
+	case DOH_CONN_CLOSING:
+		replies =3D conn->replies;
+
+		/*
+		 * Completing a query may send new ones but never frees
+		 * this connection.
+		 */
+		err =3D conn_read(conn);
+		if (err < 0) {
+			conn_failed(conn, err);
+			break;
+		}
+
+		/* TLS 1.3 tickets arrive after the handshake */
+		if (replies =3D=3D 0 && conn->replies > 0)
+			conn_store_session(conn);
+
+		conn_update(conn);
+		break;
+	}
+
+	return FALSE;
+}
+
+static void conn_open(struct doh_server *server)
+{
+	unsigned int count =3D g_strv_length(server->addresses);
+	const char *address =3D server->addresses[server->next_address % count];
+	union {
+		struct sockaddr sa;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} addr;
+	socklen_t addr_len;
+	struct doh_conn *conn;
+	int fd, err, on =3D 1;
+
+	memset(&addr, 0, sizeof(addr));
+
+	if (inet_pton(AF_INET, address, &addr.sin.sin_addr) =3D=3D 1) {
+		addr.sin.sin_family =3D AF_INET;
+		addr.sin.sin_port =3D htons(server->port);
+		addr_len =3D sizeof(addr.sin);
+	} else if (inet_pton(AF_INET6, address, &addr.sin6.sin6_addr) =3D=3D 1) {
+		addr.sin6.sin6_family =3D AF_INET6;
+		addr.sin6.sin6_port =3D htons(server->port);
+		addr_len =3D sizeof(addr.sin6);
+	} else {
+		err =3D -EINVAL;
+		goto failed;
+	}
+
+	fd =3D socket(addr.sa.sa_family, SOCK_STREAM | SOCK_NONBLOCK |
+						SOCK_CLOEXEC, IPPROTO_TCP);
+	if (fd < 0) {
+		err =3D -errno;
+		goto failed;
+	}
+
+	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on));
+
+	if (connect(fd, &addr.sa, addr_len) < 0 && errno !=3D EINPROGRESS) {
+		err =3D -errno;
+		close(fd);
+		goto failed;
+	}
+
+	DBG("connecting to %s (%s)", server->host, address);
+
+	conn =3D g_new0(struct doh_conn, 1);
+	conn->server =3D server;
+	conn->state =3D DOH_CONN_CONNECTING;
+	conn->fd =3D fd;
+	conn->out =3D g_byte_array_new();
+	conn->channel =3D g_io_channel_unix_new(fd);
+	conn->timer =3D g_timeout_add_seconds(DOH_CONNECT_TIMEOUT,
+						conn_setup_timeout, conn);
+
+	server->conns =3D g_slist_prepend(server->conns, conn);
+
+	conn_watch(conn, G_IO_OUT);
+
+	return;
+
+failed:
+	DBG("cannot connect to %s (%s): %s", server->host, address,
+							strerror(-err));
+
+	server->next_address++;
+
+	if (++server->connect_failures < count) {
+		server_schedule(server);
+		return;
+	}
+
+	server->connect_failures =3D 0;
+	server_failed(server, err);
+}
+
+static void resolve_result(GResolvResultStatus status, char **results,
+							gpointer user_data)
+{
+	struct doh_server *server =3D user_data;
+
+	server->resolve_id =3D 0;
+
+	if (status !=3D G_RESOLV_RESULT_STATUS_SUCCESS || !results ||
+							!results[0]) {
+		DBG("cannot resolve %s (status %d)", server->host, status);
+
+		if (!server->addresses) {
+			server_failed(server, -EHOSTUNREACH);
+			return;
+		}
+
+		/* Keep using the addresses resolved earlier */
+		server->addresses_expire =3D now_seconds() + DOH_RESOLVE_RETRY;
+		server_schedule(server);
+		return;
+	}
+
+	g_strfreev(server->addresses);
+	server->addresses =3D g_strdupv(results);
+	server->addresses_expire =3D now_seconds() + DOH_RESOLVE_INTERVAL;
+	server->next_address =3D 0;
+	server->connect_failures =3D 0;
+
+	DBG("resolved %s to %s", server->host, server->addresses[0]);
+
+	server_schedule(server);
+}
+
+/*
+ * Server names without a known address are resolved through the DNS
+ * proxy itself, which forwards queries for them in plain text.
+ */
+static void server_resolve(struct doh_server *server)
+{
+	guint id;
+
+	if (server->resolve_id)
+		return;
+
+	if (!bootstrap) {
+		bootstrap =3D g_resolv_new(0);
+		if (!bootstrap) {
+			server_failed(server, -ENOMEM);
+			return;
+		}
+
+		if (!g_resolv_add_nameserver(bootstrap, "127.0.0.1",
+							bootstrap_port, 0)) {
+			g_resolv_unref(bootstrap);
+			bootstrap =3D NULL;
+			server_failed(server, -EIO);
+			return;
+		}
+	}
+
+	DBG("resolving %s", server->host);
+
+	/* Failures are returned as a negative errno cast to guint */
+	id =3D g_resolv_lookup_hostname(bootstrap, server->host,
+						resolve_result, server);
+	if ((gint) id <=3D 0) {
+		server_failed(server, -EIO);
+		return;
+	}
+
+	server->resolve_id =3D id;
+}
+
+static bool server_has_addresses(struct doh_server *server)
+{
+	if (!server->addresses || !server->addresses[0])
+		return false;
+
+	/* Refresh resolved addresses while still using the old ones */
+	if (!server->fixed_addresses &&
+			now_seconds() >=3D server->addresses_expire)
+		server_resolve(server);
+
+	return true;
+}
+
+static void server_dispatch(struct doh_server *server)
+{
+	struct doh_conn *conn;
+
+	if (g_queue_is_empty(server->queue))
+		return;
+
+	conn =3D server_current_conn(server);
+	if (!conn) {
+		if (server_has_addresses(server))
+			conn_open(server);
+		else
+			server_resolve(server);
+
+		return;
+	}
+
+	if (conn->state !=3D DOH_CONN_READY)
+		return;
+
+	conn_submit_queued(conn);
+	conn_update(conn);
+}
+
+static gboolean server_kick(gpointer user_data)
+{
+	struct doh_server *server =3D user_data;
+
+	server->kick =3D 0;
+
+	server_dispatch(server);
+
+	return FALSE;
+}
+
+static void server_schedule(struct doh_server *server)
+{
+	if (!server->kick)
+		server->kick =3D g_idle_add(server_kick, server);
+}
+
+static struct doh_server *server_new(void)
+{
+	struct doh_server *server =3D g_new0(struct doh_server, 1);
+
+	server->queue =3D g_queue_new();
+
+	return server;
+}
+
+struct doh_server *__connman_doh_server_new(const char *url)
+{
+	const struct doh_provider *provider;
+	struct doh_server *server =3D server_new();
+
+	if (parse_url(server, url) < 0) {
+		__connman_doh_server_free(server);
+		return NULL;
+	}
+
+	if (server->numeric) {
+		server->addresses =3D g_new0(char *, 2);
+		server->addresses[0] =3D g_strdup(server->host);
+		server->fixed_addresses =3D true;
+	} else {
+		provider =3D provider_by_host(server->host);
+		if (provider) {
+			server->addresses =3D provider_addresses(provider, 0);
+			server->fixed_addresses =3D true;
+		}
+	}
+
+	DBG("server %s", server->url);
+
+	return server;
+}
+
+struct doh_server *__connman_doh_server_new_for_address(const char *addres=
s)
+{
+	const struct doh_provider *provider;
+	struct doh_server *server;
+	g_autofree char *url =3D NULL;
+	unsigned int index;
+
+	provider =3D provider_by_address(address, &index);
+	if (!provider)
+		return NULL;
+
+	url =3D g_strdup_printf("https://%s%s", provider->host, provider->path);
+
+	server =3D server_new();
+	if (parse_url(server, url) < 0) {
+		__connman_doh_server_free(server);
+		return NULL;
+	}
+
+	/* Use the address the network (or user) chose first */
+	server->addresses =3D provider_addresses(provider, index);
+	server->fixed_addresses =3D true;
+
+	DBG("address %s server %s", address, server->url);
+
+	return server;
+}
+
+/*
+ * Pending queries are dropped without calling their callbacks. Must not
+ * be called from a reply callback.
+ */
+void __connman_doh_server_free(struct doh_server *server)
+{
+	struct doh_query *query;
+
+	if (!server)
+		return;
+
+	if (server->kick)
+		g_source_remove(server->kick);
+
+	if (server->resolve_id)
+		g_resolv_cancel_lookup(bootstrap, server->resolve_id);
+
+	while (server->conns) {
+		struct doh_conn *conn =3D server->conns->data;
+		GSList *list;
+
+		for (list =3D conn->queries; list; list =3D list->next)
+			query_free(list->data);
+
+		g_slist_free(conn->queries);
+		conn->queries =3D NULL;
+
+		conn_close(conn);
+	}
+
+	while ((query =3D g_queue_pop_head(server->queue)))
+		query_free(query);
+
+	g_queue_free(server->queue);
+
+	g_strfreev(server->addresses);
+	gnutls_free(server->session_data.data);
+	g_free(server->url);
+	g_free(server->host);
+	g_free(server->authority);
+	g_free(server->path);
+	g_free(server);
+}
+
+const char *__connman_doh_server_get_url(const struct doh_server *server)
+{
+	return server->url;
+}
+
+const char *__connman_doh_server_get_host(const struct doh_server *server)
+{
+	return server->host;
+}
+
+bool __connman_doh_server_is_available(const struct doh_server *server)
+{
+	return now_seconds() >=3D server->retry_after;
+}
+
+/* Forget past failures, e.g. after moving to another network */
+void __connman_doh_server_reset(struct doh_server *server)
+{
+	server->failures =3D 0;
+	server->retry_after =3D 0;
+	server->connect_failures =3D 0;
+}
+
+/*
+ * Send a DNS query. The reply callback is called exactly once, never
+ * from within this function, unless an error is returned.
+ */
+int __connman_doh_send(struct doh_server *server, const unsigned char *msg=
,
+				size_t len, connman_doh_reply_cb_t callback,
+				void *user_data)
+{
+	struct doh_query *query;
+
+	if (!server || !msg || !callback || len < DOH_DNS_HEADER_SIZE ||
+						len > DOH_MAX_MESSAGE)
+		return -EINVAL;
+
+	if (g_queue_get_length(server->queue) >=3D DOH_MAX_QUEUED)
+		return -EBUSY;
+
+	query =3D g_new0(struct doh_query, 1);
+	query->server =3D server;
+	query->msg =3D g_malloc(len);
+	query->msg_len =3D len;
+	query->reply =3D g_byte_array_new();
+	query->callback =3D callback;
+	query->user_data =3D user_data;
+	query->started =3D g_get_monotonic_time();
+
+	/* RFC 8484 4.1: use DNS ID 0, the original is restored on reply */
+	memcpy(query->msg, msg, len);
+	memcpy(query->id, msg, sizeof(query->id));
+	memset(query->msg, 0, sizeof(query->id));
+
+	query->timeout =3D g_timeout_add_seconds(DOH_QUERY_TIMEOUT,
+						query_timeout, query);
+
+	g_queue_push_tail(server->queue, query);
+	server_schedule(server);
+
+	return 0;
+}
+
+int __connman_doh_init(unsigned int dns_port)
+{
+	DBG("");
+
+	bootstrap_port =3D dns_port;
+
+	if (nghttp2_session_callbacks_new(&h2_callbacks) !=3D 0)
+		return -ENOMEM;
+
+	doh_h2_set_send_callback(h2_callbacks, h2_send);
+	nghttp2_session_callbacks_set_on_header_callback(h2_callbacks,
+							h2_on_header);
+	nghttp2_session_callbacks_set_on_data_chunk_recv_callback(h2_callbacks,
+							h2_on_data_chunk);
+	nghttp2_session_callbacks_set_on_frame_recv_callback(h2_callbacks,
+							h2_on_frame_recv);
+	nghttp2_session_callbacks_set_on_stream_close_callback(h2_callbacks,
+							h2_on_stream_close);
+
+	return 0;
+}
+
+void __connman_doh_cleanup(void)
+{
+	DBG("");
+
+	if (bootstrap) {
+		g_resolv_unref(bootstrap);
+		bootstrap =3D NULL;
+	}
+
+	if (h2_callbacks) {
+		nghttp2_session_callbacks_del(h2_callbacks);
+		h2_callbacks =3D NULL;
+	}
+
+	if (credentials) {
+		gnutls_certificate_free_credentials(credentials);
+		credentials =3D NULL;
+	}
+}
--=20
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.36.141.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883722;
	b=ZjDdMe8yMu8GGmWOHLc8HxnQhmt0RD/Pa4UsfaN0vWs3xg3/ZslZDpij6Ujyob4XB1lo
	 04le1H0T7II57/8JOe7Hi+NO98CK5yx/8SYJMk2a3TE1PxmHSkv55b4eHMzX6TiiH1waD
	 rLwTOdqIncvSb+ol90Z1s8gB1KE4Dff6fMYhvkHlXK/3jck1o3MOmmsGLg9ERIYc2UEyl
	 ewtZtIHAEyDNaCy7Hk3s7t8Pgfd99cRpChpCOSZ4wMCKFBHddfFq0ENhKAbUroe1BxHmt
	 dlBIsmuieF6i4mb/0OXos0WE91wwFDjMHWYCpYU+0+3uC52wXkV6ludJjoBy+5603EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883722;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=r7IgG6Pp2d7HyNJLmLzPbM3G6irvOKxFmMpY29+ul74=;
	b=q8A+jb+I8UYNs4hZ0GRrze0P60AmsUuzroNi1HpSy0iBETh4RN3VhU0Ueymxe+dxGrBN
	 e01XxHWJ7qwH1WTpct7+fZLXOv/Y0akeus/HTDFRQha5wGISSoBjN/PEle2wxb9CUs+16
	 Ig7Cunt+8EYJIhcG9gjbe0sXgxYuZF3omdfFihryc18vpjBgjWItyi/h13wRd/ci0gBz2
	 lnFIF6EKIgZcettLQnbuhJNWnA3URu0VMueJI5uvO7doXaw3DRel3IsQvOji7ZjgO1dzw
	 sWjarCHpjbdKivm3QSQBd2OOBcBuyzmjm41jNkzsfsUljxhtY78JzWgYRE2f3xwXUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=54.36.141.12
Received: from smtpout12.r2.mail-out.ovh.net (smtpout12.r2.mail-out.ovh.net [54.36.141.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C7606A326
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C99C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.54.109])
	by mo512.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wj0z6Jz6B9d
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:53 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 3/6] dnsproxy: Add DNS over HTTPS support
Date: Thu, 5 Nov 2026 13:01:42 +0000
Message-ID: <20261105130145.523935-4-email@samnazarko.co.uk>
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
x-ovh-tracer-id: 9097552723581259756
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFtOiFlHTNYDyj2LZ7skX042VW1BDxc4LFVPuBmvpvBUawJQeVvBrpDqhW6eHiERmNZJLytfBZ207zBas/jItDrFg1O8lblY4Qb6r1Uq3yUv3WF1b0Eb9vhDzZiHSvtJKJR1JoQIMWjViM3qO8FMexS2JYuksdAWStZtRre1IzcI5Rv40QIdQXooieVkzPhmuFAux9yUikV6dceTziA0kiM5ICPzo9ysKHxsTnNCpy5fuMch7NnwxNajQofQzFobCjMKGvjEjiMDA3TYyanqY7PzJy1Z/bBIvAcRPPhZU0SajmeRJm/U0BQp3o5x/thOBzBeCIUCNeZYr7Hm4IdqPhQOQ8xfvBfNv2XX1VXarHxMoGMAHcTbk2ouIEub1PulXUy9Fto6UohhSW8iNxD6DpQD3dML8pjlcRaPgUmxxIGq7PhkJgHxzQ5/2NqYInMBHyNgxFj9XZzznjQdIIH10dPfDMGyw2llIRQ+wOWRnQxqUJmBUBLTj/PWoDN7vie15X59sC45bTJUJKn/eKsyNW1/tZJTXgJp4Pvj9Nl9quDHRsH9kP0Da6quf6dqh7OOM8EcKELuJk11v1ZNSpers1sRYcvxrEK54vwNGAryvQvZ7FI9nwgIJl/N8YYlUEiPeB2JOIpEhrQtmBsdZBwsaJ81fbdv0xND0TrjCBLqXSmPw

Forward queries over DNS over HTTPS according to the new DNSOverHTTPS
setting:

  off     plain DNS only (default).
  auto    when every DNS server in use is a public resolver known to
          serve DoH on the same address, talk DoH to those resolvers,
          otherwise use plain DNS. The resolver answering never
          changes, so local DNS such as Pi-hole keeps working.
  on      use the DNSOverHTTPSServers, plain DNS while none of them
          can be reached.
  strict  use the DNSOverHTTPSServers and fail rather than fall back.

Names only the local network can resolve always go to the network's
servers in plain text: single label names, the local, lan, home,
home.arpa, internal and similar domains, reverse lookups of private
addresses and, except in strict mode, the network's search domains.

DoH replies take the normal reply path, so they are cached and
delivered to UDP and TCP clients like plain replies. Replies larger
than a UDP client accepts are truncated so the client retries over
TCP. Requests handled over DoH are never also sent in plain text by
flush_requests() or new TCP server connections, are not failed when a
plain TCP server connection closes and are never matched by ID
against plain DNS replies. When the DoH servers are merely overloaded
a request fails with SERVFAIL instead of falling back to plain text.

The state is inactive until DoH has been used, active after a
successful exchange and unavailable when no server could be reached,
or in strict mode without servers. When the mode or the servers are
changed over D-Bus, a root NS query, which reveals no name, updates the
state straight away. Backed off servers are tried again when the
default service changes. The mode and the servers are only stored once
they are set over D-Bus, so main.conf keeps applying until then.
---
 doc/connman.conf.5.in      |   16 +
 src/connman.h              |    7 +
 src/dns-systemd-resolved.c |   30 ++
 src/dnsproxy.c             | 1014 +++++++++++++++++++++++++++++++++++-
 src/main.c                 |   41 ++
 src/main.conf              |   10 +
 6 files changed, 1113 insertions(+), 5 deletions(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a81ac7bb..ea2dfefa 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -70,6 +70,22 @@ to the list of nameservers given by the service. The
 nameserver entries must be in numeric format, host
 names are ignored.
 .TP
+.BI DNSOverHTTPS=3D off\ \fR|\fB\ auto\ \fR|\fB\ on\ \fR|\fB\ strict
+How the DNS proxy uses DNS over HTTPS (RFC 8484). With auto, queries
+are sent over HTTPS when every DNS server in use is a public resolver
+known to offer it on the same address. With on, queries are sent to
+the DNSOverHTTPSServers, falling back to plain text DNS while they
+cannot be reached. With strict, queries fail instead of falling back.
+Names that only the local network can resolve always use the network's
+DNS servers. A value set over D-Bus takes precedence. Default value is
+off.
+.TP
+.BI DNSOverHTTPSServers=3D url\fR[,...]
+List of DNS over HTTPS servers, separated by ",", used by the on and
+strict modes unless servers are set over D-Bus. Each server is an
+https://host[:port][/path] URL and must support HTTP/2. Default value
+is empty.
+.TP
 .BI DefaultAutoConnectTechnologies=3D technology\fR[,...]
 List of technologies that are marked autoconnectable
 by default, separated by commas ",". The default value
diff --git a/src/connman.h b/src/connman.h
index 73532b66..4f609a39 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -1024,6 +1024,13 @@ int __connman_dnsproxy_append(int index, const char =
*domain, const char *server)
 int __connman_dnsproxy_remove(int index, const char *domain, const char *s=
erver);
 int __connman_dnsproxy_set_mdns(int index, bool enabled);
 void __connman_dnsproxy_set_listen_port(unsigned int port);
+const char *__connman_dnsproxy_get_doh_mode(void);
+const char *__connman_dnsproxy_get_doh_state(void);
+void __connman_dnsproxy_append_doh_servers(DBusMessageIter *iter,
+							void *user_data);
+int __connman_dnsproxy_configure_doh(const char *mode, char **servers);
+int __connman_dnsproxy_set_doh_mode(const char *mode);
+int __connman_dnsproxy_set_doh_servers(char **servers);
=20
 struct doh_server;
=20
diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
index 9dd0328c..3da702b9 100644
--- a/src/dns-systemd-resolved.c
+++ b/src/dns-systemd-resolved.c
@@ -822,3 +822,33 @@ void __connman_dnsproxy_cleanup(void)
 		connection =3D NULL;
 	}
 }
+
+const char *__connman_dnsproxy_get_doh_mode(void)
+{
+	return "off";
+}
+
+const char *__connman_dnsproxy_get_doh_state(void)
+{
+	return "off";
+}
+
+void __connman_dnsproxy_append_doh_servers(DBusMessageIter *iter,
+							void *user_data)
+{
+}
+
+int __connman_dnsproxy_configure_doh(const char *mode, char **servers)
+{
+	return -EOPNOTSUPP;
+}
+
+int __connman_dnsproxy_set_doh_mode(const char *mode)
+{
+	return -EOPNOTSUPP;
+}
+
+int __connman_dnsproxy_set_doh_servers(char **servers)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 9a7fe516..21486ebf 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -135,6 +135,9 @@ struct request_data {
 	gsize resplen;
 	struct listener_data *ifdata;
 	bool append_domain;
+	bool doh;		/* owned by DNS over HTTPS */
+	unsigned int doh_serial;
+	unsigned int doh_attempts;
 };
=20
 struct listener_data {
@@ -340,6 +343,10 @@ static struct request_data *find_request(guint16 id)
 	for (GSList *list =3D request_list; list; list =3D list->next) {
 		struct request_data *req =3D list->data;
=20
+		/* DoH requests never use their IDs on the wire */
+		if (req->doh)
+			continue;
+
 		if (req->dstid =3D=3D id || req->altid =3D=3D id)
 			return req;
 	}
@@ -2536,7 +2543,7 @@ hangup:
 			req =3D list->data;
 			list =3D list->next;
=20
-			if (req->protocol =3D=3D IPPROTO_UDP)
+			if (req->protocol =3D=3D IPPROTO_UDP || req->doh)
 				continue;
 			else if (!req->request)
 				continue;
@@ -2601,7 +2608,7 @@ hangup:
 			int status;
 			req =3D list->data;
=20
-			if (req->protocol =3D=3D IPPROTO_UDP) {
+			if (req->protocol =3D=3D IPPROTO_UDP || req->doh) {
 				list =3D list->next;
 				continue;
 			}
@@ -2968,6 +2975,936 @@ static bool resolv(struct request_data *req,
 	return false;
 }
=20
+/*
+ * DNS over HTTPS
+ *
+ * off:    plain DNS only.
+ * auto:   when every enabled server is a public resolver known to serve
+ *         DoH on the same address, talk DoH to those same resolvers.
+ * on:     use the configured DoH servers, plain DNS when they fail.
+ * strict: use the configured DoH servers, fail when they fail.
+ *
+ * Names that only the local network can resolve always use the
+ * network's servers in plain text.
+ */
+
+#define DOH_REQUEST_TIMEOUT 10	/* seconds, UDP clients */
+#define DOH_MAX_SERVERS 8
+
+enum doh_mode {
+	DOH_MODE_OFF,
+	DOH_MODE_AUTO,
+	DOH_MODE_ON,
+	DOH_MODE_STRICT,
+};
+
+enum doh_state {
+	DOH_STATE_OFF,
+	DOH_STATE_INACTIVE,
+	DOH_STATE_ACTIVE,
+	DOH_STATE_UNAVAILABLE,
+};
+
+static const char *doh_mode_names[] =3D { "off", "auto", "on", "strict" };
+static const char *doh_state_names[] =3D {
+	"off", "inactive", "active", "unavailable"
+};
+
+static const char *doh_local_domains[] =3D {
+	"local", "localhost", "localdomain", "lan", "home", "home.arpa",
+	"internal", "intranet", "corp", "private", NULL
+};
+
+static bool dnsproxy_running;
+static enum doh_mode doh_mode;
+static bool doh_mode_stored;		/* chosen over D-Bus */
+static enum doh_state doh_state;
+static char **doh_user_servers;		/* from D-Bus, empty: defaults */
+static GSList *doh_servers;		/* on and strict modes */
+static GHashTable *doh_auto_servers;	/* plain address -> server */
+static unsigned int doh_serial;
+
+static void doh_reply(int err, const unsigned char *reply, size_t len,
+							void *user_data);
+
+static bool name_in_domain(const char *name, const char *domain)
+{
+	size_t len =3D strlen(name), domain_len =3D strlen(domain);
+
+	if (domain_len && domain[domain_len - 1] =3D=3D '.')
+		domain_len--;
+
+	if (!domain_len || len < domain_len)
+		return false;
+
+	if (g_ascii_strncasecmp(name + len - domain_len, domain,
+							domain_len) !=3D 0)
+		return false;
+
+	return len =3D=3D domain_len || name[len - domain_len - 1] =3D=3D '.';
+}
+
+static int label_number(const char *label)
+{
+	char *end;
+	long value;
+
+	if (!g_ascii_isdigit(label[0]))
+		return -1;
+
+	value =3D strtol(label, &end, 10);
+	if (*end !=3D '\0' || value > 255)
+		return -1;
+
+	return value;
+}
+
+/* Reverse lookups of private, link-local and loopback addresses */
+static bool is_private_reverse(const char *name)
+{
+	g_auto(GStrv) labels =3D NULL;
+	unsigned int count;
+
+	if (name_in_domain(name, "in-addr.arpa")) {
+		int first, second;
+
+		labels =3D g_strsplit(name, ".", -1);
+		count =3D g_strv_length(labels);
+		if (count < 3)
+			return false;
+
+		first =3D label_number(labels[count - 3]);
+		if (first =3D=3D 10 || first =3D=3D 127)
+			return true;
+
+		if (count < 4)
+			return false;
+
+		second =3D label_number(labels[count - 4]);
+
+		return (first =3D=3D 172 && second >=3D 16 && second <=3D 31) ||
+			(first =3D=3D 192 && second =3D=3D 168) ||
+			(first =3D=3D 169 && second =3D=3D 254) ||
+			(first =3D=3D 100 && second >=3D 64 && second <=3D 127);
+	}
+
+	if (name_in_domain(name, "ip6.arpa")) {
+		labels =3D g_strsplit(name, ".", -1);
+		count =3D g_strv_length(labels);
+		if (count < 4 || g_strcmp0(labels[count - 3], "f") !=3D 0)
+			return false;
+
+		/* fc00::/7 */
+		if (g_str_equal(labels[count - 4], "c") ||
+				g_str_equal(labels[count - 4], "d"))
+			return true;
+
+		/* fe80::/10 */
+		return count >=3D 5 && g_str_equal(labels[count - 4], "e") &&
+			strchr("89ab", labels[count - 5][0]) &&
+			labels[count - 5][0] && !labels[count - 5][1];
+	}
+
+	return false;
+}
+
+static bool doh_is_local(const char *query)
+{
+	g_autofree char *name =3D g_ascii_strdown(query, -1);
+	size_t len =3D strlen(name);
+
+	if (len && name[len - 1] =3D=3D '.')
+		name[--len] =3D '\0';
+
+	/* Single label names are for the local network */
+	if (!strchr(name, '.'))
+		return true;
+
+	for (int i =3D 0; doh_local_domains[i]; i++) {
+		if (name_in_domain(name, doh_local_domains[i]))
+			return true;
+	}
+
+	if (is_private_reverse(name))
+		return true;
+
+	/* Bootstrap lookups of the DoH servers themselves */
+	for (GSList *list =3D doh_servers; list; list =3D list->next) {
+		if (g_str_equal(name, __connman_doh_server_get_host(list->data)))
+			return true;
+	}
+
+	/*
+	 * Search domains handed out by the network. Strict mode does not
+	 * let the network decide what leaves the device unencrypted.
+	 */
+	if (doh_mode =3D=3D DOH_MODE_STRICT)
+		return false;
+
+	for (GSList *list =3D server_list; list; list =3D list->next) {
+		struct server_data *data =3D list->data;
+
+		if (!data->enabled)
+			continue;
+
+		for (GList *dom =3D data->domains; dom; dom =3D dom->next) {
+			const char *domain =3D dom->data;
+
+			/* Ignore top level domains such as "com" */
+			if (domain && strchr(domain, '.') &&
+					name_in_domain(name, domain))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static struct doh_server *doh_auto_server(const char *address)
+{
+	struct doh_server *server;
+
+	if (!doh_auto_servers)
+		doh_auto_servers =3D g_hash_table_new_full(g_str_hash,
+					g_str_equal, g_free,
+					(GDestroyNotify) __connman_doh_server_free);
+
+	/* Addresses of unknown resolvers are cached as NULL */
+	if (g_hash_table_lookup_extended(doh_auto_servers, address, NULL,
+							(gpointer *) &server))
+		return server;
+
+	server =3D __connman_doh_server_new_for_address(address);
+	g_hash_table_insert(doh_auto_servers, g_strdup(address), server);
+
+	return server;
+}
+
+/* DoH servers to try for a query, in order of preference */
+static GSList *doh_current_servers(void)
+{
+	GSList *servers =3D NULL;
+
+	if (doh_mode =3D=3D DOH_MODE_ON || doh_mode =3D=3D DOH_MODE_STRICT)
+		return g_slist_copy(doh_servers);
+
+	if (doh_mode !=3D DOH_MODE_AUTO)
+		return NULL;
+
+	for (GSList *list =3D server_list; list; list =3D list->next) {
+		struct server_data *data =3D list->data;
+		struct doh_server *server;
+
+		if (data->protocol !=3D IPPROTO_UDP || !data->enabled)
+			continue;
+
+		/* Only upgrade when no plain server would still be used */
+		server =3D doh_auto_server(data->server);
+		if (!server) {
+			g_slist_free(servers);
+			return NULL;
+		}
+
+		if (!g_slist_find(servers, server))
+			servers =3D g_slist_append(servers, server);
+	}
+
+	return servers;
+}
+
+static void doh_set_state(enum doh_state state)
+{
+	DBusConnection *conn;
+	const char *str;
+
+	if (doh_state =3D=3D state)
+		return;
+
+	DBG("DNS over HTTPS %s -> %s", doh_state_names[doh_state],
+						doh_state_names[state]);
+
+	if (state =3D=3D DOH_STATE_UNAVAILABLE)
+		connman_warn("DNS over HTTPS unavailable, %s",
+			doh_mode =3D=3D DOH_MODE_STRICT ? "lookups will fail" :
+						"using plain DNS");
+	else if (state =3D=3D DOH_STATE_ACTIVE)
+		connman_info("DNS over HTTPS active");
+
+	doh_state =3D state;
+
+	conn =3D connman_dbus_get_connection();
+	if (!conn)
+		return;
+
+	str =3D doh_state_names[state];
+	connman_dbus_property_changed_basic(CONNMAN_MANAGER_PATH,
+				CONNMAN_MANAGER_INTERFACE, "DNSOverHTTPSState",
+				DBUS_TYPE_STRING, &str);
+
+	dbus_connection_unref(conn);
+}
+
+static void doh_update_state(bool reset)
+{
+	enum doh_state state =3D doh_state;
+	GSList *servers;
+
+	if (doh_mode =3D=3D DOH_MODE_OFF) {
+		doh_set_state(DOH_STATE_OFF);
+		return;
+	}
+
+	servers =3D doh_current_servers();
+
+	/* Strict mode fails every lookup when it has no server */
+	if (!servers)
+		state =3D doh_mode =3D=3D DOH_MODE_STRICT ?
+			DOH_STATE_UNAVAILABLE : DOH_STATE_INACTIVE;
+	else if (reset || state =3D=3D DOH_STATE_OFF)
+		state =3D DOH_STATE_INACTIVE;	/* until it is used */
+
+	g_slist_free(servers);
+
+	doh_set_state(state);
+}
+
+/* Report the outcome of an exchange while DoH still applies */
+static void doh_report(enum doh_state state)
+{
+	GSList *servers =3D doh_current_servers();
+
+	if (servers)
+		doh_set_state(state);
+	else
+		doh_update_state(false);
+
+	g_slist_free(servers);
+}
+
+static bool doh_wanted(const char *name)
+{
+	GSList *servers;
+
+	if (doh_mode =3D=3D DOH_MODE_OFF || doh_is_local(name))
+		return false;
+
+	if (doh_mode =3D=3D DOH_MODE_STRICT)
+		return true;
+
+	servers =3D doh_current_servers();
+	g_slist_free(servers);
+
+	return servers !=3D NULL;
+}
+
+/*
+ * Hand the request to the next DoH server not yet tried for it. Returns
+ * -EBUSY when the remaining servers are only overloaded and -ENODEV when
+ * none of them can be used.
+ */
+static int doh_forward(struct request_data *req)
+{
+	const size_t offset =3D protocol_offset(req->protocol);
+	GSList *servers =3D doh_current_servers(), *list;
+	unsigned int index =3D 0;
+	bool sent =3D false, busy =3D false;
+
+	for (list =3D servers; list && !sent; list =3D list->next, index++) {
+		struct doh_server *server =3D list->data;
+		int err;
+
+		if (index < req->doh_attempts)
+			continue;
+
+		req->doh_attempts =3D index + 1;
+
+		if (doh_mode !=3D DOH_MODE_STRICT &&
+				!__connman_doh_server_is_available(server))
+			continue;
+
+		err =3D __connman_doh_send(server,
+				(unsigned char *) req->request + offset,
+				req->request_len - offset, doh_reply,
+				GUINT_TO_POINTER(req->doh_serial));
+		if (err =3D=3D -EBUSY)
+			busy =3D true;
+
+		if (err < 0)
+			continue;
+
+		debug("req %p %s via %s", req, (char *) req->name,
+					__connman_doh_server_get_url(server));
+		sent =3D true;
+	}
+
+	g_slist_free(servers);
+
+	if (sent)
+		return 0;
+
+	return busy ? -EBUSY : -ENODEV;
+}
+
+static void doh_servfail(struct request_data *req)
+{
+	struct domain_hdr *hdr =3D (void *) ((char *) req->request +
+					protocol_offset(req->protocol));
+
+	hdr->id =3D req->srcid;
+
+	if (req->protocol =3D=3D IPPROTO_UDP) {
+		int sk =3D get_req_udp_socket(req);
+
+		if (sk >=3D 0)
+			send_response(sk, req->request, req->request_len,
+					&req->sa, req->sa_len, IPPROTO_UDP);
+	} else {
+		send_response(req->client_sk, req->request, req->request_len,
+						NULL, 0, IPPROTO_TCP);
+	}
+
+	request_list =3D g_slist_remove(request_list, req);
+	destroy_request_data(req);
+}
+
+/* Forward the request in plain text, or fail it in strict mode */
+static void doh_fallback(struct request_data *req)
+{
+	bool sent =3D false;
+
+	req->doh =3D false;
+	req->numserv =3D 0;
+	req->numresp =3D 0;
+
+	if (doh_mode !=3D DOH_MODE_STRICT) {
+		for (GSList *list =3D server_list; list; list =3D list->next) {
+			struct server_data *data =3D list->data;
+			int err;
+
+			if (data->protocol !=3D IPPROTO_UDP || !data->enabled)
+				continue;
+
+			/* Sent once the TCP connection is established */
+			if (req->protocol =3D=3D IPPROTO_TCP) {
+				if (create_server(data->index, NULL,
+						data->server, IPPROTO_TCP))
+					sent =3D true;
+				continue;
+			}
+
+			if (!data->channel && server_create_socket(data) < 0)
+				continue;
+
+			err =3D ns_resolv(data, req, req->request, req->name);
+			if (err > 0) {
+				/* answered from the cache */
+				request_list =3D g_slist_remove(request_list,
+									req);
+				destroy_request_data(req);
+				return;
+			}
+
+			if (err =3D=3D 0)
+				sent =3D true;
+		}
+	}
+
+	if (!sent) {
+		debug("req %p %s failed", req, (char *) req->name);
+		doh_servfail(req);
+		return;
+	}
+
+	debug("req %p %s falls back to plain DNS", req, (char *) req->name);
+
+	if (req->timeout > 0)
+		g_source_remove(req->timeout);
+
+	req->timeout =3D g_timeout_add_seconds(
+				req->protocol =3D=3D IPPROTO_TCP ? 30 : 5,
+				request_timeout, req);
+}
+
+/*
+ * Send the request to the next DoH server. Overloaded servers fail only
+ * this request; unusable ones make it fall back to plain DNS, or fail
+ * in strict mode.
+ */
+static void doh_retry(struct request_data *req)
+{
+	int err =3D doh_forward(req);
+
+	if (err =3D=3D 0)
+		return;
+
+	if (err =3D=3D -EBUSY) {
+		req->doh =3D false;
+		doh_servfail(req);
+		return;
+	}
+
+	doh_report(DOH_STATE_UNAVAILABLE);
+	doh_fallback(req);
+}
+
+/* Takes over a request that is already on the request list */
+static void doh_dispatch(struct request_data *req)
+{
+	req->doh =3D true;
+	req->doh_attempts =3D 0;
+	req->numserv =3D 1;
+
+	if (++doh_serial =3D=3D 0)
+		doh_serial =3D 1;
+
+	req->doh_serial =3D doh_serial;
+
+	doh_retry(req);
+}
+
+static size_t dns_question_end(const unsigned char *msg, size_t len)
+{
+	size_t pos =3D DNS_HEADER_SIZE;
+
+	while (pos < len && msg[pos]) {
+		if ((msg[pos] & NS_CMPRSFLGS) =3D=3D NS_CMPRSFLGS) {
+			pos +=3D 1;
+			break;
+		}
+
+		pos +=3D msg[pos] + 1;
+	}
+
+	pos +=3D 1 + DNS_QTYPE_QCLASS_SIZE;
+
+	return pos <=3D len ? pos : 0;
+}
+
+/* Largest UDP response the client accepts (RFC 6891) */
+static size_t request_udp_size(const struct request_data *req)
+{
+	const unsigned char *msg =3D req->request;
+	const struct domain_hdr *hdr =3D req->request;
+	size_t pos =3D dns_question_end(msg, req->request_len);
+	size_t size;
+
+	if (!pos || !hdr->arcount || pos + 11 > req->request_len ||
+			msg[pos] !=3D 0 || msg[pos + 1] !=3D 0 ||
+			msg[pos + 2] !=3D ns_t_opt)
+		return 512;
+
+	size =3D msg[pos + 3] << 8 | msg[pos + 4];
+
+	return MAX(size, 512);
+}
+
+static void doh_deliver(struct request_data *req, const unsigned char *rep=
ly,
+								size_t len)
+{
+	const size_t offset =3D protocol_offset(req->protocol);
+	g_autofree char *buf =3D g_malloc(offset + len);
+
+	if (offset) {
+		const uint16_t msg_len =3D htons(len);
+
+		memcpy(buf, &msg_len, sizeof(msg_len));
+	}
+	memcpy(buf + offset, reply, len);
+
+	req->numresp++;
+
+	if (req->protocol =3D=3D IPPROTO_UDP && len > request_udp_size(req)) {
+		struct domain_hdr *hdr =3D (void *) buf;
+		size_t question =3D dns_question_end(reply, len);
+		int sk =3D get_req_udp_socket(req);
+
+		/* Make the client retry over TCP */
+		cache_update(IPPROTO_UDP, (unsigned char *) buf, len);
+
+		hdr->id =3D req->srcid;
+		hdr->tc =3D 1;
+		hdr->ancount =3D 0;
+		hdr->nscount =3D 0;
+		hdr->arcount =3D 0;
+
+		if (question && sk >=3D 0 && sendto(sk, buf, question,
+				MSG_NOSIGNAL, &req->sa, req->sa_len) < 0)
+			debug("Cannot send truncated reply: %s",
+							strerror(errno));
+	} else {
+		forward_dns_reply(buf, offset + len, req->protocol, req);
+	}
+
+	request_list =3D g_slist_remove(request_list, req);
+	destroy_request_data(req);
+}
+
+static void doh_reply(int err, const unsigned char *reply, size_t len,
+							void *user_data)
+{
+	const unsigned int serial =3D GPOINTER_TO_UINT(user_data);
+	struct request_data *req =3D NULL;
+
+	for (GSList *list =3D request_list; list; list =3D list->next) {
+		struct request_data *data =3D list->data;
+
+		if (data->doh && data->doh_serial =3D=3D serial) {
+			req =3D data;
+			break;
+		}
+	}
+
+	/* Timed out or answered already */
+	if (!req)
+		return;
+
+	if (err =3D=3D 0 && !reply_matches_request(req, reply, len,
+							IPPROTO_UDP))
+		err =3D -EBADMSG;
+
+	if (err < 0) {
+		debug("req %p %s failed: %s", req, (char *) req->name,
+							strerror(-err));
+		doh_retry(req);
+		return;
+	}
+
+	doh_report(DOH_STATE_ACTIVE);
+	doh_deliver(req, reply, len);
+}
+
+/* A root NS query checks a new configuration without leaking names */
+static const unsigned char doh_probe_query[] =3D {
+	0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01,
+};
+
+static void doh_probe(unsigned int index);
+
+static void doh_probe_reply(int err, const unsigned char *reply,
+					size_t len, void *user_data)
+{
+	if (err < 0)
+		doh_probe(GPOINTER_TO_UINT(user_data) + 1);
+	else
+		doh_report(DOH_STATE_ACTIVE);
+}
+
+/* Updates the state soon after the servers were changed over D-Bus */
+static void doh_probe(unsigned int index)
+{
+	struct doh_server *server;
+
+	if (doh_mode !=3D DOH_MODE_ON && doh_mode !=3D DOH_MODE_STRICT)
+		return;
+
+	for (; (server =3D g_slist_nth_data(doh_servers, index)); index++) {
+		if (__connman_doh_send(server, doh_probe_query,
+				sizeof(doh_probe_query), doh_probe_reply,
+				GUINT_TO_POINTER(index)) =3D=3D 0)
+			return;
+	}
+
+	if (doh_servers)
+		doh_report(DOH_STATE_UNAVAILABLE);
+}
+
+static void doh_free_servers(void)
+{
+	g_slist_free_full(doh_servers,
+			(GDestroyNotify) __connman_doh_server_free);
+	doh_servers =3D NULL;
+
+	if (doh_auto_servers) {
+		g_hash_table_destroy(doh_auto_servers);
+		doh_auto_servers =3D NULL;
+	}
+}
+
+/* Retry backed off servers, e.g. after moving to another network */
+static void doh_reset_servers(void)
+{
+	GHashTableIter iter;
+	gpointer server;
+
+	for (GSList *list =3D doh_servers; list; list =3D list->next)
+		__connman_doh_server_reset(list->data);
+
+	if (!doh_auto_servers)
+		return;
+
+	g_hash_table_iter_init(&iter, doh_auto_servers);
+	while (g_hash_table_iter_next(&iter, NULL, &server)) {
+		if (server)
+			__connman_doh_server_reset(server);
+	}
+}
+
+/* (Re)create the servers after a configuration change */
+static void doh_apply(void)
+{
+	char **urls =3D doh_user_servers;
+
+	if (!urls || !urls[0])
+		urls =3D connman_setting_get_string_list("DNSOverHTTPSServers");
+
+	doh_free_servers();
+
+	if (doh_mode =3D=3D DOH_MODE_ON || doh_mode =3D=3D DOH_MODE_STRICT) {
+		for (int i =3D 0; urls && urls[i]; i++) {
+			struct doh_server *server;
+
+			server =3D __connman_doh_server_new(urls[i]);
+			if (!server) {
+				connman_warn("Invalid DNS over HTTPS server %s",
+								urls[i]);
+				continue;
+			}
+
+			doh_servers =3D g_slist_append(doh_servers, server);
+		}
+
+		if (!doh_servers)
+			connman_warn("DNS over HTTPS is %s but no server is "
+				"configured", doh_mode_names[doh_mode]);
+	}
+
+	/* Requests sent to the old servers need a new home */
+	for (GSList *list =3D request_list; list; ) {
+		struct request_data *req =3D list->data;
+
+		list =3D list->next;
+
+		if (!req->doh)
+			continue;
+
+		req->doh_attempts =3D 0;
+		if (doh_mode =3D=3D DOH_MODE_OFF)
+			doh_fallback(req);
+		else
+			doh_retry(req);
+	}
+
+	cache_invalidate();
+
+	doh_update_state(true);
+}
+
+static bool string2doh_mode(const char *str, enum doh_mode *mode)
+{
+	for (size_t i =3D 0; i < NUM_ARRAY_ELEMENTS(doh_mode_names); i++) {
+		if (g_strcmp0(str, doh_mode_names[i]) =3D=3D 0) {
+			*mode =3D i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool doh_valid_servers(char **servers)
+{
+	if (servers && g_strv_length(servers) > DOH_MAX_SERVERS)
+		return false;
+
+	for (int i =3D 0; servers && servers[i]; i++) {
+		if (!__connman_doh_url_is_valid(servers[i]))
+			return false;
+	}
+
+	return true;
+}
+
+static void doh_load(void)
+{
+	GKeyFile *keyfile;
+	char **servers;
+	char *str;
+
+	if (!string2doh_mode(connman_setting_get_string("DNSOverHTTPS"),
+								&doh_mode))
+		doh_mode =3D DOH_MODE_OFF;
+
+	keyfile =3D __connman_storage_load_global();
+	if (!keyfile)
+		return;
+
+	str =3D g_key_file_get_string(keyfile, "global", "DNSOverHTTPS", NULL);
+	if (str && string2doh_mode(str, &doh_mode))
+		doh_mode_stored =3D true;
+	else if (str)
+		connman_warn("Invalid stored DNSOverHTTPS mode %s", str);
+
+	g_free(str);
+
+	servers =3D g_key_file_get_string_list(keyfile, "global",
+					"DNSOverHTTPSServers", NULL, NULL);
+	if (doh_valid_servers(servers))
+		doh_user_servers =3D servers;
+	else
+		g_strfreev(servers);
+
+	g_key_file_free(keyfile);
+}
+
+static void doh_save(void)
+{
+	GKeyFile *keyfile;
+
+	keyfile =3D __connman_storage_load_global();
+	if (!keyfile)
+		keyfile =3D g_key_file_new();
+
+	/* Values not chosen over D-Bus follow main.conf */
+	if (doh_mode_stored)
+		g_key_file_set_string(keyfile, "global", "DNSOverHTTPS",
+						doh_mode_names[doh_mode]);
+	else
+		g_key_file_remove_key(keyfile, "global", "DNSOverHTTPS",
+									NULL);
+
+	if (doh_user_servers && doh_user_servers[0])
+		g_key_file_set_string_list(keyfile, "global",
+				"DNSOverHTTPSServers",
+				(const gchar * const *) doh_user_servers,
+				g_strv_length(doh_user_servers));
+	else
+		g_key_file_remove_key(keyfile, "global",
+					"DNSOverHTTPSServers", NULL);
+
+	__connman_storage_save_global(keyfile);
+
+	g_key_file_free(keyfile);
+}
+
+static void append_doh_servers(DBusMessageIter *iter, void *user_data)
+{
+	for (int i =3D 0; doh_user_servers && doh_user_servers[i]; i++)
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&doh_user_servers[i]);
+}
+
+const char *__connman_dnsproxy_get_doh_mode(void)
+{
+	return dnsproxy_running ? doh_mode_names[doh_mode] : "off";
+}
+
+const char *__connman_dnsproxy_get_doh_state(void)
+{
+	return dnsproxy_running ? doh_state_names[doh_state] : "off";
+}
+
+void __connman_dnsproxy_append_doh_servers(DBusMessageIter *iter,
+							void *user_data)
+{
+	append_doh_servers(iter, user_data);
+}
+
+/* Apply a configuration without storing it, e.g. for testing */
+int __connman_dnsproxy_configure_doh(const char *mode, char **servers)
+{
+	enum doh_mode new_mode;
+
+	if (!dnsproxy_running)
+		return -EOPNOTSUPP;
+
+	if (!string2doh_mode(mode, &new_mode) || !doh_valid_servers(servers))
+		return -EINVAL;
+
+	doh_mode =3D new_mode;
+
+	g_strfreev(doh_user_servers);
+	doh_user_servers =3D g_strdupv(servers);
+
+	doh_apply();
+
+	return 0;
+}
+
+int __connman_dnsproxy_set_doh_mode(const char *mode)
+{
+	DBusConnection *conn;
+	enum doh_mode new_mode;
+	const char *str;
+
+	if (!dnsproxy_running)
+		return -EOPNOTSUPP;
+
+	if (!string2doh_mode(mode, &new_mode))
+		return -EINVAL;
+
+	doh_mode_stored =3D true;
+
+	if (new_mode =3D=3D doh_mode) {
+		doh_save();
+		return 0;
+	}
+
+	doh_mode =3D new_mode;
+	doh_save();
+	doh_apply();
+	doh_probe(0);
+
+	conn =3D connman_dbus_get_connection();
+	if (conn) {
+		str =3D doh_mode_names[doh_mode];
+		connman_dbus_property_changed_basic(CONNMAN_MANAGER_PATH,
+				CONNMAN_MANAGER_INTERFACE, "DNSOverHTTPS",
+				DBUS_TYPE_STRING, &str);
+		dbus_connection_unref(conn);
+	}
+
+	return 0;
+}
+
+static bool doh_same_servers(char **a, char **b)
+{
+	unsigned int len_a =3D a ? g_strv_length(a) : 0;
+	unsigned int len_b =3D b ? g_strv_length(b) : 0;
+
+	if (len_a !=3D len_b)
+		return false;
+
+	for (unsigned int i =3D 0; i < len_a; i++) {
+		if (!g_str_equal(a[i], b[i]))
+			return false;
+	}
+
+	return true;
+}
+
+int __connman_dnsproxy_set_doh_servers(char **servers)
+{
+	DBusConnection *conn;
+
+	if (!dnsproxy_running)
+		return -EOPNOTSUPP;
+
+	if (!doh_valid_servers(servers))
+		return -EINVAL;
+
+	if (doh_same_servers(servers, doh_user_servers))
+		return 0;
+
+	g_strfreev(doh_user_servers);
+	doh_user_servers =3D g_strdupv(servers);
+
+	doh_save();
+	doh_apply();
+	doh_probe(0);
+
+	conn =3D connman_dbus_get_connection();
+	if (conn) {
+		connman_dbus_property_changed_array(CONNMAN_MANAGER_PATH,
+				CONNMAN_MANAGER_INTERFACE,
+				"DNSOverHTTPSServers", DBUS_TYPE_STRING,
+				append_doh_servers, NULL);
+		dbus_connection_unref(conn);
+	}
+
+	return 0;
+}
+
 static void update_domain(int index, const char *domain, bool append)
 {
 	DBG("index %d domain %s", index, domain);
@@ -3024,6 +3961,9 @@ static void flush_requests(struct server_data *server=
)
=20
 		list =3D list->next;
=20
+		if (req->doh)
+			continue;
+
 		if (ns_resolv(server, req, req->request, req->name)) {
 			/*
 			 * A cached result was sent,
@@ -3073,6 +4013,7 @@ int __connman_dnsproxy_append(int index, const char *=
domain,
 		return -EIO;
=20
 	flush_requests(data);
+	doh_update_state(false);
=20
 	return 0;
 }
@@ -3112,6 +4053,7 @@ int __connman_dnsproxy_remove(int index, const char *=
domain,
=20
 	remove_server(index, server, IPPROTO_UDP);
 	remove_server(index, server, IPPROTO_TCP);
+	doh_update_state(false);
=20
 	return 0;
 }
@@ -3146,9 +4088,12 @@ static void dnsproxy_default_changed(struct connman_=
service *service)
 	/* DNS has changed, invalidate the cache */
 	cache_invalidate();
=20
+	doh_reset_servers();
+
 	if (!service) {
 		/* When no services are active, then disable DNS proxying */
 		dnsproxy_offline_mode(true);
+		doh_update_state(false);
 		return;
 	}
=20
@@ -3182,6 +4127,8 @@ static void dnsproxy_default_changed(struct connman_s=
ervice *service)
 	if (!any_server_enabled)
 		enable_fallback(true);
=20
+	doh_update_state(false);
+
 	cache_refresh();
 }
=20
@@ -3409,7 +4356,7 @@ read_another:
=20
 	err =3D parse_request(client->buf + DNS_HEADER_TCP_EXTRA_BYTES,
 			msg_len, query, sizeof(query));
-	if (err < 0 || (g_slist_length(server_list) =3D=3D 0)) {
+	if (err < 0 || (!server_list && !doh_wanted(query))) {
 		send_response(client_sk, client->buf,
 			msg_len + DNS_HEADER_TCP_EXTRA_BYTES,
 			NULL, 0, IPPROTO_TCP);
@@ -3467,6 +4414,26 @@ read_another:
 			debug("data missing, ignoring cache for this query");
 	}
=20
+	if (doh_wanted(query)) {
+		req->request =3D g_try_malloc0(req->request_len);
+		req->name =3D g_try_malloc0(sizeof(query));
+		if (!req->request || !req->name) {
+			send_response(client_sk, client->buf,
+				req->request_len, NULL, 0, IPPROTO_TCP);
+			g_free(req->request);
+			g_free(req->name);
+			g_free(req);
+			goto out;
+		}
+		memcpy(req->request, client->buf, req->request_len);
+		memcpy(req->name, query, sizeof(query));
+		req->timeout =3D g_timeout_add_seconds(30, request_timeout, req);
+		request_list =3D g_slist_append(request_list, req);
+
+		doh_dispatch(req);
+		goto out;
+	}
+
 	for (GSList *list =3D server_list; list; list =3D list->next) {
 		struct server_data *data =3D list->data;
=20
@@ -3834,7 +4801,7 @@ static bool udp_listener_event(GIOChannel *channel, G=
IOCondition condition,
 	debug("Received %d bytes (id 0x%04x)", len, buf[0] | buf[1] << 8);
=20
 	err =3D parse_request(buf, len, query, sizeof(query));
-	if (err < 0 || (g_slist_length(server_list) =3D=3D 0)) {
+	if (err < 0 || (!server_list && !doh_wanted(query))) {
 		send_response(sk, buf, len, client_addr,
 				*client_addr_len, IPPROTO_UDP);
 		return true;
@@ -3863,6 +4830,23 @@ static bool udp_listener_event(GIOChannel *channel, =
GIOCondition condition,
 	req->ifdata =3D ifdata;
 	req->append_domain =3D false;
=20
+	if (doh_wanted(query)) {
+		if (ns_try_resolv_from_cache(req, buf, query) > 0) {
+			g_free(req);
+			return true;
+		}
+
+		req->name =3D g_strdup(query);
+		req->request =3D g_malloc(len);
+		memcpy(req->request, buf, len);
+		req->timeout =3D g_timeout_add_seconds(DOH_REQUEST_TIMEOUT,
+							request_timeout, req);
+		request_list =3D g_slist_append(request_list, req);
+
+		doh_dispatch(req);
+		return true;
+	}
+
 	if (resolv(req, buf, query)) {
 		/* a cached result was sent, so the request can be released */
 	        g_free(req);
@@ -4236,8 +5220,13 @@ int __connman_dnsproxy_init(void)
=20
 	index =3D connman_inet_ifindex("lo");
 	err =3D __connman_dnsproxy_add_listener(index);
-	if (err < 0)
+	if (err < 0) {
+		g_hash_table_destroy(listener_table);
+		listener_table =3D NULL;
+		g_hash_table_destroy(partial_tcp_req_table);
+		partial_tcp_req_table =3D NULL;
 		return err;
+	}
=20
 	err =3D connman_notifier_register(&dnsproxy_notifier);
 	if (err < 0) {
@@ -4248,6 +5237,14 @@ int __connman_dnsproxy_init(void)
 		return err;
 	}
=20
+	if (__connman_doh_init(dns_listen_port) < 0)
+		connman_error("Failed to initialize DNS over HTTPS");
+
+	dnsproxy_running =3D true;
+
+	doh_load();
+	doh_apply();
+
 	return 0;
 }
=20
@@ -4282,6 +5279,13 @@ void __connman_dnsproxy_cleanup(void)
 		g_resolv_unref(ipv4_resolve);
 	if (ipv6_resolve)
 		g_resolv_unref(ipv6_resolve);
+
+	dnsproxy_running =3D false;
+
+	doh_free_servers();
+	g_strfreev(doh_user_servers);
+	doh_user_servers =3D NULL;
+	__connman_doh_cleanup();
 }
=20
 void __connman_dnsproxy_set_listen_port(unsigned int port)
diff --git a/src/main.c b/src/main.c
index 70909264..a7a8751b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -136,6 +136,8 @@ static struct {
 	char *localtime;
 	bool regdom_follows_timezone;
 	char *resolv_conf;
+	char *dns_over_https;
+	char **dns_over_https_servers;
 } connman_settings  =3D {
 	.bg_scan =3D true,
 	.pref_timeservers =3D NULL,
@@ -173,6 +175,8 @@ static struct {
 	.use_gateways_as_timeservers =3D false,
 	.localtime =3D NULL,
 	.resolv_conf =3D NULL,
+	.dns_over_https =3D NULL,
+	.dns_over_https_servers =3D NULL,
 };
=20
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -210,6 +214,8 @@ static struct {
 #define CONF_LOCALTIME                  "Localtime"
 #define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
 #define CONF_RESOLV_CONF                "ResolvConf"
+#define CONF_DNS_OVER_HTTPS             "DNSOverHTTPS"
+#define CONF_DNS_OVER_HTTPS_SERVERS     "DNSOverHTTPSServers"
=20
 static const char *supported_options[] =3D {
 	CONF_BG_SCAN,
@@ -247,6 +253,8 @@ static const char *supported_options[] =3D {
 	CONF_LOCALTIME,
 	CONF_REGDOM_FOLLOWS_TIMEZONE,
 	CONF_RESOLV_CONF,
+	CONF_DNS_OVER_HTTPS,
+	CONF_DNS_OVER_HTTPS_SERVERS,
 	NULL
 };
=20
@@ -850,6 +858,31 @@ static void parse_config(GKeyFile *config, const char =
*file)
=20
 	g_clear_error(&error);
=20
+	string =3D __connman_config_get_string(config, GENERAL_GROUP,
+				CONF_DNS_OVER_HTTPS, &error);
+	if (!error && (g_str_equal(string, "off") ||
+			g_str_equal(string, "auto") ||
+			g_str_equal(string, "on") ||
+			g_str_equal(string, "strict"))) {
+		connman_settings.dns_over_https =3D string;
+	} else {
+		if (!error)
+			connman_warn("Invalid %s [%s]", CONF_DNS_OVER_HTTPS,
+								string);
+		g_free(string);
+	}
+
+	g_clear_error(&error);
+
+	str_list =3D __connman_config_get_string_list(config, GENERAL_GROUP,
+			CONF_DNS_OVER_HTTPS_SERVERS, &len, &error);
+	if (!error)
+		connman_settings.dns_over_https_servers =3D str_list;
+	else
+		g_strfreev(str_list);
+
+	g_clear_error(&error);
+
 	online_check_settings_log();
 }
=20
@@ -1051,6 +1084,9 @@ char *connman_setting_get_string(const char *key)
 	if (g_str_equal(key, CONF_ONLINE_CHECK_INTERVAL_STYLE))
 		return connman_settings.online_check_interval_style;
=20
+	if (g_str_equal(key, CONF_DNS_OVER_HTTPS))
+		return connman_settings.dns_over_https;
+
 	return NULL;
 }
=20
@@ -1126,6 +1162,9 @@ char **connman_setting_get_string_list(const char *ke=
y)
 	if (g_str_equal(key, CONF_FALLBACK_NAMESERVERS))
 		return connman_settings.fallback_nameservers;
=20
+	if (g_str_equal(key, CONF_DNS_OVER_HTTPS_SERVERS))
+		return connman_settings.dns_over_https_servers;
+
 	if (g_str_equal(key, CONF_BLACKLISTED_INTERFACES))
 		return connman_settings.blacklisted_interfaces;
=20
@@ -1346,6 +1385,8 @@ int main(int argc, char *argv[])
 	g_free(connman_settings.online_check_ipv4_url);
 	g_free(connman_settings.online_check_ipv6_url);
 	g_free(connman_settings.localtime);
+	g_free(connman_settings.dns_over_https);
+	g_strfreev(connman_settings.dns_over_https_servers);
=20
 	g_free(option_debug);
 	g_free(option_wifi);
diff --git a/src/main.conf b/src/main.conf
index da1307d9..77287d69 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -42,6 +42,16 @@
 # names are ignored.
 # FallbackNameservers =3D
=20
+# How the DNS proxy uses DNS over HTTPS: off, auto (use it when the
+# DNS servers in use are public resolvers known to support it), on (use
+# DNSOverHTTPSServers, plain DNS when they fail) or strict (use
+# DNSOverHTTPSServers, never plain DNS). Default value is off.
+# DNSOverHTTPS =3D off
+
+# List of DNS over HTTPS servers for the on and strict modes,
+# separated by ",", e.g. https://dns.quad9.net/dns-query.
+# DNSOverHTTPSServers =3D
+
 # List of technologies that are marked autoconnectable
 # by default, separated by commas ",". The default value
 # for this entry when empty is ethernet,wifi,cellular.
--=20
2.34.1


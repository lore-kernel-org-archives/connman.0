Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.33.248.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883722;
	b=OwF+pMH03ix+AeSov0ZON/PdJdnCDEVWCQS71KezXhX5uvfMn5oWD5ZHr7nIYILJ8NJg
	 JZtCvMhpXHq6RfBaxj2Vrpjhw+NcCov7JbbPYv8oB+jyfFYwP1fVMr4X9YK6iZGGMiye/
	 U3Ka/CdgVW6lwNy26AcYLopfY1ivuLQvreL76Nlh7Voxq8BpvYSxa4FIB9D/vDKb+Xtp6
	 MtMfZatE71FSlg8cWQkqgnH3JCJlTwTluWWPqDdWxvHa++kWqFObndrw9O5H1oBtgZiaB
	 C//NYIOf9VZdRn5h6iXwtUBZpUQQGNaxXz7pVAhR+mwSCQKIPkDrTZAF+P7Anup8YXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883722;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=+00isamrnNS+AKeHMNUSRENI75hTmQXcZ7nZRivF2t0=;
	b=QT1d4FAg9Ge0QRJqQ9zj44F2axZRaKJTXKe07oCEyoPSgHuCNW43GjIUd0p1xsIDjF7h
	 HbGnSC6Rzc70qfQoISBs4ZrtdG371/sknOhHmirJ2fXZu/IkmU3o3VQIU0sMoDWflTekr
	 pArtI1CpjlyjaesprFR1nlQlxP2hwEGq9wevzMmgXU9cCiTDfXfcVXcceu4/bBHIXIGUx
	 yPWyP6EIMtEawstQ89DEXyC959qXZINbn+02tyKUVjP6GvQGTcgCIwHYxLMBg5gcrsuYk
	 0dS8knphIfzRECow8t5qJRS5zPNs6cA/+cssboE+kmcz4v/ifHHqjRyyW/mZ3jfcEAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=178.33.248.74
Received: from 11.511.mail-out.ovh.net (11.511.mail-out.ovh.net [178.33.248.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067D606A32E
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A067D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.54.109])
	by mo511.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wj4gRdz9sdS
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:53 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 4/6] manager: Add DNS over HTTPS properties
Date: Thu, 5 Nov 2026 13:01:43 +0000
Message-ID: <20261105130145.523935-5-email@samnazarko.co.uk>
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
x-ovh-tracer-id: 9097552726206238700
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE/8Kr4Ao/05lZi0R567X3Az0s0BqkSd0VZIGdCYiEiGsBUmycZFwMfqiGwLlzmo2XLYSvkOIx+TbHoOja0axR2e2Y2nJjAv2XfGEQ4f1/LAbDaIvJfZ+m99ZOtQImLHCPNaGeh1zmtTRB9o1gFHF9opx5A6o3Bpxdhe/LDpdmZcsbaodVsDNJ89x4pjfbrKVli2Dp1yBc0XezzdPs1D0uLw7z3gBGOUH94HIgcMTU0CGbOaWYkLkxI953RRR4Y3A+HlGr9pOObzi/t+tsvtWQghH84aNGaEHeWelqoFuVLQAWNB06QLVkhkSxc/t8VPP2/uRQm3MMch4/DotiySp9yptLMtyb9WkavlSDT25vO9xbUg7ZB2QdAd4nyJs8WdayW1XmH/Xh317TLy+Q9a8IESwjoVmn9Y4PVE0bn3hUVdj7rUqAw4D1gmcJe++s/OEdPTNr3eaFOVT3a61nF4gHsPuq+0rxEHVjOHpd2GXWjzvQLKdyKPE8xPUHVecO7/Ye+Ny7m+A39YTRhYpGBBi5MCJ5x/xx/zDvhThSGt2pZwm4zPZmpaDl6waTK2krRI6vpn/NtwajjB67JbrKGMlKU4Nw12yPIWfTttqzSgkOVATDDfYPcz2sD+zpvb/Uoh49nLDanthCH0WMV1DOXeF5wFjlvFxCIUUGjww00vUWY1w

Expose the DNS over HTTPS mode, server list and state on the Manager
interface. The mode and servers are writable and stored in the global
settings, taking precedence over main.conf. An empty server list
selects the servers from main.conf, so a distribution can update its
defaults without overriding a user's choice.
---
 doc/manager-api.txt | 60 ++++++++++++++++++++++++++++++++++++++++++
 src/manager.c       | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 6eaa0a38..409f6cea 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -319,3 +319,63 @@ Properties	string State [readonly]
 			and does not affect ConnMan in any way.
=20
 			The default value is false.
+
+		string DNSOverHTTPS [readwrite]
+
+			How the DNS proxy uses DNS over HTTPS (RFC 8484).
+			Possible values are:
+
+			"off": queries are forwarded in plain text.
+
+			"auto": when every DNS server in use is a public
+			resolver known to offer DNS over HTTPS on the same
+			address, queries are sent to those resolvers over
+			HTTPS instead. Otherwise, or if that fails, plain
+			text is used. This never changes which resolver
+			answers.
+
+			"on": queries are sent to DNSOverHTTPSServers.
+			Plain text DNS of the network is used while none
+			of them can be reached.
+
+			"strict": like "on", but queries fail instead of
+			falling back to plain text.
+
+			In every mode, names that only the local network
+			can resolve are sent to the network's DNS servers
+			in plain text: single label names, names in the
+			local, lan, home, home.arpa, internal and similar
+			domains, reverse lookups of private addresses and,
+			except in "strict" mode, names in the search domains
+			provided by the network.
+
+			Setting this property fails with NotSupported when
+			the DNS proxy is disabled. The default value comes
+			from the DNSOverHTTPS setting of main.conf; a value
+			set through this property is stored and used
+			instead.
+
+		array{string} DNSOverHTTPSServers [readwrite]
+
+			The DNS over HTTPS servers used by the "on" and
+			"strict" modes, in order of preference, as
+			https://host[:port][/path] URLs. The host can be a
+			host name or an IP address; IPv6 addresses must be
+			in brackets. When the path is missing, /dns-query
+			is used. Servers must support HTTP/2.
+
+			An empty list selects the servers of the
+			DNSOverHTTPSServers setting of main.conf. Setting
+			this property fails with NotSupported when the DNS
+			proxy is disabled.
+
+		string DNSOverHTTPSState [readonly]
+
+			The state of DNS over HTTPS. Possible values are
+			"off", "inactive" (enabled, but not used yet or not
+			applicable, e.g. "auto" while using a resolver that
+			does not support it), "active" (the last query over
+			HTTPS succeeded) and "unavailable" (no DNS over HTTPS
+			server could be reached, or "strict" mode has no
+			server; depending on the mode plain text DNS is used
+			or queries fail).
diff --git a/src/manager.c b/src/manager.c
index 892d3a42..80828752 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -64,6 +64,18 @@ static DBusMessage *get_properties(DBusConnection *conn,
 					DBUS_TYPE_BOOLEAN,
 					&sessionmode);
=20
+	str =3D __connman_dnsproxy_get_doh_mode();
+	connman_dbus_dict_append_basic(&dict, "DNSOverHTTPS",
+					DBUS_TYPE_STRING, &str);
+
+	connman_dbus_dict_append_array(&dict, "DNSOverHTTPSServers",
+				DBUS_TYPE_STRING,
+				__connman_dnsproxy_append_doh_servers, NULL);
+
+	str =3D __connman_dnsproxy_get_doh_state();
+	connman_dbus_dict_append_basic(&dict, "DNSOverHTTPSState",
+					DBUS_TYPE_STRING, &str);
+
 	connman_dbus_dict_close(&array, &dict);
=20
 	return reply;
@@ -110,6 +122,57 @@ static DBusMessage *set_property(DBusConnection *conn,
=20
 		dbus_message_iter_get_basic(&value, &sessionmode);
=20
+	} else if (g_str_equal(name, "DNSOverHTTPS")) {
+		const char *mode;
+		int err;
+
+		if (type !=3D DBUS_TYPE_STRING)
+			return __connman_error_invalid_arguments(msg);
+
+		dbus_message_iter_get_basic(&value, &mode);
+
+		err =3D __connman_dnsproxy_set_doh_mode(mode);
+		if (err =3D=3D -EOPNOTSUPP)
+			return __connman_error_not_supported(msg);
+
+		if (err < 0)
+			return __connman_error_invalid_arguments(msg);
+
+	} else if (g_str_equal(name, "DNSOverHTTPSServers")) {
+		DBusMessageIter entry;
+		GPtrArray *servers;
+		int err;
+
+		if (type !=3D DBUS_TYPE_ARRAY ||
+				dbus_message_iter_get_element_type(&value) !=3D
+							DBUS_TYPE_STRING)
+			return __connman_error_invalid_arguments(msg);
+
+		servers =3D g_ptr_array_new();
+
+		dbus_message_iter_recurse(&value, &entry);
+		while (dbus_message_iter_get_arg_type(&entry) =3D=3D
+							DBUS_TYPE_STRING) {
+			const char *val;
+
+			dbus_message_iter_get_basic(&entry, &val);
+			g_ptr_array_add(servers, (gpointer) val);
+			dbus_message_iter_next(&entry);
+		}
+		g_ptr_array_add(servers, NULL);
+
+		err =3D __connman_dnsproxy_set_doh_servers(
+						(char **) servers->pdata);
+		g_ptr_array_free(servers, TRUE);
+
+		if (err =3D=3D -EOPNOTSUPP)
+			return __connman_error_not_supported(msg);
+
+		if (err < 0)
+			return __connman_error_invalid_arguments(msg);
+
+	} else if (g_str_equal(name, "DNSOverHTTPSState")) {
+		return __connman_error_permission_denied(msg);
 	} else
 		return __connman_error_invalid_property(msg);
=20
--=20
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.34.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883716;
	b=YSyLS2gE2AD5j0lpL0pngzuz9wOn5Y5kg82JMI6YA3w5HVLXveQzLFWvZnLZEzAAIhFf
	 cXk3mAIYb2ibzQ6dfcQggsKeAXFJOwB1DiyyMs3DgImZI3nsihjF2RAEs4qmBNG2jcUeO
	 id0BZ6Gb8puVsjcAaXNLtz+h9ShgPKv59sWJ5ImzyfcImkOq7TUmGgxWCgqYAaH/KV0k3
	 QuN5FgyDf0D+pnrTPwcQXkVGLGJHMRn/F3KQ0xYfhIrtE6kjCzv9hb64Dt3cCWp/s1qLS
	 4XK+ZSXHZZvX7NuxjLy9DSNhlECu/939uGguVbk1d+v6tkKHntJ9yiy6MGZZ2theiWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883716;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=MEmVArKaLHJyaox2JXsWQUrH7Rnz7PHoSgeiTZMN3Ag=;
	b=vZXkuDLneeGedMmJJu+e5g8DweHxf56zsMuru6Dcy+NnrO1r/xj8tvGplfTCTZ6dER3w
	 2djU4JrPHckwL+eYnKyvF9gWANuZ4Qtw9vzZqrAOjY4OzSS045kAgGot2cSEGOvq2EvuR
	 mRmOG3FqTQc+lQ9fJTNZ9fVScRYjYItGsg5n/L9w/hKpibbHy3oKgCFk6lCk4SwW42t+e
	 as058EOwQQyfPWefh2b2vwDAln8OgoLQeviyvbxeiaDCXcPAmfyhH2u4Z9TXw+eINKbKp
	 wmOjz/iRU+5pkLbpOIlLtZvFpaiQ/etodrXOn0yTzevPW65+HB7834nV5E8svbp8qiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.34.219
Received: from 15.mo23.mail-out.ovh.net (15.mo23.mail-out.ovh.net [46.105.34.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECE606A326
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94ECE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.54.224])
	by mo23.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wk0vJQz7xVV
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:54 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 5/6] client: Add doh command
Date: Thu, 5 Nov 2026 13:01:44 +0000
Message-ID: <20261105130145.523935-6-email@samnazarko.co.uk>
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
x-ovh-tracer-id: 9097834198231338988
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF/6WAJh3HhOrLscjSJzNvxJSRs2p5sC+dA5lquWe8u5gCjirEcWAS4wgDUeR6ys2GAtYg+lsOP5e9tReU+TK93OJ37RPu+VcwBdMCtBIHIz7fGzFqusCM4sE93KZz0q0fKNNinOjyNVPP5SdlbtvIOIvgVeKYHLfDRxb2+CnOezWsu6NXSCA77rwgmXGvYynZAdhqOfOKizRhWG0kNlaGton6Xjuq0m3VMfNEcHu0TMSudq1pevT4e6B4ll3KXABzNHWRwwWawwj0rFMw4EKwJUz5I1bZZ8cx+i5mgryCUX8NcABjWRujCinlBUb5k0iPjOonrqXS1YHcFCVHssaF4i8Mmp1wlJUlxPZ33QrGnI0u8agscv4YDQXYye91TrglDHHnkuKFATBkyQk/ucnYBNAKaeDXNaj+pfhPhqRfXq7CnX8qwcndiDycARFFTw44D/3z8sM9r7kFOVwY6DO/bI7ENgu+DxIgcDSAe9U6DI7/+DHlE4IatrxpWVrrxn2yw2pVPWGUvFeenSd6hHtpXQeqGpvK5DAp/BenbqHjRLRlb0LZRydOhOZ9icNNgGt9sRSJRiqMsZhkAoakivXXTjNHxHds9NEmE3GxGun4qGF4sgmXYUFNj3mn9VlQ1OKvZy4/zFZ2VNdtwOXib4MAVLheEARdRJEqtHj9IM4DzFw

"doh" shows the DNS over HTTPS settings and state, "doh <mode>" sets
the mode and "doh servers [<url> ...]" sets the servers, or restores
the defaults when no URL is given.
---
 client/commands.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/client/commands.c b/client/commands.c
index 376ccdb5..32bca950 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -312,6 +312,113 @@ static int cmd_clock(char *args[], int num, struct co=
nnman_option *options)
 			clock_print, NULL, NULL, NULL);
 }
=20
+static int doh_print(DBusMessageIter *iter, int errnum, const char *error,
+		void *user_data)
+{
+	DBusMessageIter dict;
+
+	if (error) {
+		fprintf(stderr, "Error: %s\n", error);
+		return 0;
+	}
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, value, array;
+		const char *key, *str;
+		bool empty =3D true;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+		dbus_message_iter_next(&dict);
+
+		if (strncmp(key, "DNSOverHTTPS", 12) !=3D 0)
+			continue;
+
+		switch (dbus_message_iter_get_arg_type(&value)) {
+		case DBUS_TYPE_STRING:
+			dbus_message_iter_get_basic(&value, &str);
+			fprintf(stdout, "  %s =3D %s\n", key, str);
+			break;
+		case DBUS_TYPE_ARRAY:
+			fprintf(stdout, "  %s =3D [", key);
+			dbus_message_iter_recurse(&value, &array);
+			while (dbus_message_iter_get_arg_type(&array) =3D=3D
+							DBUS_TYPE_STRING) {
+				dbus_message_iter_get_basic(&array, &str);
+				fprintf(stdout, " %s", str);
+				dbus_message_iter_next(&array);
+				empty =3D false;
+			}
+			fprintf(stdout, " ]%s\n", empty ? " (defaults)" : "");
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int doh_return(DBusMessageIter *iter, int errnum, const char *error=
,
+		void *user_data)
+{
+	if (error)
+		fprintf(stderr, "Error: %s\n", error);
+
+	return 0;
+}
+
+struct doh_servers {
+	char **urls;
+	int count;
+};
+
+static void append_doh_servers(DBusMessageIter *iter, void *user_data)
+{
+	struct doh_servers *servers =3D user_data;
+
+	for (int i =3D 0; i < servers->count; i++)
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&servers->urls[i]);
+}
+
+static int cmd_doh(char *args[], int num, struct connman_option *options)
+{
+	const char *modes[] =3D { "off", "auto", "on", "strict", NULL };
+	struct doh_servers servers;
+
+	if (num < 2)
+		return __connmanctl_dbus_method_call(connection,
+				CONNMAN_SERVICE, CONNMAN_PATH,
+				"net.connman.Manager", "GetProperties",
+				doh_print, NULL, NULL, NULL);
+
+	if (strcmp(args[1], "servers") =3D=3D 0) {
+		servers.urls =3D &args[2];
+		servers.count =3D num - 2;
+
+		return __connmanctl_dbus_set_property_array(connection,
+				CONNMAN_PATH, "net.connman.Manager",
+				doh_return, NULL, "DNSOverHTTPSServers",
+				DBUS_TYPE_STRING, append_doh_servers, &servers);
+	}
+
+	if (num > 2)
+		return -E2BIG;
+
+	for (int i =3D 0; modes[i]; i++) {
+		if (strcmp(args[1], modes[i]) =3D=3D 0)
+			return __connmanctl_dbus_set_property(connection,
+					CONNMAN_PATH, "net.connman.Manager",
+					doh_return, NULL, "DNSOverHTTPS",
+					DBUS_TYPE_STRING, &args[1]);
+	}
+
+	return -EINVAL;
+}
+
 static int services_list(DBusMessageIter *iter, int errnum, const char *er=
ror,
 		void *user_data)
 {
@@ -2384,6 +2491,32 @@ static char *lookup_on_off(const char *text, int sta=
te)
 	return NULL;
 }
=20
+static char *lookup_doh(const char *text, int state)
+{
+	char *words[] =3D { "off", "auto", "on", "strict", "servers", NULL };
+	static int idx =3D 0;
+	static int len =3D 0;
+
+	if (__connmanctl_input_calc_level() > 1) {
+		__connmanctl_input_lookup_end();
+		return NULL;
+	}
+
+	if (!state) {
+		idx =3D 0;
+		len =3D strlen(text);
+	}
+
+	while (words[idx]) {
+		char *str =3D words[idx++];
+
+		if (!strncmp(text, str, len))
+			return strdup(str);
+	}
+
+	return NULL;
+}
+
 static char *lookup_tether(const char *text, int state)
 {
 	int level;
@@ -2793,6 +2926,10 @@ static const struct {
 	  "Display technologies", NULL },
 	{ "clock",        NULL,           NULL,            cmd_clock,
 	  "Get System Clock Properties", NULL },
+	{ "doh",          "[off|auto|on|strict]\n"
+	                  "            servers [<url> ...]",
+	                                  NULL,            cmd_doh,
+	  "Show or set DNS over HTTPS mode and servers", lookup_doh },
 	{ "enable",       "<technology>|offline", NULL,    cmd_enable,
 	  "Enables given technology or offline mode",
 	  lookup_technology_offline },
--=20
2.34.1


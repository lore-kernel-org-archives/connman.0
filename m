Received: from gmmr2.centrum.cz (gmmr2.centrum.cz [46.255.227.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF570
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 16:41:02 +0000 (UTC)
Received: from gmmr-2.centrum.cz (unknown [10.255.254.39])
	by gmmr2.centrum.cz (Postfix) with ESMTP id A07B86000804
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 18:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1628095182; bh=lkwlrmzOWCmK1UsB2a/auvKtKBYEWnL8l17mBNpKaVM=;
	h=From:To:Subject:Date:From;
	b=VySLC5ryo+kXhkX560DCxtso63IG6ZRr7ElrHF3olMiRY/yS+PF3lEHZf0EdpekUj
	 oyCXWadeMKJRphssY2vjq084Cqw5o4y78oTwB0/ovHfSaYzlZjxUveYRPOg8csfTsR
	 CIHj19OnvViS78eXqt5lgMuas+lK6jpCM0Btm0e4=
Received: from vm1.excello.cz (vm1.excello.cz [IPv6:2001:67c:1591::3])
	by gmmr-2.centrum.cz (Postfix) with QMQP id 9D31777DE
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 18:39:42 +0200 (CEST)
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:1:502::7):SC:0(-8.7/5.0):CC:0:;
 processed in 0.6 s); 04 Aug 2021 16:39:42 +0000
X-VF-Scanner-ID: 20210804163942.049944.15275.vm1.excello.cz.0
X-Spam-Status: No, hits=-8.7, required=5.0
Received: from gmmr-2.centrum.cz (2a00:da80:1:502::7)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 4 Aug 2021 18:39:42 +0200
Received: from gm-smtp10.centrum.cz (unknown [10.255.254.20])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id E40E620055F6D
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 18:39:41 +0200 (CEST)
Received: from latitudemachine.localnet (unknown [195.74.76.233])
	by gm-smtp10.centrum.cz (Postfix) with ESMTPA id D2E20C063A35
	for <connman@lists.linux.dev>; Wed,  4 Aug 2021 18:39:41 +0200 (CEST)
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] make possible to use alternative auth group with 2nd password
Date: Wed, 04 Aug 2021 18:39:39 +0200
Message-ID: <1666033.JRX4bv1jlI@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1639452.jrOPP9CB8l"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1639452.jrOPP9CB8l
Content-Type: multipart/mixed; boundary="nextPart1885944.MhZgWzoaL4"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] make possible to use alternative auth group with 2nd password
Date: Wed, 04 Aug 2021 18:39:39 +0200
Message-ID: <1666033.JRX4bv1jlI@latitudemachine>

This is a multi-part message in MIME format.

--nextPart1885944.MhZgWzoaL4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Some servers are configured with multiple authentication groups.
OpenConnect request just authentication entries that are valid
for specific group (process_auth_form method). So, authentication
group have to setup first, and new form have to be requested then.

Some authentication groups may require secondary password.
For example one-time password from Google Authenticator app.

Lukas
--nextPart1885944.MhZgWzoaL4
Content-Disposition: attachment; filename="0001-make-possible-to-use-alternative-auth-group-with-2nd.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="utf-8"; name="0001-make-possible-to-use-alternative-auth-group-with-2nd.patch"

=46rom 775bfdb98cfd0d61a502399389ec68d5284a2af2 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Luk=3DC3=3DA1=3DC5=3DA1=3D20Karas?=3D <lukas.karas@cent=
rum.cz>
Date: Tue, 3 Aug 2021 17:00:26 +0200
Subject: [PATCH] make possible to use alternative auth group with 2nd passw=
ord

Some servers are configured with multiple authentication groups.
OpenConnect request just authentication entries that are valid
for specific group (process_auth_form method). So, authentication
group have to setup first, and new form have to be requested then.

Some authentication groups may require secondary password.
=46or example one-time password from Google Authenticator app.

Signed-off-by: Luk=C3=A1=C5=A1 Karas <lukas.karas@centrum.cz>
=2D--
 client/agent.c            |  1 +
 vpn/plugins/openconnect.c | 79 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 1cad3e03..abede4c6 100644
=2D-- a/client/agent.c
+++ b/client/agent.c
@@ -102,6 +102,7 @@ static struct agent_input_data vpnagent_input_handler[]=
 =3D {
 	  request_input_string_return },
 	{ "Username", false, "VPN username? ", request_input_string_return },
 	{ "Password", false, "VPN password? ", request_input_string_return },
+	{ "OpenConnect.SecondPassword", false, "VPN one-time password? ", request=
_input_string_return },
 	{ },
 };
=20
diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index fc6ceff0..954bed8e 100644
=2D-- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -110,6 +110,7 @@ struct oc_private_data {
 	GIOChannel *err_ch;
 	enum oc_connect_type connect_type;
 	bool tried_passphrase;
+	bool group_set;
 };
=20
 typedef void (*request_input_reply_cb_t) (DBusMessage *reply,
@@ -473,6 +474,7 @@ static void clear_provider_credentials(struct vpn_provi=
der *provider,
 	const char *keys[] =3D { "OpenConnect.PKCSPassword",
 				"OpenConnect.Username",
 				"OpenConnect.Password",
+				"OpenConnect.SecondPassword",
 				"OpenConnect.Cookie",
 				NULL
 	};
@@ -796,11 +798,39 @@ static gboolean process_auth_form(void *user_data)
 	struct oc_private_data *data =3D form_data->data;
 	struct oc_form_opt *opt;
 	const char *password;
+	int i;
=20
 	g_mutex_lock(&form_data->mutex);
=20
 	DBG("");
=20
+	/*
+	 * Special handling for "GROUP:" field, if present.
+	 * Different group selections can make other fields disappear/appear
+	 */
+	if (form_data->form->authgroup_opt) {
+		struct oc_form_opt_select *authgroup_opt =3D form_data->form->authgroup_=
opt;
+		const char *group =3D vpn_provider_get_string(data->provider,
+							    "OpenConnect.Group");
+		if (group && !data->group_set) {
+			for (i =3D 0; i < authgroup_opt->nr_choices; i++) {
+				struct oc_choice *choice =3D authgroup_opt->choices[i];
+				if (strcmp(group, choice->label) =3D=3D 0) {
+					DBG("Switching to auth group: %s", group);
+					openconnect_set_option_value(&authgroup_opt->form, choice->name);
+					data->group_set =3D true;
+					form_data->status =3D OC_FORM_RESULT_NEWGROUP;
+					goto out;
+				}
+			}
+			connman_warn("Group choice %s not present", group);
+			data->err =3D -EACCES;
+			clear_provider_credentials(data->provider, true);
+			form_data->status =3D OC_FORM_RESULT_ERR;
+			goto out;
+		}
+	}
+
 	switch (data->connect_type) {
 	case OC_CONNECT_USERPASS:
 	case OC_CONNECT_COOKIE_WITH_USERPASS:
@@ -872,12 +902,21 @@ static gboolean process_auth_form(void *user_data)
 						"OpenConnect.Username");
 			if (user)
 				opt->_value =3D strdup(user);
=2D		} else if (opt->type =3D=3D OC_FORM_OPT_PASSWORD) {
+		} else if (opt->type =3D=3D OC_FORM_OPT_PASSWORD &&
+				g_str_has_prefix(opt->name, "password")) {
+
 			const char *pass =3D vpn_provider_get_string(
 						data->provider,
 						"OpenConnect.Password");
 			if (pass)
 				opt->_value =3D strdup(pass);
+		} else if (opt->type =3D=3D OC_FORM_OPT_PASSWORD &&
+				g_str_has_prefix(opt->name, "secondary_password")) {
+			const char *pass =3D vpn_provider_get_string(
+				data->provider,
+				"OpenConnect.SecondPassword");
+			if (pass)
+				opt->_value =3D strdup(pass);
 		}
 	}
=20
@@ -1201,6 +1240,7 @@ static void request_input_credentials_reply(DBusMessa=
ge *reply, void *user_data)
 	const char *vpnhost =3D NULL;
 	const char *username =3D NULL;
 	const char *password =3D NULL;
+	const char *second_password =3D NULL;
 	const char *pkcspassword =3D NULL;
 	const char *key;
 	DBusMessageIter iter, dict;
@@ -1298,6 +1338,18 @@ static void request_input_credentials_reply(DBusMess=
age *reply, void *user_data)
 			dbus_message_iter_get_basic(&value, &password);
 			vpn_provider_set_string_hide_value(data->provider,
 					"OpenConnect.Password", password);
+		} else if (g_str_equal(key, "OpenConnect.SecondPassword")) {
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry)
+			!=3D DBUS_TYPE_VARIANT)
+				break;
+			dbus_message_iter_recurse(&entry, &value);
+			if (dbus_message_iter_get_arg_type(&value)
+			!=3D DBUS_TYPE_STRING)
+				break;
+			dbus_message_iter_get_basic(&value, &second_password);
+			vpn_provider_set_string_hide_value(data->provider,
+							   "OpenConnect.SecondPassword", second_password);
 		} else if (g_str_equal(key, "OpenConnect.PKCSPassword")) {
 			dbus_message_iter_next(&entry);
 			if (dbus_message_iter_get_arg_type(&entry)
@@ -1374,6 +1426,7 @@ static int request_input_credentials_full(
 	DBusMessageIter dict;
 	int err;
 	void *agent;
+	bool use_second_password =3D false;
=20
 	if (!data || !cb)
 		return -ESRCH;
@@ -1440,6 +1493,16 @@ static int request_input_credentials_full(
 		username =3D vpn_provider_get_string(data->provider,
 					"OpenConnect.Username");
 		vpn_agent_append_user_info(&dict, data->provider, username);
+
+		use_second_password =3D vpn_provider_get_boolean(data->provider,
+					"OpenConnect.UseSecondPassword",
+					false);
+
+		if (use_second_password)
+			request_input_append_to_dict(data->provider, &dict,
+					request_input_append_password,
+					"OpenConnect.SecondPassword");
+
 		break;
 	case OC_CONNECT_PUBLICKEY:
 		return -EINVAL;
@@ -1520,8 +1583,10 @@ static int oc_connect(struct vpn_provider *provider,
 	const char *certificate;
 	const char *username;
 	const char *password;
+	const char *second_password =3D NULL;
 	const char *private_key;
 	int err;
+	bool use_second_password =3D false;
=20
 	connman_info("provider %p task %p", provider, task);
=20
@@ -1551,8 +1616,18 @@ static int oc_connect(struct vpn_provider *provider,
 					"OpenConnect.Username");
 		password =3D vpn_provider_get_string(provider,
 					"OpenConnect.Password");
+
+		use_second_password =3D vpn_provider_get_boolean(provider,
+					"OpenConnect.UseSecondPassword",
+					false);
+
+		if (use_second_password)
+			second_password =3D vpn_provider_get_string(provider,
+					"OpenConnect.SecondPassword");
+
 		if (!username || !password || !g_strcmp0(username, "-") ||
=2D					!g_strcmp0(password, "-"))
+					!g_strcmp0(password, "-") ||
+					(use_second_password && !second_password))
 			goto request_input;
=20
 		break;
=2D-=20
2.27.0


--nextPart1885944.MhZgWzoaL4--

--nextPart1639452.jrOPP9CB8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEHpwLEdVNCIHcrTqZhcquo3dMC18FAmEKwssACgkQhcquo3dM
C19I/gf/bXY83bn37bF1sE+5C/5b72wI0Ez7la/OZ447Q1NpBkrAH+s8gg5q6vqP
oowgdcYFOzGiExsb+vQyvXR9zEwjkv3mubWlEkIiiscnIR9YMNlB+EmyXWpkBxlK
p5yxTNa120glWjdAdQZJoWNPniHzB9GNqZcuHLrev/myZeLmLLHCKIz1xCTDIfSx
g7+CBnX56yAcOaa/CjWklgvmGc1YSbVgLua6/o3B4GInTGWKI3BxKMFap4jUuRm/
GwR9ZqrImTQbJ8XoPtzBdiGaeBn7hD0fEQ/AwpKbLcddLV0QeUQI61tgITWXn7JJ
He7XUbAgEz/oTAbGE+xcv++NCvNHjw==
=CTsG
-----END PGP SIGNATURE-----

--nextPart1639452.jrOPP9CB8l--




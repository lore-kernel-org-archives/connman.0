Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101972
	for <connman@lists.linux.dev>; Sat, 28 Aug 2021 17:17:04 +0000 (UTC)
Received: from [178.148.156.23] (port=37368 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mK1ww-0000u7-Eh
	for connman@lists.linux.dev; Sat, 28 Aug 2021 19:17:03 +0200
Date: Sat, 28 Aug 2021 19:16:57 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: [PATCH] Respect EnableOnlineCheck globally
Message-ID: <20210828171657.2qxolbym36hdiuhu@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gutkjriolp4czagh"
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host35.dwhost.net
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - strahinja.org
X-Get-Message-Sender-Via: host35.dwhost.net: authenticated_id: contact@strahinja.org
X-Authenticated-Sender: host35.dwhost.net: contact@strahinja.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 


--gutkjriolp4czagh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, even while having EnableOnlineCheck=3Dfalse,
EnableOnlineToReadyTransition=3Dfalse and Enable6to4=3Dfalse in the configu=
ration
file, connman seems to make connections to ipv4.connman.net and ipv6.connma=
n.net
in the function wispr_portal_detect in src/wispr.c. This patch makes the
configuration option behave consistently by setting the status_url to
"localhost" if EnableOnlineCheck=3Dfalse.=20

If a user doesn't want connman "pinging home", that should be respected.

---
 src/wispr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index c63dc819..d69ed70b 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -916,6 +916,11 @@ static int wispr_portal_detect(struct connman_wispr_po=
rtal_context *wp_context)
 		wp_context->status_url =3D STATUS_URL_IPV6;
 	}
=20
+	/* Respect EnableOnlineCheck globally */
+	if (connman_setting_get_bool("EnableOnlineCheck")) {
+		wp_context->status_url =3D "localhost";
+	}
+
 	for (i =3D 0; nameservers[i]; i++)
 		g_web_add_nameserver(wp_context->web, nameservers[i]);
=20
--=20
2.33.0


--gutkjriolp4czagh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEqb4kACgkQySjVAu4c
WEDNUhAAiKnsD4NjBC31OJN/ix+AyXdNNYDXRKxU+tJ6IygPTUXtSzsJzAPaRHMW
YpytLFE0hB4g31OMu4ZzgNFFRB/pymhvxrYlu4YQD84yBTxQgH9DP5QUFPWS3cJW
T0w30dWPyV9ovnuygAqqFISx71fwPm6R+du57uORfkOy0EvaPE+GVw/oE8s/hs14
DxvZpbCpGwMuFiLTJDqsuKYE5gYL2HFqD92hMQTU+LZWcDjsbM3mfdCPd2C1/37S
SL/OJqI4gvag9Ca65xPFk7GnSNde2KpI0MtgH9j2bbnOyPnjFwh9u23RdhtZx9Rn
ZSmSp5Kuz2q4igvTSo/5tr1InaEjWxbZbTN9TXF0xTO+mJAYK4QG3B4tWwjb8mET
cYMd5XDWsle6G7LBEJlQs+jf0PUp/8Z34Frl53HYhRAJ5iPWtCcmHadNlZDQkziO
syNeU17GhKfYu6jhWbUxZTEuSZ1eIFgJ3XwfLtUD9qrekyzaBmCdWRc3a/N+B9xQ
HmgIeZOL2dDd6RHMMAtCYo6HmnzTFueDyTgPraSsjo4ztcZ7i2WrvDQGXYHRru+8
4064NXq39IZgylDM9lMHzdIB/HFl2ftJsaZuzkyrLAHvblQQxgwYBp+P+VZ50sdd
jkFbNSrEJMh4PWTnS3qdHslFkXHJUG/EdLQBdOS58lA66JqKs1U=
=gxwE
-----END PGP SIGNATURE-----

--gutkjriolp4czagh--

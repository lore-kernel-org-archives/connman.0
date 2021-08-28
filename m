Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F072
	for <connman@lists.linux.dev>; Sat, 28 Aug 2021 17:34:30 +0000 (UTC)
Received: from [178.148.156.23] (port=37370 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mK2Ds-00012t-UJ
	for connman@lists.linux.dev; Sat, 28 Aug 2021 19:34:29 +0200
Date: Sat, 28 Aug 2021 19:34:27 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: Re: [PATCH] Respect EnableOnlineCheck globally
Message-ID: <20210828173427.7ctqrpj2w2ldrkla@prancingpony>
References: <20210828171657.2qxolbym36hdiuhu@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q2opdbjukhns7l76"
Content-Disposition: inline
In-Reply-To: <20210828171657.2qxolbym36hdiuhu@prancingpony>
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


--q2opdbjukhns7l76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/08/28 07:16, =D0=A1=D1=82=D1=80=D0=B0=D1=85=D0=B8=D1=9A=D0=B0 =D0=A0=
=D0=B0=D0=B4=D0=B8=D1=9B wrote:
> +	if (connman_setting_get_bool("EnableOnlineCheck")) {

This should read

+       if (!connman_setting_get_bool("EnableOnlineCheck")) {

sorry. I'm sending the modified patch with this email.

---
 src/wispr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index c63dc819..7b52914e 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -916,6 +916,11 @@ static int wispr_portal_detect(struct
connman_wispr_portal_context *wp_context)
                wp_context->status_url =3D STATUS_URL_IPV6;
        }

+       /* Respect EnableOnlineCheck globally */
+       if (!connman_setting_get_bool("EnableOnlineCheck")) {
+               wp_context->status_url =3D "localhost";
+       }
+
        for (i =3D 0; nameservers[i]; i++)
                g_web_add_nameserver(wp_context->web, nameservers[i]);

--
2.33.0


--q2opdbjukhns7l76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEqc6MACgkQySjVAu4c
WEDuqxAA4gAyL3j+BqLkvzmkoK0xeDIPhJxCN9UkISBhoyWcXou052253SAAZxHa
1PWKhZbmJZjEGcLHdHDjpbMl/a1VA8DhpinGmJ0mQV8an6O//fbaye5vVQFcGmWE
vZKOWXOF5gvx4pk09jUTYfu28GRMQmM9JHGxssDJNPFqY2GxQAyas+WmIIEBPiWq
+tUvfwcVeRh+8JPZt3VTomDyZUg7EmFYaS03OQpNFXn8/pTIldQcFhdY297xPaOM
EJn0ng0A37me4XRqxVkRiugAWed5iRE0LXzF3rZbmMxmg/+1srjejluVX9WyBD2c
1oBkHWfJRoemGT3z/ytmqUWD31v6PsJ47WD9WCwOsWQhMZZlGRcRly83OdmK2/m7
dujlFXw3xJQb1vlCAplwHO2oT2LWTKUyazBKfGHuj3MjjZ70hURAz0/fVBvWtyvK
YzW9v8/al3oQ0u0f00CpeA3zJDRIaFlXun80hkYTT6dMn5hR/GuOufA2mnBU25Zz
ncARb5LRl3Edh8rOsMR6fZ432lX+x4RuLwko5HvtK3hRDTE2/1igFTblPD+G2pJ3
KtpX5bluQiZmD5Do0myHgSXe25vC7OhjHNtca6ccKkLYVX7D4fqC4ckahq7SoLg2
Ym3zzTr3vjt6CrWXDop8RvDTYsQbI/InsE3RroVIt6K953a76U0=
=5ZUa
-----END PGP SIGNATURE-----

--q2opdbjukhns7l76--

Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323D3FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:32:39 +0000 (UTC)
Received: from [178.148.156.23] (port=55896 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mKQXf-0004OV-Ns
	for connman@lists.linux.dev; Sun, 29 Aug 2021 21:32:31 +0200
Date: Sun, 29 Aug 2021 21:32:30 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: Re: [PATCH] Respect EnableOnlineCheck globally
Message-ID: <20210829193230.rmpb6ks3ocim5c62@prancingpony>
References: <20210828171657.2qxolbym36hdiuhu@prancingpony>
 <20210828173427.7ctqrpj2w2ldrkla@prancingpony>
 <20210829175411.u7gfenrvleehvp7v@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k3vko57qn7tqutwm"
Content-Disposition: inline
In-Reply-To: <20210829175411.u7gfenrvleehvp7v@beryllium.lan>
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


--k3vko57qn7tqutwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/08/29 07:54, Daniel Wagner wrote:
> This was the only place I found where we call
> __connman_service_wispr_start() without the EnableOnlineCheck test.

There's one more place, src/service.c:3728-3734 (set_property function).


--k3vko57qn7tqutwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEr4M0ACgkQySjVAu4c
WEBFVQ/+I8lfayyDmdRpkXtydvTA7XIL4iK2qYcUo17FM1o5jpPg/IaEh8w8MHZ8
yS53MMVP5noPmGQ/jsMEqiGnNxcqRYscQErShwLdTOKBm6ybLjzK02ab1nBn+xGM
u9iss6UTh1oYMA6FHU+LkbZijWXcLJC+ebhGmW/kvKIHRxYo6aJnkt/yC31EsmMi
bFB2uK+O9Wk5ZG2KOJUS3fYZONzpkrts6HCAveMow4SAzTcgv1/ftFsBYB6jBw62
tvIBrOhMVJ1JIhzZSoRbNFYXvwDZ/2VCVHusxyDH9fvPABRVRSiwSZcWFzbIUujp
z5nIAG+u5oE2zNorV91ZxpZdwN0TXg7SgAmlcuoCkTzTI2oQwsqmUfPbAekyX3gh
XNSUgLbcXKDHNXv94ZfS5WRgVhgTqoBYY/oKzw3o7Es7MCHWjzp0zjQoXKp3BjxX
O3MqF8fjkglPiURzV6enqoEFVQdrHdLfSeSkQmUTbS4MDnDtOKny4u8YKdqTr79h
DyeroAna7hzQ0yhSlmdu16wFGXyNxREVeEJRTgXr20y+hb+OUc2I7nhhKKwSRr5M
FkVD1KUHa76sAzsz1SdmJtzP6/3gLzAc7CnUf4AckbUzBzeBOvA1F3FfIUJ6Z+SF
k3ybACC3AaF+zOATHp15/d/DDVUT/V9O9PzROXoMFds6tdYgeyo=
=7D/0
-----END PGP SIGNATURE-----

--k3vko57qn7tqutwm--

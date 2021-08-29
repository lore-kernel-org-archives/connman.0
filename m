Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B03FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 20:08:52 +0000 (UTC)
Received: from [178.148.156.23] (port=38450 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mKR6o-0005po-O8
	for connman@lists.linux.dev; Sun, 29 Aug 2021 22:08:50 +0200
Date: Sun, 29 Aug 2021 22:08:49 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] service: Do not trigger wispr start when
 EnableOnlineCheck is disabled
Message-ID: <20210829200849.6ttu3udd65fk7lt3@prancingpony>
References: <20210829195321.23396-1-wagi@monom.org>
 <20210829195321.23396-3-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zxqf3zek7w75feef"
Content-Disposition: inline
In-Reply-To: <20210829195321.23396-3-wagi@monom.org>
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


--zxqf3zek7w75feef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/08/29 09:53, Daniel Wagner wrote:
> Do not try to use wispr when the user has disabled the online check.

The patch you proposed seems fine to me. The gist is to let the user control if
the online check happens or not.


--zxqf3zek7w75feef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEr6VAACgkQySjVAu4c
WEA96w/9EsVci6M/espu4Xp7goaeEsN7jBS/re1PJgten+gdC5taa19T8Ocd8/As
sKT3aynDBclEKOWU/Q6V2H4iBXPWhm0OjKkKNYRWjLxy10LGmN8/AZwQRgxa3iiz
+Yua7ueMwARVWWmaMnDfLWfOU1/QCZasCbMZY01sGgGDHxcbi1t7t2RZKtg/610j
ey7pJX1/zbsMP+Xcd8X6mXaj+P1bcB5VTAo/1WNqXwZ20hJNySrqkuRPkVCBRCP5
G6xA1TgZXcHtQkUmk6uByYr8e23N7yT4aapX4tzDaFNDVxG/2aoz1y8wp+cQK3A3
mJLDdVl1AYurr0EMiwPB6ahGKquA31MBUptEjrvjlx2xx+l8pfZyA7lWw6ZqMykV
UEEHv0+bRcu/eQBjryNAbVjB1lhgvgcezSHkYIfFlvWphKJn21fJi50oRXaBAgmM
gsFZajU8vL+l8jEZL3ObLEaqU6Ii03AKVtJmZQ3hmJbqoYMnzjs42ZlAwDZlOQLL
m5krNm1KrZRP9muAWaQKyiZC2uQr6j275S82/tw5hD8o0xPU+q2twjAaMhE6D0Uu
/E5jnbohyiq2gVB897NTHTbCtBPdl2Ob1nha8pecrCo8zh2O+rmWLPseeCLYSjnU
HDpEOaKHGH55Mmdz3yQjxXSUZTMta3RDOvkDlAdKL+BGNZQaqho=
=uToP
-----END PGP SIGNATURE-----

--zxqf3zek7w75feef--

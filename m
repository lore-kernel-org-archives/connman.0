Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86953FC3
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 11:02:26 +0000 (UTC)
Received: from [178.148.156.23] (port=43386 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mKf3V-0003Cx-Kf
	for connman@lists.linux.dev; Mon, 30 Aug 2021 13:02:25 +0200
Date: Mon, 30 Aug 2021 13:02:19 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] service: Do not trigger wispr start when
 EnableOnlineCheck is disabled
Message-ID: <20210830110219.4iuqzhymsbbccnrv@prancingpony>
References: <20210829195321.23396-1-wagi@monom.org>
 <20210829195321.23396-3-wagi@monom.org>
 <20210829200849.6ttu3udd65fk7lt3@prancingpony>
 <20210830064403.5r3szonne7baipa2@carbon.lan>
 <20210830103411.f33oibwwmk2sqmkl@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jti3lltnidqtgtvh"
Content-Disposition: inline
In-Reply-To: <20210830103411.f33oibwwmk2sqmkl@prancingpony>
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


--jti3lltnidqtgtvh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/08/30 12:34, =D0=A1=D1=82=D1=80=D0=B0=D1=85=D0=B8=D1=9A=D0=B0 =D0=A0=
=D0=B0=D0=B4=D0=B8=D1=9B wrote:
> I tested the patch with tcpdump, but unfortunately, it seems the connecti=
ons are
> still being made, even with EnableOnlineCheck=3Dfalse, Enable6to4=3Dfalse=
 and
> EnableOnlineToReadyTransition=3Dfalse in /etc/connman/main.conf.

I found the culprit -- when built from source, default prefix is /usr/local=
, so
connman was looking for main.conf in /usr/local/etc/connman instead of
/etc/connman. When I symlinked /etc/connman/main.conf to
/usr/local/etc/connman/main.conf and repeated the test, there were no
occurrences of ipv4.connman.net in the log. I also repeated the test using =
only
your two patches, without my patch, and got the same result.

Your two patches combined look ok.


--jti3lltnidqtgtvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEsursACgkQySjVAu4c
WEDsSBAArKPv3clTcQ9H66FU4KD5qF8TpPqI4RW1ZwdfqNSZSjdkCFOz+GOJq3Od
AyouqIoyVRFJFaqs5os3Phx7HgWWvSci3wxNoH2d2K1sxRhEPMQCiDyJU659K16W
aPVCJjCAMXeqwGUhG8Y1fYwEyE9NiL3Ba2TJPT4uPFjBs+0+rZS4rfKgppEWsWuY
ySbfRgKQIKCwL+TxAWQUzteVn6t3DmK439+iNLdNBfLBiF/14MbReFsTjrBr4WGw
ALR0l/ldqD3snFIHKWH9+lXe0e+Q8mm0Qk9ulJaMqUw30B9mZ7w8pRnxoF6qoHKo
CRu0eZQy1KZIKX+CXyyAFrPgo++yWx5cHIyJUWfU81LV9V9P5P+4yFImlgHkRb6w
MLSNkdniQrzb4uLpSVxUQluk4NIvXkNtNDd64hskjApMS5Ue4tkuZPfKivN1Ql9w
lwJ0/sHvJDaanoXTbG11yKjnop243Zf8SZXalPbO7OA+kwD2AuwyPKpXtvdG/g3M
zicGJGUnHekDPEr8BbRAjRPXiPJqUyK2XC1T9tGp7+t3B6rb734CATv6S1ZcS6e0
W0qr5kkhVXIAxYAG1WKc7U4D+Q8fV2DP4bsWrgOwd9EgRMLTNDwSgHLM3voKdLO5
G8lot/lvGEnBV6C7PKChW7eQKL6e9g20qC7FWE76u4Wb97uhkko=
=8uoM
-----END PGP SIGNATURE-----

--jti3lltnidqtgtvh--

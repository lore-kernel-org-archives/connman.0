Received: from host35.dwhost.net (host35.dwhost.net [88.99.219.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB853FC3
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 10:34:19 +0000 (UTC)
Received: from [178.148.156.23] (port=43382 helo=localhost)
	by host35.dwhost.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <contact@strahinja.org>)
	id 1mKecI-0006A5-4R
	for connman@lists.linux.dev; Mon, 30 Aug 2021 12:34:17 +0200
Date: Mon, 30 Aug 2021 12:34:11 +0200
From: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
To: connman <connman@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] service: Do not trigger wispr start when
 EnableOnlineCheck is disabled
Message-ID: <20210830103411.f33oibwwmk2sqmkl@prancingpony>
References: <20210829195321.23396-1-wagi@monom.org>
 <20210829195321.23396-3-wagi@monom.org>
 <20210829200849.6ttu3udd65fk7lt3@prancingpony>
 <20210830064403.5r3szonne7baipa2@carbon.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xuueerzczpw5ceci"
Content-Disposition: inline
In-Reply-To: <20210830064403.5r3szonne7baipa2@carbon.lan>
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


--xuueerzczpw5ceci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/08/30 08:44, Daniel Wagner wrote:
> On Sun, Aug 29, 2021 at 10:08:49PM +0200, =D0=A1=D1=82=D1=80=D0=B0=D1=85=
=D0=B8=D1=9A=D0=B0 =D0=A0=D0=B0=D0=B4=D0=B8=D1=9B wrote:
> > On 21/08/29 09:53, Daniel Wagner wrote:
> > > Do not try to use wispr when the user has disabled the online check.
> >=20
> > The patch you proposed seems fine to me. The gist is to let the user co=
ntrol if
> > the online check happens or not.
>=20
> Could you give them a quick test if they work for you? Thanks!

I tested the patch with tcpdump, but unfortunately, it seems the connection=
s are
still being made, even with EnableOnlineCheck=3Dfalse, Enable6to4=3Dfalse a=
nd
EnableOnlineToReadyTransition=3Dfalse in /etc/connman/main.conf.

I first uninstalled and pkilled any existing versions of connman, then ensu=
red I
applied both of your patches with git apply, ran make clean && make and make
install as root. Then I ran connmand as root and inside connmanctl:

connmanctl> enable wifi
connmanctl> agent on
connmanctl> connect <my_network>
<entered passphrase>

at the same time, I used tcpdump -i wlan0 > log.txt

and in the log I got a number of lines containing ipv4.connman.net.

Then I tried to apply my patch on top of your patches and repeat the proces=
s,
but got the same result.


--xuueerzczpw5ceci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnVz5QZIXdcnu/26GySjVAu4cWEAFAmEstCMACgkQySjVAu4c
WEBmUw/8D2aWJCuykWbbkhFJqijXFvG+O6GrfAKS1Iu10tUTwZRG62UgVvLw/3Ji
A1IPmOOUTEZzgopdaS3TKcwhb+3vUKTle9rTIIdsCgSp2Uu3d2msLqSK6iuRqvxD
O86dajr2OaowgWqkVTT6o1Zcu3GSoLVYEQeJoUVUr3gp+XFxYS8AP15X2vaySjSm
FLlJURCD1d52LVWlSoRVH6kN7wjWzSmHmzzOfGfwy/KaAlnlJ7gzJF0162siDJF1
U/WplqghXs+HTY9n6Ss6AQ7Y3AUTlhjZr9bflf069uLXqtVPMhYGvrQ3af9JbLws
jYy1RWHh80Q59UtX1obFZRyWIwYEWFqlrSAxLpzzqwlvfsLKAmRdaMvOPSnG0/55
tZMbW9EMBw6aU02/9uNtT8/ArsKBMlWF20nvmhiDOYmzA3DaSMpG31WYV9bNg027
8SY1sW2NtMqIgcuJcJNWI+IJyi9dZZDCKiTYjrSXFKSKPp04tHj1Ba6pg7QH02lF
luPc+6rubXczjp1QrIFwDyiLA36/0h1XoqJDE/07kMHdx32pSCLwO39LkHLGd7wL
afzYGfJiuc9zrMbcikhxEqZEFqS6nWNdAQGc1iUzZ1aAx/5vgQaI+n9dYx4ZbuNd
wH0NszvV+63OSFF0KS4OqmavwNBw1reaKAwDb0OETji+8nXHXWo=
=VBmc
-----END PGP SIGNATURE-----

--xuueerzczpw5ceci--

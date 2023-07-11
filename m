Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F221774C
	for <connman@lists.linux.dev>; Tue, 11 Jul 2023 12:25:28 +0000 (UTC)
Date: Tue, 11 Jul 2023 12:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=lwoz6ajhkberrkxwjcecqijwmi.protonmail; t=1689078326; x=1689337526;
	bh=9seU0UfeajGGyE4qw9T+YhJ7pN45Zvu7AiJtLx7yvS0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BlU7uKIJ1EdJ2MMc49AgK0rEhuLVixs2aJVvNDbX5heV5GbjCkcWYblI0n3Qxg0XS
	 BX8TTACTK7rGXuWjM44EOM9ObWi9LQxQXKjHiuyLQgMgWnhbYgqu7o+ksQbVkvAO5H
	 5jkHCuzbj/HL5zpMa8kRQdB1sCgiYxSUZV0/q6nFq12IC/LkxPdkFXkv49ZC/c8gnO
	 ZYMG7ler47IfWb7cG8BM4o4A7G+nG5pHMUfbKJ2326+Fo/6zeygLYRdgwh7EThn+Xw
	 frMqZRy8s+ESJWnCaXeP4MnoUPwNWrSu691yYiRb9k8Dv0p7G3gzNjBiavePvcK/SM
	 t55NnVOo1mUJg==
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
From: Mo <mo.wei.no.way@proton.me>
Subject: IPv4LL MAC seeding instead of random IP
Message-ID: <b_Ofhsln4b7zrWZJerJ3KNkje3ACidY7pCrRjgPgHzEL4yUUIiXbQT-RGNE0rWBQrMnqc2_MbNNoU9uVUbfn7d6JAIlVRo7YxVjZyvZbQ7I=@proton.me>
Feedback-ID: 73880283:user:proton
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------700f28871d7feecac8bb9f15e06bf9e8361a9090a68ebfa3f62fc70a55e6ea69"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------700f28871d7feecac8bb9f15e06bf9e8361a9090a68ebfa3f62fc70a55e6ea69
Content-Type: multipart/mixed;boundary=---------------------b8710e326e2cda928e79bb9cb13f00fb

-----------------------b8710e326e2cda928e79bb9cb13f00fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

When I enable `IPv4.method=3Dauto`=C2=A0on an interface, the device gets a=
 random link-local address each boot (assuming there is no DHCP server on =
the network).

I'd like to use the MAC as a seed for the IP. This is mentioned in [RFC 39=
27](https://www.rfc-editor.org/rfc/rfc3927), sec. 2.1:

>=C2=A0If the host has access to persistent information that is different =
for each host, =


  such as its IEEE 802 MAC address, then the pseudo-random number generato=
r
  SHOULD be seeded using a value derived from this information.


Until commit 3da07ebeb4 ConnMan implemented MAC seeding. =


It was removed, however, in what seems to be a cleaning effort. As I read =
it, the feature was lost on accident, but maybe there were other reasons.

-=C2=A0Are there plans to (re-)introduce it?
-=C2=A0If not: Why?


Yours sincerely
Mo


Version:
connman 1.41

Mentioned commit:
```
commit 3da07ebeb4ae8e6bea3fe71a3854db7744df8bb6 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0
Author: Patrik Flykt <patrik.flykt@linux.intel.com> =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
Date: =C2=A0 Wed Nov 19 12:46:55 2014 +0200 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0

=C2=A0 =C2=A0 gdhcp: Use dhcp_get_random() where necessary =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0

=C2=A0 =C2=A0 Instead of always using the libc rand() function, use the fu=
nction from =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 the gdhcp common code. With this change the seed value can b=
e omitted =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 from IPv4 link-local code. =C2=A0
```
-----------------------b8710e326e2cda928e79bb9cb13f00fb
Content-Type: application/pgp-keys; filename="publickey - mo.wei.no.way@proton.me - 0xBA1F4BCD.asc"; name="publickey - mo.wei.no.way@proton.me - 0xBA1F4BCD.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - mo.wei.no.way@proton.me - 0xBA1F4BCD.asc"; name="publickey - mo.wei.no.way@proton.me - 0xBA1F4BCD.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWkZUdzlSWUpLd1lCQkFI
YVJ3OEJBUWRBenpJZjNySFY4cWpLSldsSjgxNFdDVkRaMUN1THRubW0KZjJMRm5NYzdUdzNOTVcx
dkxuZGxhUzV1Ynk1M1lYbEFjSEp2ZEc5dUxtMWxJRHh0Ynk1M1pXa3VibTh1CmQyRjVRSEJ5YjNS
dmJpNXRaVDdDakFRUUZnb0FQZ1dDWkZUdzlRUUxDUWNJQ1pBN0ZCOGtCQmJKN3dNVgpDQW9FRmdB
Q0FRSVpBUUtiQXdJZUFSWWhCTG9mUzgybTJZU0VXdkNZN1RzVUh5UUVGc252QUFDR0NRRUEKeWVD
b0U3MTFFY0s1Ykt3dEcva0k5L3BsVC9kLysyTlpvUXdaZTF0MWVpY0EvUkpHdkdoSnUrVnFLdy92
ClNpaDlYL1g1RC8yQVlCSENvWGhHak1IenhQd0V6amdFWkZUdzlSSUtLd1lCQkFHWFZRRUZBUUVI
UUMzYQpFcnF6WEFUVXlyRkpiTUNtbWR1bUliMDZjcUt1dVhtbk5qZkNDNHNJQXdFSUI4SjRCQmdX
Q0FBcUJZSmsKVlBEMUNaQTdGQjhrQkJiSjd3S2JEQlloQkxvZlM4Mm0yWVNFV3ZDWTdUc1VIeVFF
RnNudkFBQXhad0VBCi9SV01nOExJNitxS3hTUGViR1RqZEIyUk5KaHVXNW9NYWZhaWV0SFViejhC
QU9uaS9iR0RpZ3IrdTJvQQpjMXpoZ3hxNjkyNGplVmt6MFJpTGdnaGNDTGNMCj1ncWRhCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
-----------------------b8710e326e2cda928e79bb9cb13f00fb--

--------700f28871d7feecac8bb9f15e06bf9e8361a9090a68ebfa3f62fc70a55e6ea69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmStShoJkDsUHyQEFsnvFiEEuh9LzabZhIRa8JjtOxQfJAQW
ye8AAGBxAP9gqHZgOK7+KWuTC4zUo3h++6EVFV7E73qC/SJVjTkHaQD+Kqom
M/S6BPR4hjrP9bLkRrOdan37VK/hVAkO7xLcxAQ=
=+0fp
-----END PGP SIGNATURE-----


--------700f28871d7feecac8bb9f15e06bf9e8361a9090a68ebfa3f62fc70a55e6ea69--


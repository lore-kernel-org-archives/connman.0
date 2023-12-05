Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71969280
	for <connman@lists.linux.dev>; Tue,  5 Dec 2023 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3CBF07310E;
	Tue,  5 Dec 2023 11:57:49 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5908:434f:401b:daca] (unknown [IPv6:2601:647:5a00:15c1:5908:434f:401b:daca])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DC0C37312B;
	Tue,  5 Dec 2023 11:57:48 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: =?utf-8?Q?Re=3A_Regression_caused_by_=22Don=27t_add_route_for_inv?=
 =?utf-8?Q?alid_dst_and_gateway_address_combinations=E2=80=9D?=
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <83d7e315-a25c-4c2c-9ddc-9abde56ebeff@gmail.com>
Date: Tue, 5 Dec 2023 08:57:48 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <73D64378-2195-4669-8B60-39F808190977@nuovations.com>
References: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
 <83d7e315-a25c-4c2c-9ddc-9abde56ebeff@gmail.com>
To: =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 22, 2023, at 8:07 AM, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n =
<zboszor@gmail.com> wrote:
> Someone with a bigger hammer should look into this.
>=20
> I guess there is a difference between
> * intentional default gw with all-zero network and netmask bits for =
VPN
> * dhcp not responding on an interface and then adding a route with =
all-zero gateway and netmask values
>=20
> 2023. 11. 22. 15:53 keltez=C3=A9ssel, Christian Hewitt =C3=ADrta:
>>=20
>> [=E2=80=A6]
>>=20
>> And =E2=80=9Call-traffic=E2=80=9D is routing through the tunnel =
again.
>>=20
>> I don=E2=80=99t code so can=E2=80=99t figure out how to fix this =
myself. I=E2=80=99ll happily test any patches you share though, and can =
provide remote access to test devices if needed.


Zolt=C3=A1n and/or Christian,

Are either of you running this down or working on a patch to revert the =
prior one until a more comprehensive solution can be found?

Christian, based on your =E2=80=9Cdon=E2=80=99t code=E2=80=9D comment, I =
suspect you are not. :-)

I have some patches that should be flowing shortly that add low-priority =
default routes for non-default service network interfaces. Those may =
allow the infrastructure to better address this but could also confound =
and complicate this by introducing potentially additional VPN breakage =
since that=E2=80=99s not a use case I currently have a DUT configuration =
for.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


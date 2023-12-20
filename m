Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819714B5B6
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7820873123;
	Wed, 20 Dec 2023 11:20:34 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:dc8d:b6d6:ffb0:8467] (unknown [IPv6:2601:647:5a00:15c1:dc8d:b6d6:ffb0:8467])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 393B673154;
	Wed, 20 Dec 2023 11:20:34 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/2] Add option to omit DHCP Client Identifier
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
Date: Wed, 20 Dec 2023 08:20:33 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <47B181A7-0A76-45D8-8E0B-3183A4177FB9@nuovations.com>
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
To: =?utf-8?Q?Ant=C3=B3nio_Oliveira?= <antonio.oliveira@konsulko.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 20, 2023, at 7:42 AM, Ant=C3=B3nio Oliveira =
<antonio.oliveira@konsulko.com> wrote:
> While recently working a customer project, I ran into an issue after
> upgrading the OS to a newer version which uses connman for network
> management.
>=20
> The DHCP client in the old OS didn't include option 61 (Client
> Identifier) but connman does. In this scenario, when the system
> reboots after an upgrade, it changes IP address, which can get very
> confusing, especially if a UI is waiting for the device to come back
> alive to signal completion of the update.
>=20
> This proposed change adds an option to main.conf - =
OmitClientIdentifier,
> which, if set to true causes that option to not be added to DHCP
> packets.
>=20
> The default behaviour is retained in case no option is set in =
main.conf.
>=20
> The change is relatively small, and I'm posting it here in case it is
> helpful for connman users facing the same issue.
>=20
> Please feel free to consider or exclude it. If there's anything that I
> can do to improve it to match upstream requirements, please let me =
know
> and I'll do what I can to help.

Ant=C3=B3nio,

It=E2=80=99s slightly different than the client identifier; however, did =
you experiment with the existing AllowHostnameUpdates configuration =
option?

Also, connman should request the last-issued DHCP address to the DHCP =
server. Assuming another client hasn=E2=80=99t reserved it first, the =
client should get a semi-stable IP address. Did you chase that down as =
well?

Finally, if the DHCP server is configured to serve a different IPv4 =
address for the specified client ID rather than the one the client has, =
might this be better addressed at the DHCP server? Though, I can see =
that you might not have access to the server.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


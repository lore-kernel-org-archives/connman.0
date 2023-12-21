Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BE77B5A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id CAF87CECCA;
	Thu, 21 Dec 2023 23:18:44 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] Add option to omit DHCP Client Identifier
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <47B181A7-0A76-45D8-8E0B-3183A4177FB9@nuovations.com>
Date: Thu, 21 Dec 2023 23:18:33 +0100
Cc: =?utf-8?Q?Ant=C3=B3nio_Oliveira?= <antonio.oliveira@konsulko.com>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F5F2F14-2D51-46E1-9D2C-50FA16749271@holtmann.org>
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
 <47B181A7-0A76-45D8-8E0B-3183A4177FB9@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

>> While recently working a customer project, I ran into an issue after
>> upgrading the OS to a newer version which uses connman for network
>> management.
>>=20
>> The DHCP client in the old OS didn't include option 61 (Client
>> Identifier) but connman does. In this scenario, when the system
>> reboots after an upgrade, it changes IP address, which can get very
>> confusing, especially if a UI is waiting for the device to come back
>> alive to signal completion of the update.
>>=20
>> This proposed change adds an option to main.conf - =
OmitClientIdentifier,
>> which, if set to true causes that option to not be added to DHCP
>> packets.
>>=20
>> The default behaviour is retained in case no option is set in =
main.conf.
>>=20
>> The change is relatively small, and I'm posting it here in case it is
>> helpful for connman users facing the same issue.
>>=20
>> Please feel free to consider or exclude it. If there's anything that =
I
>> can do to improve it to match upstream requirements, please let me =
know
>> and I'll do what I can to help.
>=20
> Ant=C3=B3nio,
>=20
> It=E2=80=99s slightly different than the client identifier; however, =
did you experiment with the existing AllowHostnameUpdates configuration =
option?
>=20
> Also, connman should request the last-issued DHCP address to the DHCP =
server. Assuming another client hasn=E2=80=99t reserved it first, the =
client should get a semi-stable IP address. Did you chase that down as =
well?
>=20
> Finally, if the DHCP server is configured to serve a different IPv4 =
address for the specified client ID rather than the one the client has, =
might this be better addressed at the DHCP server? Though, I can see =
that you might not have access to the server.

I think that Denis already mentioned this. We need to kill the ConnMan =
DHCP client in favor of the one from ELL.

Regards

Marcel


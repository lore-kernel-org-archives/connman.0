Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC651840
	for <connman@lists.linux.dev>; Wed, 16 Aug 2023 07:06:22 +0000 (UTC)
Received: from smtpclient.apple (p4fefcd6d.dip0.t-ipconnect.de [79.239.205.109])
	by mail.holtmann.org (Postfix) with ESMTPSA id 581B6CED0C;
	Wed, 16 Aug 2023 09:06:21 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [RFC][PATCH] gdhcp/client: Don't attach a DHCP client to veth*
 devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230711154032.935972-1-zboszor@gmail.com>
Date: Wed, 16 Aug 2023 09:06:11 +0200
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <09F98822-C02E-43CE-B4C2-54B2050DE462@holtmann.org>
References: <20230711154032.935972-1-zboszor@gmail.com>
To: =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)

Hi Zoltan,

> veth* interfaces are created as sub-interfaces for a bridge
> by Docker and not actually used for communication in my use case.
>=20
> But Connman tries to use DHCPv4 on them and they end up with
> an IP address in the 169.254.x.x range with routes added to them,
> which extra routes in turn break networking on the host.
>=20
> This is a very bad approach, hence the RFC status of the patch.
> It may be better if Connman didn't add routing for interfaces
> with only a link local address. Please give me some pointers
> so I can implement it properly.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi =
<zboszor@gmail.com>
> ---
> gdhcp/client.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/gdhcp/client.c b/gdhcp/client.c
> index 82017692..36c233a1 100644
> --- a/gdhcp/client.c
> +++ b/gdhcp/client.c
> @@ -1175,6 +1175,11 @@ GDHCPClient *g_dhcp_client_new(GDHCPType type,
> goto error;
> }
>=20
> + if (strncmp(dhcp_client->interface, "veth", 4) =3D=3D 0) {
> + *error =3D G_DHCP_CLIENT_ERROR_INTERFACE_IN_USE;
> + goto error;
> + }
> +
> if (!interface_is_up(ifindex)) {
> *error =3D G_DHCP_CLIENT_ERROR_INTERFACE_DOWN;
> goto error;

bad approach indeed. No hard code interface name matching in the DHCP =
client code.

Regards

Marcel


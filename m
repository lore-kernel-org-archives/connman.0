Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C41E526
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id ABBEACECD1;
	Wed, 29 Nov 2023 14:18:23 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] connection: Rename 'ipv[46]_gateway' gateway config
 field.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129000816.1230451-1-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 14:18:13 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A90CA5E-4E2E-4A46-B53B-A2A75AAFB369@holtmann.org>
References: <20231129000816.1230451-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This renames the 'gateway_data' structure 'ipv[46]_gateway' fields as
> 'ipv[46]_config' to:
>=20
>    1. Better align the fields with their type, 'gateway_config'.
>    2. Disambiguate the fields from their type field, 'gateway'.
>    3. Align with and mirror 'ipconfig'.
> ---
> src/connection.c | 352 +++++++++++++++++++++++------------------------
> 1 file changed, 176 insertions(+), 176 deletions(-)
>=20
> diff --git a/src/connection.c b/src/connection.c
> index 75591a741ad4..499e8e46a5a5 100644
> --- a/src/connection.c
> +++ b/src/connection.c
> @@ -52,8 +52,8 @@ struct gateway_config {
> struct gateway_data {
> int index;
> struct connman_service *service;
> - struct gateway_config *ipv4_gateway;
> - struct gateway_config *ipv6_gateway;
> + struct gateway_config *ipv4_config;
> + struct gateway_config *ipv6_config;
> bool default_checked;
> };
>=20
> @@ -168,24 +168,24 @@ static void gateway_data_debug(const char =
*function,
>=20
> CONNMAN_DEBUG(function,
> "%s %p: { index: %d (%s), service: %p (%s), "
> - "ipv4_gateway: %p, ipv6_gateway: %p, default_checked: %u }",
> + "ipv4_config: %p, ipv6_config: %p, default_checked: %u }",
> description,
> data,
> data->index,
> maybe_null(interface),
> data->service,
> connman_service_get_identifier(data->service),
> - data->ipv4_gateway,
> - data->ipv6_gateway,
> + data->ipv4_config,
> + data->ipv6_config,
> data->default_checked);

and now you are killing me since I can=E2=80=99t apply these patches =
since they depend on some changed debug thing.

I really like to keep things at just having DBG(). It is easy to spot =
and easy to use. And we can backport and bisect things later on.

Regards

Marcel


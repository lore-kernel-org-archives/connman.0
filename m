Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3762114
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 5FE72CECD1;
	Wed, 29 Nov 2023 14:23:56 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/4] connection: Refactor 'connection_newgateway'.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129073947.1280705-2-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 14:23:46 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E617690-AD00-41B4-B4E2-7E4E5826D20A@holtmann.org>
References: <20231129073947.1280705-1-gerickson@nuovations.com>
 <20231129073947.1280705-2-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This refactors the body tail of 'connection_newgateway' into a
> separate function, 'check_default_gateway', shortening the length of
> the former and making the latter an individually auditable and
> comprehensible function.
> ---
> src/connection.c | 86 +++++++++++++++++++++++++++++++-----------------
> 1 file changed, 55 insertions(+), 31 deletions(-)
>=20
> diff --git a/src/connection.c b/src/connection.c
> index ce38f35d68c7..747b744a295e 100644
> --- a/src/connection.c
> +++ b/src/connection.c
> @@ -1051,6 +1051,57 @@ static bool choose_default_gateway(struct =
gateway_data *data,
> return downgraded;
> }
>=20
> +static void check_default_gateway(struct gateway_data *activated)
> +{
> + GHashTableIter iter;
> + gpointer value, key;
> + bool found =3D false;
> +
> + DBG("activated %p", activated);
> +
> + GATEWAY_DATA_DBG("activated", activated);
> +

this will get out of hand. I appreciate what you are trying to do, but =
long term this kind of DBG is not maintainable. You need to work under =
assumption that you only ever have DBG and do magic with that.

Back in the early days I refused to have levels or priorities or section =
added since that always gets out of hand. Hence we did a concept where =
every debug statement could be potentially enabled separately (like =
dynamic_debug) in the kernel. And it is really a game changer in =
maintainability if you keep it simple.

Regards

Marcel


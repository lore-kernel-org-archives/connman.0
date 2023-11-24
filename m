Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B531740
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 77720730F3;
	Fri, 24 Nov 2023 12:46:20 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c] (unknown [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2AA357310B;
	Fri, 24 Nov 2023 12:46:20 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] service: Make DBG in
 '__connman_service_ipconfig_indicate_state' consistent.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20231117210514.699193-1-gerickson@nuovations.com>
Date: Fri, 24 Nov 2023 09:46:19 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <53F8288B-E003-477D-862D-B6F6F48DF434@nuovations.com>
References: <20231117210336.699149-1-gerickson@nuovations.com>
 <20231117210514.699193-1-gerickson@nuovations.com>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Any thoughts on this patch?

> On Nov 17, 2023, at 1:05 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>=20
> This makes the DBG statement in =
'__connman_service_ipconfig_indicate_state'
> consistent in format of 'service <service_pointer> (<service_name>) =
type
> <ipconfig_type> (<ipconfig_type_name>)' with that of other DBG =
statements
> in the module.
>=20
> This makes at-a-glance, columnar correlation and comparison of service
> activities easier.
> ---
> src/service.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/service.c b/src/service.c
> index 81a1bebdc14b..a5aef1402933 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -7126,11 +7126,11 @@ int =
__connman_service_ipconfig_indicate_state(struct connman_service =
*service,
> 	if (old_state =3D=3D new_state)
> 		return -EALREADY;
>=20
> -	DBG("service %p (%s) old state %d (%s) new state %d (%s) type %d =
(%s)",
> +	DBG("service %p (%s) type %d (%s) old state %d (%s) new state %d =
(%s)",
> 		service, connman_service_get_identifier(service),
> +		type, __connman_ipconfig_type2string(type),
> 		old_state, state2string(old_state),
> -		new_state, state2string(new_state),
> -		type, __connman_ipconfig_type2string(type));
> +		new_state, state2string(new_state));
>=20
> 	switch (new_state) {
> 	case CONNMAN_SERVICE_STATE_UNKNOWN:
> --=20
> 2.42.0
>=20
>=20

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


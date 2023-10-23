Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195951B272
	for <connman@lists.linux.dev>; Mon, 23 Oct 2023 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id F13DA73123;
	Mon, 23 Oct 2023 10:52:15 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:80dc:8223:2fa1:8ff1] (unknown [IPv6:2601:647:5a00:15c1:80dc:8223:2fa1:8ff1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A68BB73296;
	Mon, 23 Oct 2023 10:52:15 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] resolver: FIX path to resolv.conf config option
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20230929033408.80874-1-ngariepy1999@gmail.com>
Date: Mon, 23 Oct 2023 07:52:14 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <344155DA-16CE-4CC8-847E-CA3EBB00A664@nuovations.com>
References: <20230929033408.80874-1-ngariepy1999@gmail.com>
To: Nicolas Gariepy <ngariepy1999@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Nicolas:

This looks good to me and seems to address the issues I was having with =
this configuration option.

Best,

Grant

Reviewed-by: Grant Erickson <gerickson@nuovations.com>

On Sep 28, 2023, at 8:34 PM, Nicolas Gariepy <ngariepy1999@gmail.com> =
wrote:
> There are two problems with how the "ResolvConf" option was =
implemented.
>=20
> 1. The "ResolvConf" is used in src/resolver.c using the function =
connman_setting_get_string(const char *key) but the =
connman_settings.resolv_conf option could only be accessed using the =
connman_setting_get_bool(const char *key) function at the moment.
> 2. The Gerror is not cleared before trying to read the "ResolvConf" =
parameter of the config.
>=20
> This patch fixes the two issues above.
> ---
> src/main.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/main.c b/src/main.c
> index ae4a450d..61881442 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -599,6 +599,8 @@ static void parse_config(GKeyFile *config)
> 	if (!error)
> 		connman_settings.regdom_follows_timezone =3D boolean;
>=20
> +	g_clear_error(&error);
> +
> 	string =3D __connman_config_get_string(config, "General",
> 				CONF_RESOLV_CONF, &error);
> 	if (!error)
> @@ -801,6 +803,9 @@ char *connman_setting_get_string(const char *key)
> 		return connman_settings.localtime ?
> 			connman_settings.localtime : DEFAULT_LOCALTIME;
>=20
> +	if (g_str_equal(key, CONF_RESOLV_CONF))
> +		return connman_settings.resolv_conf;
> +
> 	return NULL;
> }
>=20
> @@ -842,9 +847,6 @@ bool connman_setting_get_bool(const char *key)
> 	if (g_str_equal(key, CONF_REGDOM_FOLLOWS_TIMEZONE))
> 		return connman_settings.regdom_follows_timezone;
>=20
> -	if (g_str_equal(key, CONF_RESOLV_CONF))
> -		return connman_settings.resolv_conf;
> -
> 	return false;
> }
>=20
> --=20
> 2.40.1
>=20
>=20

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


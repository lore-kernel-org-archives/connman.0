Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970FA33E7
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C7E1D7317C;
	Wed,  1 Nov 2023 16:59:13 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7F5FD73176;
	Wed,  1 Nov 2023 16:59:13 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] resolver: FIX path to resolv.conf config option
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20230929033408.80874-1-ngariepy1999@gmail.com>
Date: Wed, 1 Nov 2023 13:59:13 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <74BF1D0B-1D8D-40D2-8ADC-737884FB1886@nuovations.com>
References: <20230929033408.80874-1-ngariepy1999@gmail.com>
To: Nicolas Gariepy <ngariepy1999@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Nicolas,

Thank you again for this. I=E2=80=99ve submitted a pull request at my =
clone / fork:

    https://github.com/Nuovations/connman/pull/19

and it has been merged to the primary branch there.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

On Sep 28, 2023, at 8:34 PM, Nicolas Gariepy <ngariepy1999@gmail.com> =
wrote:
>=20
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

Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF492C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 3AF34CECEB;
	Tue,  7 Nov 2023 16:33:43 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] resolver: FIX path to resolv.conf config option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230929033408.80874-1-ngariepy1999@gmail.com>
Date: Tue, 7 Nov 2023 16:33:32 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADA17299-4A4F-46F7-929A-E4ADDBF03784@holtmann.org>
References: <20230929033408.80874-1-ngariepy1999@gmail.com>
To: Nicolas Gariepy <ngariepy1999@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Nicolas,

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

patch has been applied.

Regards

Marcel


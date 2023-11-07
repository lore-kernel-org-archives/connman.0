Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5AD2D02E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 66574CECEE;
	Tue,  7 Nov 2023 19:52:33 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/2] Rename and Document 'switch_default_service'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
Date: Tue, 7 Nov 2023 19:52:23 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9379D51-F803-4576-8E66-19F83E4FD77C@holtmann.org>
References: <37EFB709-B379-4AE2-85F6-0D74564EF4C8@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch patch series renames and documents the =
=E2=80=98switch_default_service' function.
>=20
> The function =E2=80=98switch_default_service' is used in two contexts:
>=20
>  1. =46rom =E2=80=98__connman_service_move', which may be called from =
either the public D-Bus
>      =E2=80=9CMoveAfter" or =E2=80=9CMoveBefore" method requests or =
from =E2=80=98connman_provider_set_split_routing' in "src/provider.c".
>  2. =46rom =E2=80=98service_update_preferred_order' in which the first =
argument is guaranteed to the default service.
>=20
> In the D-Bus =E2=80=9CMoveAfter" or =E2=80=9CMoveBefore" contexts, the =
=E2=80=98switch_default_service' is a misnomer since neither
> service argument, in particular the first, is guaranteed to be the =
default service. Consequently,
> =E2=80=98switch_default_service' is renamed to the more neutral =
=E2=80=98switch_service_order' to reflect its varied usage in the
> above contexts.

both patches have been applied.

Regards

Marcel


Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB2DFBF0
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 6D93ACECD8;
	Sat, 23 Dec 2023 16:31:04 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/3] Ensure resolving and setting of proper ISO3166 code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
Date: Sat, 23 Dec 2023 16:30:53 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0511602-0B7D-43A2-BC25-9B9AC5FB6504@holtmann.org>
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Jussi,

> This patch set amends the functionality added in commit
> bce73f1bdbf1aa6fc28d2f75b7780f4f1d8b0e3a by making sure that the =
ISO3166 code:
> - is resolved in every case using both zone1970.tab and zone.tab
> - gets set for the technology when it powers up
> - and, is kept in sync between technology and device(s)
>=20
> Technology now stores the regulatory domain as an internal value which =
is
> changed whenever a change is detected. Similarly each device ensures =
that the
> value is being kept in sync with technology as it is set always when =
the device
> gets powered. Technology gets the change notifification via Ofono or =
via the
> Localtime setting watched by timezone.
>=20
> In order to always resolve, or attempt to resolve, the correct ISO3166 =
code in
> every country sub-region both zone1970.tab and the deprecated zone.tab =
files
> are used. Initially the ISO3166 code is retrieved from zone1970.tab =
but if not
> found then the deprecated timezone map is used to get the correct iso =
ISO3166
> which is used as a search parameter to again search from the =
zone1970.tab but
> this time searching from the string lists. This is needed in special =
cases,
> such as =C3=85lands and Pacific/Midway regions to name but a few, to =
have the
> ISO3166 code set. Otherwise in these regions WiFi plugin, for =
instance, is
> told to use the default region, resulting in some channels being =
inaccessible.
>=20
>=20
> Jussi Laakkonen (3):
>  technology: Add global regdom and regdom getter
>  device: Setup regdom when powering up to maintain consistency
>  timezone: Fix resolving of proper ISO3166 code from tz data
>=20
> src/connman.h    |   1 +
> src/device.c     |  11 +++
> src/technology.c |  27 +++++++
> src/timezone.c   | 178 ++++++++++++++++++++++++++++++++++++++++-------
> 4 files changed, 191 insertions(+), 26 deletions(-)

all 3 patches have been applied.

Regards

Marcel


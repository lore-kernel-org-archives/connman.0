Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB4428E1A
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B54B4730F9;
	Fri, 22 Dec 2023 11:33:50 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138] (unknown [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 76C2173144;
	Fri, 22 Dec 2023 11:33:50 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] Ensure resolving and setting of proper ISO3166 code
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
Date: Fri, 22 Dec 2023 08:33:49 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D272FAC-BA62-4533-B6A7-750F563D3F9F@nuovations.com>
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 22, 2023, at 7:46 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> =
wrote:
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
>=20
> --=20
> 2.30.2

Jussi,

Thank you for this patch.

I have a system where the timezone is currently set to "America/Denver" =
which periodically results in the being incorrectly identified as =
=E2=80=9CNavajo=E2=80=9D:

2023-12-22T09:27:46-0700 [19205453]# cat /etc/timezone=20
America/Denver

But is identified as =E2=80=9CNavajo=E2=80=9D here:

connmand[<PID>]: src/timezone.c:__connman_timezone_init()=20
connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() sysconfig =
zone (null)
connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() localtime =
zone Navajo

But in another run is identified as =E2=80=9CAmerica/Denver=E2=80=9D:

connmand[<PID>]: src/timezone.c:__connman_timezone_init()=20
connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() sysconfig =
zone (null)
connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() localtime =
zone America/Denver

I will be eager to see if this patch series fixes this issue.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/




Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81023773
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jolla.com
Received: from localhost.localdomain (88-113-60-79.elisa-laajakaista.fi [88.113.60.79])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 5006dd13-a0e1-11ee-b3cf-005056bd6ce9;
	Fri, 22 Dec 2023 17:46:47 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Ensure resolving and setting of proper ISO3166 code
Date: Fri, 22 Dec 2023 17:46:42 +0200
Message-Id: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set amends the functionality added in commit
bce73f1bdbf1aa6fc28d2f75b7780f4f1d8b0e3a by making sure that the ISO3166 code:
 - is resolved in every case using both zone1970.tab and zone.tab
 - gets set for the technology when it powers up
 - and, is kept in sync between technology and device(s)

Technology now stores the regulatory domain as an internal value which is
changed whenever a change is detected. Similarly each device ensures that the
value is being kept in sync with technology as it is set always when the device
gets powered. Technology gets the change notifification via Ofono or via the
Localtime setting watched by timezone.

In order to always resolve, or attempt to resolve, the correct ISO3166 code in
every country sub-region both zone1970.tab and the deprecated zone.tab files
are used. Initially the ISO3166 code is retrieved from zone1970.tab but if not
found then the deprecated timezone map is used to get the correct iso ISO3166
which is used as a search parameter to again search from the zone1970.tab but
this time searching from the string lists. This is needed in special cases,
such as Ålands and Pacific/Midway regions to name but a few, to have the
ISO3166 code set. Otherwise in these regions WiFi plugin, for instance, is
told to use the default region, resulting in some channels being inaccessible.


Jussi Laakkonen (3):
  technology: Add global regdom and regdom getter
  device: Setup regdom when powering up to maintain consistency
  timezone: Fix resolving of proper ISO3166 code from tz data

 src/connman.h    |   1 +
 src/device.c     |  11 +++
 src/technology.c |  27 +++++++
 src/timezone.c   | 178 ++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 191 insertions(+), 26 deletions(-)

-- 
2.30.2


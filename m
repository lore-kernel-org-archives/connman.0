Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8A15A5
	for <connman@lists.linux.dev>; Tue,  5 Apr 2022 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0daf5725-b4ed-11ec-877a-005056bdfda7;
	Tue, 05 Apr 2022 17:31:17 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] Set regdom to follow timezone setting as optional feature
Date: Tue,  5 Apr 2022 17:31:12 +0300
Message-Id: <20220405143116.2272080-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds an optional feature to make regdom follow the timezone set
on the system. This feature is useful on systems where no cellular is available
or there is no SIM present, as the regdom on WLAN would stay on default (US)
and some channels would be unreachable. Enabling the "RegdomFollowsTimezone"
config option makes Ofono plugin not to change regdom when the cellular network
has indicated a change on country. By following the timezone, which can be
also updated by the cellular stack if set to automatic configuration (might
need a external service to do this), would then eventually propagate to ConnMan.

In order to fully faciliate this on different configurations also the watching
of the localtime is improved. This is done by allowing to configure it as on
some systems there may be an external service controlling localtime setting,
e.g, by defining /etc/localtime a permanent symlink to the service's own
changeable symlink. Furthermore, inotify then needed to react also to IN_CREATE
event in timezone.c in order to detect changes on symlink.

Regdom is read from /usr/share/zoneinfo/zone1970.tab and the first ISO3166
country code set for the current timezone is used. This is done both on startup
and when the content/link of the localtime set has changed.

Jussi Laakkonen (4):
  main: Add path to localtime to config options.
  main: Add RegdomFollowsTimezone option for regdom changes
  timezone: Change regdom along timezone, use localtime config
  ofono: Do not change regdom when it follows timezone

 doc/connman.conf.5.in |   9 ++++
 plugins/ofono.c       |   5 +++
 src/main.c            |  32 ++++++++++++++
 src/timezone.c        | 100 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 141 insertions(+), 5 deletions(-)

-- 
2.30.2


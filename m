Received: from fgw20-4.mail.saunalahti.fi (fgw20-4.mail.saunalahti.fi [62.142.5.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6B272
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 05ec932b-0974-11ec-bea8-005056bd6ce9;
	Mon, 30 Aug 2021 12:24:06 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 0/2] Implement connmand state monitoring to vpnd
Date: Mon, 30 Aug 2021 12:24:03 +0300
Message-Id: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement connmand state monitoring into vpnd to keep track of the state
changes in regards to connectivity and D-Bus registration. vpnd retrieves the
state from connmand using Manager interface when started and otherwise it
monitors PropertyChanged signals as well as utilizes D-Bus service monitoring
to get the changes.

This change prevents connecting VPNs when connmand is not yet online or has
gone away from D-Bus (e.g., restart). In case VPN is connected before the state
has been queried a delayed connection function is utilized to connect that VPN
when online/ready state is reached.

In case connmand is offline or gone from D-Bus ENOLINK is returned as an error.
This is handled in plugins/vpn.c and returned back to the caller as NoCarrier
D-Bus error message.

Changes since V2:
 - Updated vpn-provider patch to v3: cleanups, reformat, remove agent checks.
 - Updated vpn patch to v2: do handle ENOLINK properly and reformat.

Jussi Laakkonen (2):
  vpn-provider: Implement connmand online state checking
  vpn: Refactor connect_reply() and handle NoCarrier ->  ENOLINK error

 plugins/vpn.c      |  14 +-
 vpn/vpn-provider.c | 357 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 368 insertions(+), 3 deletions(-)

-- 
2.20.1


Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F173
	for <connman@lists.linux.dev>; Tue, 17 Aug 2021 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id d9c6f5c7-ff6d-11eb-b1af-005056bdfda7;
	Tue, 17 Aug 2021 18:14:43 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] Implement connmand state monitoring to vpnd
Date: Tue, 17 Aug 2021 18:14:41 +0300
Message-Id: <20210817151443.32305-1-jussi.laakkonen@jolla.com>
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
This is handled in plugins/vpn.c similar to EINPROGRESS reply as it is not a
real VPN error, EINPROGRESS is replied in case the connection is being delayed.

Jussi Laakkonen (2):
  vpn-provider: Implement connmand online state checking
  vpn: Handle ENOLINK error in connect callback

 plugins/vpn.c      |  10 +-
 vpn/vpn-provider.c | 361 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 369 insertions(+), 2 deletions(-)

-- 
2.20.1


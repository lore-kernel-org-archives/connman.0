Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A40173
	for <connman@lists.linux.dev>; Fri, 13 Aug 2021 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4203dc0a-fc3c-11eb-b1af-005056bdfda7;
	Fri, 13 Aug 2021 16:42:10 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Improve invalid auth and disconnect notify on l2tp and pptp
Date: Fri, 13 Aug 2021 16:42:06 +0300
Message-Id: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both l2tp and pptp have the symptom that when authentication is invalid
the binary keeps on looping disconnect notify. As a solution to this the
task can be stopped to ensure that binary also dies. And to further make
the process better adapt similar connect done -approach that is used in,
e.g., OpenVPN to ensure the callback (vpn-provider.c:connect_cb()) will
get called only once.

This change makes both plugins to respond with 0 ("ok") only after the
notify from the binary is received that connection is established. Both
of the plugins did reply with 0 right after run_connect() which was not
the proper way.

Also add support for using ConnMan specific control file with xl2tpd
using -C switch. 

Jussi Laakkonen (2):
  l2tp: Improve invalid auth and disconnect notify, fix cb use
  pptp: Improve invalid auth and disconnect notify, fix cb use

Matt Vogt (1):
  l2tp: Create control file for xl2tpd

 vpn/plugins/l2tp.c | 133 +++++++++++++++++++++++++++++++--------------
 vpn/plugins/pptp.c | 127 ++++++++++++++++++++++++++++---------------
 2 files changed, 175 insertions(+), 85 deletions(-)

-- 
2.20.1


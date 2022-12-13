Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8E33FF
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6dcfcfaa-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:07 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 0/9] Add association state for VPNs
Date: Tue, 13 Dec 2022 16:06:58 +0200
Message-Id: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds the association state also for the VPNs. This state is to
indicate that the VPN is waiting for VPN agent to provide input given by user.
In this state service.c must not do connect timeout checks as the timers for
both differ in length, default being 120s for connect timeout and 300s for VPN
agent dialog timeout.

In order to facilitate this change the association state had to be implemented
also for VPNs. It is common state for services and like with services the
association state for VPNs preceeds the configuration state (on VPN side
connect state). Both vpn.c plugins on connmand and vpnd side require changes
to accommodate this state. When the VPN agent succeeds in getting the input
from the user the state transitions from association to connect (configuration)
state and, thus, requires no specific changes to VPN plugins.

On connmand side the association state is the initial state when VPN is getting
connected and the state needs to be accounted as a connecting state in
plugins/vpn.c to not to lose transport ident for it and in provider.c as a
pre-configuration state to not to start the connect timeout for the VPN before
the VPN is in configuration state. The reason for the latter is that the
connect timeout should be exact and start from the point when
connect/configuration state is entered.

On vpnd side association state is, like on connmand side, the initial state for
the VPN getting connected. After the VPN agent succeeds getting the information
from the user (credentials) the state transitions to connect (configuratioin).
There may be a possibility for a VPN plugin to run without VPN agent and thus
in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() does
the state transition in such cases. It is allowed go back to association state
from connect state but not from other states.


I'd like to raise the following issues for commenting:
a) Is this current approach sound in the way that the vpn-agent.c is
   responsible of changing the state? vpn-provider.c:connect_cb() would be
   ideal but that does get called in notify if there is no error. Processing
   the message with the vpn_agent_check_and_process_reply_error() with success
   indicates that VPN agent succeeded getting the input.

b) Can we figure out a case where the state transition from VPN plugin notify
   SHOULD change the state back to ASSOCIATION when normally in CONNECT state?
   This change is in vpn/plugins/vpn.c that accommodates transitions from
   CONNECT->ASSOCIATION.

c) Furthermore, might any of the VPN plugins available (elsewhere) work
   without accessing the VPN agent? The flow now requires to use vpn-agent.c
   for processing and state transition. However, these cases should then use
   the vpn_provider_set_state() directly, as most of the plugins now do in,
   e.g., error cases.

d) The VPN and PROVIDER states, should these be harmonized to follow the same
   structure as the common service states to avoid confusion or might this be
   risky as many of the headers are public?

e) Should the specific VPNs that do need VPN agent more than once then do the
   transition back to ASSOCIATION when the first VPN agent returns and sets the
   state to CONNECT? This is what I couldn't decide, there is another option to
   have the vpn_agent_check_and_process_reply_error() to have an additional
   parameter to state that do not transition state, but in the case of OpenVPN
   the private key, for instance, can be decrypted and the management interface
   queries the passphrase on need basis. Thus, there is no apriori information
   on this.

And of course, any other issue that may trouble your mind with these changes.

Jussi Laakkonen (9):
  agent: Cancel agent request on NoReply D-Bus error
  vpn-provider: Use association state for VPN agent input wait
  vpn: Add association state before connect state
  vpn-agent: Do connect state transition after input dialog check
  service: Explicit VPN connect timeout, ignore in VPN agent wait
  provider: Handle VPN configuration and association states
  vpn: Add support for association state, add state getter
  vpn: Check if connecting when setting state or disconnecting
  doc: Update VPN documentation for association state

 doc/vpn-connection-api.txt |  4 +--
 doc/vpn-overview.txt       |  4 ++-
 include/provider.h         |  1 +
 plugins/vpn.c              | 23 ++++++++++++++---
 src/agent.c                |  4 ++-
 src/connman.h              |  2 ++
 src/provider.c             | 22 +++++++++++++++-
 src/service.c              | 52 ++++++++++++++++++++++++++++++++++----
 vpn/plugins/vpn.c          | 29 ++++++++++++++++++++-
 vpn/plugins/vpn.h          |  1 +
 vpn/vpn-agent.c            |  6 ++++-
 vpn/vpn-provider.c         | 45 ++++++++++++++++++++++++++++++---
 vpn/vpn-provider.h         |  6 +++++
 13 files changed, 179 insertions(+), 20 deletions(-)

-- 
2.30.2


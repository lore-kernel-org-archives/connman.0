Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED83FC1
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0a2abacb-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:25 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/5] Add heurestic and customizable value for VPN auth errors
Date: Thu,  2 Sep 2021 18:11:19 +0300
Message-Id: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement heuristic for auth error counter to avoid losing credentials
because a VPN server can report back AUTH_FAILED control message
unnecessarily. This seemed to be common with OpenVPN providers that
allow only one authentication at a time from one account only and until
a short leeway-time (usually 30s) after an improper disconnect the
credentials are allowed again.

This is achieved by adding a per provider property "AuthErrorLimit" that
can be set by the user via D-Bus or by a VPN plugin. By default one (1)
auth error is allowed until credentials are re-requested (or cleared by
the VPN agent) if there was a successful connection made in the past
hour. The feature can be disabled by setting value 0 for
"AuthErrorLimit".

This was noticed to happen in a scenario where an OpenVPN is connected
over UDP or TCP (with some providers this seems to happen quite
frequently on both):
1. connect VPN over cellular with autoconnect set
2. connection is switched to WiFi and let VPN to autoconnect,
3. set cellular off and back on again (WiFi should be preferred here)
4. disconnect WiFi and let VPN to autoconnect over cellular
5. re-enable WiFi after which VPN server reports AUTH_FAILED to client
6. next connection attempt re-requests VPN creds with error set in msg.
Usually this is enough to time the network disconnects in the sense that
OpenVPN binary cannot send the disconnect message back to server having
following in the system log:
    openvpn: event_wait : Interrupted system call (code=4)
    openvpn: SIGTERM received, sending exit notification to peer
    openvpn: write UDP: Network is unreachable (code=101)
    openvpn: Closing TUN/TAP interface

As a solution each provider sets a run-time only previous_connect_time
using the monotonic boot time clock whenever the connection has been
successful. This, in conjunction with a limit for allowed authentication
errors is used to determine whether the actual authentication error count
is reported back to the VPN agent or by returning 0 attempt again with
the current credentials. After a connection has been made all errors are
cleared. If the connection abruptly goes away, e.g., the server is lost
only the conn_error_counter is increased and previous_connect_time is
cleared but this does not trigger clearing of the authentication error
and, provided the credentials are still valid, the next attempt succeeds
when the server is again reachable. Same applies for a proper
disconnect. Thus, this solution does not interfere with normal cases but
mitigates unwanted credential loss in case if the VPN server determines
connection limit being full and reports back with an authentication error
message.

OpenVPN sets this value by default to 10 unless already defined and can
be disabled by setting value zero (0). Some VPNs may not require this
option and that is why lenience of one (1) auth error is allowed by
default.

Also change to report back EALREADY in case a VPN is attempted to be
disconneced when already disconnecting. It shouldn't be treated as an
error.

Jussi Laakkonen (5):
  vpn: Report EALREADY back to caller if VPN is already disconnecting
  vpn-provider: Ignore error adding when state is idle/unknown
  vpn-provider: Add auth error check heuristic to avoid losing creds
  openvpn: Default to 10 AuthErrorLimit unless set by user
  doc: Document AuthErrorLimit in VPN connection API

 doc/vpn-connection-api.txt |  13 ++++
 plugins/vpn.c              |   3 +-
 vpn/plugins/openvpn.c      |   9 +++
 vpn/vpn-provider.c         | 125 +++++++++++++++++++++++++++++++++++++
 vpn/vpn-provider.h         |   2 +
 5 files changed, 151 insertions(+), 1 deletion(-)

-- 
2.20.1


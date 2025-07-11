Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CEB2E763B
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=YY1XSG/pUrcf4jMPZcFBZ07pJfUQhtwT0SnTRlmTxF9upFWJ/8MiBYOGJ/SpG3XrL8GsC3Q7JJBh/SjM8d8ORM+s0kotb7xOKru+BL8Q1z0jwkPH+KLr2JH9Ql+bWXwllyltGIONFWzVeB2WKeHdlYgKUeK4UdxuKOH9lbRwQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=GTuuzKku36o9Da6Crcff6Kdi67QbxEsDZDVaAPUP0QI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DTdD+9W03e1PmLD1y0gHtIg4O6nvSmBW9+xHQwiDfIIUnlOBln/RresuxTxEd3JmVTLSjzs+apyZUrdFJGV7xg29e7Q30xVsS9n22wq7Qri0Y5gacnL+5yzTlGD/KtooK6skpwn/oWa6+mtiQGmR2X9OBaWZE+MEhK8m/ChAdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=D0Toqf+L; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="D0Toqf+L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mu5Y3dfthiZ9u3fmAZhGOq0kSiFJ4f3boQ6Bs9YDtx4=; b=D0Toqf+LRjfDRIf20wH4z/1xaK
	POdZxnmwnSISq6sRr0QpO0zBHW90j/IkXURPgnzbhJihhiRkqOm9vEs7vEXfyGGNLrprbpv1OdRWb
	+axK88bpvbiR+JBBY1m7sz8UDna2A0vJvnih6e9DMqzg1kPDZM6CfpLWuPSJyY8lCdHG7GPgcfAmO
	F6NFn2VmuqGOUtlQBp1AHRrCEQ+1+3Pq14YHBt9Tzupp1TjK2FV8a8Ws7Q5l0NIG7Wuo/hv/m8ji3
	dh18sly16Sfjk26jPM9qN3W73CA5BPTMfWIp+8fngj6lO3uvhzSmlDqKgTBKGjjoPLerqH8hkjxLE
	pktSq0jg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj0-003kbq-2W
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:42 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/46] VPN association state, dual IP support and WG fixes
Date: Fri, 11 Jul 2025 17:26:51 +0300
Message-Id: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

This patch set (1) adds the association state also for the VPNs, (2) implements
dual IP support for VPNs and (3) contains fixes for Wireguard address,
especially for FQDN handling. This is a combination of all three improvements
for the sake of testing them together.

(1): association state for VPNs
The association state is to indicate that the VPN is waiting for VPN agent to
provide input given by user. In this state service.c must not do connect
timeout checks as the timers for both differ in length, default being 120s for
connect timeout and 300s for VPN agent dialog timeout.

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

(2): dual IP support for VPNs

Dual IP support for VPNs is implemented by adding an family extension that
simply uses a boolean array of 2. With this IPv4 and IPv6 can be both defined
on a VPN such as WireGuard and provider.c will setup the addresses correctly in
connmand.

(3): WireGuard fixes

This improves the WireGuard plugin and adds better error case support for the
vpn/plugins/vpn.c. This allows also to propagate the errors upward and with
other changes, allows the shutdown to follow the same process as the other
VPNs. Also fix the PrefixLength use in the WireGuard plugin by tokenizing the
host before getaddrinfo() check. One of the key fixes here is to make FQDN
work with WireGuard. Also a new option is added for using the transport
nameservers with WireGuard reresolve queries, which by default is off (false).

First, the basic saving of the WireGuard configuration is done similarly to
other plugins, as well as to what wg-quick is utilizing.

Second, the handling of errors is improved within the plugin and vpn.c as well.
This will make it possible to pass the errors upwards from the plugin  In
addition to this there is a limit for reresolve errors (5 by default) after
which WireGuard plugin dies in case the configuration is wrong, or network is
broken.

Third, the use of getaddrinfo() will block with invalid configuration when
doing the reresolve for the endpoint. This is now replaced with GResolv by
adding a wrapper for it in vpn-util.c so it can be used within VPN plugins as
well. This avoids the blocking of the non-existent address resolve that made
vpnd unresponsive for the time being, for example, disconnects did not work.

Fourth, the shutdown is now simulated in a same way other daemon utilizing VPNs
do, by calling the vpn_died() with a slight delay. This makes daemonless VPNs
work in the same way as the rest of the plugins to do the same cleanup steps.

Fifth, the host given in the configuration as an IP-address should contain 
CIDR notation but as getaddrinfo() uses inet_pton(), which is relying on the
address to not to have the notation, the host is tokenized first for this use.

Sixth, there is an option added, "WireGuard.ReresolveUseTransportDNS" that can
be set to boolean values, "true" indicating that the nameservers of the
transport are used for the DNS reresolve queries. This may become useful in
cases where user cannot affect their network setup outside their devices. By
default this option is set off, and is saved among other options.

Seventh, the FQDN server use is fixed by using the resolved IP of the server as
the gateway. The reason this broke networking was that the FQDN name was sent
to connmand "as is" and it was used as gateway, which could not be resolved
when routing packets.

Jussi Laakkonen (45):
  agent: Cancel agent request on NoReply D-Bus error
  vpn-provider: Use association state for VPN agent input wait
  vpn: Add association state before connect state
  vpn-agent: Do connect state transition after input dialog check
  service: Explicit VPN connect timeout, ignore in VPN agent wait
  provider: Handle VPN configuration and association states
  vpn: Add support for association state, add state getter
  vpn: Check if connecting when setting state or disconnecting
  vpn: Add VPN agent use callback for plugins
  vpn-provider: Transition to CONNECT state with agentless VPNs
  doc: Update VPN documentation for association state
  wireguard: Add saving of provider properties
  wireguard: Use positive errors for VPN provider connect_cb
  vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
  wireguard: Handle disconnect, error and network errors better
  gresolv: Add generic error for GResolv struct with getter
  vpn-util: Add wrappers for GResolv hostname lookup use
  wireguard: Use GResolv for DNS reresolve to avoid blocking
  vpn: Drop state changes from update_provider_state()
  wireguard: Fix shutdown, ensure one exit and set no agent is used
  vpn: Check if disconnect is implemented before calling in stop_vpn()
  wireguard: Tokenize host for getaddrinfo()
  util: Add address family set/get/reset helpers
  vpn-provider: Add support for dual-IP VPNs
  provider: Add support for dual-IP VPNs
  vpn: Add support for dual-IP VPNs
  wireguard: Support both IPv4 and IPv6 address
  inet: Expose __connman_inet_is_any_addr() for plugins to use
  wireguard: Set split routing based on AllowedIPs
  Revert "vpn: Remove unused __vpn_provider_check_routes"
  vpn-provider: Allow to add complete routes and to remove routes
  wireguard: Add routes for other than any addresses
  wireguard: Fix string list parsing and IP tunneling
  wireguard: Treat initial connect failure as unreachable host
  service: handle also EALREADY in service_connect()
  vpn-provider: Make daemonless VPNs to connect when connmand is online
  vpn: Implement getter for the flags set by the VPN
  vpn-provider: Delay connect of daemonless VPNs until connmand is
    online
  wireguard: Rework hostname resolve, split code and do not resolve IP
  vpn-util: Add wrapper for adding a namerver for GResolv
  service: Send the DNS servers of VPN's transport when VPN is ready
  vpn-provider: Add support for set/get "TransportNameservers"
  wireguard: Add option for using transport nameservers for DNS
    reresolve
  wireguard: Fix FQDN by using the resolved IP as the gateway
  provider: Add the VPN nameserver routes when connected

 Makefile.am                |   3 +-
 doc/vpn-connection-api.txt |   4 +-
 doc/vpn-overview.txt       |   7 +-
 gweb/gresolv.c             |  15 +-
 gweb/gresolv.h             |   2 +
 include/inet.h             |   1 +
 include/provider.h         |  11 +-
 plugins/vpn.c              | 149 ++++---
 src/agent.c                |   4 +-
 src/connman.h              |   2 +
 src/inet.c                 |   5 +
 src/provider.c             | 114 ++++--
 src/service.c              |  94 ++++-
 src/shared/util.c          |  40 ++
 src/shared/util.h          |  11 +
 vpn/plugins/vpn.c          | 124 ++++--
 vpn/plugins/vpn.h          |  12 +-
 vpn/plugins/wireguard.c    | 817 ++++++++++++++++++++++++++++++++-----
 vpn/vpn-agent.c            |   6 +-
 vpn/vpn-provider.c         | 316 ++++++++++++--
 vpn/vpn-provider.h         |  17 +
 vpn/vpn-util.c             |  38 ++
 vpn/vpn.h                  |  13 +
 23 files changed, 1537 insertions(+), 268 deletions(-)

-- 
2.39.5


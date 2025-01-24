Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FE1D54D8
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745219; cv=none; b=B3NRjxMUGSUflJx+DOHE8XqTAqh3MiKoj0yVc2I5O65na9+y4QGESYbhB5drlOHFoObD/ZmBPWSDj0V/SqHA69ISy5XtQ7y66E8LDc7F8f1MWm3nVaAAnJhT2+ZPdYgpnIPDoh2GQ1p3RGEwwekGYgxcMvvkfXulzAJasnkJ3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745219; c=relaxed/simple;
	bh=Yz2+OO2hHu8wJC9qBndgpFhETWCjwPa2yuClZN1omvs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iHCSg9CU/coakAb8ITm/jC8T2uSOHF6tfDSl3q4kyVG5G4XuwQhxtjU4lNuwPmY4HBJd/nVER1DXRiLHVPb2kLm3HoBm5E8ytS4oBYcRm1THQTSEuBf55uk7RO3k6RUkFfluiYlM3QBfsuCYt7nuHH0FG4/41A4PTydbJ5ejYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=A+KhTpPk; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="A+KhTpPk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=acpKMMEgQPYb2kdkXxtAjFl3jbSCoN/h2Q8/ij0Y1Hc=; b=A+KhTpPkK9czNclRdNvabiMxrr
	JzX6iyIzICYerXX6g/5DplEzWEt9OrqqlQOgkUlPUH3VxLYG4v/UGVyTJ1z1L+6xP3brpqZsqBnI3
	tLyXRmS2k+ZNbOj0MeVJd9lfT4QEJOzuzgbiHuGRrz1iGrBV98t1JBPPCSmocLnh7+PfJ2xOA25Fm
	ExfyS3CPkDqSkIOWSZombkGKSgRWTPwLk5yf5m4xk2pmYquDpWfcGb8OTvemhSybERsKKssNTAJU/
	rpalOy67WfSBHOZ+U7ILYBdoIjDCclBuwgruciZVfqpSCYxcveh9+tcaitzUEG8X+eQnni3d4kMT2
	Llkwa4Gw==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-1a
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/11] Add association state for VPNs
Date: Fri, 24 Jan 2025 20:58:34 +0200
Message-Id: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

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

Jussi Laakkonen (11):
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

 doc/vpn-connection-api.txt |  4 +--
 doc/vpn-overview.txt       |  7 ++++-
 include/provider.h         |  9 +++---
 plugins/vpn.c              | 23 ++++++++++++---
 src/agent.c                |  4 ++-
 src/connman.h              |  2 ++
 src/provider.c             | 22 ++++++++++++++-
 src/service.c              | 52 ++++++++++++++++++++++++++++++----
 vpn/plugins/vpn.c          | 44 ++++++++++++++++++++++++++++-
 vpn/plugins/vpn.h          | 12 ++++----
 vpn/vpn-agent.c            |  6 +++-
 vpn/vpn-provider.c         | 58 ++++++++++++++++++++++++++++++++++----
 vpn/vpn-provider.h         |  7 +++++
 13 files changed, 220 insertions(+), 30 deletions(-)

-- 
2.39.5


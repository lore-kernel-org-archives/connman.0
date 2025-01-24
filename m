Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925122248B2
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=Acgh+8ic70L9QhnWrc07F7rTXtW/jHDKBBCDa6cVzMfeVRtCuin3kRza+7IlLV27fyu1AeXrKzLqTqEC7WgZlXHhEuBJfeWPeRhaUt5agLPhSfitkRp8xSYENjCeWRONQR+BeUAkcNqgTKTmyh7G9f2GY4zQedYnr8R3blFflWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=cnWOA+U4uZGHQeR8zBVepF7z1KHUapV1eRFvEhGcjvo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=spv5PXiwfS4Gx6UoMskCi0rKIsD7jdteSHuhZRP7h/LU3hbv01+K2czuxY5Y0Ei1DN0/OGbcg7cvszLSpUFGZdDpyeS5tFCWP29Dub0hJohgy+jdqJ1pqtLqCGlTczIFH5/kSPD1UULOA+4s/NBT/WFSbepVRpqz7h5kLunrhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Gcwm/mJB; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Gcwm/mJB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BriK0TrSecEhPZNiuC1ssx/OFqF3qxqBI6Zj+rzJ1ps=; b=Gcwm/mJBoZdiRQ0VoK4+4FPYja
	mcMTjbVvJ7fzonITGdJYWHoDPvdRPl7KxFlivZxOHeOUufa3YQ5lKDSimS1vKcwvaxMkwimX2J+cd
	zzNKW6b1XnMFKhAwI/iFL6UqHHqY2sLDM/xyJ2gXGi7GMbNLTDyD5QSUpomb9CWXDeovGYDXiVMU9
	4T26rZ1W9roudjUmPHmdEXY3n/v8ZRKBAzZUhgg1vfKEBdxEr+MTWKFAoVIZAHFzQ8Zw4ZedLDPPZ
	MOndEIpyDzw+5QzC8wYP2JDJVjWFJFw3dInsPznpL2ux7myHY0TfeMjCAvzvrf0tlAd2lB/6MbJOF
	NdJDSkgA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-1t
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/12] Improve WireGuard disconnect, error and hostname lookup
Date: Fri, 24 Jan 2025 20:59:04 +0200
Message-Id: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
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

This set of patches improves the WireGuard plugin and adds better error case
support for the vpn/plugins/vpn.c. This allows also to propagate the errors
upward and with other changes, allows the shutdown to follow the same process
as the other VPNs. Alsom fix the PrefixLength use in connmand and in the
WireGuard plugin by tokenizing the host before getaddrinfo() check.

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


Jussi Laakkonen (12):
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
  vpn: Fix extracting of PrefixLength D-Bus value
  wireguard: Tokenize host for getaddrinfo()

 gweb/gresolv.c          |  15 +-
 gweb/gresolv.h          |   2 +
 plugins/vpn.c           |   5 +-
 vpn/plugins/vpn.c       |  63 +++---
 vpn/plugins/wireguard.c | 430 +++++++++++++++++++++++++++++++++++-----
 vpn/vpn-util.c          |  30 +++
 vpn/vpn.h               |  10 +
 7 files changed, 476 insertions(+), 79 deletions(-)

-- 
2.39.5


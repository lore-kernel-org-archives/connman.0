Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540908;
	b=SyNlaIDZtHwRDK68n7zUz+p8C2cps73cvl1X0b+JcKX/+rhXpzS8udRkUR+bTOvea/dJ
	 2LIr7rdjG1ms4S6GLmpqYVmifyKny6il6zN22vn5+9LuiWOXCef9/sSs2myIHIdKWkbOT
	 BWnHkEVPVrStZt+LgNsS93C4mslX8DYwspbqWisagEAb++J+qMNqL210dqAZoH63FKHHu
	 2wLawigfIp1RvFWdmPHZhPJREc4cvZMzmrg3tkCYPjNXsZYJCZM9xGcsAyrmmptbFppJJ
	 nn65LGZySK7EesaRjCGr0pCUnrf741QSLwyP6aBfV0pr8HrQ1fBWmJNKEK1O7km+vTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540908;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=Ur0jflhBs8Vc2Zu0+skbmKpn/JLd4kMPh6XZhDQKIX8=;
	b=Rmupkb2cp+EbEwpQnK1SVQvFenh7YZEYwaqAL5KSkv7Xl/T+ywKYBeneFUiGytTPBDry
	 ooJuv1JeQ2XRSvwgJvTXhtA1f2J2qMIDfTBJmecC//UT7+amN9J9sry8hJacgWo61Lh8K
	 WPpDTr9OOgr9NnD0QxUGkgDsYxANwRHnJfti+vJ0sUMbz6WVf6mZTW+Da0kTIcNMK9nH8
	 WWu5go6loQW1qOcMtgoKXU2C6Yh2CYLVE/p+Vd5e2BmY0pX9I6kf4Yhsw+OjijEbOFWcC
	 /Nbw4blfFzcvHvUKr80EoNpYjRygMLJNCQzPZUfF0jGkxC37bPNSbdO9k0vJSj/j8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=JAGm5XRR;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D07606A88D
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D07606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=JAGm5XRR
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 26BDF160279;
	Thu, 12 Nov 2026 22:35:06 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BA177124C53;
	Thu, 12 Nov 2026 22:35:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] Keep link-local-only services from displacing the default
Date: Thu, 12 Nov 2026 19:35:00 -0800
Message-ID: <20261113033504.1828738-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Ur0jflhBs8Vc2Zu0+skbmKpn/JLd4kMPh6XZhDQKIX8=; b=JAGm5XRRl8/XXGKeEvJMYkYTQ15hDyTd6ySX5N8WTbv05GBMvJyp9sxS0MSyDmGOLbD3WB5p4rJWVwaX3e0XwQI6VnZ85ILWxxdZ2cr0pekEUSxY1JNUF/xQIl/oTrbj3gwKkKw4lxsY/Qt1/up5+CQmJTzU1EYF4obt8V5Prxht6oz+SmPGIlyyiPEc+z0SiP39Yhi/WW+NWTfT+qhbQjVabSezlRjyO0rRcnnXAwdF8kXOOCTYwD3bnbhfxLsX0opH6DEIwGoCLnfNkUmThxlT/yL+WeEN9+paJyvyFsAvXi66BXXvT07/k6OC3Fy/5oGpIZQxNcsZGTGvxJ4TVw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When DHCP gets no lease, connman falls back to IPv4 link-local
addressing and the service becomes "ready" with a "default dev
<interface> scope link" route and no gateway. Ethernet cabled directly
to a phone or laptop, or to a switch with nothing else on it, ends up
this way. It reaches only its own link and never passes an online
check.

With PreferredTechnologies listing ethernet first, such a service
outranks an "online" Wi-Fi or cellular service: 'service_compare' and
'service_update_preferred_order' consult PreferredTechnologies before
online-over-ready. Ethernet takes the default route, Wi-Fi is demoted
to "ready", and only Ethernet is online checked. The system is offline
until Ethernet meets the online check failures threshold, every time
such a cable is plugged in, and at every start with one plugged in.

This series ranks a service connected only by link-local addressing
below any connected service that can reach beyond its link, whatever
its technology, in both places. For IPv4 that means connected with the
"auto" (IPv4 link-local) method; for IPv6 it means not connected, since
connman drops IPv6 link-local addresses as they arrive and becomes
"ready" for IPv6 only with some other address. It also re-sorts when a
connected service gains or loses that reach with no change in its
state, as when a DHCP server later appears on the link of a
link-local-only Ethernet service. A link-local-only service alone is
still the default, as before.

The IPv4 test keys on the method, not on the gateway address, because
point-to-point links such as many cellular bearers have no gateway
either but reach beyond their link.

Note: This adds a new log entry: "Interface <name> [ <type> ] is now
link-local only" and "... is no longer link-local only" once per
change.

Grant Erickson (4):
  service: Rank link-local-only services below others in
    'service_compare'
  service: Rank link-local-only services below others when reordering
  service: Re-sort when a connected service's link-local-only state
    changes
  doc: Describe link-local-only services under PreferredTechnologies

 doc/connman.conf.5.in |   7 +-
 src/service.c         | 276 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 276 insertions(+), 7 deletions(-)

-- 
2.52.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540908;
	b=HmWsODwK9ka2m0Ies3bKH5fL0Sbrd78MZpQRTPb3ZuoUKIC2k2Wj7X2tMIYTCe6QTXFm
	 /DVZzxdP/+3jczokB1j/JTLtxDIaPfQwz6YLlja7Z+K4KM/lo9iYd44KrLX+xo+iMHDZP
	 htoDX/SOSOO44bjSdvMaHaWZYwm5JcccZBOazsyjZiTxoDB3iZRS4qhVQNKbXrf1BtYdk
	 BjsgLP7tSgLh25Yj85yE5nCeYn2S7r09CPFZTTntDk1fp0d4IxfkRJPc58O7VIA9Vi0mv
	 KZ+so17IUXDPOcRcWCaRmjoE6zs6+mldvl1JfE6l7fDsI0tTwJaqL95gBAbUF9J00KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540908;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=4pKRUOhas3lQ85JZCmbWXI2nruhrx9eyh4sqkSScfu8=;
	b=D0/lxmVfwyogxrUs5WqTSf1EkI8CnZuvwSDcI9WUiq3R1dL5ezmm5UehmmNcE37rrHgd
	 FNPvRLlSngEuf3rQKdaK8i1vsa3zKTxN5MKCqMWkWffeXkRwYk8jMqVFJn9IO1ViSp2kN
	 daHsLFdav33xz5O5faqTgcEl+mIWv/1URTWdNGUJf66c05Fjnu6H+L+St3nBd+bh2vjE7
	 nSX0Xf8D+Ru0SlGMRU1uh3z3KylBKJ208raD9rotA2upcQcTk2ww/sfbMHmp+/Umw1mMb
	 gjnx0R4i0WjEeTrxdY++k6s5bXzfuv6OA9BLF9pV2dDWDd4JzEi6YZVY3c9Fa5CSHAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b="o/hzI4bo";
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD7606A88C
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CD7606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=o/hzI4bo
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A6201160285;
	Thu, 12 Nov 2026 22:35:06 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 48C6F124B8D;
	Thu, 12 Nov 2026 22:35:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/4] service: Rank link-local-only services below others in 'service_compare'
Date: Thu, 12 Nov 2026 19:35:01 -0800
Message-ID: <20261113033504.1828738-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261113033504.1828738-1-gerickson@nuovations.com>
References: <20261113033504.1828738-1-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=4pKRUOhas3lQ85JZCmbWXI2nruhrx9eyh4sqkSScfu8=; b=o/hzI4boRlGcCp4FIjipd+09oJlqWMhrKUR/6i3FvkAKMwtZVF2Rt6MxoTbEfLj+JJmJh+OkjSnrbizvqMyavV/wLik/SCCNbFg8xfr444pJH9n8RxU1kyl+7pzAFBdcF+WO67QA9phMmBMrt6YPWLEikePnQOHLVbFr8aKCgtNibkYsrYsyHlr1yHcHmmKXEkQ//Kw1/F4DOe9rBmdg4owL0sInLw6CVBgynTuywuErwTMdGK7y6Jwsr5cshbxAwbQnOek726LCmInvokxwQabOjlP6uivo3Uj23P92B6E3kx61WwhpLeVB0VTsMTVIJPDP23AamX2buEekRJ8z7Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When DHCP gets no lease, connman falls back to IPv4 link-local
addressing (RFC 3927) and the service still becomes "ready", with a
"default dev <interface> scope link" route and no gateway. Such a
service, for example Ethernet cabled directly to a phone or laptop, or
to a switch with nothing else on it, reaches only the hosts on its own
link and can never pass an online check.

However, when both services are connected, 'service_compare' ranks by
service order and the PreferredTechnologies list before preferring
"online" over "ready". With the common PreferredTechnologies of
ethernet before wifi and cellular, a "ready" link-local Ethernet
service therefore sorts before an "online" Wi-Fi or cellular service,
takes the default route, and is the only service online checked. The
system is offline until that service meets the online check
failures threshold, and back offline each time the cable is plugged
in.

Add 'is_link_local_only', true for a connected service with neither an
IPv4 nor an IPv6 configuration other than link-local addressing, built
on one test per family:

  - 'has_non_link_local_ipv4': connected for IPv4 with a method other
    than "auto". connman assigns an IPv4 link-local address itself,
    with the "auto" method, and indicates IPv4 "ready" with it, so the
    method is what tells it apart.

  - 'has_non_link_local_ipv6': connected for IPv6. 'process_newaddr'
    drops IPv6 link-local (fe80::/10) addresses, which every IPv6
    interface always has, so they never reach the IP configuration;
    IPv6 becomes "ready" only with some other address.

Add 'service_compare_link_local_only', which ranks a service that can
reach beyond its own link before one that cannot, and apply it in
'service_compare' for two connected services after the online check
failures threshold, VPN and order comparisons, immediately ahead of
the PreferredTechnologies comparison it corrects. The VPN comparison
recurses into 'service_compare' for the VPN's transport, so the rule
applies to it there too.

The IPv4 test keys on the configuration method rather than on the
gateway address: a point-to-point link, such as many cellular bearers,
has no gateway either, but it reaches beyond its link. A service
connected only by link-local addressing is still ranked first, and so
is the default, when no other service is connected.
---
 src/service.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/src/service.c b/src/service.c
index d5869b1471dc..2348b65663af 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1143,6 +1143,92 @@ static bool is_online(enum connman_service_state state)
 	return state == CONNMAN_SERVICE_STATE_ONLINE;
 }
 
+/**
+ *  @brief
+ *    Determine whether a network service has an IPv4 configuration
+ *    other than IPv4 link-local addressing.
+ *
+ *  This determines whether the specified network service is connected
+ *  for IPv4 with a configuration method other than "auto". For IPv4,
+ *  "auto" is IPv4 link-local (RFC 3927) addressing, to which DHCP
+ *  falls back when no lease is available. connman assigns that
+ *  address itself and indicates the IPv4 configuration "ready" with
+ *  it, so the method is what tells it apart.
+ *
+ *  @param[in]  service  A pointer to the immutable service to check.
+ *
+ *  @returns
+ *    True if @a service is connected for IPv4 with a configuration
+ *    method other than "auto"; otherwise, false.
+ *
+ */
+static bool has_non_link_local_ipv4(const struct connman_service *service)
+{
+	return is_connected(service->state_ipv4) &&
+		__connman_ipconfig_get_method(service->ipconfig_ipv4) !=
+					CONNMAN_IPCONFIG_METHOD_AUTO;
+}
+
+/**
+ *  @brief
+ *    Determine whether a network service has an IPv6 configuration
+ *    other than IPv6 link-local addressing.
+ *
+ *  This determines whether the specified network service is connected
+ *  for IPv6. Every IPv6 interface always has an IPv6 link-local
+ *  (fe80::/10) address, but connman never counts one: the routing
+ *  netlink new address handler drops IPv6 link-local addresses, so
+ *  they never reach the IP configuration, and the IPv6 configuration
+ *  becomes "ready" only with some other address (from router
+ *  advertisement, DHCPv6 or manual configuration). Being connected
+ *  for IPv6 therefore already implies a non-link-local address.
+ *
+ *  @param[in]  service  A pointer to the immutable service to check.
+ *
+ *  @returns
+ *    True if @a service is connected for IPv6; otherwise, false.
+ *
+ */
+static bool has_non_link_local_ipv6(const struct connman_service *service)
+{
+	return is_connected(service->state_ipv6);
+}
+
+/**
+ *  @brief
+ *    Determine whether a network service is connected only by
+ *    link-local addressing.
+ *
+ *  This determines whether the specified network service is connected,
+ *  yet has neither an IPv4 nor an IPv6 configuration other than
+ *  link-local addressing.
+ *
+ *  Such a service, for example Ethernet cabled directly to a phone or
+ *  laptop, or to a switch with no DHCP server or IPv6 router behind
+ *  it, reaches only the hosts on its own link. Its default route,
+ *  "default dev <interface> scope link", leads to no gateway.
+ *
+ *  @param[in]  service  A pointer to the immutable service to check.
+ *
+ *  @returns
+ *    True if @a service is connected for IPv4 or IPv6 but has no
+ *    configuration of either other than link-local addressing;
+ *    otherwise, false.
+ *
+ *  @sa has_non_link_local_ipv4
+ *  @sa has_non_link_local_ipv6
+ *
+ */
+static bool is_link_local_only(const struct connman_service *service)
+{
+	if (!is_connected(service->state_ipv4) &&
+			!is_connected(service->state_ipv6))
+		return false;
+
+	return !has_non_link_local_ipv4(service) &&
+		!has_non_link_local_ipv6(service);
+}
+
 static bool is_idle(enum connman_service_state state)
 {
 	switch (state) {
@@ -8283,6 +8369,45 @@ static gint service_compare_vpn(const struct connman_service *a,
 	return service_compare(transport, service);
 }
 
+/**
+ *  @brief
+ *    Compare two network services by whether each is connected only
+ *    by link-local addressing.
+ *
+ *  This compares the two specified network services by whether each
+ *  is connected only by link-local addressing, giving priority to the
+ *  service that can reach beyond its own link.
+ *
+ *  @param[in]  service_a  A pointer to the first immutable service
+ *                         to compare.
+ *  @param[in]  service_b  A pointer to the second immutable service
+ *                         to compare.
+ *
+ *  @retval   0  If both or neither of the services are connected only
+ *               by link-local addressing.
+ *  @retval  -1  If only @a service_b is connected only by link-local
+ *               addressing and @a service_a should sort @b before
+ *               @a service_b.
+ *  @retval   1  If only @a service_a is connected only by link-local
+ *               addressing and @a service_b should sort @b before
+ *               @a service_a.
+ *
+ *  @sa is_link_local_only
+ *
+ */
+static gint service_compare_link_local_only(
+					const struct connman_service *service_a,
+					const struct connman_service *service_b)
+{
+	const bool a_link_local_only = is_link_local_only(service_a);
+	const bool b_link_local_only = is_link_local_only(service_b);
+
+	if (a_link_local_only == b_link_local_only)
+		return 0;
+
+	return a_link_local_only ? 1 : -1;
+}
+
 /**
  *  @brief
  *    Compare two network services against the @a
@@ -8352,6 +8477,7 @@ static gint service_compare_preferred(const struct connman_service *service_a,
  *  @retval  < 0  If service @a a should sort @b before service @a b.
  *  @retval  > 0  If service @a b should sort @b before service @a a.
  *
+ *  @sa service_compare_link_local_only
  *  @sa service_compare_preferred
  *  @sa __connman_service_compare
  *
@@ -8409,6 +8535,17 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 		if (service_a->order < service_b->order)
 			return 1;
 
+		/*
+		 * If at this point the services are still comparing as
+		 * equivalent, then give priority to the service that can
+		 * reach beyond its own link over one connected only by
+		 * link-local addressing, ahead of the PreferredTechnologies
+		 * priority list.
+		 */
+		rval = service_compare_link_local_only(service_a, service_b);
+		if (rval)
+			return rval;
+
 		rval = service_compare_preferred(service_a, service_b);
 		if (rval)
 			return rval;
-- 
2.52.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540908;
	b=3I3x3Ps3tEBB+rJcVQVD3o8wxe/A/Qn2vJFRAstwIxSDLX/r0k9B3unREeVDF5OYVCi5
	 r+pEwH6FDW5PiKesIJUP4vRjAVFw6XNiWWSrGNb+Csfwb0uxhWO4uP6QlihVbn4yeK4j8
	 fD/t5Cyegt2pWhXt3W29XWtBvg/sx6nbb1DoHYZnfIdT/IUp6B73pq1JI7q21By25bdLH
	 SNsbR5aFO4u1xSDWWKX5usBjXnXc7yGXOI/xHesbJSRzDGiszIzgRL4k/fICoGRhIAxQ5
	 sxoIgiEjJIYmE99b7Jzsq0J8LpdmjXfT9ao4Ii3rQ1Xkwqa7WshyIgEzlJvns4ZV3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540908;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=vtHWPmgglYO1XX1j7LbugoPAMyfR/hfiMt3GFPnvC0w=;
	b=NwktN8cTCAcsFInuYzXDnUB6lmKL4CWR4t5wX8TMphwi3eBGouOoeeKchIkaodPLqfJ9
	 LXxBWBCrpbvZjnKgRdPL/DwVkLuPzuxIYNNACX+oQVmEQ2KKtRCG6xFgUvcKLSheMw1mt
	 2+gwAEXyFoOUlE72uwpikUELdaU7r1R/8B4zls5TeTKf9UvYNmhdNkGWCRDCcvyzknNfM
	 V7i/h4eGNgIGHGricBn7sxR1FtAh7gXCGIXasqPWRZDJy4jV46VNA0XyXk3SzRyn0+sYQ
	 JbAVwgJA1yEPf8ms0vxx8kLs/Yr4HEDEqYeqE+v8vO272A+R1yTkt8H1VG4Wazbm+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=W3GPX24I;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FD606A890
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9FD606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=W3GPX24I
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B5F7E1602D4;
	Thu, 12 Nov 2026 22:35:07 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 59415124C62;
	Thu, 12 Nov 2026 22:35:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] service: Re-sort when a connected service's link-local-only state changes
Date: Thu, 12 Nov 2026 19:35:03 -0800
Message-ID: <20261113033504.1828738-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261113033504.1828738-3-gerickson@nuovations.com>
References: <20261113033504.1828738-1-gerickson@nuovations.com>
 <20261113033504.1828738-2-gerickson@nuovations.com>
 <20261113033504.1828738-3-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=vtHWPmgglYO1XX1j7LbugoPAMyfR/hfiMt3GFPnvC0w=; b=W3GPX24Ii0aJ8LkOAis/I040Uvxnu/FtEgvTRavtbUvYpNMrWrlhqAUsFxnnKk5Fpio+we4khINPTUPqZA1YuJ4Jsp1CIxfN6pgUlYPJEGbeLik085d3ywwYAEncV5KozGXANyn6Lb4nL0u+j2sMmtHsz4qlZaIOY4kaDheVIEgsZ7VtkWFb31JiuEFKXIG01wrcde078XjRfbq6wEtasgqB/dMW0D42w+HWApGlEjAWnLboP5wj5/S7NRwuSmXzMVVf/z/37tHCFcvBdZcCGXJVs+hQW9H8fbBqtR7m/Aml4yVQ1ulawvTCP4QnfaSYfX0FU8dhEW6PPew0CoaWeg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

A connected service can become, or stop being, connected only by IPv4
link-local addressing without a change in its combined state, so
without passing through 'service_indicate_state' and the reordering it
does on becoming "ready":

  - An Ethernet service that fell back to IPv4 link-local addressing
    stays "ready" when a DHCP server later appears on its link (an
    unmanaged switch that gets a router plugged in, for example).
    'lease_available_cb' moves the IPv4 method back to "dhcp" and the
    new gateway is added, but '__connman_service_ipconfig_indicate_state'
    sees "ready" again and returns -EALREADY.

  - A service whose lease is lost falls back to IPv4 link-local
    addressing while staying "ready".

  - IPv6 can become connected next to IPv4 link-local addressing,
    leaving the combined state "ready".

Now that 'service_compare' ranks link-local-only services below the
others, each of these leaves the service list and the default service
stale. In the first, the most likely, a link-local-only Ethernet
service is never the default and so is never online checked; once its
lease arrives, nothing re-ranks it, and it stays behind Wi-Fi or
cellular despite PreferredTechnologies.

Track whether each service is connected only by link-local
addressing, setting it whenever the combined state changes and logging
each change while connected:

    Interface eth0 [ ethernet ] is now link-local only
    Interface eth0 [ ethernet ] is no longer link-local only

When an IP configuration state indication for a connected service
leaves the combined state unchanged but the tracked state changed,
re-sort the service list, update the gateways, and signal the default
service, as becoming "ready" does. The service ranked first then gets
the high-priority default route, is signaled as the default, and is
online checked.
---
 src/service.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index d566fcaa6019..d0b03cc133a1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -219,6 +219,13 @@ struct connman_service {
      *  "continuous" online check mode.
      */
 	bool online_check_failures_met_threshold;
+
+    /**
+     *  Tracks whether the service, while connected, is connected only
+     *  by link-local addressing. This is false while the service is
+     *  not connected.
+     */
+	bool link_local_only;
 	bool do_split_routing;
 	bool new_service;
 	bool hidden_service;
@@ -9381,6 +9388,93 @@ static const char *get_dbus_sender(struct connman_service *service)
 	return dbus_message_get_sender(service->pending);
 }
 
+/**
+ *  @brief
+ *    Update whether a network service is connected only by
+ *    link-local addressing.
+ *
+ *  This updates the tracked state of whether the specified network
+ *  service is connected only by link-local addressing and, if the
+ *  service is connected and that state changed, logs it.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for
+ *                           which to update the tracked state.
+ *
+ *  @returns
+ *    True if the tracked state changed; otherwise, false.
+ *
+ *  @sa is_link_local_only
+ *
+ */
+static bool service_update_link_local_only(struct connman_service *service)
+{
+	g_autofree char *interface = NULL;
+	bool link_local_only;
+
+	link_local_only = is_connected(service->state) &&
+				is_link_local_only(service);
+
+	if (link_local_only == service->link_local_only)
+		return false;
+
+	service->link_local_only = link_local_only;
+
+	if (is_connected(service->state)) {
+		interface = connman_service_get_interface(service);
+
+		connman_info("Interface %s [ %s ] is %s link-local only",
+			interface,
+			__connman_service_type2string(service->type),
+			link_local_only ? "now" : "no longer");
+	}
+
+	return true;
+}
+
+/**
+ *  @brief
+ *    Re-sort the network services if a connected network service
+ *    became, or stopped being, connected only by link-local
+ *    addressing.
+ *
+ *  A connected service can become, or stop being, connected only by
+ *  link-local addressing with no change in its combined state. For
+ *  example, an Ethernet service that fell back to IPv4 link-local
+ *  addressing stays "ready" when a DHCP lease later arrives or when
+ *  IPv6 becomes connected, and a service that loses its lease falls
+ *  back to IPv4 link-local addressing while staying "ready".
+ *
+ *  Because #service_compare ranks such a service below the others,
+ *  the network service list and the default service may then be
+ *  stale. If so, this re-sorts the network service list and updates
+ *  the gateways, so that the service now first gets the high-priority
+ *  default route, is signaled as the default service, and is online
+ *  checked.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service that
+ *                           may have become, or stopped being,
+ *                           connected only by link-local
+ *                           addressing.
+ *
+ *  @sa service_update_link_local_only
+ *
+ */
+static void service_resort_if_link_local_only_changed(
+					struct connman_service *service)
+{
+	if (!service_update_link_local_only(service))
+		return;
+
+	if (!is_connected(service->state))
+		return;
+
+	SERVICE_LIST_SORT();
+
+	__connman_gateway_update();
+
+	DEFAULT_CHANGED();
+}
+
 static int service_indicate_state(struct connman_service *service)
 {
 	enum connman_service_state old_state, new_state;
@@ -9423,6 +9517,8 @@ static int service_indicate_state(struct connman_service *service)
 	service->state = new_state;
 	state_changed(service);
 
+	service_update_link_local_only(service);
+
 	if (!is_connected(old_state) && is_connected(new_state))
 		searchdomain_add_all(service);
 
@@ -9742,6 +9838,7 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 	struct connman_ipconfig *ipconfig = NULL;
 	enum connman_service_state old_state;
 	enum connman_ipconfig_method method;
+	int err;
 
 	if (!service)
 		return -EINVAL;
@@ -9787,9 +9884,16 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 
 	}
 
-	/* Any change? */
-	if (old_state == new_state)
+	/*
+	 * Any change? If not, the IP configuration may still have
+	 * changed, for example from IPv4 link-local addressing to a DHCP
+	 * lease, so re-sort if that changed the service's reach.
+	 */
+	if (old_state == new_state) {
+		service_resort_if_link_local_only_changed(service);
+
 		return -EALREADY;
+	}
 
 	DBG("service %p (%s) type %d (%s) old state %d (%s) new state %d (%s)",
 		service, connman_service_get_identifier(service),
@@ -9860,7 +9964,17 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 				CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
 	}
 
-	return service_indicate_state(service);
+	/*
+	 * If the combined service state is unchanged, a change in this
+	 * IP configuration type's state may still have changed the
+	 * service's reach, for example IPv6 becoming connected next to
+	 * IPv4 link-local addressing, so re-sort if so.
+	 */
+	err = service_indicate_state(service);
+	if (err == -EALREADY)
+		service_resort_if_link_local_only_changed(service);
+
+	return err;
 }
 
 static bool prepare_network(struct connman_service *service)
-- 
2.52.0


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990930EF63
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432359; cv=none; b=eRcBtiTEBwxTnIKBH9UKG1znfhST8IbTssVP5TNZqgXOG6yomb2D75Wcy3oe7bVbhN0nWCKPuQIpfqGQMdDq7vvE0rzMJ7hDaQFhsF3FSvu/gDHm6cpcW8YZFNzReX8SEvDmrnbgsawezj1aCQj4tIqZqdeDM11P1X2LZTRD9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432359; c=relaxed/simple;
	bh=pIrPBgTZXdBl6SiCAHcVj0s/5lrINLx+ZM1pA+yLJoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RLl4EhjtiM8cU7XSOu/zsi7/cXXjY1Eq4wQnXW7IFjtkZmQ7Swo1iwmzCC9ca+TjXsWnAGPUJnms3WFZiBzBzHHb2F4hJPiRUKmXwzICRA+8Ro00fUpLWWtHLoYYsmHUJeDEW/AvmP+JajeK/GufYyuXHSdVDLupz9Ujc/b7fzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=rcsscOf+; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="rcsscOf+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w4OrpxzduWLqF6eZDr0ofrHlrjgluDDVHO1gWgFQEN8=; b=rcsscOf+Xb5JZ0v+6GykFMWLsk
	PfZmNdZWaWAYWWxPUfm+PAmGoTitl7QX894UeOLY2CdMWcMIGWUAZht+83FCK6TLLoyi5AqDrEZrX
	hBcbBmWgRRMZthPlb0n+lmy9sPhc9A83XHTvKpPk4xuOa/MYNqfHvqLWPETIrZsmaiKkWuudRQSu1
	kA8XIkhuCm2JvcZJFOZjpsr3juuk7lBRuCR28jMtObejAM5YKj3309Fs0cAtSqoNAMEFH6Ewz8CDO
	Mou+XchJdKwBdHd4t/y2jzBD5q7oFMBL43QC/p0vhM3lxNrkGcbyuyXXuUw7xEw7Hz61yIyf6CJoL
	YZEUb7Zw==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMBV-00Brql-0x
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 14:59:13 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2] systemd-resolved: Use DNS servers of the default service
Date: Mon, 26 Jan 2026 14:59:00 +0200
Message-ID: <20260126125906.37683-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Register to get the notifies about the default service, service state
and offline mode changes. When default service changes set it as
default route in resolved, revert other links' status and flush the cache
so only the default service's DNSs are used. This brings the similar
behavior that is is in dnsproxy.c, and prevents leaking of DNS queries
outside VPNs as well. Thus, effectively making only the DNS servers of
the default online service to be used.

To ensure that the servers are gone the domains and servers lists are
cleared when the service is disconnecting. The current default index is
being tracked and when it is being reset, the cache will be flushed as
well.

---
Changes since v2:
 - Send the correct patch file without the internal bug reference.

 src/dns-systemd-resolved.c | 340 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 3 deletions(-)

diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
index 912ab3fe..9dd0328c 100644
--- a/src/dns-systemd-resolved.c
+++ b/src/dns-systemd-resolved.c
@@ -36,7 +36,7 @@
 #define SYSTEMD_RESOLVED_SERVICE "org.freedesktop.resolve1"
 #define SYSTEMD_RESOLVED_PATH "/org/freedesktop/resolve1"
 
-struct mdns_data {
+struct resolved_dbus_data {
 	int index;
 	bool enabled;
 };
@@ -48,6 +48,7 @@ static GDBusProxy *resolved_proxy;
 
 /* update after a full set of instructions has been received */
 static guint update_interfaces_source;
+static gint current_default_index = -1;
 
 struct dns_interface {
 	GList *domains;
@@ -55,6 +56,7 @@ struct dns_interface {
 	int index;
 	bool needs_domain_update;
 	bool needs_server_update;
+	bool enabled;
 };
 
 static gboolean compare_index(gconstpointer a, gconstpointer b)
@@ -405,7 +407,7 @@ static int setup_resolved(void)
 }
 
 static void setlinkmulticastdns_append(DBusMessageIter *iter, void *user_data) {
-	struct mdns_data *data = user_data;
+	struct resolved_dbus_data *data = user_data;
 	char *val = "no";
 
 	if (data->enabled)
@@ -419,7 +421,7 @@ static void setlinkmulticastdns_append(DBusMessageIter *iter, void *user_data) {
 
 int __connman_dnsproxy_set_mdns(int index, bool enabled)
 {
-	struct mdns_data data = { .index = index, .enabled = enabled };
+	struct resolved_dbus_data data = { .index = index, .enabled = enabled };
 
 	if (!resolved_proxy)
 		return -ENOENT;
@@ -434,6 +436,332 @@ int __connman_dnsproxy_set_mdns(int index, bool enabled)
 	return 0;
 }
 
+static void setlinkdefaultroute_append(DBusMessageIter *iter, void *user_data)
+{
+	struct resolved_dbus_data *data = user_data;
+	dbus_bool_t val = data->enabled;
+
+	DBG("SetLinkDefaultRoute: %d/%s", data->index, val ? "yes" : "no");
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT32, &data->index);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+}
+
+static int resolved_set_default_route(int index, bool enabled)
+{
+	struct resolved_dbus_data data = { .index = index, .enabled = enabled };
+
+	if (!resolved_proxy)
+		return -ENOENT;
+
+	if (index < 0)
+		return -ENODEV;
+
+	if (!g_dbus_proxy_method_call(resolved_proxy, "SetLinkDefaultRoute",
+			setlinkdefaultroute_append, NULL, &data, NULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int resolved_flush_cache()
+{
+	DBG("");
+
+	if (!resolved_proxy)
+		return -ENOENT;
+
+	if (!g_dbus_proxy_method_call(resolved_proxy, "FlushCaches",
+			NULL, NULL, NULL, NULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void setrevertlink_append(DBusMessageIter *iter, void *user_data)
+{
+	int index = GPOINTER_TO_INT(user_data);
+
+	DBG("RevertLink: %d", index);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT32, &index);
+}
+
+static int resolved_disable_interface(int index)
+{
+	if (!resolved_proxy)
+		return -ENOENT;
+
+	if (index < 0)
+		return -ENODEV;
+
+	if (!g_dbus_proxy_method_call(resolved_proxy, "RevertLink",
+			setrevertlink_append, NULL, GINT_TO_POINTER(index),
+			NULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+struct interface_search_data {
+	bool enable;
+	bool forced;
+	bool disconnected;
+	int index4;
+	int index6;
+	int vpn_index;
+};
+
+static bool interface_index_match(int index,
+				struct interface_search_data *search_data)
+{
+	if (search_data->forced)
+		return true;
+
+	if (index == search_data->index4 || index == search_data->index6) {
+		DBG("interface %d match", index);
+		return true;
+	}
+
+	if (index == search_data->vpn_index) {
+		DBG("VPN interface %d match", index);
+		return true;
+	}
+
+	return false;
+}
+
+static void toggle_interface_dns(struct dns_interface *iface, bool enable)
+{
+	DBG("%s interface %p/%d", enable ? "enable" : "disable", iface,
+								iface->index);
+
+	if (iface->enabled == enable) {
+		DBG("already %s", enable ? "enabled" : "disabled");
+		return;
+	}
+
+	iface->enabled = enable;
+
+	if (!enable) {
+		DBG("disabling interface %d", iface->index);
+		resolved_disable_interface(iface->index);
+	} else {
+		DBG("re-enabling interface %d", iface->index);
+		set_systemd_resolved_values(iface);
+	}
+
+	if (is_empty(iface)) {
+		DBG("removing interface %d", iface->index);
+		g_hash_table_remove(interface_hash,
+					GUINT_TO_POINTER(iface->index));
+	}
+}
+
+static void check_interface(gpointer key, gpointer value, gpointer user_data)
+{
+	struct dns_interface *iface = value;
+	struct interface_search_data *search_data = user_data;
+
+	if (interface_index_match(iface->index, search_data)) {
+		/*
+		 * Clear domains and servers before updating the status to
+		 * resolved when interface is disconnected.
+		 */
+		if (!search_data->enable && search_data->disconnected) {
+			DBG("clear domains and servers of %d", iface->index);
+
+			g_list_free_full(iface->domains, g_free);
+			iface->domains = NULL;
+
+			g_list_free_full(iface->servers, g_free);
+			iface->servers = NULL;
+		}
+
+		toggle_interface_dns(iface, search_data->enable);
+	/* If DNSs of an interface are to be enabled disable the others */
+	} else if (search_data->enable) {
+		toggle_interface_dns(iface, false);
+	} else {
+		return;
+	}
+
+	if (!update_interfaces_source)
+		update_interfaces_source = g_idle_add(update_systemd_resolved,
+									NULL);
+}
+
+static void resolved_offline_mode(bool enabled)
+{
+	struct interface_search_data search_data = { 0 };
+	int err;
+
+	DBG("enabled %d", enabled);
+
+	search_data.enable = !enabled;
+	search_data.forced = true;
+
+	g_hash_table_foreach(interface_hash, check_interface, &search_data);
+
+	/* Offline mode is not on, skip default unset and flushing of cache */
+	if (!enabled)
+		return;
+
+	err = resolved_set_default_route(current_default_index, false);
+	if (err && err != -ENODEV)
+		DBG("failed to unset interface %d as default route",
+							current_default_index);
+
+	current_default_index = -1;
+
+	resolved_flush_cache();
+}
+
+static void resolved_default_changed(struct connman_service *service)
+{
+	struct connman_ipconfig *ipconfig;
+	struct interface_search_data search_data = { 0 };
+	int index;
+	int err;
+
+	DBG("service %p interface %d", service,
+					__connman_service_get_index(service));
+
+	if (!service) {
+		/* When no services are active, then disable DNSs */
+		resolved_offline_mode(true);
+		return;
+	}
+
+	if (connman_service_get_type(service) == CONNMAN_SERVICE_TYPE_VPN) {
+		/* VPN is either or take both to be sure */
+		search_data.index4 = search_data.index6 = -1;
+		search_data.vpn_index = __connman_service_get_index(service);
+
+		if (search_data.vpn_index < 0)
+			return;
+
+		index = search_data.vpn_index;
+	} else {
+		ipconfig = __connman_service_get_ip4config(service);
+		search_data.index4 = __connman_ipconfig_get_index(ipconfig);
+
+		ipconfig = __connman_service_get_ip6config(service);
+		search_data.index6 = __connman_ipconfig_get_index(ipconfig);
+
+		if (search_data.index4 < 0 && search_data.index6 < 0)
+			return;
+
+		/*
+		 * In case non-split-routed VPN is set as split routed the DNS
+		 * servers the VPN must be enabled as well, when the transport
+		 * becomes the default service. Try first with IPv4 and then
+		 * attempt using IPv6 if not set. VPN can be either or.
+		 */
+		search_data.vpn_index = __connman_gateway_get_vpn_index(
+							search_data.index4);
+		if (search_data.vpn_index < 0)
+			search_data.vpn_index =
+					__connman_gateway_get_vpn_index(
+							search_data.index6);
+
+		if (search_data.index4 == search_data.index6)
+			index = search_data.index4;
+		else
+			index = search_data.index6; // Prefer IPv6, as usual.
+	}
+
+	if (current_default_index != index) {
+		err = resolved_set_default_route(current_default_index, false);
+		if (err && err != -ENODEV)
+			DBG("failed to unset %d as default",
+							current_default_index);
+
+		current_default_index = -1;
+
+		err = resolved_set_default_route(index, true);
+		if (err && err != -ENODEV)
+			DBG("failed to set %d as default", index);
+		else
+			current_default_index = index;
+	}
+
+	search_data.enable = true;
+	g_hash_table_foreach(interface_hash, check_interface, &search_data);
+
+	resolved_flush_cache();
+}
+
+static void resolved_service_state_changed(struct connman_service *service,
+			enum connman_service_state state)
+{
+	struct connman_ipconfig *ipconfig;
+	struct interface_search_data search_data = { 0 };
+	int index;
+	int err;
+
+	index = __connman_service_get_index(service);
+	DBG("service %p interface %d state %d", service, index, state);
+
+	switch (state) {
+	case CONNMAN_SERVICE_STATE_DISCONNECT:
+	case CONNMAN_SERVICE_STATE_IDLE:
+	case CONNMAN_SERVICE_STATE_FAILURE:
+	case CONNMAN_SERVICE_STATE_UNKNOWN:
+		DBG("disable interface %d", index);
+		break;
+	case CONNMAN_SERVICE_STATE_ASSOCIATION:
+	case CONNMAN_SERVICE_STATE_CONFIGURATION:
+	case CONNMAN_SERVICE_STATE_ONLINE:
+	case CONNMAN_SERVICE_STATE_READY:
+		DBG("connecting/connected mode, skip interface %d", index);
+		return;
+	}
+
+	ipconfig = __connman_service_get_ip4config(service);
+	search_data.index4 = __connman_ipconfig_get_index(ipconfig);
+
+	ipconfig = __connman_service_get_ip6config(service);
+	search_data.index6 = __connman_ipconfig_get_index(ipconfig);
+
+	if (current_default_index == search_data.index4)
+		index = search_data.index4;
+	else if (current_default_index == search_data.index6)
+		index = search_data.index6;
+	else
+		index = -1;
+
+	if (index != -1) {
+		err = resolved_set_default_route(index, false);
+		if (err && err != -ENODEV)
+			DBG("failed to unset %d as default route", index);
+
+		current_default_index = -1;
+		resolved_flush_cache(); // Do when index is unset
+	}
+
+	/*
+	 * Disable DNS servers when the service is not connected and clear the
+	 * domains and servers. Use both indexes as service can have two
+	 * separate interfaces, both of which can be registered to resolved.
+	 */
+	search_data.enable = false;
+	search_data.disconnected = true;
+
+	g_hash_table_foreach(interface_hash, check_interface, &search_data);
+
+	if (!update_interfaces_source)
+		update_interfaces_source = g_idle_add(update_systemd_resolved,
+									NULL);
+}
+
+static struct connman_notifier resolved_notifier = {
+	.name			= "systemd-resolved",
+	.default_changed	= resolved_default_changed,
+	.offline_mode		= resolved_offline_mode,
+	.service_state_changed	= resolved_service_state_changed,
+};
+
 int __connman_dnsproxy_init(void)
 {
 	int ret;
@@ -451,6 +779,10 @@ int __connman_dnsproxy_init(void)
 	if (!interface_hash)
 		return -ENOMEM;
 
+	ret = connman_notifier_register(&resolved_notifier);
+	if (ret < 0)
+		DBG("cannot register notifier");
+
 	return 0;
 }
 
@@ -458,6 +790,8 @@ void __connman_dnsproxy_cleanup(void)
 {
 	DBG("");
 
+	connman_notifier_unregister(&resolved_notifier);
+
 	if (update_interfaces_source) {
 		/*
 		 * It might be that we don't get to an idle loop anymore, so
-- 
2.47.3


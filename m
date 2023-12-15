Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48C363
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E77AF73118
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A61E773128
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/8] inet: Add IPv{4,6} host/network route functions with metric/priority.
Date: Thu, 14 Dec 2023 16:10:26 -0800
Message-ID: <20231215001032.2127527-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215001032.2127527-1-gerickson@nuovations.com>
References: <20231215001032.2127527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds
'connman_inet_{add,del}_{,ipv6_}{host,network}_route_with_metric'
functions that provide the ability to add/delete an IPv4 or IPv6 host
or network route with an explicit metric / priority.

As a convenience, the
'connman_inet_{add,del}_{,ipv6_}network_route_with_metric' functions
allow the caller to provide the IPv4 or IPv6 network address in masked
(that is, 169.254.0.0/16) or unmasked (169.254.75.191/16) form. The
function will mask the address, based on the provided prefix length,
before modifying the route with it.
---
 include/inet.h |  36 ++++
 src/inet.c     | 475 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 479 insertions(+), 32 deletions(-)

diff --git a/include/inet.h b/include/inet.h
index 1b2be1e23d8f..c7488165720c 100644
--- a/include/inet.h
+++ b/include/inet.h
@@ -42,8 +42,26 @@ bool connman_inet_is_ifup(int index);
 
 int connman_inet_set_address(int index, struct connman_ipaddress *ipaddress);
 int connman_inet_clear_address(int index, struct connman_ipaddress *ipaddress);
+int connman_inet_add_host_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric);
+int connman_inet_del_host_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric);
 int connman_inet_add_host_route(int index, const char *host, const char *gateway);
 int connman_inet_del_host_route(int index, const char *host);
+int connman_inet_add_network_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint8_t prefix_len,
+					uint32_t metric);
+int connman_inet_del_network_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint8_t prefix_len,
+					uint32_t metric);
 int connman_inet_add_network_route(int index, const char *host, const char *gateway,
 					const char *netmask);
 int connman_inet_del_network_route(int index, const char *host);
@@ -56,9 +74,27 @@ int connman_inet_set_ipv6_address(int index,
 		struct connman_ipaddress *ipaddress);
 int connman_inet_clear_ipv6_address(int index,
 					struct connman_ipaddress *ipaddress);
+int connman_inet_add_ipv6_host_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric);
+int connman_inet_del_ipv6_host_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric);
 int connman_inet_add_ipv6_host_route(int index, const char *host,
 						const char *gateway);
 int connman_inet_del_ipv6_host_route(int index, const char *host);
+int connman_inet_del_ipv6_network_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint8_t prefix_len,
+					uint32_t metric);
+int connman_inet_add_ipv6_network_route_with_metric(int index,
+					const char *host,
+					const char *gateway,
+					uint8_t prefix_len,
+					uint32_t metric);
 int connman_inet_add_ipv6_network_route(int index, const char *host,
 					const char *gateway,
 					unsigned char prefix_len);
diff --git a/src/inet.c b/src/inet.c
index ad2bca7a5e04..cb2fa4f111e2 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
+#include <sys/param.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <netdb.h>
@@ -596,6 +597,348 @@ static const char *rtnl_route_cmd2string(int cmd)
 	return "";
 }
 
+static int inet_get_addr_data(int family,
+			const char *addr_string,
+			void *addr_data)
+{
+	int status = 0;
+
+	if (!addr_string || !addr_data)
+		return -EINVAL;
+
+	status = inet_pton(family, addr_string, addr_data);
+	switch (status) {
+	case -1:
+		return -errno;
+	default:
+	case 0:
+		return -EINVAL;
+	case 1:
+		break;
+	}
+
+	return 0;
+}
+
+static int inet_mask_addr_data(size_t addr_len,
+			void *addr_data,
+			uint8_t prefixlen)
+{
+	uint8_t *const addr_bytes = addr_data;
+	const size_t total_prefix_bytes = howmany(prefixlen, NBBY);
+	const size_t full_prefix_bytes	= prefixlen / NBBY;
+	const size_t full_clear_bytes	= addr_len - total_prefix_bytes;
+	const uint8_t remaining_bits	= prefixlen % NBBY;
+
+	if (!addr_len || !addr_data || full_prefix_bytes > addr_len)
+		return -EINVAL;
+
+	/* Clear whole non-prefix bytes */
+
+	memset(&addr_bytes[addr_len - full_clear_bytes],
+		0x00,
+		full_clear_bytes);
+
+	/* Mask remaining bits in the last partial prefix byte */
+
+	if (remaining_bits)
+		addr_bytes[full_prefix_bytes] &= ~(0xFF >> remaining_bits);
+
+	return 0;
+}
+
+static int inet_modify_host_or_network_route(int cmd,
+					int family,
+					int index,
+					const char *host_or_network,
+					const char *gateway,
+					uint8_t prefixlen,
+					uint32_t table_id,
+					uint32_t metric)
+{
+	g_autofree char *interface = NULL;
+	struct __connman_inet_rtnl_handle rth;
+	unsigned char host_or_network_buf[sizeof(struct in6_addr)];
+	unsigned char gateway_buf[sizeof(struct in6_addr)];
+	int ret;
+	size_t addr_len;
+
+	if (!host_or_network || index < 0)
+		return -EINVAL;
+
+	interface = connman_inet_ifname(index);
+
+	DBG("cmd %d (%s) family %d index %d (%s) destination %s/%u gateway %s "
+		"table %u <%s> metric %u",
+		cmd, rtnl_route_cmd2string(cmd),
+		family,
+		index, interface,
+		host_or_network, prefixlen,
+		gateway,
+		table_id, __connman_inet_table2string(table_id),
+		metric);
+
+	switch (family) {
+	case AF_INET:
+		addr_len = 4;
+		break;
+	case AF_INET6:
+		addr_len = 16;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Convert the host or network address from text to binary form */
+
+	ret = inet_get_addr_data(family, host_or_network, host_or_network_buf);
+	if (ret < 0)
+		return ret;
+
+	/* Apply the prefix length to the address data */
+
+	ret = inet_mask_addr_data(addr_len, host_or_network_buf, prefixlen);
+	if (ret < 0)
+		return ret;
+
+	/* If present, convert the gateway address from text to binary form */
+
+	if (gateway) {
+		ret = inet_get_addr_data(family, gateway, gateway_buf);
+		if (ret < 0)
+			return ret;
+	}
+
+	memset(&rth, 0, sizeof(rth));
+
+	rth.req.n.nlmsg_len   = NLMSG_LENGTH(sizeof(struct rtmsg));
+	rth.req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	rth.req.n.nlmsg_type  = cmd;
+
+	rth.req.u.r.rt.rtm_family   = family;
+	rth.req.u.r.rt.rtm_table    = table_id;
+	rth.req.u.r.rt.rtm_protocol = RTPROT_BOOT;
+	rth.req.u.r.rt.rtm_scope    = gateway ?
+							RT_SCOPE_UNIVERSE :
+							RT_SCOPE_LINK;
+	rth.req.u.r.rt.rtm_type     = RTN_UNICAST;
+	rth.req.u.r.rt.rtm_dst_len  = prefixlen;
+
+	__connman_inet_rtnl_addattr_l(&rth.req.n, sizeof(rth.req),
+				RTA_DST, host_or_network_buf, addr_len);
+
+	if (gateway) {
+		__connman_inet_rtnl_addattr_l(&rth.req.n, sizeof(rth.req),
+					RTA_GATEWAY, gateway_buf, addr_len);
+	}
+
+	__connman_inet_rtnl_addattr32(&rth.req.n, sizeof(rth.req),
+				RTA_TABLE, table_id);
+
+	__connman_inet_rtnl_addattr32(&rth.req.n, sizeof(rth.req),
+				RTA_OIF, index);
+
+	__connman_inet_rtnl_addattr32(&rth.req.n, sizeof(rth.req),
+				RTA_PRIORITY, metric);
+
+	ret = __connman_inet_rtnl_open(&rth);
+	if (ret < 0)
+		goto done;
+
+	ret = __connman_inet_rtnl_send(&rth, &rth.req.n);
+	if (ret < 0)
+		goto done;
+
+	ret = __connman_inet_rtnl_recv(&rth, NULL);
+	if (ret < 0)
+		goto done;
+
+done:
+	__connman_inet_rtnl_close(&rth);
+
+	return ret;
+}
+
+static int inet_modify_host_route(int cmd,
+					int family,
+					int index,
+					const char *host,
+					const char *gateway,
+					uint8_t prefixlen,
+					uint32_t metric)
+{
+	static const uint32_t table_id = RT_TABLE_MAIN;
+
+	return inet_modify_host_or_network_route(cmd,
+				family,
+				index,
+				host,
+				gateway,
+				prefixlen,
+				table_id,
+				metric);
+}
+
+static int inet_modify_network_route(int cmd,
+					int family,
+					int index,
+					const char *network,
+					const char *gateway,
+					uint8_t prefixlen,
+					uint32_t metric)
+{
+	static const uint32_t table_id = RT_TABLE_MAIN;
+
+	return inet_modify_host_or_network_route(cmd,
+				family,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				table_id,
+				metric);
+}
+
+static int inet_modify_ipv4_network_route(int cmd,
+					int index,
+					const char *network,
+					const char *gateway,
+					uint8_t prefixlen,
+					uint32_t metric)
+{
+	static const int family = AF_INET;
+
+	return inet_modify_network_route(cmd,
+				family,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
+
+static int inet_modify_ipv6_network_route(int cmd,
+					int index,
+					const char *network,
+					const char *gateway,
+					uint8_t prefixlen,
+					uint32_t metric)
+{
+	static const int family = AF_INET6;
+
+	return inet_modify_network_route(cmd,
+				family,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
+
+static int inet_modify_ipv4_host_route(int cmd,
+					int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric)
+{
+	static const int family = AF_INET;
+	static const uint8_t prefixlen = 32;
+
+	return inet_modify_host_route(cmd,
+				family,
+				index,
+				host,
+				gateway,
+				prefixlen,
+				metric);
+}
+
+static int inet_modify_ipv6_host_route(int cmd,
+					int index,
+					const char *host,
+					const char *gateway,
+					uint32_t metric)
+{
+	static const int family = AF_INET6;
+	static const uint8_t prefixlen = 128;
+
+	return inet_modify_host_route(cmd,
+				family,
+				index,
+				host,
+				gateway,
+				prefixlen,
+				metric);
+}
+
+int connman_inet_add_host_route_with_metric(int index,
+				const char *host,
+				const char *gateway,
+				uint32_t metric)
+{
+	static const int cmd = RTM_NEWROUTE;
+
+	DBG("");
+
+	return inet_modify_ipv4_host_route(cmd,
+				index,
+				host,
+				gateway,
+				metric);
+}
+
+int connman_inet_del_host_route_with_metric(int index,
+				const char *host,
+				const char *gateway,
+				uint32_t metric)
+{
+	static const int cmd = RTM_DELROUTE;
+
+	DBG("");
+
+	return inet_modify_ipv4_host_route(cmd,
+				index,
+				host,
+				gateway,
+				metric);
+}
+
+int connman_inet_add_network_route_with_metric(int index,
+				const char *network,
+				const char *gateway,
+				uint8_t prefixlen,
+				uint32_t metric)
+{
+	static const int cmd = RTM_NEWROUTE;
+
+	DBG("");
+
+	return inet_modify_ipv4_network_route(cmd,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
+
+int connman_inet_del_network_route_with_metric(int index,
+				const char *network,
+				const char *gateway,
+				uint8_t prefixlen,
+				uint32_t metric)
+{
+	static const int cmd = RTM_DELROUTE;
+
+	DBG("");
+
+	return inet_modify_ipv4_network_route(cmd,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
+
 int connman_inet_add_host_route(int index, const char *host,
 				const char *gateway)
 {
@@ -749,48 +1092,78 @@ out:
 	return err;
 }
 
-int connman_inet_del_ipv6_network_route(int index, const char *host,
-						unsigned char prefix_len)
+int connman_inet_add_ipv6_host_route_with_metric(int index,
+				const char *host,
+				const char *gateway,
+				uint32_t metric)
 {
-	struct in6_rtmsg rt;
-	int sk, err = 0;
+	static const int cmd = RTM_NEWROUTE;
 
-	DBG("index %d host %s", index, host);
+	DBG("");
 
-	if (!host)
-		return -EINVAL;
+	return inet_modify_ipv6_host_route(cmd,
+				index,
+				host,
+				gateway,
+				metric);
+}
 
-	memset(&rt, 0, sizeof(rt));
+int connman_inet_del_ipv6_host_route_with_metric(int index,
+				const char *host,
+				const char *gateway,
+				uint32_t metric)
+{
+	static const int cmd = RTM_DELROUTE;
 
-	rt.rtmsg_dst_len = prefix_len;
+	DBG("");
 
-	if (inet_pton(AF_INET6, host, &rt.rtmsg_dst) != 1) {
-		err = -errno;
-		goto out;
-	}
+	return inet_modify_ipv6_host_route(cmd,
+				index,
+				host,
+				gateway,
+				metric);
+}
 
-	rt.rtmsg_flags = RTF_UP | RTF_HOST;
+int connman_inet_add_ipv6_network_route_with_metric(int index,
+				const char *network,
+				const char *gateway,
+				uint8_t prefixlen,
+				uint32_t metric)
+{
+	static const int cmd = RTM_NEWROUTE;
 
-	rt.rtmsg_metric = 1;
-	rt.rtmsg_ifindex = index;
+	DBG("");
 
-	sk = socket(AF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
-	if (sk < 0) {
-		err = -errno;
-		goto out;
-	}
+	return inet_modify_ipv6_network_route(cmd,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
 
-	if (ioctl(sk, SIOCDELRT, &rt) < 0 && errno != ESRCH)
-		err = -errno;
+int connman_inet_del_ipv6_network_route_with_metric(int index,
+				const char *network,
+				const char *gateway,
+				uint8_t prefixlen,
+				uint32_t metric)
+{
+	static const int cmd = RTM_DELROUTE;
 
-	close(sk);
+	DBG("");
 
-out:
-	if (err < 0)
-		connman_error("Del IPv6 host route error (%s)",
-						strerror(-err));
+	return inet_modify_ipv6_network_route(cmd,
+				index,
+				network,
+				gateway,
+				prefixlen,
+				metric);
+}
 
-	return err;
+int connman_inet_add_ipv6_host_route(int index, const char *host,
+					const char *gateway)
+{
+	return connman_inet_add_ipv6_network_route(index, host, gateway, 128);
 }
 
 int connman_inet_del_ipv6_host_route(int index, const char *host)
@@ -869,10 +1242,48 @@ out:
 	return err;
 }
 
-int connman_inet_add_ipv6_host_route(int index, const char *host,
-					const char *gateway)
+int connman_inet_del_ipv6_network_route(int index, const char *host,
+						unsigned char prefix_len)
 {
-	return connman_inet_add_ipv6_network_route(index, host, gateway, 128);
+	struct in6_rtmsg rt;
+	int sk, err = 0;
+
+	DBG("index %d host %s", index, host);
+
+	if (!host)
+		return -EINVAL;
+
+	memset(&rt, 0, sizeof(rt));
+
+	rt.rtmsg_dst_len = prefix_len;
+
+	if (inet_pton(AF_INET6, host, &rt.rtmsg_dst) != 1) {
+		err = -errno;
+		goto out;
+	}
+
+	rt.rtmsg_flags = RTF_UP | RTF_HOST;
+
+	rt.rtmsg_metric = 1;
+	rt.rtmsg_ifindex = index;
+
+	sk = socket(AF_INET6, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (sk < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	if (ioctl(sk, SIOCDELRT, &rt) < 0 && errno != ESRCH)
+		err = -errno;
+
+	close(sk);
+
+out:
+	if (err < 0)
+		connman_error("Del IPv6 host route error (%s)",
+						strerror(-err));
+
+	return err;
 }
 
 int connman_inet_clear_ipv6_gateway_address(int index, const char *gateway)
-- 
2.42.0


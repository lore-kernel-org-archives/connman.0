Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB468361
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8610973100
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 47F0B73122
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/8] inet: Reorder IPv6 host and network route function declarations.
Date: Thu, 14 Dec 2023 16:10:25 -0800
Message-ID: <20231215001032.2127527-3-gerickson@nuovations.com>
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

This reorders the IPv6 host and network route function declarations to
match that of their IPv4 couterparts.
---
 include/inet.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/inet.h b/include/inet.h
index 9245eef8bf52..1b2be1e23d8f 100644
--- a/include/inet.h
+++ b/include/inet.h
@@ -56,13 +56,14 @@ int connman_inet_set_ipv6_address(int index,
 		struct connman_ipaddress *ipaddress);
 int connman_inet_clear_ipv6_address(int index,
 					struct connman_ipaddress *ipaddress);
-int connman_inet_add_ipv6_network_route(int index, const char *host,
-					const char *gateway, unsigned char prefix_len);
 int connman_inet_add_ipv6_host_route(int index, const char *host,
 						const char *gateway);
+int connman_inet_del_ipv6_host_route(int index, const char *host);
+int connman_inet_add_ipv6_network_route(int index, const char *host,
+					const char *gateway,
+					unsigned char prefix_len);
 int connman_inet_del_ipv6_network_route(int index, const char *host,
 					unsigned char prefix_len);
-int connman_inet_del_ipv6_host_route(int index, const char *host);
 int connman_inet_clear_ipv6_gateway_address(int index, const char *gateway);
 int connman_inet_set_ipv6_gateway_interface(int index);
 int connman_inet_clear_ipv6_gateway_interface(int index);
-- 
2.42.0


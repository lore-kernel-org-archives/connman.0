Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F552C82
	for <connman@lists.linux.dev>; Tue, 16 Nov 2021 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id b6fabc82-46f2-11ec-877a-005056bdfda7;
	Tue, 16 Nov 2021 17:34:40 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] service: Support hot-plug of technologies by updating ipconfig index
Date: Tue, 16 Nov 2021 17:34:35 +0200
Message-Id: <20211116153435.17073-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is important to update the index of the ipconfig belonging to the
service that is to be created from network after re-inserting a
technology that supports hot-plug (e.g., an USB ethernet adapter). The
service does exist in such case but the interface index is not updated
which results in DHCP failing to start. This is because the old index
would be used.

With this change index update is always done regardless of the existing
path for the service.
---
 src/service.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 8d3c75a5..9141b85d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7464,8 +7464,19 @@ struct connman_service * __connman_service_create_from_network(struct connman_ne
 	if (__connman_network_get_weakness(network))
 		return service;
 
+	index = connman_network_get_index(network);
+
 	if (service->path) {
 		update_from_network(service, network);
+
+		if (service->ipconfig_ipv4)
+			__connman_ipconfig_set_index(service->ipconfig_ipv4,
+									index);
+
+		if (service->ipconfig_ipv6)
+			__connman_ipconfig_set_index(service->ipconfig_ipv6,
+									index);
+
 		__connman_connection_update_gateway();
 		return service;
 	}
@@ -7496,14 +7507,16 @@ struct connman_service * __connman_service_create_from_network(struct connman_ne
 
 	update_from_network(service, network);
 
-	index = connman_network_get_index(network);
-
 	if (!service->ipconfig_ipv4)
 		service->ipconfig_ipv4 = create_ip4config(service, index,
 				CONNMAN_IPCONFIG_METHOD_DHCP);
+	else
+		__connman_ipconfig_set_index(service->ipconfig_ipv4, index);
 
 	if (!service->ipconfig_ipv6)
 		service->ipconfig_ipv6 = create_ip6config(service, index);
+	else
+		__connman_ipconfig_set_index(service->ipconfig_ipv6, index);
 
 	service_register(service);
 	service_schedule_added(service);
-- 
2.20.1


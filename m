Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FD13FF3
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3703473144
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id ED9607314E
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 7/9] inet: Document '{add,del}_nameserver_route'.
Date: Sat, 16 Dec 2023 00:28:02 -0800
Message-ID: <20231216082805.2221938-8-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216082805.2221938-1-gerickson@nuovations.com>
References: <20231216082805.2221938-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '{add,del}_nameserver_route' functions.
---
 src/service.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/service.c b/src/service.c
index e0a11a2bc6a2..8821445f32e7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1345,6 +1345,32 @@ void __connman_service_nameserver_clear(struct connman_service *service)
 	nameserver_add_all(service, CONNMAN_IPCONFIG_TYPE_ALL);
 }
 
+/**
+ *  @brief
+ *    Add an IPv4 or IPv6 host route for the specified domain name
+ *    service (DNS) server.
+ *
+ *  This attempts to add an IPv4 or IPv6 host route for the specified
+ *  domain name service (DNS) server with the specified attributes.
+ *
+ *  @param[in]  family      The address family describing the
+ *                          address pointed to by @a nameserver.
+ *  @param[in]  index       The network interface index associated
+ *                          with the output network device for
+ *                          the route.
+ *  @param[in]  nameserver  A pointer to an immutable null-terminated
+ *                          C string containing the IPv4 or IPv6
+ *                          address, in text form, of the route
+ *                          DNS server destination address.
+ *  @param[in]  gw          A pointer to an immutable null-terminated
+ *                          C string containing the IPv4 or IPv6
+ *                          address, in text form, of the route next
+ *                          hop gateway address.
+ *
+ *  @sa del_nameserver_route
+ *  @sa nameserver_add_routes
+ *
+ */
 static void add_nameserver_route(int family, int index, const char *nameserver,
 				const char *gw)
 {
@@ -1370,6 +1396,33 @@ static void add_nameserver_route(int family, int index, const char *nameserver,
 	}
 }
 
+/**
+ *  @brief
+ *    Delete an IPv4 or IPv6 host route for the specified domain name
+ *    service (DNS) server.
+ *
+ *  This attempts to delete an IPv4 or IPv6 host route for the
+ *  specified domain name service (DNS) server with the specified
+ *  attributes.
+ *
+ *  @param[in]  family      The address family describing the
+ *                          address pointed to by @a nameserver.
+ *  @param[in]  index       The network interface index associated
+ *                          with the output network device for
+ *                          the route.
+ *  @param[in]  nameserver  A pointer to an immutable null-terminated
+ *                          C string containing the IPv4 or IPv6
+ *                          address, in text form, of the route
+ *                          DNS server destination address.
+ *  @param[in]  gw          A pointer to an immutable null-terminated
+ *                          C string containing the IPv4 or IPv6
+ *                          address, in text form, of the route next
+ *                          hop gateway address.
+ *
+ *  @sa add_nameserver_route
+ *  @sa nameserver_del_routes
+ *
+ */
 static void del_nameserver_route(int family, int index, const char *nameserver,
 				const char *gw,
 				enum connman_ipconfig_type type)
-- 
2.42.0


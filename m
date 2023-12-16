Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAED14016
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9579073146
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 57B0C73154
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 8/9] inet: Document 'nameserver_{add,del}_routes'.
Date: Sat, 16 Dec 2023 00:28:03 -0800
Message-ID: <20231216082805.2221938-9-gerickson@nuovations.com>
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

This adds documentation to the 'nameserver_{add,del}_routes'
functions.
---
 src/service.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/service.c b/src/service.c
index 8821445f32e7..7e14a3dbf496 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1457,6 +1457,31 @@ static void del_nameserver_route(int family, int index, const char *nameserver,
 	}
 }
 
+/**
+ *  @brief
+ *    Add IPv4 or IPv6 host routes for the specified domain name
+ *    service (DNS) servers.
+ *
+ *  This attempts to add IPv4 or IPv6 host routes for the specified
+ *  domain name service (DNS) servers with the specified attributes.
+ *
+ *  @param[in]  index        The network interface index associated
+ *                           with the output network device for
+ *                           the route.
+ *  @param[in]  nameservers  A pointer to a null-terminated array of
+ *                           mutable null-terminated C strings
+ *                           containing the IPv4 or IPv6 addresses, in
+ *                           text form, of the route DNS server
+ *                           destination addresses.
+ *  @param[in]  gw           A pointer to an immutable null-terminated
+ *                           C string containing the IPv4 or IPv6
+ *                           address, in text form, of the route next
+ *                           hop gateway address.
+ *
+ *  @sa add_nameserver_route
+ *  @sa nameserver_del_routes
+ *
+ */
 static void nameserver_add_routes(int index, char **nameservers,
 					const char *gw)
 {
@@ -1475,6 +1500,31 @@ static void nameserver_add_routes(int index, char **nameservers,
 	}
 }
 
+/**
+ *  @brief
+ *    Delete IPv4 or IPv6 host routes for the specified domain name
+ *    service (DNS) servers.
+ *
+ *  This attempts to delete IPv4 or IPv6 host routes for the specified
+ *  domain name service (DNS) servers with the specified attributes.
+ *
+ *  @param[in]  index        The network interface index associated
+ *                           with the output network device for
+ *                           the route.
+ *  @param[in]  nameservers  A pointer to a null-terminated array of
+ *                           mutable null-terminated C strings
+ *                           containing the IPv4 or IPv6 addresses, in
+ *                           text form, of the route DNS server
+ *                           destination addresses.
+ *  @param[in]  gw           A pointer to an immutable null-terminated
+ *                           C string containing the IPv4 or IPv6
+ *                           address, in text form, of the route next
+ *                           hop gateway address.
+ *
+ *  @sa del_nameserver_route
+ *  @sa nameserver_add_routes
+ *
+ */
 static void nameserver_del_routes(int index, char **nameservers,
 				const char *gw,
 				enum connman_ipconfig_type type)
-- 
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371E14018
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 002C273145
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B61E87315A
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 9/9] inet: Document '__connman_service_nameserver_{add,del}_routes'.
Date: Sat, 16 Dec 2023 00:28:04 -0800
Message-ID: <20231216082805.2221938-10-gerickson@nuovations.com>
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

This adds documentation to the
'__connman_service_nameserver_{add,del}_routes' functions.
---
 src/service.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/service.c b/src/service.c
index 7e14a3dbf496..b8224e8ff0bc 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1545,6 +1545,27 @@ static void nameserver_del_routes(int index, char **nameservers,
 	}
 }
 
+/**
+ *  @brief
+ *    Add IPv4 or IPv6 host routes for the domain name service (DNS)
+ *    servers associated with the specified service.
+ *
+ *  This attempts to add IPv4 or IPv6 host routes for both the
+ *  automatic and configured domain name service (DNS) servers
+ *  associated with the specified network service.
+ *
+ *  @param[in]  service      A pointer to the immutable network
+ *                           service for which to add DNS server host
+ *                           routes.
+ *  @param[in]  gw           A pointer to an immutable null-terminated
+ *                           C string containing the IPv4 or IPv6
+ *                           address, in text form, of the route next
+ *                           hop gateway address.
+ *
+ *  @sa __connman_service_nameserver_del_routes
+ *  @sa nameserver_add_routes
+ *
+ */
 void __connman_service_nameserver_add_routes(
 					const struct connman_service *service,
 					const char *gw)
@@ -1574,6 +1595,29 @@ void __connman_service_nameserver_add_routes(
 	}
 }
 
+/**
+ *  @brief
+ *    Delete IPv4 or IPv6 host routes for the domain name service (DNS)
+ *    servers associated with the specified service.
+ *
+ *  This attempts to delete IPv4 or IPv6 host routes for both the
+ *  automatic and configured domain name service (DNS) servers
+ *  associated with the specified network service.
+ *
+ *  @param[in]  service      A pointer to the immutable network
+ *                           service for which to delete DNS server
+ *                           host routes.
+ *  @param[in]  gw           A pointer to an immutable null-terminated
+ *                           C string containing the IPv4 or IPv6
+ *                           address, in text form, of the route next
+ *                           hop gateway address.
+ *  @param[in]  type         The IP configuration type for which to
+ *                           delete DNS server host routes.
+ *
+ *  @sa __connman_service_nameserver_del_routes
+ *  @sa nameserver_add_routes
+ *
+ */
 void __connman_service_nameserver_del_routes(
 					const struct connman_service *service,
 					const char *gw,
-- 
2.42.0


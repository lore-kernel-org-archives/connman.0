Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7D13FF3
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C7F4373100
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8950A7312B
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/9] service: Refactor 'nameserver_del_routes'.
Date: Sat, 16 Dec 2023 00:27:56 -0800
Message-ID: <20231216082805.2221938-2-gerickson@nuovations.com>
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

This refactors 'nameserver_del_routes' into a second, helper function
'del_nameserver_route' such that host route deletion is separated from
nameserver iteration.

In addition, the structure now mirrors that of 'nameserver_add_routes'
and 'add_nameserver_route'. This is beneficial since route addition
and deletion should be symmetric.
---
 src/service.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/src/service.c b/src/service.c
index 1f2c9f54db9a..54c12532e9ca 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1367,6 +1367,27 @@ static void add_nameserver_route(int family, int index, char *nameserver,
 	}
 }
 
+static void del_nameserver_route(int family, int index, const char *nameserver,
+				const char *gw,
+				enum connman_ipconfig_type type)
+{
+	DBG("family %d index %d nameserver %s gw %s",
+		family, index, nameserver, gw);
+
+	switch (family) {
+	case AF_INET:
+		if (type != CONNMAN_IPCONFIG_TYPE_IPV6)
+			connman_inet_del_host_route(index,
+						nameserver);
+		break;
+	case AF_INET6:
+		if (type != CONNMAN_IPCONFIG_TYPE_IPV4)
+			connman_inet_del_ipv6_host_route(index,
+						nameserver);
+		break;
+	}
+}
+
 static void nameserver_add_routes(int index, char **nameservers,
 					const char *gw)
 {
@@ -1388,25 +1409,15 @@ static void nameserver_add_routes(int index, char **nameservers,
 static void nameserver_del_routes(int index, char **nameservers,
 				enum connman_ipconfig_type type)
 {
-	int i, family;
+	int i, ns_family;
 
 	for (i = 0; nameservers[i]; i++) {
-		family = connman_inet_check_ipaddress(nameservers[i]);
-		if (family < 0)
+		ns_family = connman_inet_check_ipaddress(nameservers[i]);
+		if (ns_family < 0)
 			continue;
 
-		switch (family) {
-		case AF_INET:
-			if (type != CONNMAN_IPCONFIG_TYPE_IPV6)
-				connman_inet_del_host_route(index,
-							nameservers[i]);
-			break;
-		case AF_INET6:
-			if (type != CONNMAN_IPCONFIG_TYPE_IPV4)
-				connman_inet_del_ipv6_host_route(index,
-							nameservers[i]);
-			break;
-		}
+		del_nameserver_route(ns_family, index, nameservers[i],
+			NULL, type);
 	}
 }
 
-- 
2.42.0


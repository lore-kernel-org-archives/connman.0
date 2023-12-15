Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BE36A
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 28071730F9
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DECBF7311A
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/8] inet: Relocate 'rtnl_route_cmd2string'.
Date: Thu, 14 Dec 2023 16:10:24 -0800
Message-ID: <20231215001032.2127527-2-gerickson@nuovations.com>
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

This relocates the 'rtnl_route_cmd2string' function earlier in the
file to accommodate incorporation by other functions later in the file
without the need for a forward declration.
---
 src/inet.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index e957212f11e8..ad2bca7a5e04 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -584,6 +584,18 @@ int connman_inet_clear_address(int index, struct connman_ipaddress *ipaddress)
 	return 0;
 }
 
+static const char *rtnl_route_cmd2string(int cmd)
+{
+	switch (cmd) {
+	case RTM_NEWROUTE:
+		return "add";
+	case RTM_DELROUTE:
+		return "del";
+	}
+
+	return "";
+}
+
 int connman_inet_add_host_route(int index, const char *host,
 				const char *gateway)
 {
@@ -3255,18 +3267,6 @@ int __connman_inet_del_fwmark_rule(uint32_t table_id, int family, uint32_t fwmar
 	return iprule_modify(RTM_DELRULE, family, table_id, fwmark);
 }
 
-static const char *rtnl_route_cmd2string(int cmd)
-{
-	switch (cmd) {
-	case RTM_NEWROUTE:
-		return "add";
-	case RTM_DELROUTE:
-		return "del";
-	}
-
-	return "";
-}
-
 /**
  *  @brief
  *    Add or remove a gateway default route.
-- 
2.42.0


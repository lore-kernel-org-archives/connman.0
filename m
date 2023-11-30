Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C114AB9
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 46A2473145
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id ED84073171
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/4] connection: Add additional DBG statements to '{un,}set_default_gateway'.
Date: Wed, 29 Nov 2023 21:26:21 -0800
Message-ID: <20231130052622.1335266-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130052622.1335266-1-gerickson@nuovations.com>
References: <20231130052622.1335266-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds additional 'DBG' statements to '{un,}set_default_gateway' to
distinguish the any / unspecified and catch-all conditional cases,
mirroring the 'DBG' statements for the existing VPN cases.
---
 src/connection.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 2460ca91074c..716569debfa5 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -900,11 +900,17 @@ static void set_default_gateway(struct gateway_data *data,
 				return;
 
 			data->ipv4_config->active = true;
+
+			DBG("set %p index %d",
+				data, data->index);
 		} else {
 			status4 = __connman_inet_add_default_to_table(
 						RT_TABLE_MAIN,
 						data->index,
 						data->ipv4_config->gateway);
+
+			DBG("set %p index %d gateway %s",
+				data, data->index, data->ipv4_config->gateway);
 		}
 	}
 
@@ -924,14 +930,22 @@ static void set_default_gateway(struct gateway_data *data,
 				return;
 
 			data->ipv6_config->active = true;
+
+			DBG("set %p index %d",
+				data, data->index);
 		} else {
 			status6 = __connman_inet_add_default_to_table(
 						RT_TABLE_MAIN,
 						data->index,
 						data->ipv6_config->gateway);
+
+			DBG("set %p index %d gateway %s",
+				data, data->index, data->ipv4_config->gateway);
 		}
 	}
 
+	DBG("status4 %d status6 %d", status4, status6);
+
 	if (status4 < 0 || status6 < 0)
 		return;
 
@@ -971,9 +985,15 @@ static void unset_default_gateway(struct gateway_data *data,
 			connman_inet_clear_gateway_interface(data->index);
 
 			data->ipv4_config->active = false;
+
+			DBG("unset %p index %d",
+				data, data->index);
 		} else {
 			connman_inet_clear_gateway_address(data->index,
 						data->ipv4_config->gateway);
+
+			DBG("unset %p index %d gateway %s",
+				data, data->index, data->ipv4_config->gateway);
 		}
 	}
 
@@ -991,9 +1011,15 @@ static void unset_default_gateway(struct gateway_data *data,
 			connman_inet_clear_ipv6_gateway_interface(data->index);
 
 			data->ipv6_config->active = false;
+
+			DBG("unset %p index %d",
+				data, data->index);
 		} else {
 			connman_inet_clear_ipv6_gateway_address(data->index,
 						data->ipv6_config->gateway);
+
+			DBG("unset %p index %d gateway %s",
+				data, data->index, data->ipv4_config->gateway);
 		}
 	}
 }
-- 
2.42.0


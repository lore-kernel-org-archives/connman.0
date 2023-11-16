Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F217F0
	for <connman@lists.linux.dev>; Thu, 16 Nov 2023 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ECB8773225
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A3A7673233
	for <connman@lists.linux.dev>; Wed, 15 Nov 2023 20:03:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 14/17] wispr: Add '__connman_wispr_cancel' interface.
Date: Wed, 15 Nov 2023 17:02:55 -0800
Message-ID: <20231116010259.628527-15-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a heretofore-missing '__connman_wispr_cancel' interface. It
attempts to cancel a HTTP-based Internet reachability check for the
specified network service IP configuration type.

If a matching WISPr portal detect request or HTTP-based Internet
reachability check is found, the original callback specified with
'__connman_wispr_start' will be invoked with a success value of zero
('0') or false and an error value of -ECANCELED.
---
 src/connman.h |  2 ++
 src/wispr.c   | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index d5aa6f5599e7..ae04cd9a26c6 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -534,6 +534,8 @@ int __connman_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					guint connect_timeout_ms,
 					__connman_wispr_cb_t callback);
+int __connman_wispr_cancel(struct connman_service *service,
+					enum connman_ipconfig_type type);
 void __connman_wispr_stop(struct connman_service *service);
 
 #include <connman/technology.h>
diff --git a/src/wispr.c b/src/wispr.c
index 9d471628e705..f42429f56e07 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1340,6 +1340,61 @@ free_wp:
 	return err;
 }
 
+int __connman_wispr_cancel(struct connman_service *service,
+					enum connman_ipconfig_type type)
+{
+	struct connman_wispr_portal_context *wp_context = NULL;
+	struct connman_wispr_portal *wispr_portal = NULL;
+	int index;
+
+	DBG("service %p (%s) type %d (%s)",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
+
+	if (!is_wispr_supported(service))
+		return -EOPNOTSUPP;
+
+	index = __connman_service_get_index(service);
+	if (index < 0)
+		return -EINVAL;
+
+	DBG("index %d", index);
+
+	if (!wispr_portal_hash)
+		return -ENOENT;
+
+	wispr_portal = g_hash_table_lookup(wispr_portal_hash,
+					GINT_TO_POINTER(index));
+
+	DBG("wispr_portal %p", wispr_portal);
+
+	if (!wispr_portal)
+		return -ENOENT;
+
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		wp_context = wispr_portal->ipv4_context;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		wp_context = wispr_portal->ipv6_context;
+	else
+		return -EINVAL;
+
+	DBG("wp_context %p", wp_context);
+
+	if (!wp_context)
+		return -ENOENT;
+
+	cancel_connman_wispr_portal_context(wp_context);
+
+	wp_context->cb(wp_context->service,
+			wp_context->type,
+			false,
+			-ECANCELED);
+
+	wispr_portal_context_unref(wp_context);
+
+	return 0;
+}
+
 /**
  *  @brief
  *    Stop all HTTP-based Internet reachability checks for the specified
-- 
2.42.0


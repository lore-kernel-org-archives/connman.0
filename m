Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0523753
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jolla.com
Received: from localhost.localdomain (88-113-60-79.elisa-laajakaista.fi [88.113.60.79])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 50b914ca-a0e1-11ee-b3cf-005056bd6ce9;
	Fri, 22 Dec 2023 17:46:47 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] technology: Add global regdom and regdom getter
Date: Fri, 22 Dec 2023 17:46:43 +0200
Message-Id: <20231222154645.278128-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global regdom to be saved when setting technology regdom because
the technologies are not loaded yet at bootup. Loading of plugins
initializes technologies which then sets up the regdom if it has been set
up earlier by timezone.c. The getter prioritizes the technology regdom
and then the global regdom and is to be used by devices when powering
up.
---
 src/connman.h    |  1 +
 src/technology.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index 622a7785..34e1463e 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -595,6 +595,7 @@ void __connman_technology_remove_interface(enum connman_service_type type,
 				int index, const char *ident);
 void __connman_technology_notify_regdom_by_device(struct connman_device *device,
 						int result, const char *alpha2);
+const char *__connman_technology_get_regdom(enum connman_service_type type);
 
 #include <connman/device.h>
 
diff --git a/src/technology.c b/src/technology.c
index 5c469111..65fb9854 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -43,6 +43,8 @@ static GHashTable *rfkill_list;
 
 static bool global_offlinemode;
 
+static char *global_regdom = NULL;
+
 struct connman_rfkill {
 	unsigned int index;
 	enum connman_service_type type;
@@ -333,8 +335,14 @@ int connman_technology_set_regdom(const char *alpha2)
 					driver->set_regdom(technology, alpha2);
 			}
 		}
+
+		/* Save regdom for this technology */
+		connman_technology_regdom_notify(technology, alpha2);
 	}
 
+	g_free(global_regdom);
+	global_regdom = g_strdup(alpha2);
+
 	return 0;
 }
 
@@ -354,6 +362,22 @@ static struct connman_technology *technology_find(enum connman_service_type type
 	return NULL;
 }
 
+const char *__connman_technology_get_regdom(enum connman_service_type type)
+{
+	struct connman_technology *technology;
+
+	DBG("type %d/%s", type, get_name(type));
+
+	technology = technology_find(type);
+	if (!technology)
+		return NULL;
+
+	if (technology->regdom)
+		return technology->regdom;
+
+	return global_regdom;
+}
+
 enum connman_service_type connman_technology_get_type
 				(struct connman_technology *technology)
 {
@@ -1283,6 +1307,7 @@ static struct connman_technology *technology_get(enum connman_service_type type)
 	technology_load(technology);
 	technology_list = g_slist_prepend(technology_list, technology);
 	technology->driver_list = tech_drivers;
+	technology->regdom = g_strdup(global_regdom);
 
 	for (list = tech_drivers; list; list = list->next) {
 		driver = list->data;
@@ -1905,4 +1930,6 @@ void __connman_technology_cleanup(void)
 	g_hash_table_destroy(rfkill_list);
 
 	dbus_connection_unref(connection);
+
+	g_free(global_regdom);
 }
-- 
2.30.2


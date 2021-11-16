Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DC2C82
	for <connman@lists.linux.dev>; Tue, 16 Nov 2021 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e213e514-46ef-11ec-ae1c-005056bdf889;
	Tue, 16 Nov 2021 17:14:24 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v1 1/2] vpn-provider: Support checking if provider setting key exists.
Date: Tue, 16 Nov 2021 17:14:16 +0200
Message-Id: <20211116151417.14827-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
References: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to check if the setting key exists in the setting hash
table.
---
 vpn/vpn-provider.c | 6 ++++++
 vpn/vpn-provider.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 4bb6c24e..cc325967 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -2937,6 +2937,12 @@ bool vpn_provider_get_string_immutable(struct vpn_provider *provider,
 	return setting->immutable;
 }
 
+bool vpn_provider_setting_key_exists(struct vpn_provider *provider,
+							const char *key)
+{
+	return g_hash_table_contains(provider->setting_strings, key);
+}
+
 void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
 							unsigned int limit)
 {
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index ee09e8ef..5d1455da 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -88,6 +88,8 @@ int vpn_provider_set_boolean(struct vpn_provider *provider, const char *key,
 							bool force_change);
 bool vpn_provider_get_boolean(struct vpn_provider *provider, const char *key,
 							bool default_value);
+bool vpn_provider_setting_key_exists(struct vpn_provider *provider,
+							const char *key);
 void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
 							unsigned int limit);
 
-- 
2.20.1


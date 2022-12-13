Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD005CB5
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 70c2b54c-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:12 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 7/9] vpn: Add support for association state, add state getter
Date: Tue, 13 Dec 2022 16:07:05 +0200
Message-Id: <20221213140707.278313-8-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
References: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support VPN wait user input state as the association state.

Add support for "State" string into the get_property() driver callback.
---
 plugins/vpn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 42396d2a..d9a56ae1 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -156,6 +156,8 @@ static const char *get_string(struct connman_provider *provider,
 		return data->domain;
 	else if (g_str_equal(key, "Transport"))
 		return data->service_ident;
+	else if (g_str_equal(key, "State"))
+		return data->state;
 
 	return g_hash_table_lookup(data->setting_strings, key);
 }
@@ -283,6 +285,8 @@ static void set_provider_state(struct connection_data *data)
 		goto set;
 	} else if (g_str_equal(data->state, "configuration")) {
 		state = CONNMAN_PROVIDER_STATE_CONNECT;
+	} else if (g_str_equal(data->state, "association")) {
+		state = CONNMAN_PROVIDER_STATE_ASSOCIATION;
 	} else if (g_str_equal(data->state, "idle")) {
 		state = CONNMAN_PROVIDER_STATE_IDLE;
 	} else if (g_str_equal(data->state, "disconnect")) {
-- 
2.30.2


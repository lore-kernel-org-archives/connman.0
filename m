Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0732FAF
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0b1c0b54-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:26 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/5] vpn-provider: Ignore error adding when state is idle/unknown
Date: Thu,  2 Sep 2021 18:11:21 +0300
Message-Id: <20210902151124.4983-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not allow to add errors for provider that is already set into idle
state or is in unknown state. This case may happen when networks are
rapidly changed and VPN did not call the callback connect_cb() until the
VPN is died and vpn.c:vpn_died() initiates cleanup in the VPN which
eventually calls connect_cb() with an error.
---
 vpn/vpn-provider.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index f30ce04f..90e21e95 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -2026,6 +2026,21 @@ int vpn_provider_indicate_error(struct vpn_provider *provider,
 	DBG("provider %p id %s error %d", provider, provider->identifier,
 									error);
 
+	/*
+	 * Ignore adding of errors when the VPN is idle or not set. Calls may
+	 * happen in a case when networks are rapidly changed and the call to
+	 * vpn_died() is done before executing the connect_cb() from the
+	 * plugin. Then vpn.c:vpn_died() executes the plugin specific died()
+	 * function which may free the plugin private data, containing also
+	 * the callback which hasn't yet been called. As a result the provider
+	 * might already been reset to idle state when the callback is executed
+	 * resulting in unnecessary reset of the previous successful connect
+	 * timer and adding of an error for already disconnected VPN.
+	 */
+	if (provider->state == VPN_PROVIDER_STATE_IDLE ||
+				provider->state == VPN_PROVIDER_STATE_UNKNOWN)
+		return 0;
+
 	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_FAILURE);
 
 	vpn_provider_add_error(provider, error);
-- 
2.20.1


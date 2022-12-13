Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BC33FF
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 706acc4d-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:12 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 6/9] provider: Handle VPN configuration and association states
Date: Tue, 13 Dec 2022 16:07:04 +0200
Message-Id: <20221213140707.278313-7-jussi.laakkonen@jolla.com>
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

Set the association state when VPN is waiting for user input as an
initial state after connecting the provider. Set the configuration
state (as it is declaced to be the string to connect state in VPN)
accordingly as well. Start VPN connect timeout in configuration
state with restart option to ensure that the timeout begins from the
last known configuration (connect) state.
---
 include/provider.h |  1 +
 src/provider.c     | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/provider.h b/include/provider.h
index 1f120990..f2954dc3 100644
--- a/include/provider.h
+++ b/include/provider.h
@@ -48,6 +48,7 @@ enum connman_provider_state {
 	CONNMAN_PROVIDER_STATE_READY         = 3,
 	CONNMAN_PROVIDER_STATE_DISCONNECT    = 4,
 	CONNMAN_PROVIDER_STATE_FAILURE       = 5,
+	CONNMAN_PROVIDER_STATE_ASSOCIATION   = 6,
 };
 
 enum connman_provider_error {
diff --git a/src/provider.c b/src/provider.c
index e2091846..0d09c85b 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -126,6 +126,22 @@ static int provider_indicate_state(struct connman_provider *provider,
 {
 	DBG("state %d", state);
 
+	switch (state) {
+	case CONNMAN_SERVICE_STATE_UNKNOWN:
+	case CONNMAN_SERVICE_STATE_IDLE:
+	case CONNMAN_SERVICE_STATE_ASSOCIATION:
+		break;
+	case CONNMAN_SERVICE_STATE_CONFIGURATION:
+		__connman_service_start_connect_timeout(provider->vpn_service,
+								true);
+		break;
+	case CONNMAN_SERVICE_STATE_READY:
+	case CONNMAN_SERVICE_STATE_ONLINE:
+	case CONNMAN_SERVICE_STATE_DISCONNECT:
+	case CONNMAN_SERVICE_STATE_FAILURE:
+		break;
+	}
+
 	__connman_service_ipconfig_indicate_state(provider->vpn_service, state,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
@@ -291,9 +307,13 @@ int connman_provider_set_state(struct connman_provider *provider,
 		return -EINVAL;
 	case CONNMAN_PROVIDER_STATE_IDLE:
 		return set_connected(provider, false);
-	case CONNMAN_PROVIDER_STATE_CONNECT:
+	case CONNMAN_PROVIDER_STATE_ASSOCIATION:
+		/* Connect timeout is not effective for VPNs in this state */
 		return provider_indicate_state(provider,
 					CONNMAN_SERVICE_STATE_ASSOCIATION);
+	case CONNMAN_PROVIDER_STATE_CONNECT:
+		return provider_indicate_state(provider,
+					CONNMAN_SERVICE_STATE_CONFIGURATION);
 	case CONNMAN_PROVIDER_STATE_READY:
 		return set_connected(provider, true);
 	case CONNMAN_PROVIDER_STATE_DISCONNECT:
-- 
2.30.2


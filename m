Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3342FB6
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0c21528e-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:28 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/5] openvpn: Default to 10 AuthErrorLimit unless set by user
Date: Thu,  2 Sep 2021 18:11:23 +0300
Message-Id: <20210902151124.4983-5-jussi.laakkonen@jolla.com>
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

Unless the user has set a value for provider property "AuthErrorLimit"
default to 10 attempts after a successful connection has been made before
allowing to clear the credentials. This is imperative for the cases when
OpenVPN server requires client to do a clean shutdown but the network
goes down before it can be completed. In these cases server may respond
back with AUTH_FAILED control message until it determines that old
client is realy gone. By using this limit credentials are not
unnecessarily cleared because there was no real problem with them.
---
 vpn/plugins/openvpn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vpn/plugins/openvpn.c b/vpn/plugins/openvpn.c
index daf66cd5..7089d6ce 100644
--- a/vpn/plugins/openvpn.c
+++ b/vpn/plugins/openvpn.c
@@ -1099,6 +1099,15 @@ static int ov_connect(struct vpn_provider *provider,
 	const char *tmpdir;
 	struct ov_private_data *data;
 
+	/*
+	 * Explicitly set limit of 10 for authentication errors. This defines
+	 * the authentication error message limit from the server before VPN
+	 * agent is instructed to clear the credentials. This is effective only
+	 * after a successful connection has been made within CONNECT_OK_DIFF
+	 * time. User defined value for "AuthErrorLimit" overrides this.
+	 */
+	vpn_provider_set_auth_error_limit(provider, 10);
+
 	data = g_try_new0(struct ov_private_data, 1);
 	if (!data)
 		return -ENOMEM;
-- 
2.20.1


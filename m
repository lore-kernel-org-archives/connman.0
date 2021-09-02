Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D442FAF
	for <connman@lists.linux.dev>; Thu,  2 Sep 2021 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0c8bc17e-0c00-11ec-96db-005056bdf889;
	Thu, 02 Sep 2021 18:11:29 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/5] doc: Document AuthErrorLimit in VPN connection API
Date: Thu,  2 Sep 2021 18:11:24 +0300
Message-Id: <20210902151124.4983-6-jussi.laakkonen@jolla.com>
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

Add documentation of AuthErrorLimit that can be set for each provider
via the D-Bus API.
---
 doc/vpn-connection-api.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/vpn-connection-api.txt b/doc/vpn-connection-api.txt
index 6e6293e4..1f6403fe 100644
--- a/doc/vpn-connection-api.txt
+++ b/doc/vpn-connection-api.txt
@@ -235,6 +235,19 @@ Properties	string State [readonly]
 			The VPN server activated route. These routes
 			are pushed to connman by VPN server.
 
+		string AuthErrorLimit
+
+			This value defines the amount of authentication errors
+			that are allowed before informing VPN agent to clear
+			the credentials in case there was a previous successful
+			VPN connection made within one hour. This is to be used
+			with providers that allow only one login from one
+			account at a time to prevent clearing of credentials
+			when networks are rapidly changed. This value is used
+			as an integer and if unset this default to "1" for all
+			except OpenVPN that uses value "10". Setting value "0"
+			disables the feature for the provider.
+
 		There can be other properties also but as the VPN
 		technologies are so different, they have different
 		kind of options that they need, so not all options
-- 
2.20.1


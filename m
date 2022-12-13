Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F333FF
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 716fc15c-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:13 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 9/9] doc: Update VPN documentation for association state
Date: Tue, 13 Dec 2022 16:07:07 +0200
Message-Id: <20221213140707.278313-10-jussi.laakkonen@jolla.com>
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

Add brief descriptions of the association state. Add it to parameter
descriptions as well.
---
 doc/vpn-connection-api.txt | 4 ++--
 doc/vpn-overview.txt       | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/vpn-connection-api.txt b/doc/vpn-connection-api.txt
index 2d3e0078..df070957 100644
--- a/doc/vpn-connection-api.txt
+++ b/doc/vpn-connection-api.txt
@@ -104,8 +104,8 @@ Properties	string State [readonly]
 
 			The connection state information.
 
-			Valid states are "idle", "failure", "configuration",
-			"ready", "disconnect".
+			Valid states are "idle", "failure", "association",
+			"configuration", "ready", "disconnect".
 
 		string Type [readonly]
 
diff --git a/doc/vpn-overview.txt b/doc/vpn-overview.txt
index d2d14a0c..7a07fdd1 100644
--- a/doc/vpn-overview.txt
+++ b/doc/vpn-overview.txt
@@ -66,7 +66,9 @@ VPN agent interface described in vpn-agent-api.txt is used for
 interaction between the connectivity UI and ConnMan. A VPN agent
 registered via Management interface gets requests from the VPN plugins
 to input credentials or other authentication information for the VPN
-connection and offers information about the VPN to be connected.
+connection and offers information about the VPN to be connected. When
+waiting for input via VPN agent the state of the VPN is "association"
+and after getting the input the state transitions to "connect".
 
 In addition to basic credentials, there are additional types of optional
 and control parameters. The user can dictate whether to store the
-- 
2.30.2


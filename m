Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A116D13
	for <connman@lists.linux.dev>; Tue, 17 Aug 2021 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id db06ddac-ff6d-11eb-b1af-005056bdfda7;
	Tue, 17 Aug 2021 18:14:45 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] vpn: Handle ENOLINK error in connect callback
Date: Tue, 17 Aug 2021 18:14:43 +0300
Message-Id: <20210817151443.32305-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210817151443.32305-1-jussi.laakkonen@jolla.com>
References: <20210817151443.32305-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add handling of ENOLINK error that is reported back by vpnd when a VPN
cannot be connected because connmand is in offline state. ENOLINK has
to be handled similarly to EINPROGRESS as it is not a real error in the
actual VPN connection.
---
 plugins/vpn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index d708d1ff..bc025c0c 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -491,6 +491,9 @@ static int errorstr2val(const char *error) {
 	if (g_strcmp0(error, CONNMAN_ERROR_INTERFACE ".AlreadyConnected") == 0)
 		return -EISCONN;
 
+	if (g_strcmp0(error, CONNMAN_ERROR_INTERFACE ".NoCarrier") == 0)
+		return -ENOLINK;
+
 	if (g_strcmp0(error, CONNMAN_ERROR_INTERFACE ".OperationCanceled") == 0)
 		return -ECANCELED;
 
@@ -538,7 +541,12 @@ static void connect_reply(DBusPendingCall *call, void *user_data)
 		if (err == -ECANCELED) {
 			DBG("%s connect canceled", data->path);
 			connman_provider_set_autoconnect(data->provider, false);
-		} else if (err != -EINPROGRESS) {
+		/*
+		 * ENOLINK (No carrier) is not an error situation but is caused
+		 * by connman not being online when VPN is attempted to be
+		 * connected.
+		 */
+		} else if (err != -EINPROGRESS && err != -ENOLINK) {
 			connman_error("Connect reply: %s (%s)", error.message,
 								error.name);
 			DBG("data %p cb_data %p", data, cb_data);
-- 
2.20.1


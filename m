Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4A3FC0
	for <connman@lists.linux.dev>; Fri, 20 Aug 2021 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 718fdf32-01b7-11ec-ae1c-005056bdd08f;
	Fri, 20 Aug 2021 16:06:33 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 2/2] vpn: Refactor connect_reply() and handle NoCarrier ->  ENOLINK error
Date: Fri, 20 Aug 2021 16:06:28 +0300
Message-Id: <20210820130628.20218-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210817151443.32305-3-jussi.laakkonen@jolla.com>
References: <20210817151443.32305-3-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor connect_reply() to be extendable for more fine grained error
handling.

Add handling of ENOLINK error that is reported back by vpnd when a VPN
cannot be connected because connmand is in offline state. ENOLINK is to
be handled as any other error causing the VPN state not to change later
on that in turn would cause the cb_data->callback() never getting
called.
---
Changes since v2:
 * Change commit title to describe the change.
 * ENOLINK must be handled as an error since otherwise callback is not called
 * Refactor the connect_reply() to be more extendable in the future.

 plugins/vpn.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index d708d1ff..387447c3 100644
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
 
@@ -529,16 +532,23 @@ static void connect_reply(DBusPendingCall *call, void *user_data)
 	if (dbus_set_error_from_message(&error, reply)) {
 		int err = errorstr2val(error.name);
 
+		switch (err) {
+		case -EINPROGRESS:
+			break;
 		/*
 		 * ECANCELED means that user has canceled authentication
 		 * dialog. That's not really an error, it's part of a normal
 		 * workflow. We also take it as a request to turn autoconnect
 		 * off, in case if it was on.
 		 */
-		if (err == -ECANCELED) {
+		case -ECANCELED:
 			DBG("%s connect canceled", data->path);
 			connman_provider_set_autoconnect(data->provider, false);
-		} else if (err != -EINPROGRESS) {
+			break;
+		case -ENOLINK: /* vpnd reports that connmand is not online. */
+		case -EISCONN:
+		case -ECONNREFUSED:
+		default:
 			connman_error("Connect reply: %s (%s)", error.message,
 								error.name);
 			DBG("data %p cb_data %p", data, cb_data);
-- 
2.20.1


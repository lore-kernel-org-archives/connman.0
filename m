Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77787BE5E
	for <connman@lists.linux.dev>; Thu,  3 Jul 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570343; cv=none; b=QCURyolzedUJlGVkkmjcwnyS34Z372p8kfkPqnd4NQxDqzulHK5/F1gTUXbEpyMnTADxydtdPExS5NxCXsMpnJVI0OWUE4Eh31zroQxy38LkAtbPkWvdg3myjP4qxxDU55fm0wfB7ep7XkvSxeoaXAkggR3tQ/RobTblAL+HvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570343; c=relaxed/simple;
	bh=hQp8j6VPy2FbCOOc0MZjxHNgFhyahwundTYjizPXhvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKXpENtMcaBQNUyibuwjHey3KlVRQ6fHPTMUFm3gbi+K/chCA5CKNo5nc8EGlAoMkomJobQMWdX2j9bgbBZM0XfgOlHUL5GFzbumpP58LUR+qjq5dxqtTottqKghazwaF2AhaKgt9q2Q8RJpWka1g/ByWTHZ5Dethh2QqEtEnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.53 with ESMTP; 4 Jul 2025 03:48:58 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: jaeyoon.jung@lge.com
Received: from unknown (HELO magneto.lge.net) (10.177.121.44)
	by 156.147.1.127 with ESMTP; 4 Jul 2025 03:48:58 +0900
X-Original-SENDERIP: 10.177.121.44
X-Original-MAILFROM: jaeyoon.jung@lge.com
From: jaeyoon.jung@lge.com
To: connman@lists.linux.dev
Cc: Jaeyoon Jung <jaeyoon.jung@lge.com>
Subject: [PATCH] client: Add missing newlines on error messages
Date: Fri,  4 Jul 2025 03:48:11 +0900
Message-ID: <20250703184812.988694-1-jaeyoon.jung@lge.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaeyoon Jung <jaeyoon.jung@lge.com>

This adds missing newlines at the end of some error messages.
---
 client/commands.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/client/commands.c b/client/commands.c
index 53cc14c8..376ccdb5 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -1874,7 +1874,7 @@ static int session_create_cb(DBusMessageIter *iter, int errnum,
 	char *str;
 
 	if (error) {
-		fprintf(stderr, "Error creating session: %s", error);
+		fprintf(stderr, "Error creating session: %s\n", error);
 		session_notify_remove();
 		return 0;
 	}
@@ -2044,7 +2044,7 @@ static int session_destroy_cb(DBusMessageIter *iter, int errnum,
 			const char *error, void *user_data)
 {
 	if (error) {
-		fprintf(stderr, "Error destroying session: %s", error);
+		fprintf(stderr, "Error destroying session: %s\n", error);
 		return 0;
 	}
 
@@ -3026,7 +3026,7 @@ static int populate_service_hash(DBusMessageIter *iter, int errnum,
 				const char *error, void *user_data)
 {
 	if (error) {
-		fprintf(stderr, "Error getting services: %s", error);
+		fprintf(stderr, "Error getting services: %s\n", error);
 		return 0;
 	}
 
@@ -3086,7 +3086,7 @@ static int populate_vpnconnection_hash(DBusMessageIter *iter, int errnum,
 	DBusMessageIter array;
 
 	if (error) {
-		fprintf(stderr, "Error getting VPN connections: %s", error);
+		fprintf(stderr, "Error getting VPN connections: %s\n", error);
 		return 0;
 	}
 
@@ -3158,7 +3158,7 @@ static int populate_peer_hash(DBusMessageIter *iter, int errnum,
 			const char *error, void *user_data)
 {
 	if (error) {
-		fprintf(stderr, "Error getting peers: %s", error);
+		fprintf(stderr, "Error getting peers: %s\n", error);
 		return 0;
 	}
 
-- 
2.47.2


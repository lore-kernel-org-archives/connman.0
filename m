Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A920ADEF
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403579; cv=none; b=f+9VmPYRcBI8BI/USW6uqQeUmT+TGhltlnZPoaw1AhrCdGIymJl8KJ+HvXGr8aj694MFyl6gR2Ydl4UDPz+3zKAMyT3ekYr0Jdijdk4Ne4pH/8iHzH5OqRFQU5HH81CQLjftCFyxFfcfPkDjH+iB30g6dYChgxzcdqp4ZswuS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403579; c=relaxed/simple;
	bh=O/6pdNPvUZenmfKvGhOjTx3XTk3dA7+zdf7WEsU/8uE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6UpFk86iIQkRMYwB+jwUSWWurD4uxA1xXdSgSnoNY6D8nYcYz9ohZU+1/HtwkAXJFW2mGCoe+jJ1BmtpDyki5mLG8UcvEN2wB8dX50qL3glyqETZ+8stnroMx+UsxBuMk64dD6hII6am9T/SatjUv9m1n79lj8bHvu72IoiZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=cdrNpgzQ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="cdrNpgzQ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 87C031649D5
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 38FF4124F28
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] ofono: Use goto error-handling semantics in 'add_cm_context'.
Date: Wed, 12 Feb 2025 15:39:31 -0800
Message-ID: <176e12723e92e75ea8b62cad6b622306002cfcf1.1739403363.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739403363.git.gerickson@nuovations.com>
References: <cover.1739403363.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=nvO5Uac9Gi1Q4FQaKD/iVS2MEUmnjbDXDDnQbSRbrzU=; b=cdrNpgzQxmqBgFb8dZtja271quHZFRtk+AVBGhQlCsLbhUNM9vrV/seilJtX3QBTx3v/eEi/zd2o8w22UA8ZpCckAu4oIV2GVjs14JrSxTrWm4Xyv/JmjyZaRNIgu17uZi5WbVptDFw7EF8Zbt3RNjUpLGN9S2Mq3T4bTaJ9CsJzAX+TITHHMp6ZojqWofOZa5emVkUeD57R7YPgXnXR+2pMuYwfl0rJSoJg8UUj+/F4k1TFaYvcwjpPOlvVbWJnRNFrJ3SmajOErs8uMInx58t9FnJZUGdHiYnU7TMwdcoCl1WKVXgVempyz8G3dnaoHpalaCa3j9v4M/Djx0ARVQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Eases current and future debugging of ofono cellular context additions
by allowing for a single point of DBG instrumentation for the
'add_cm_context' return value, indicating whether or not the proposed
context was added successfully.
---
 plugins/ofono.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 47f289f605e0..b7a5f80bda5c 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1160,12 +1160,15 @@ static int add_cm_context(struct modem_data *modem, const char *context_path,
 	struct network_context *context = NULL;
 	dbus_bool_t active = FALSE;
 	const char *ip_protocol = NULL;
+	int err = 0;
 
 	DBG("%s context path %s", modem->path, context_path);
 
 	context = network_context_alloc(context_path);
-	if (!context)
-		return -ENOMEM;
+	if (!context) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	while (dbus_message_iter_get_arg_type(dict) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -1217,7 +1220,8 @@ static int add_cm_context(struct modem_data *modem, const char *context_path,
 
 	if (g_strcmp0(context_type, "internet") != 0) {
 		network_context_unref(context);
-		return -EINVAL;
+		err = -EINVAL;
+		goto done;
 	}
 
 	if (ip_protocol)
@@ -1232,7 +1236,10 @@ static int add_cm_context(struct modem_data *modem, const char *context_path,
 	    has_interface(modem->interfaces, OFONO_API_NETREG))
 		add_network(modem, context);
 
-	return 0;
+done:
+	DBG("err %d", err);
+
+	return err;
 }
 
 static void remove_cm_context(struct modem_data *modem,
-- 
2.45.0


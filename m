Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBE2165E2
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742423; cv=none; b=WUROEAFDp5WZeugFlollgMMHiqi/bA1CW2S7JbFLa1mY7qyOW9HZgc6u6F9w+J5G/Kb5XvpPO33sgbJPBGII7AJEvns908gAiwcoPq17/7L31xaweBy+/Xr7Zer1lQsxFMsQP8W1lsqpPfcX+vQ+f8SwOwp1/IXvVV4YTVvAQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742423; c=relaxed/simple;
	bh=ER/3GZqn248wTxkn1HoJe8jZW/VLwNViKy0bk1FnB9o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3xE2R4qXTZ8GLYhO4OjDQn+iDbbwQJRc21NRlXWfsYViR4hld6KuHY9eDDxWpwm60adn7S2MRvlikkA8tPK5lP6HZx8XGw+lhJ4pJvQyk3zuI82LgtT/VEHre9OqX/obmHsXVRqmXMOVe/saS5qjFl4XOKthKBLtJBHBea97VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=JaSxvrRF; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="JaSxvrRF"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B69BC164A96
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:19 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6F727124E6D
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:19 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] technology: Leverage 'DefaultEnabledTechnologies' setting.
Date: Mon, 28 Jul 2025 15:32:16 -0700
Message-ID: <20250728223217.3991877-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250728223217.3991877-1-gerickson@nuovations.com>
References: <20250728223217.3991877-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=rwBx6EhVtZEL7A4XIPwo9HSjnoPYKTqUcUkC6iNmfdk=; b=JaSxvrRFnDMwnfgyEjUkomTnxlNe22so6nbWVuXcVgxG8UDMYbNqu7OkvNJmK9IPmGmBQBCBpOz1eG4Q+nadEKKCO2chg4JDVcavqxXl98/IryA+ubhRtvOksad7Ue16iXKcR+hIwJmUCKABAdVjKpotGDqGlEq6yNJKnaNP8nVIAuMl957a6U6zm9B67ktqfkgghn82+H1lYT/wThn9GFmuwK8JHPtuUJ0TyrshDQH7QhCZn+tT9IZyTe0Q1FxoeFJ+C2UiwvFGrafj3FcYnuBxftkOZU07f39l+RS2EG+K00W3nRMolWgg2TjoVwV1qS+cM+198vU5H3V59PZ6ug==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This leverages the new 'DefaultEnabledTechnologies' configuration
setting.
---
 src/technology.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/technology.c b/src/technology.c
index 270d83d0d3cb..2c709abdd3df 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -429,19 +429,27 @@ static void technology_load(struct connman_technology *technology)
 	GKeyFile *keyfile;
 	gchar *identifier;
 	GError *error = NULL;
-	bool enable, need_saving = false;
+	bool enable, need_saving = false, enable_persistent = false;
 	char *enc;
+	int i;
+	unsigned int *enabled_types;
 
 	DBG("technology %p", technology);
 
+	/* Determine which technology types are enabled by default */
+
+	enabled_types = connman_setting_get_uint_list("DefaultEnabledTechnologies");
+	for (i = 0; enabled_types && enabled_types[i] != 0; i++) {
+		if (technology->type == enabled_types[i]) {
+			enable_persistent = true;
+			break;
+		}
+	}
+
 	keyfile = __connman_storage_load_global();
 	/* Fallback on disabling technology if file not found. */
 	if (!keyfile) {
-		if (technology->type == CONNMAN_SERVICE_TYPE_ETHERNET)
-			/* We enable ethernet by default */
-			technology->enable_persistent = true;
-		else
-			technology->enable_persistent = false;
+		technology->enable_persistent = enable_persistent;
 		return;
 	}
 
@@ -453,10 +461,7 @@ static void technology_load(struct connman_technology *technology)
 	if (!error)
 		technology->enable_persistent = enable;
 	else {
-		if (technology->type == CONNMAN_SERVICE_TYPE_ETHERNET)
-			technology->enable_persistent = true;
-		else
-			technology->enable_persistent = false;
+		technology->enable_persistent = enable_persistent;
 
 		need_saving = true;
 		g_clear_error(&error);
-- 
2.45.0


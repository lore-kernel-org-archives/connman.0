Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2722DF99
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742425; cv=none; b=VlfhuGWblc0egusxBbAddRwN7wzm6PwvlTTMkNSk1doFe+/Ibi3OX1iFk4gPQI5z7qpEhwMAdfUhxWCdRQgjH0C9cJeM/CfAPeUla1Qa8puVOubKKbQ/nVM8xyhJvb1ZUKi5UpVWmAlcxFlYS3AokZC9FWC6RQOewqDZYrb559Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742425; c=relaxed/simple;
	bh=5R6aNQmApP4D5Pq2KoWbLMXbthTHgroTzWMVswoUM0w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8nY0itm0aAF4Y3cANpEVBgjxP8tEqni2JBfg1sJ6OBhhFUtzDaoHjkKH7vRSzmHnRwkw8t6PdIE0q9kK0iXzvqbNp3TS0BDXSpbrEfmVMi0G3lwohpHRarThG7O5WW/pscfOAffCoVuvKoC5DN6UIr7N1QJUPHqTaaXlmE+uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=k8oGEMWY; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="k8oGEMWY"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 2CFE0164A9A
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:20 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D9212124E6D
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:19 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] doc: Document the 'DefaultEnabledTechnologies' setting.
Date: Mon, 28 Jul 2025 15:32:17 -0700
Message-ID: <20250728223217.3991877-4-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=LZuT8FoDAznwm5aRirZjO7qxLdALIhj7DRWxyh60PL4=; b=k8oGEMWYWkwOO1a9LVUbqezisgfaZi20FaMG8r5Xhuj0I5Dli3VB2QIkN8YDclhfIyBZ8YqrIpGJkdYxHcGJoV4iTY7Gglb6XomCNvBG8o3K9h8UmkQN1vxxRnPHMnAmZ0EdsyOni/cylT+B+dmrW8/tlcK0hAk+YHzpqfGaeuP0vTT5fxmsmDutHcwQa8UswdbZ96dBGT+7RIaFEkncLzDtzv7vPlzrr+BP4crRR/1JtXykh8wOQYhb+rsrA4Wx+MK/JHqZIhh74pgc3Uhbf91KK3YEEiQLVqddgo3vBRH2y2ylCWtCDsVkbSboUIP/z1ICzgFcs1GtVr13lUIOuQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This documents the 'DefaultEnabledTechnologies' configuration setting.
---
 doc/connman.conf.5.in | 5 +++++
 src/main.conf         | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 7ab0b28b1f9e..a81ac7bb1e45 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -77,6 +77,11 @@ for this entry when empty is ethernet,wifi,cellular.
 Services that are automatically connected must have been
 set up and saved to storage beforehand.
 .TP
+.BI DefaultEnabledTechnologies= technology\fR[,...]
+List of technologies that are marked enabled or powered
+by default, separated by commas ",". The default value for
+this entry when empty is \fIethernet\fR.
+.TP
 .BI DefaultFavoriteTechnologies= technology\fR[,...]
 List of technologies that are marked favorite by default,
 separated by commas ",". The default value for this entry
diff --git a/src/main.conf b/src/main.conf
index 53de3cd202f1..da1307d9ed09 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -49,6 +49,11 @@
 # set up and saved to storage beforehand.
 # DefaultAutoConnectTechnologies =
 
+# List of technologies that are marked enabled or powered
+# by default, separated by commas ",". The default value for
+# this entry when empty is "ethernet".
+# DefaultEnabledTechnologies
+
 # List of preferred technologies from the most preferred
 # one to the least preferred one separated by commas ",".
 # Services of the listed technology type will be tried one
-- 
2.45.0


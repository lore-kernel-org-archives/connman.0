Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93D748A
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981834; cv=none; b=PZdW8adJn7koHLSEJ3VrJNzYNJkQaZcManE/4tJ/ulYbiCX3XlrSN9wEuUrGsLW+M1UA4flbld9y7vqpoOxXhilf+DZttnac5y5FPoZ5a8E4L2O83tU55cIZ5EO8VAbFcN5nrQW+2ox7h+0lDuTgDdN9ZoNxWTmEHCdT2OMjjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981834; c=relaxed/simple;
	bh=cHPl4D49YzgjiTPpg6VKrOtLuziez6x9dstG2MRoNaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhjsMKiE4gWNaYgrfreMcR1BH6lDdnhGdKntTrYFIi+zgArKcF3ztoxC5Oc5lWpuX4Y+wgpgijzu69UTIXcZv68y/QHvHyYoyg4hgJVPJwoA3AVW5Mj5Gak6+m8i791lrHkC6vXS/VzYEzXqbROUKsoDf6Hf3i7P4CkiOQFVo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=UeDjo+mc; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="UeDjo+mc"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 345DF1649BA
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:19 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DD83B124FD0
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/15] service: Add 'service_log_pac' function.
Date: Wed, 11 Dec 2024 21:28:03 -0800
Message-ID: <20241212052817.2021264-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241212052817.2021264-1-gerickson@nuovations.com>
References: <20241212052817.2021264-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=9fe+bQ1COG98YkRJbgrD9E5NKklRxJhPfW8htohn3jE=; b=UeDjo+mcNzfQeVCZlzcGpdfgrGUMTkSXrp1+6QeGGAcA4xp7DIYKD0DM/B8v6P+gcy8xyl0f0V2wVkOab8Pv4k9q7gSX3y4nK+CMPFWEA4lCcWH1mMcJxbPtNBdao3U8cmNmyi2gYssSHEIEndE6ATkmdVtT3tVtKBwow6L+rOL5JfSf2E9MBIrXtl2JoBoYITfV2H6FTMqEnwdHT0zT1MYsaAtKIwNtOPR6z654nFDRUNnzl4Dvlnb+nuYxq5FSVDcuTKolcEV53RIuqxY0YQad8VhmLnjzVIeSpVcIZCewbdzF9iz6KL863Tru6rWLG4YC+bmZsGARRcYE5FgqgQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Logs the network service interface name and type at the info level
when the proxy auto-configuration (PAC) URL is set or cleared.

Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
is the source of connectivity problems, particularly for online
reachability checks.
---
 src/service.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/service.c b/src/service.c
index 805cfca7ad12..0ab299e8ecbf 100644
--- a/src/service.c
+++ b/src/service.c
@@ -555,6 +555,19 @@ int __connman_service_load_modifiable(struct connman_service *service)
 	return 0;
 }
 
+static void service_log_pac(const struct connman_service *service,
+				const char *url)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(service);
+
+	connman_info("Interface %s [ %s ] proxy auto-configuration (PAC) URL %s.",
+				 interface,
+				 __connman_service_type2string(service->type),
+				 url ? url : "is not set");
+}
+
 static int service_load(struct connman_service *service)
 {
 	GKeyFile *keyfile;
-- 
2.45.0


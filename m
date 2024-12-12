Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EA1632D3
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981834; cv=none; b=tF2TWARSYwjh+64EdrvPyMe8vovk9QRRneagXB+R5Rt0znwiiCIVp4fVQlQmzw6AZcThjmS/8tOTNsSLFyD7dswhc7/OPF6ORPuKjwjSdghaLoAU1YvkGmO2LGq7yVAsIrqpq2zBqvbKleC7AkjLEWRSf89xWk30Br7Iw2k/q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981834; c=relaxed/simple;
	bh=gcQDwiNlApbr8vuxA1f8McIOwK/VHDf09k5bLSWTn2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiFgY7ApQJ+KIqlxDfDWgn9ls1VcAwV0j31FeLryM5Kht5UOT42aqeB5WtfpI5IDFG2sXEg5SjUWx671HQOUay+mZ5Q0TfH+fjFbu8d89uEVJFTy9Iok2fEYxTGlsXlEpGzzlta8+HkcMIna8LeSsdbsdE8pPYFUueuEYp7zzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fwEnmIZd; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fwEnmIZd"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C43DA1649C1
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:19 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 58E63124FD0
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 02/15] service: Add 'service_set_pac' function.
Date: Wed, 11 Dec 2024 21:28:04 -0800
Message-ID: <20241212052817.2021264-3-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=swBuVsbs5tHoForVMqgAD0nWLf1VIoj6qXtKjx3EY2w=; b=fwEnmIZdEcZhwuaNFckHaGBpnw+sd33jbsODzouAXqqilxOo7eA9GcqBMJhJI4VepDNQHy8dpO1Jnt9+m+t6qf8jeqbfulcWhquStLc2FZ48fpboSTh757CnMccjJ+Ul+w6KOJSUHg71QMLNb1xdcZDmKUuljOWhGjd8DM4jQtfXkZEGIvrVQAjILGyRxN3VUJ9dSBPjr/2qqJtKhENLDixjMDPn7YdoWCPb82nDAUrw7B3BrtRLjExPHNTyv6kqwN+yWvNsfA/IeHC/ibDUswe2Z9147bJyjqNHxWDG7DEgccc5IfAmIRMC2hTr63gP1fKj2ZtFYrplYx65PPQlIg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Allows for logging, setting, and dispatching property changed
notifications from a single place.
---
 src/service.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/service.c b/src/service.c
index 0ab299e8ecbf..c48959a7940f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -233,6 +233,7 @@ static struct connman_ipconfig *create_ip4config(struct connman_service *service
 static struct connman_ipconfig *create_ip6config(struct connman_service *service,
 		int index);
 static void dns_changed(struct connman_service *service);
+static void proxy_changed(struct connman_service *service);
 static void vpn_auto_connect(void);
 static void trigger_autoconnect(struct connman_service *service);
 static void service_list_sort(const char *function);
@@ -568,6 +569,32 @@ static void service_log_pac(const struct connman_service *service,
 				 url ? url : "is not set");
 }
 
+static void service_set_pac(struct connman_service *service,
+				const char *pac,
+				bool dochanged)
+{
+	DBG("service %p (%s) pac %p (%s) dochanged %u",
+		service, connman_service_get_identifier(service),
+		pac,
+		pac ? pac : "<null>",
+		dochanged);
+
+	if (service->hidden)
+		return;
+
+	service_log_pac(service, pac);
+
+	g_free(service->pac);
+
+	if (pac && strlen(pac) > 0)
+		service->pac = g_strstrip(g_strdup(pac));
+	else
+		service->pac = NULL;
+
+	if (dochanged)
+		proxy_changed(service);
+}
+
 static int service_load(struct connman_service *service)
 {
 	GKeyFile *keyfile;
-- 
2.45.0


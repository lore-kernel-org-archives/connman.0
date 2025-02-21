Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4851E491B
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153419; cv=none; b=WAHQi2956q0rzPdYUF836+ajz3y45iBvOPbgZC0Cdad5nnq9LZDXNMpv5/0ruyXrH2G7kRSgqrLinGrrAWCergFp6h+Fkyl2cq0V0/wxUeijvcGSFUAMEZAtPJWmz9bCTGdbrIUFaRE7trDjl1fmmdglhnHTpZGPyXEBrfh0VJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153419; c=relaxed/simple;
	bh=cHPl4D49YzgjiTPpg6VKrOtLuziez6x9dstG2MRoNaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3AKfvSTOUjraQ3/82jCovOksRaeKxZwdaxuYX4qSCaKqFNPxvRexnjGG73w+ZOWBFrpRudB7c9vezgCe7Xsdr5AoAlTFkyJCWfp1AE8twa1Da6xLkX0MWSLJ/6l0QePjcoqZIKk/LlZ9d71V1aFcsorrIGN2yJ6xApseqsFRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=dW3t7pgx; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="dW3t7pgx"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CCB6C164A23
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:55 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8087712516C
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/15] service: Add 'service_log_pac' function.
Date: Fri, 21 Feb 2025 07:56:39 -0800
Message-ID: <20250221155653.760046-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=9fe+bQ1COG98YkRJbgrD9E5NKklRxJhPfW8htohn3jE=; b=dW3t7pgxmqsbDutnADJPVbStzR4RlkAHDRB4WNaHI0x6e5WdlfxyFmTGU6qytUWAOZ1U4YTa6JEPvTC32KH1ZrGYHmvVtes9gJGPye/eeqhULNBT0R+ysVYfKJMWh7CCvu0uP7tYvAoi5f/dd51eKuWAJj6J5jao1SVBEoRhZt1Sy2r4xTQ6GWht+tGJ59K+usiGHFT1Jei3meWKKALrMmbX8o9ZpidlwK7IfqKDlAYIHfsaX+3jq5JxENfxqE0peYWMKwG1CFKwgaPJuqB/pNFPafPwT3iemHFey3t3JG92yRn/aqKEwKZc0VdAtS+wqZPB7aZBnLj4CANGj1Rshw==
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


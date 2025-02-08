Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C14A8B
	for <connman@lists.linux.dev>; Sat,  8 Feb 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976524; cv=none; b=EPUH5D3pk7kIa1kMwVkGTCktHf+IRCwQjeenTGgehftjlpNnHxHIxIb9pzD+xNIfaEVHbT1XFv8E/KtnmnqSsHy+StFEuhExzPlt0Z1pmrXV83G59volmUJpwRGO6A/iwmqPzE2c5zvy95bgJK7ZcthdH3s/qY3oe0FvYEmin2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976524; c=relaxed/simple;
	bh=pCKIDsZabZ/wOhaWazyFIFD1VAXZy/L25MBxTuNPeNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZnvKJmxkWq1BiewC/yvPqyqnfyhspez0kIRv/KK+9tkkuENQ9SkM40dnKt36sBAZW1S5euQEKtwybf059p88mcgZkJCW0O2SoJ+FpegCv4j8KRYaykAWRr3K8V890mSpU6/JS2phoSWQ/8xcPt8f/ciHkT0EcGB/snO0H7qOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=IkOvkFf5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="IkOvkFf5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 08671164A90
	for <connman@lists.linux.dev>; Fri,  7 Feb 2025 20:02:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B38AF124FB3
	for <connman@lists.linux.dev>; Fri,  7 Feb 2025 20:02:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] ofono: Document 'add_cm_context'.
Date: Fri,  7 Feb 2025 17:01:58 -0800
Message-ID: <231da3e13894648ae7e18c1c7618eab5f2013d8c.1738976381.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738976381.git.gerickson@nuovations.com>
References: <cover.1738976381.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=vEZ3ng5k/2FWQsLR7KjIOhHHRzi4ol/bhF0DSBKM/TI=; b=IkOvkFf5tNTpaa5PXMCfNDkvngBpRh1MiVT6uozqewuYT0pWnbEorSYHsAoVpDHnokGygQEJlsin3Vz3psQcuMKIdpyd0kvshiJCDQpnzl6AJrEjGvVxHufiIF1ajGxlmUZcdq6g72EgBvOJaHCr+iYxdcMZZAONYMI7JdJemspKk7b4I3mAXDQXAMaWDEJYTkmSKPK4TA3bxeziHZgbybwiA7Wg3ETwD7t4A1CLBKocOd86Ms4eD/vYh5gGNWkeWJx3z4tOPNwAUXr/jGNM87rNmTWRVSFPsIFGo6BhEPse/K9I2imEZBWBAjiMQjhTbLPLUo4E1ZWJozy1LaxOnA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'add_cm_context' function.
---
 plugins/ofono.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 6b89df3af0ae..17df01ff013e 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1147,6 +1147,35 @@ static int set_context_ipconfig(struct network_context *context,
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Attempt to add an oFono context.
+ *
+ *  This evaluates the oFono context with the specified path and
+ *  dictionary. If it finds one of type 'internet', it adds the
+ *  context to the modem context list; adds the modem to the context
+ *  hash, keyed off the context path; and, if the context has a valid
+ *  APN, the modem is attached, and has a network registration
+ *  interface, a connman network object is created for the context.
+ *
+ *  @param[in,out]  modem         A pointer to the mutable modem data
+ *                                instance associated with @a
+ *                                context_path.
+ *  @param[in]      context_path  A pointer to an immutable, null-
+ *                                terminated C string containing the
+ *                                path of the context to evaluate.
+ *  @param[in]      dict          A pointer to a D-Bus message iterator
+ *                                for the dictionary associated with
+ *                                the context to evaluate.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -ENOMEM  If memory could not be allocated for a context
+ *                    instance.
+ *  @retval  -EINVAL  If the context was not of type 'internet'.
+ *
+ *  @private
+ *
+ */
 static int add_cm_context(struct modem_data *modem, const char *context_path,
 				DBusMessageIter *dict)
 {
-- 
2.45.0


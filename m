Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DE241CBC
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203201; cv=none; b=rBSj1rR1pbKeUcB3mn4h3yKWOYjIT6pyVOlBQ7w79THq8SZxACFF6u/JHJodKGk77pp6CNUQl2fRQunRXkJQDuZzJN8DeKwKg//wnbq5JyYSp7+/CXQ8KJmyLkkEEPzKdFliDG6zPi+EFD5QdxMwHWb5+UoaiMqONf4CA4PMBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203201; c=relaxed/simple;
	bh=pCKIDsZabZ/wOhaWazyFIFD1VAXZy/L25MBxTuNPeNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSi0seLOBk17Yn/n+a3da6vS5XKbMDsHD0hmtIzC+r3WCtbkZw1ufrLpbVAMWDbNrVCxtnh5Vk/FsUdgWLkbkmWDLzq+ujI05sdABq3nwW0K58PK6r99yeCN+rJIrAn9JWTJzBsYFK3WnaHTDN8aa0w7s1E7oyzcixBbqsBGpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Cn6Tpx46; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Cn6Tpx46"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5613F164A6D
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 10:59:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0E43A124F64
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 10:59:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 2/2] ofono: Document 'add_cm_context'.
Date: Mon, 10 Feb 2025 07:59:49 -0800
Message-ID: <d4a24a17c23fe773efdca0f2454d3cbc9794a791.1739203086.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739203086.git.gerickson@nuovations.com>
References: <cover.1739203086.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=vEZ3ng5k/2FWQsLR7KjIOhHHRzi4ol/bhF0DSBKM/TI=; b=Cn6Tpx46r4YGvQA1AGrTxVlhLbQh3FxAi5QU3WvnbMJwUKdsy+bVKpsJ/hjDKF0YfhxpdmOdCHNosJPuYpLqpITqQMnqygjqu7QUEMO1ysU2Eigvt7H/OFPicnxmBxW/53UOKrpglYsuBEsOtvpsDBDz3DcZiWdP14ZXhKQbzsyGQHX8VxeHAcvzX+yBUnGzX0HCManj6Revez+ocNFmylhJBwhF9sD/Yjzef6NOEugEc0b323pmoK6GK70IUj/3krpKuYNl85yLoegUGwOphn32r39wZY2mt2iphAj0G/Sl7QngCZCAbgEtWiMAzWr8lFTRhbvD3qH8+lW6e13SlQ==
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


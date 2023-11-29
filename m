Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74A5DF35
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E06C673227
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9947A73247
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:09 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 4/8] connection: Document 'gateway_{config,data}_debug'.
Date: Wed, 29 Nov 2023 11:21:02 -0800
Message-ID: <20231129192106.1295868-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129192106.1295868-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'gateway_{config,data}_debug'
functions.
---
 src/connection.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 586c44330e89..7b530f26c2f2 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -59,11 +59,45 @@ struct gateway_data {
 
 static GHashTable *gateway_hash = NULL;
 
+/**
+ *  @brief
+ *    Return the specified pointer if non-null; otherwise, the
+ *    immutable "<null>" string.
+ *
+ *  @param[in]  pointer  The pointer to be returned if non-null.
+ *
+ *  @returns
+ *     @a pointer if non-null; otherwise the "<null>" immutable
+ *     null-terminated C string.
+ *
+ */
 static const char *maybe_null(const void *pointer)
 {
 	return pointer ? pointer : "<null>";
 }
 
+/**
+ *  @brief
+ *    Conditionally log the specified gateway configuration.
+ *
+ *  This conditionally logs at the debug level the specified
+ *  #gateway_config gateway configuration, @a config, with the
+ *  provided description, @a description, attributed to the provided
+ *  function name, @a function.
+ *
+ *  @param[in]  function     A pointer to an immutable null-terminated
+ *                           C string containing the function name to
+ *                           which the call to this function should be
+ *                           attributed.
+ *  @param[in]  description  A pointer to an immutable null-terminated
+ *                           C string briefly describing @a
+ *                           config. For example, "ipv4_config".
+ *  @param[in]  config       A pointer to the immutable gateway
+ *                           configuration to conditionally log.
+ *
+ *  @sa DBG
+ *
+ */
 static void gateway_config_debug(const char *function,
 				const char *description,
 				const struct gateway_config *config)
@@ -95,6 +129,29 @@ static void gateway_config_debug(const char *function,
 	}
 }
 
+/**
+ *  @brief
+ *    Conditionally log the specified gateway data.
+ *
+ *  This conditionally logs at the debug level the specified
+ *  #gateway_data gateway data, @a data, with the provided
+ *  description, @a description, attributed to the provided function
+ *  name, @a function.
+ *
+ *  @param[in]  function     A pointer to an immutable null-terminated
+ *                           C string containing the function name to
+ *                           which the call to this function should be
+ *                           attributed.
+ *  @param[in]  description  A pointer to an immutable null-terminated
+ *                           C string briefly describing @a
+ *                           data. For example, "default_gateway".
+ *  @param[in]  data         A pointer to the immutable gateway
+ *                           data to conditionally log.
+ *
+ *  @sa DBG
+ *  @sa gateway_config_debug
+ *
+ */
 static void gateway_data_debug(const char *function,
 				const char *description,
 				const struct gateway_data *data)
-- 
2.42.0


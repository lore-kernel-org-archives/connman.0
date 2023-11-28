Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BB5C09B
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 122FC73100
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BB58C73154
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/8] log: Refactor debugging preprocessor macros.
Date: Tue, 28 Nov 2023 15:08:39 -0800
Message-ID: <20231128230847.1224497-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128230847.1224497-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the debugging / debug log preprocessor-related
macros. In particular, it:

    * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
      instantiates an instance of 'connmand_debug_desc'.

    * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
      declares and instantiates an alias (that is, asserts the
      CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
      'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.

    * Introduces CONNMAN_DEBUG which declares and instantiates
      an instance of 'connmand_debug_desc', again using
      CONNMAN_DEBUG_DESC_INSTANTIATE, for controlling an invocation of
      'connman_debug' with it that includes both the file and function
      name the macro was invoked in or attributed to.

      - The key difference between this and 'DBG' is that this allows
        the caller to specify the function string rather than relying on
        '__FUNCTION__' (or __func__).

    * Redefines 'DBG' against 'CONNMAN_DEBUG' with '__func__' as the
      function parameter.
---
 include/log.h | 34 +++++++++++++++++++++-------------
 src/log.c     |  2 +-
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/log.h b/include/log.h
index 8b00e9dc979c..fd47c8d53c9b 100644
--- a/include/log.h
+++ b/include/log.h
@@ -58,11 +58,27 @@ struct connman_debug_desc {
 	unsigned int flags;
 } __attribute__((aligned(8)));
 
-#define CONNMAN_DEBUG_DEFINE(name) \
-	static struct connman_debug_desc __debug_alias_ ## name \
+#define CONNMAN_DEBUG_DESC_INSTANTIATE(symbol, _name, _file, _flags) \
+	static struct connman_debug_desc symbol \
 	__attribute__((used, section("__debug"), aligned(8))) = { \
-		#name, __FILE__, CONNMAN_DEBUG_FLAG_ALIAS \
-	};
+		.name = _name, .file = _file, .flags = _flags \
+	}
+
+#define CONNMAN_DEBUG_ALIAS(suffix) \
+	CONNMAN_DEBUG_DESC_INSTANTIATE(__debug_alias_##suffix, \
+		#suffix, \
+		__FILE__, \
+		CONNMAN_DEBUG_FLAG_ALIAS)
+
+#define CONNMAN_DEBUG(function, fmt, args...) do { \
+	CONNMAN_DEBUG_DESC_INSTANTIATE(__connman_debug_desc, \
+		0, \
+		__FILE__, \
+		CONNMAN_DEBUG_FLAG_DEFAULT); \
+		if (__connman_debug_desc.flags & CONNMAN_DEBUG_FLAG_PRINT) \
+			connman_debug("%s:%s() " fmt, \
+					__FILE__, function, ##args); \
+	} while (0)
 
 /**
  * DBG:
@@ -72,15 +88,7 @@ struct connman_debug_desc {
  * Simple macro around connman_debug() which also include the function
  * name it is called in.
  */
-#define DBG(fmt, arg...) do { \
-	static struct connman_debug_desc __connman_debug_desc \
-	__attribute__((used, section("__debug"), aligned(8))) = { \
-		.file = __FILE__, .flags = CONNMAN_DEBUG_FLAG_DEFAULT, \
-	}; \
-	if (__connman_debug_desc.flags & CONNMAN_DEBUG_FLAG_PRINT) \
-		connman_debug("%s:%s() " fmt, \
-					__FILE__, __FUNCTION__ , ## arg); \
-} while (0)
+#define DBG(fmt, args...) CONNMAN_DEBUG(__func__, fmt, ##args)
 
 #ifdef __cplusplus
 }
diff --git a/src/log.c b/src/log.c
index 554b046b07fa..f7483194b230 100644
--- a/src/log.c
+++ b/src/log.c
@@ -38,7 +38,7 @@ static const char *program_exec;
 static const char *program_path;
 
 /* This makes sure we always have a __debug section. */
-CONNMAN_DEBUG_DEFINE(dummy);
+CONNMAN_DEBUG_ALIAS(dummy);
 
 /**
  * connman_info:
-- 
2.42.0


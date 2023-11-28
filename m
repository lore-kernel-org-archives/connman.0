Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41C5C095
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7C59073147
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 35F6273156
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/8] log: Document debugging preprocessor macros.
Date: Tue, 28 Nov 2023 15:08:40 -0800
Message-ID: <20231128230847.1224497-3-gerickson@nuovations.com>
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

This adds documentation to the following debugging- / debug
logging-related data types and preprocessor macros:

    * connman_debug_desc
    * CONNMAN_DEBUG_DESC_INSTANTIATE
    * CONNMAN_DEBUG_ALIAS
    * CONNMAN_DEBUG

and expands the existing documentation for the 'DBG' preprocessor
macro.
---
 include/log.h | 107 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/include/log.h b/include/log.h
index fd47c8d53c9b..bff8a1634ab4 100644
--- a/include/log.h
+++ b/include/log.h
@@ -49,6 +49,10 @@ void connman_debug(const char *format, ...)
 	}						\
 } while (0)
 
+/**
+ *  Debug-level logging descriptor that may be used to control debug
+ *  output on a per-file or -symbol basis.
+ */
 struct connman_debug_desc {
 	const char *name;
 	const char *file;
@@ -58,18 +62,88 @@ struct connman_debug_desc {
 	unsigned int flags;
 } __attribute__((aligned(8)));
 
+/**
+ *  @def CONNMAN_DEBUG_DESC_INSTANTIATE(symbol, _name, _file, _flags)
+ *
+ *  @brief
+ *    Convenience preprocessor macro for declaring and instantiating an
+ *    instance of #connmand_debug_desc.
+ *
+ *  @param[in]  symbol   The name of the #connman_debug_desc instance
+ *                       to instantiate.
+ *  @param[in]  _name    An optional pointer to an immutable null-
+ *                       terminated C string containing the name of
+ *                       the #connman_debug_desc- controlled symbol.
+ *  @param[in]  _file    A pointer to an immutable null-terminated C
+ *                       string containing the name of the
+ *                       #connman_debug_desc-controlled source file.
+ *  @param[in]  _flags   Flags that control the interpretation and
+ *                       behavior of the instantiated
+ *                       #connman_debug_desc instance.
+ *
+ */
 #define CONNMAN_DEBUG_DESC_INSTANTIATE(symbol, _name, _file, _flags) \
 	static struct connman_debug_desc symbol \
 	__attribute__((used, section("__debug"), aligned(8))) = { \
 		.name = _name, .file = _file, .flags = _flags \
 	}
 
+/**
+ *  @def CONNMAN_DEBUG_ALIAS(suffix)
+ *
+ *  @brief
+ *    Convenience preprocessor macro for declaring and instantiating
+ *    an alias (see #CONNMAN_DEBUG_FLAG_ALIAS) instance of
+ *    #connmand_debug_desc.
+ *
+ *  @param[in]  suffix  The suffix to concatenate to the name of the
+ *                      #connman_debug_desc alias instance to
+ *                      instantiate.
+ *
+ */
 #define CONNMAN_DEBUG_ALIAS(suffix) \
 	CONNMAN_DEBUG_DESC_INSTANTIATE(__debug_alias_##suffix, \
 		#suffix, \
 		__FILE__, \
 		CONNMAN_DEBUG_FLAG_ALIAS)
 
+/**
+ *  @def CONNMAN_DEBUG(function, fmt, args...)
+ *
+ *  @brief
+ *    Convenience preprocessor macro for declaring and instantiating
+ *    an instance of #connmand_debug_desc for controlling an
+ *    invocation of #connman_debug with it that includes both the
+ *    file and function name the macro was invoked in or attributed
+ *    to.
+ *
+ *  This instantiates a scoped-instance of #connmand_debug_desc and
+ *  then, if that instance has its #CONNMAN_DEBUG_FLAG_PRINT flag
+ *  asserted, invokes a call to #connman_debug with the format:
+ *
+ *    "<file>:<function>() <fmt> ..."
+ *
+ *  where <file> is the preprocessor symbol __FILE__, <function> is
+ *  caller-specified, <fmt> is from @a fmt, and '...' is from @a
+ *  'args...'.
+ *
+ *  @param[in]  function  A pointer to an immutble null-terminated C
+ *                        string containing the name of the function
+ *                        in which the macro is being instantiated or
+ *                        to which the invocation of the macro should
+ *                        be attributed to. For example, __FUNCTION__.
+ *  @param[in]  fmt       A pointer to an immutable null-terminated C
+ *                        string container the log message, consisting
+ *                        of a printf-style format string composed of
+ *                        zero or more output conversion directives.
+ *  @param[in]  args...   A variadic argument list, where each
+ *                        argument corresponds with its peer output
+ *                        conversion directive in @a fmt.
+ *
+ *  @sa CONNMAN_DEBUG_DESC_INSTANTIATE
+ *  @sa connman_debug
+ *
+ */
 #define CONNMAN_DEBUG(function, fmt, args...) do { \
 	CONNMAN_DEBUG_DESC_INSTANTIATE(__connman_debug_desc, \
 		0, \
@@ -81,12 +155,35 @@ struct connman_debug_desc {
 	} while (0)
 
 /**
- * DBG:
- * @fmt: format string
- * @arg...: list of arguments
+ *  @def DBG(fmt, args...)
+ *
+ *  @brief
+ *    Convenience preprocessor macro for declaring an instance of
+ *    #connmand_debug_desc for controlling an invocation of
+ *    #connman_debug with it that includes both the file and function
+ *    name the macro was invoked in.
+ *
+ *  This instantiates a scoped-instance of #connmand_debug_desc and
+ *  then, if that instance has its #CONNMAN_DEBUG_FLAG_PRINT flag
+ *  asserted, invokes a call to #connman_debug with the format:
+ *
+ *    "<file>:<function>() <fmt> ..."
+ *
+ *  where <file> is the preprocessor symbol __FILE__, <function> is
+ *  the preprocessor symbol __func__, <fmt> is from @a fmt, and
+ *  '...' is from @a 'args...'.
+ *
+ *  @param[in]  fmt      A pointer to an immutable null-terminated C
+ *                       string container the log message, consisting
+ *                       of a printf-style format string composed of
+ *                       zero or more output conversion directives.
+ *  @param[in]  args...  A variadic argument list, where each
+ *                       argument corresponds with its peer output
+ *                       conversion directive in @a fmt.
+ *
+ *  @sa CONNMAN_DEBUG
+ *  @sa connman_debug
  *
- * Simple macro around connman_debug() which also include the function
- * name it is called in.
  */
 #define DBG(fmt, args...) CONNMAN_DEBUG(__func__, fmt, ##args)
 
-- 
2.42.0


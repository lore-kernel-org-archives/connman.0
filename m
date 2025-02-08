Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC8EBE
	for <connman@lists.linux.dev>; Sat,  8 Feb 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976523; cv=none; b=OXn+x+zJVwVs5Nbuy9/dFBWeTaINOGTzKDqT85Ly/1K5RkwdWN7yo0fLzAFPVdTb499gkJkT/LsLSsEXjwrDVos/EGmgeT9uUnwkypVUwQc+2UTo+oiI0Kdqivyi0kkP1ACQMrupf13KfjreiGqxbQC0J3hLTgm/GjFjbGC8wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976523; c=relaxed/simple;
	bh=lrsVasRta9OH9oJXWZ8TRhzvz2/s79PFRX+SpQUjM6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZBqu0rywA/L8jl+Te+NWa6BpDkRjPnG15Pmz2gNmJw8Kph3FoAdwcrC71XFsSexDO30OxWrRxzSj2sZecmTBjxhXb0XoQ+8llE8sMxXYBxDzKXmeCm8KM0JBR8aEp53snlE1/VGqPlIAYT7AcF5yZcuGsabhk9L+KtKYtCnebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=AwRB4kYR; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="AwRB4kYR"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8E757164A7B
	for <connman@lists.linux.dev>; Fri,  7 Feb 2025 20:02:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 42284124FB3
	for <connman@lists.linux.dev>; Fri,  7 Feb 2025 20:02:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] ofono: Correct conditional in 'cm_get_contexts_reply'.
Date: Fri,  7 Feb 2025 17:01:57 -0800
Message-ID: <1e6f26de75a331182bc2c426d5f35c19ed225ebe.1738976381.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=XThqdgV+aoJjghbxPAKeRNZ8zzggVE6IMu4xQYy/iUY=; b=AwRB4kYROX3aOk5ulihnmG9OZXAGuxDRS4cQZbjt2HCQjsUeGAd7w1lwQx0v98HYrU7HIQFAr8E6twnizlrm8kFvqFsa2/Tng+ZAiNzbmmaA7YOPw+0H5f2dqD5dALrwIeKRJuYENAIE5NlZ2wsUBVQ6Sf1RoHc7Iq3amOhFhvAxmE3YIlgjj3sEFSwKWGQlg9RRW3uepCldLVg8KtBbu6wFlYWnkQLz56xu8QtA3kaawv6nxEkEJz6wlHE0BymFO9m19GGdZxWvZ+0UyM/7mo+oiVBx9XKGotpQnkGBOk+aLGNPnHo/7c1YHBvNRcphKTJjH8O/J1IxZQBJ6QvvJw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

At the appropriate moment in the oFono plugin lifecycle, it gets and
evaluates contexts from a given Cellular modem. Depending on the
HNI/MCC+MNC and the network operator, there may be one or more such
contexts, each with a different type.

Within 'cm_get_contexts_reply', each received context is iterated on,
evaluating each for the type 'internet' by calling
'add_cm_context'. If the context is not of type 'internet',
'cm_get_contexts_reply' should continue to iterate until all contexts
are exhausted or a matching context is found.

The return semantics of 'add_cm_context' are '-ENOMEM' if memory could
not be allocated, '-EINVAL' if a context is *not* of the type
'internet'; otherwise zero ('0') if a context of type 'internet' was
found.

However, the conditional logic of 'cm_get_contexts_reply' prior to
this change was:

   while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_STRUCT) {
       const char *context_path;

       dbus_message_iter_recurse(&dict, &entry);
       dbus_message_iter_get_basic(&entry, &context_path);

       dbus_message_iter_next(&entry);
       dbus_message_iter_recurse(&entry, &value);

       if (add_cm_context(modem, context_path, &value))
           break;

       dbus_message_iter_next(&dict);
   }

So, assuming a set of contexts from, for example Verizon, such as '[ {
vzwims, ims }, { vzwinternet, internet }, { vzwapp, wap } ]', then the
above logic will encounter '{ vzwims, ims }' on the first iteration,
evaluate that it is not of type 'internet', return '-EINVAL' from
'add_cm_context', that will satisfy the conditional and trigger the
'break' from the 'while' loop and context iteration will
terminate. This then misses the second, desired '{ vzwinternet,
internet }' context and the Cellular interface will never come up.

By changing the conditional logic to match the return semantics of
'add_cm_context' the code now works correctly, regardless of the number
of contexts iterated on or their order.
---
 plugins/ofono.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 062905c8a3a6..6b89df3af0ae 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -1415,7 +1415,11 @@ static void cm_get_contexts_reply(DBusPendingCall *call, void *user_data)
 		dbus_message_iter_next(&entry);
 		dbus_message_iter_recurse(&entry, &value);
 
-		if (add_cm_context(modem, context_path, &value))
+		/*
+		 * If a context of type 'internet' is found, stop iterating;
+		 * we have the desired context.
+		 */
+		if (add_cm_context(modem, context_path, &value) == 0)
 			break;
 
 		dbus_message_iter_next(&dict);
-- 
2.45.0


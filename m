Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E168241C89
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203200; cv=none; b=LE3DMuxB9lUvMGpDiolUpBBHRMHlVKwu1m3yPOVLLiyvioEEX6DEff7fZZZFZPq/K3eluLyvBVRkFT11dCvK95i3l+TsMWKx3uDaMORhC43OnavX8Enx2u17KvdHCb0o6+kJPbdOVlThiQv7OSQbLlaXCkE9MUbMoWvWMmqEs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203200; c=relaxed/simple;
	bh=SB/KxgeTFS+W+cXSTpoAu4euw7jZqoK3/tfPVTJkV2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iQienkOTlZfN3X6hreiREMG0B9Xkz+smY9WL9G7UXAjDuTtbSwoCBbVTAixYFGTaqrvgKLJRMV1GkCZJfp1JrVYarHrhVk7kHK0d0wTaf5J1Ogf3bZRMgdc69ukUViza/1Gvdbfhu71lSGOrCcYW10I3sqFCHgiSnpnIe5xNx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=FOMU49v6; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="FOMU49v6"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6CD0E1649B8
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 10:59:51 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1EE7B124F64
	for <connman@lists.linux.dev>; Mon, 10 Feb 2025 10:59:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 0/2] ofono: Correct conditional in 'cm_get_contexts_reply'.
Date: Mon, 10 Feb 2025 07:59:47 -0800
Message-ID: <cover.1739203086.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=/3i1qstXcyE/cRiIZz1RtCNUSEFKf4rK2r0Ek4K7SKo=; b=FOMU49v6GfRlOgI+Tmq5jVdAIQIfWpAcsAn1tL4YD7XoIAdnKLK5XFgiKm751OYQuO+nyLZEatSTX8yjXlM1wAO46JwWEoz/wjjhXo64GopxNdE5605+LQKmG7Bt1Q/AATbjuxF7B2Qkh9Dm7G9yht6u5QqM+DOHRj7SrmydCWfNsKQXs0o67pwDpsGZHp/R/tuKiBGbsieGk7/tds3M/1Of+nZTK0sI5AwizzKiNF74V7pEfj/jgqcTTxsl02c6oZ7UjdpwZ232tqcoXBsnBbF7t0eAXw2szLulEKros7yAvLM8wSd6z2v1y6TnLZylAyEcikXXVWjlUhs1OzHWDA==
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

Fixes: 4b238d8590942 ("ofono: Implementation of simultaneous APNS")

Grant Erickson (2):
  ofono: Correct conditional in 'cm_get_contexts_reply'.
  ofono: Document 'add_cm_context'.

 plugins/ofono.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.45.0


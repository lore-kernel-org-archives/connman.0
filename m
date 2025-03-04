Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18C35966
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050687; cv=none; b=Mbabn419SWH//8klqVxoVCqvZzSMokwPDF+t4n23OsOHPEp7WeajSWgAntnx/PXHAM2PBZIO1//ZuHWpzNnvbOqgyJOlVidovBi5R2MXgCZqRvO67poxvd5yWC3fEATiLeum+biVNKvwLbMXSst/dwSjjtwS9UDEnT6LHmvfP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050687; c=relaxed/simple;
	bh=ARM2Zg3E0H5Rgnjib9vPQZxSQjL7ZmsZ+XQGdyJu8u8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaCnpOuTO2QjAw2Y3kl10R/klGnNJzDU72kahJi6eKACG+cuKLnia8BR3JpKXswApfsYau9ueM5OSMZxTTTM2LHFX3INV7Qu5NuIlRd9q9nBtrzBPhmMgEwjHYvA3xpHuH5qYkQYE6VAgR9W6m/i4Ag9PL8OiDzzkTs2bSb+k44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=mFfCO1GA; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="mFfCO1GA"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3869A164B50
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:18 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E4459124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/22] gweb: Add documentation to 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 17:10:57 -0800
Message-ID: <e78028fc1e4d24ed1f66aa927082bffdc09f8171.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=6BiM3CXRbEUsETTTn0rWxac0vZUilT2kQKvl4q5RImk=; b=mFfCO1GAU1R/KtwOCkF3c9xwbdCY3dH0iZNkz9uvqCTvMiA2wwnDusW+J596LGBhv+DNaNMDD9AJvOpjNzUMJSSRjPwrlvNxDnEsO7Z61iyhzW2vlY/eMj9NB4YVAYzw5DSt5YSUmKUSnx13JT7HEAD9Ki69SaQ/SQoAmdPX8IJJ2Y18t4MWAbt3tJwuh99fdVvdB2jImB/yjQUUZHXZMEjeyO3Or8TssueTv3B9uKDMt3aZyHh9ZHKamUSQ0u88JJb4tc3+UFeAb8Fhi5P4spwZGZJrQcoFX42gpPF+GHGHfhp3fGLIjnQEly3aG/7JtBeeILrEnKglIc6s2O0NGw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds documentation to the 'g_web_result_get_err' function and the
associated 'struct _GWebResult' 'err' data member.
---
 gweb/gweb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 6ada0dfa571c..72f83d8f27e4 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -55,6 +55,12 @@ enum chunk_state {
 };
 
 struct _GWebResult {
+	/**
+	 *	Operating system error, if any, associated with the request.
+	 *
+	 *	0 on success; otherwise, < 0 (negate to arrive at a POSIX
+	 *	domain error number).
+	 */
 	int err;
 	guint16 status;
 	const guint8 *buffer;
@@ -2463,6 +2469,22 @@ bool g_web_cancel_request(GWeb *web, guint id)
 	return true;
 }
 
+/**
+ *  @brief
+ *    Returns the operating system error, if any, associated with the
+ *    web session request result.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to return the
+ *                      operating system error.
+ *
+ *  @returns
+ *    0 on success; otherwise, < 0 (negate to arrive at a POSIX
+ *    domain error number).
+ *
+ *  @sa g_web_result_get_status
+ *
+ */
 int g_web_result_get_err(const GWebResult *result)
 {
 	if (!result)
-- 
2.45.0


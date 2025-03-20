Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D221C9E7
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513961; cv=none; b=Ucp8EcSorcVYA2viOs3JhN+7FJIG82MofMjhXyHrvLoBS6gMhrbTA3oScOZ2tR2SM1yKQsmo+MUqeREkD5rqDt3baEhDxqZCGoEzshNcyv6Z6ponuIj5VNOTyYYNUl9GMUv5PnxlVt0Dj1gIYEk4A15uLsv8iRMk+T8FJ+QmaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513961; c=relaxed/simple;
	bh=YZOvYYTIYpunMD2GXD3BvqTqcTrtbay4ZFK6BCvMzwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPPQmVe926rGjC0Qy8TfnZModCTZYeRgcwKB0WO+TfOgGv+e1tTvNf593ScW3tO0xtlIHGB3aQ9b9Yh+aoDC6tQEwwXRSsEV3ESjlYvwtMPGRW8q1QH61M4eSQn+J4m5KY6ZN2WPCJKK90p4I1nNw8Ql5dbQNGCXW0dXJYUcquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=BCm0/C9o; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="BCm0/C9o"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 412D6164A73
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:13 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E9F83125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:12 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 04/18] gweb: Add 'G_WEB_ERROR' domain status codes.
Date: Thu, 20 Mar 2025 16:38:55 -0700
Message-ID: <ae0d6856f80b5ac95f23626d9af0ce3638a92717.1742513884.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=UilcoyPbbNyCMRtgS4+Vuavd1qMUsW7+Z4bc2BpHVuY=; b=BCm0/C9oimGy/XkDPYjJekTrokQViU6c4O5zDkGPbnMApt2UU41zu2LzIMpk/jtvaY4JgTQnaIVyWpQ1nTT4s++JhuivZabqcG/vCAsY0aymzEMrLcAbB4i4ELNuv3kRG1zVeB9rmhc40JNUCHN2GLTxBqudOb5KVX6a4vv4c+L/5eQJmZ7e8/9CwR0ocP21LCV8pWFtjjOlzQZ7gD96wlvpbRUltciYPpPPoopnRIp7DcEoDSQZjLudKnDqmtNZ/LXJNSvBXPN34yVw5K5i7u3YI4EZJd5gMW9ZGkJq3K51+ARcbyi/I0I8ewBLkm7OFnvXFoxdeiUGonNH+cctng==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

These allow instantiating and setting GWeb-specific GLib GError
structures for G_WEB_ERROR host not found and chunked response
decoding errors.
---
 gweb/gweb.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/gweb/gweb.h b/gweb/gweb.h
index 6768601d6c69..fb29498e90ad 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -101,6 +101,22 @@ enum GWebStatusCode {
 	GWEB_HTTP_STATUS_CODE_NETWORK_AUTHENTICATION_REQUIRED = 511
 };
 
+/**
+ *  GWeb-specific error enumerations potentially set when
+ *  #GWebResultFunc is invoked on a failure.
+ */
+enum GWebErrorEnum {
+	/**
+	 *  An error occorred when decoding a chunked HTTP response.
+	 */
+	G_WEB_ERROR_CHUNK_DECODE,
+
+	/**
+	 *  A host could not be resolved.
+	 */
+	G_WEB_ERROR_HOST_NOT_FOUND,
+};
+
 struct _GWeb;
 struct _GWebResult;
 struct _GWebParser;
-- 
2.45.0


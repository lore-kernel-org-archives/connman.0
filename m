Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174A6EB7C
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050688; cv=none; b=k6DF9BZ7GtM5jonqXyC4+lIvfya7LnueVFPUQAduherjfdMp89PiUXHm8KGHwJeJ3c0SDawqpZi1e9H3nfn0EZZVUPb31rdy1XNYsI3EyYCN4ty2EkXC0DUJSUUl+j9Sxc7LLyShssfKr2DOgRBijfykNygDz2BDcdAxwDqxoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050688; c=relaxed/simple;
	bh=qs5R7JB5PHvQNbpmDh3U23jml50Tl3iuv4oBaHA7GeM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVFRiuXSyLACRtp+fVh9A0lGR8hZjjQH3vMGLos1mg7pA9xImfLTvWY8eAm80i8mzpZPkxE5lnSmrcBmB5WGGRsSG8rFWaLN3jj7A5hAlh8HiamPI5eZRewtRuU7U8+BGrFEehDsBVHnqt0lF9sNHhodTGJ6Mwmc62mxCFCtE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=T/8hQ6bl; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="T/8hQ6bl"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DA801164B57
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 92413124F28
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/22] gweb: Add documentation to 'map_gerror'.
Date: Mon,  3 Mar 2025 17:11:03 -0800
Message-ID: <e2baa4014772fc6c9ca52543a4c2d10139776a7e.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=iEOz9EaCgAx7IVywMFbcNPzXGx3AgL7YsYQhDq84H48=; b=T/8hQ6bl+P8qYXlwqp5wXS5KoZcTWnOEvIOgEX7Snb9/cHftK8qIFg8KBMinPucsIsb8Ol3XUv4dXxkk/8vSsIBMK0fcgW7Sc+SiJabM2mgF8UM1AYUa95D3LIBQ9GzQg4oa8G/GbPYwOSMvjfEw6okrZryXmrZOCrs9ElSHQCJhQTghjFUx19S503eVgbjLsXY987Z1y9YmnEwPNyxGdrpyy0nuqX+EmLsPj/TAIlGospZ+qDmzJg4Ydimg6oIeQ8r+MEYjZ4zdhltaKjMVh6Eei9OkM0QFNVAtAC+R7aFFOle0Ahlh3gwmAP/xJ6VWuIkdFyaaBXGs7YIfM4ZpiQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'map_gerror' function.
---
 gweb/gweb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4a402ccfc346..12fe682cedfb 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1130,6 +1130,20 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
+/**
+ *  @brief
+ *    Map a glib error into the negated POSIX error domain.
+ *
+ *  This attempts to map the specfied glib error into the negated
+ *  POSIX error domain, defaulting to -EIO for unmapped domain/code
+ *  pairs.
+ *
+ *  @param[in]  error  A pointer to the immutable glib error to map.
+ *
+ *  @returns
+ *    A mapped glib error into the negated POSIX error domain.
+ *
+ */
 static int map_gerror(const GError *error)
 {
 	int err;
-- 
2.45.0


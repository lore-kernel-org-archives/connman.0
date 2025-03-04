Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8935946
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050685; cv=none; b=hw+RvN9VZXFCVOHyleP3Ja6B94PzpN3znX60qJwq4UWphszBd5uJRjxzIZIsYk54aWXFXETqZjNaUKk7eGJ7jlO7G6XQXqQH1kvj9h3mpV0c0vSsUbgUAUpCgJJMfr6QM+fkZf3/Q0XMlOWvejbssP3WwUXNl+2UGZK8jfQk8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050685; c=relaxed/simple;
	bh=6ilmkFe52ejZth/1ZI3S7WNLy0LS4D38LdRlZERwPak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj0N04m3Bz7ZIdNVQWRcpeDut9tI+kaYy2FegDFU8G88W19SoroulSrCNfj1r8xLB+Ht8a9monfeN5HvNHa6fXmnkUzWg/d6lJGOpL36bI2wqUMSTofOM/Ds28Mh7UctRF+pXV51rdMkZL1DxjqldITMSuTN7AqxLn8GOZxzo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=GQ0FV4LB; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="GQ0FV4LB"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id EB2D3164B27
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:15 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A3754124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/22] gweb: Leverage 'GWEB_HTTP_STATUS_CODE_UNKNOWN' mnemonic.
Date: Mon,  3 Mar 2025 17:10:52 -0800
Message-ID: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741048994.git.gerickson@nuovations.com>
References: <cover.1741048994.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=n+7n+by2+5K9Dr347n4l+wwIKt/CYoOiG6OS+ui3LbA=; b=GQ0FV4LB9/1J9Q6r/TGaLmUkxwwcE8WuvRBrdnqvxyWH5jT5F77bqaBnl9xmbVp5FBe9V0hpPKoThj0nUrePEy4p87wGKa9ZBsjsdY5Wvj4j2rYM2PuJSAMl7JiaGP9VFLWvH+F+auxh3Ul6OPneCY1V8VtIrTtXTyfMKYhsGHTh++0+q81Ivl8Inkn5kd4nhCHzEfiL+Jwzfmakf/gmSAXkJGwcYMNDKvO4CCmo2TCC9e77NvQGXiqGbZ/UitnOdeB3GSfSEeo2ZiQZBtcH9JW39kjMP0nk43bz6bG2YCuOususAkZr6hOyYlNWzToA2Gv3pOf3UwXx3h5vYU/Mcg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

In the GWebResult structure, the 'status' data member is effectively
nullable with the GWEB_HTTP_STATUS_CODE_UNKNOWN mnemonic representing
the "null" value.

Consequently, use the GWEB_HTTP_STATUS_CODE_UNKNOWN mnemonic rather
than zero (0) to make that intent and pattern clear throughout the
code.
---
 gweb/gweb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index ce49e8d3dfc1..8e0b79c52254 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1189,7 +1189,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 
 		str = session->current_header->str;
 
-		if (session->result.status == 0) {
+		if (session->result.status == GWEB_HTTP_STATUS_CODE_UNKNOWN) {
 			unsigned int code;
 
 			if (sscanf(str, "HTTP/%*s %u %*s", &code) == 1)
@@ -2429,7 +2429,7 @@ bool g_web_cancel_request(GWeb *web, guint id)
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
-		return 0;
+		return GWEB_HTTP_STATUS_CODE_UNKNOWN;
 
 	return result->status;
 }
-- 
2.45.0


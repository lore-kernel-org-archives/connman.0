Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B103A8D2
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050685; cv=none; b=JyeRl1ObkYAVBFT4Ut15h6HZKIJJsD8Yb8NKecQS+9laBhwRDQpwfTVGsfrnr6OYoE9vdY153ItwDbujGwk5G1IFIOgRs5fr7S6nRHXCOowN4CeGK8fE/EUyVVLUE+sG/3Cj2OrjWwBdcQvq8/TO/NXUSeG4eDlcOoJ595FscwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050685; c=relaxed/simple;
	bh=47fuW5Tuk/YBmLZBmPu+sGctbNk3+gYm9LTpx6g5i+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwLILBFxy6vSzqRwkSknF/u+N1pp7ukGZO2q1BKgR3ReHHP07u1V2802q9fSomRaXOdQHZDViZtNvTKvW4sxgJd4KNA4mnjwwVkk5NtyS/HrTe8LGXbrBbuXY/aQKaHpY+PhW5oCs7Wo3KnoGASaji8HIkV93wA44ItJ0eqlCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=FuxJUW0l; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="FuxJUW0l"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DA719164B4A
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:16 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8755C124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 03/22] gweb: Added 'g_web_result_has_headers'.
Date: Mon,  3 Mar 2025 17:10:54 -0800
Message-ID: <33b4c08a164f2a8030dd86e254d79f25ac7762de.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Ra9UY3AraOCIXWWAyyZPT2eKq3kmnD1hDB2+GcQ6DPE=; b=FuxJUW0lqjsyMH0trk630i40QQAh85DezKc5GAq5VvuoKPUcjJej5ySJb1JM2C9wZ6wQ9UU3rZjBMtqJZJV7F0Eouok+B18QalsuKJLVVF197P2p1d4PrxmfCm1jli+vQQGY8tuWeRvYjKLp3E6OjHL3FvSqHNj8ad7D8xUuesUYJgx4WLENGW9kJ4IVWsVf07nOvjQAQVSH/Bs/vElMh4KUCF/L67tA5Al8+F6XI3EVabw+dvKW1g1suslng6O0IjFzLGuKykNvFzj8CirHtzxudirKUCIGzf8iAkNMqyDBt2UBWSIM5w/xI0oQDQ396ZavNcQzr7MRXedouk75LA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Return whether the web session request result has any HTTP headers
and, if requested, the header count.
---
 gweb/gweb.c | 16 ++++++++++++++++
 gweb/gweb.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index d4bdbdd641f5..76f01c44b88f 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2504,6 +2504,22 @@ bool g_web_result_get_header(GWebResult *result,
 	return true;
 }
 
+bool g_web_result_has_headers(const GWebResult *result,
+				guint *count)
+{
+	guint size;
+
+	if (!result)
+		return false;
+
+	size = g_hash_table_size(result->headers);
+
+	if (count)
+		*count = size;
+
+	return size > 0;
+}
+
 struct _GWebParser {
 	gint ref_count;
 	char *begin_token;
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 7c65aebf4698..90cccadbe883 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -166,6 +166,8 @@ guint16 g_web_result_get_status(GWebResult *result);
 
 bool g_web_result_get_header(GWebResult *result,
 				const char *header, const char **value);
+bool g_web_result_has_headers(const GWebResult *result,
+				guint *count);
 bool g_web_result_get_chunk(GWebResult *result,
 				const guint8 **chunk, gsize *length);
 
-- 
2.45.0


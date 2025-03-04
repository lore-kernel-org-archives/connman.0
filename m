Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14F35946
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050687; cv=none; b=LFsPSynwqlyfMYIFzEGE3BLD1rA1v9Df2/Fs27He1sPoiQYG4LPCuDkvUjgBQUuu/aTak8gBoHfjmrRz1NRWdX6YxSY7MpVh53JxAJKIPGMKKiMZn/UzzjSet2sSmm+lqxaBbwbn99/rUvCSBmm9oZ6DJXFXqULwn+g7q4cfZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050687; c=relaxed/simple;
	bh=SLsoLtGt4glfIO7MTGQCzMsadM7FpXEPZJAXxkDnygE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT/akIdzzVPOfclqD8gp79qMN/niR1cZZQ6Zu63yNeiWKt/+n99jmdPFbBg62dLuaIOgWkH1xpQ3ny9itcdY4wKU5TfR8bAIuRRHMlPoPnx5QRNkqgcD11d5o4vzWFylsuCSYoso84jUKDNCyTebyxoLcGw7CUMmMDXP+5VR4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fI5uD7ya; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fI5uD7ya"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C09BA164B4F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:17 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 77605124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/22] gweb: Added 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 17:10:56 -0800
Message-ID: <3e0b57485a7f50f031d7853b01a40a4821704e05.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=2phLsebY6ZrDr69vpjoZYmfgNhsUrpxApHY06pjvRi4=; b=fI5uD7yaTsO0Ov+Gee7634ata6PH8sch5Z7Jh75ayqp3qRrwc5ddbrQWcm3fDohSUMV47+W3yMDafrx/oU3BKnJF9hAwsji5THpLJuJSMvWVUh3mLBi5kwTvj7DcyDF5Ma+i4gOqOEMB/CH/NCn19aW3mMucWnrVhYhaFYigfRTrCm1S9NwegKipdMFEp3ycZ00pYYLfqV72+6bDkUqaQFlzfUYZooGCkj8GM+h9nozTCt/aHh9NkJJPELegByBtIO27+CrFU5XvZdb/AzyuD17lwmsF1EfZ8OBsp14pn6gLH7+QBFWlny0s2ImOveVCBsc+joMPdu/rdopsrHDlUQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Returns the operating system error, if any, associated with the web
session request result.
---
 gweb/gweb.c | 9 +++++++++
 gweb/gweb.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index d79d2d0808cd..6ada0dfa571c 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -55,6 +55,7 @@ enum chunk_state {
 };
 
 struct _GWebResult {
+	int err;
 	guint16 status;
 	const guint8 *buffer;
 	gsize length;
@@ -2462,6 +2463,14 @@ bool g_web_cancel_request(GWeb *web, guint id)
 	return true;
 }
 
+int g_web_result_get_err(const GWebResult *result)
+{
+	if (!result)
+		return -EINVAL;
+
+	return result->err;
+}
+
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 90cccadbe883..e9a8eda9f8f7 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -162,6 +162,7 @@ guint g_web_request_post_file(GWeb *web, const char *url,
 
 bool g_web_cancel_request(GWeb *web, guint id);
 
+int g_web_result_get_err(const GWebResult *result);
 guint16 g_web_result_get_status(GWebResult *result);
 
 bool g_web_result_get_header(GWebResult *result,
-- 
2.45.0


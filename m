Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE7310777
	for <connman@lists.linux.dev>; Tue,  7 Jul 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415831; cv=none; b=HfAErA1GnA87o2BSm3f3QrG3sFOH730UCcbX3WpFvq0bWVSHsSlzNdehREWW6abKixcVVnzrm9QDSLPOTEWzDBsdDVLzOrfXT0q7mp1e8DmMtHDHCtjdjuZkUIV6uqdreyrb6aNr8Bim/KBzbESoKWmtjq5VxKVIS++9zI7g2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415831; c=relaxed/simple;
	bh=yIYx05WB19/2aIGvgASCm1RETVyY63PI9rbKK9d+L2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOBPDSuJaabLRCRXXEepFKYq6EtGKJn/a5HFrOw145S41FXzmgmHvOYrkIzFdldIlL2wNIu89YDantivg1RIhZ9H9O6wLAxhbu3GzIiOTh7Mc7FUqFscjVDebOIMMQYq7Pkrv2x1T/beaF54c3N+SbbRaCai86xMl4yxtlYYbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE/8ZhUY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE/8ZhUY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso39738495e9.3
        for <connman@lists.linux.dev>; Tue, 07 Jul 2026 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415828; x=1784020628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76U+mFP4VsODonMpVnZmhABElVKZzqguB8sJsE4w0Ug=;
        b=jE/8ZhUYMLmlS4pcqXkcsBoHaTTknunnQI0uEVRLQnBslAy84DIGUh9s4bzgFxujG2
         eikWG1ZGlrjUIRJumvLQA8y0WkJrkPshq+x+DDks0Fqor8u4xB0VlXOCytaPgZTz/FuI
         4ptmaZbU82FvPx1ZKEpJXWUoa73LcOvYlzTtQ9W7M2uDknEs3ehDBOVkc05NWQqPAaJl
         AUNNAiyI//8EO/JKc5rubWRd44L67IENrU8kAoCtbyrAU8AOzQFZnNiju7oZ40CscQ/0
         o8jZPwQPVZrigz4FrK+5cYFHiCuzQ3FwFfF37v5ZLAzXUBtwgde+7zFV5bdEnJQ8ODQU
         eMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415828; x=1784020628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76U+mFP4VsODonMpVnZmhABElVKZzqguB8sJsE4w0Ug=;
        b=iM4EEPNl/0RUpSBbjrbCif6462pv5Om/oacwRoTExgohXhKd1UxKo76Uaq9fvfvvSk
         jp4cwoxagNRKvF4Y+cXfBJgjhraqYvSoaCfkJI5M3MHTWYlXKD5D35CK0M+BnRoNxtYm
         1xK6hsUXQC09cZa/lz2S+Gbq1luWwd9QbCH5XmZVqKkNFip5Ddj3KKUmWMMoALFFKc0u
         dtIjFNLusQXi9m8e/8SN1YRg9BlV7GFuBM6R8TVXlc3BmoKDAgeg+9HEJXVjnAfM3fQW
         zRNUXrRs/ib8NLsMOldrFmPlTnIHIjuKxt2cfo7BQyOvo9FOpG7ulynJZ5o4+Y24RfSy
         mBOA==
X-Gm-Message-State: AOJu0YxhN3RI3xrbEpOQaTvBSHadclArhkmwPC+4omvOV9dnNyjoAooK
	t7WrL8zyQF6nL4dTv4R1tCD8veUyd3KAeS0myI6NxF3Apm47Np4xQFwikuJLO3f6zSc=
X-Gm-Gg: AfdE7cl5fXWr1hCmN4UhXuzDEghQ+mXiY2iwU+dieXTu4NxEsfW9TtTqxeyBSTpXnV2
	JuKYrfnz71yDEBY33dcm8PdfpV+qKEB/kmMjUC/9v/hdnWfwVlYPONPDdpaUpcFrqeEn1ChFCJU
	mB0Ea3Rkca01E4nU4R8wgBkpUVdDE973gj+SwsqpCM/DAzUiKHFEq4wMkzoAb6+bJ4x53recF8K
	SHu/ioxYmtDiiMMgXcYDXWBonbjogljpKbCiOCVZQ6N/+r/FU/HcktiMb40hcFLaBVewiz9n8Vk
	oiEsm04S2LcmfIkFgPXwO0TFrVAe6MpGxQUA5gWoQgJ81BzwmDFgesA2l2s51s33mNIlIbfeN5I
	V30vkYVIFr9rmlnrT2eAmv2HfUA5gLlB5b0NfazwrYe99vJOzHKx4anv0JNGo1+tPyd1WbcYcoq
	HtJY/w+LyDx5M4clcIDviSA+ck+L4htMdkdqPntNo4oFDLE34Vyo07fVHnng==
X-Received: by 2002:a05:600c:5895:b0:493:c0c1:3930 with SMTP id 5b1f17b1804b1-493df062b8bmr33273785e9.1.1783415827659;
        Tue, 07 Jul 2026 02:17:07 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:90ff:59e6:6895:a56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm63406665e9.13.2026.07.07.02.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 02:17:07 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 2/2] wispr: Use lowercase header field names in g_web_result_get_header calls
Date: Tue,  7 Jul 2026 11:16:45 +0200
Message-ID: <20260707091645.90508-3-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
References: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the normalization of received header field names to
lowercase in gweb, update all g_web_result_get_header call sites
in src/wispr.c and tools/wispr.c to pass lowercase names.

This avoids the allocation inside g_web_result_get_header
on the common path, and keeps call sites consistent with the
normalized store.

Signed-off-by: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
---
 src/wispr.c   | 12 ++++++------
 tools/wispr.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index a40cf353..f7da6426 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -708,19 +708,19 @@ static void portal_manage_success_status(GWebResult *result,
 	DBG("");
 
 	/* We currently don't do anything with this info */
-	if (g_web_result_get_header(result, "X-ConnMan-Client-IP",
+	if (g_web_result_get_header(result, "x-connman-client-ip",
 				&str))
 		connman_info("Client-IP: %s", str);
 
-	if (g_web_result_get_header(result, "X-ConnMan-Client-Country",
+	if (g_web_result_get_header(result, "x-connman-client-country",
 				&str))
 		connman_info("Client-Country: %s", str);
 
-	if (g_web_result_get_header(result, "X-ConnMan-Client-Region",
+	if (g_web_result_get_header(result, "x-connman-client-region",
 				&str))
 		connman_info("Client-Region: %s", str);
 
-	if (g_web_result_get_header(result, "X-ConnMan-Client-Timezone",
+	if (g_web_result_get_header(result, "x-connman-client-timezone",
 				&str))
 		connman_info("Client-Timezone: %s", str);
 
@@ -1081,7 +1081,7 @@ static void wispr_portal_web_result_success(GWebResult *result,
 		if (wp_context->wispr_msg.message_type >= 0)
 			break;
 
-		if (g_web_result_get_header(result, "X-ConnMan-Status",
+		if (g_web_result_get_header(result, "x-connman-status",
 						&str)) {
 			portal_manage_success_status(result, wp_context);
 		} else {
@@ -1099,7 +1099,7 @@ static void wispr_portal_web_result_success(GWebResult *result,
 	case GWEB_HTTP_STATUS_CODE_TEMPORARY_REDIRECT:
 	case GWEB_HTTP_STATUS_CODE_PERMANENT_REDIRECT:
 		if (!g_web_supports_tls() ||
-			!g_web_result_get_header(result, "Location",
+			!g_web_result_get_header(result, "location",
 							&redirect)) {
 
 			wispr_portal_context_ref(wp_context);
diff --git a/tools/wispr.c b/tools/wispr.c
index 0c794ccb..810958e8 100644
--- a/tools/wispr.c
+++ b/tools/wispr.c
@@ -524,7 +524,7 @@ static bool wispr_result(const GError *error, GWebResult *result, gpointer user_
 		if (status != 302)
 			goto done;
 
-		if (!g_web_result_get_header(result, "Location", &redirect))
+		if (!g_web_result_get_header(result, "location", &redirect))
 			goto done;
 
 		printf("Redirect URL: %s\n", redirect);
@@ -583,7 +583,7 @@ static bool wispr_result(const GError *error, GWebResult *result, gpointer user_
 	if (status == 302) {
 		const char *redirect;
 
-		if (!g_web_result_get_header(result, "Location", &redirect))
+		if (!g_web_result_get_header(result, "location", &redirect))
 			goto done;
 
 		printf("\n");
-- 
2.50.1


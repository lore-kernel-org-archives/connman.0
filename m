Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7B4C954B
	for <connman@lists.linux.dev>; Fri, 21 Aug 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328595; cv=none; b=ir3Ymo8WBsLc/UqK+Qmm1l1svXYCYkXq7SSvlj9C72R66emhnTwIm9BW+DHRp6KvqXGJCTUpOkxFU1MxW0DDl+g0D2yAmcpRfNLgY2m2CP5YFhlYSEo4K3dw16t3YIwsDJ93pX+eqlxXtOTbHyvdnuX4xH4dxUtcnXo2moglmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328595; c=relaxed/simple;
	bh=ogabw7MsafEjyRAntyIrXSAFHJ4huuCH2LxgRmZZ2I8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL2qjzcsmgbyX5AuGKF2yVV6XKOR8KeLdAJz6bmixWrjcR39JnkCv1Oiq0OlvFgPwxnm4OwGzT8s28yk14+vkPONUJ7BDCJFApq2IskooawEGpGjDDVXfGfgoh+4XS3btLlywCV0Df0/1tuicyL3S+eqrMCTsg0As/RKL5hLUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=1CjhGz2H; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="1CjhGz2H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZPpmXWLiqPdhN9+dEIoUdqsVQGbKjIrL6xAV739NVC4=; b=1CjhGz2HwDGPwkFw3H7twr/OKB
	7Ze8qwnbZL396E5aFhJgEEvuvFAqkXQfLwhOpCHl2yCxHmoltXJ8+PMXgpx7wsIyL4iswbluP4Khq
	t9F5GNrML/Fv03vKlqjv+Q+u1Dlp/qe0BUGM9xF5y9i8IBtQyGZmHkhCxwal75WkQhBMsiM6IhLYW
	hc+8N8xNnMuYpvi1Pjd6Y5OhUiQv681W7s8jSnQA1utI+379mOWixKZXjDoG9RmLiMDQpILCHXGQN
	qfYsxFpp8gfJ9V1oxNNotJ7hqLsbDOxn7u3VEDOIRWjs1jQTFzg6knHzSB49AULD8q4qmtEQoq+RL
	320OCZtA==;
Received: from [2a10:a5c0:37:6501:3a8:42b5:e757:c455] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wxRoM-00AHD0-0m
	for connman@lists.linux.dev;
	Fri, 21 Aug 2026 19:09:50 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] plugin: Add log update and list functionality accessible from plugins
Date: Fri, 21 Aug 2026 19:09:11 +0300
Message-ID: <20260821160921.386690-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
References: <20260821160921.386690-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: 18.4 (++++++++++++++++++)
X-Rspam-Report: Action: add header
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NON_FI_AUTHENTICATED(20.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN_FAIL(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NON_FI_AUTHENTICATED(20.00); Authenticated submission from non-Finnish IP [unknown]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: ASN_FAIL(0.00) [5.5.4.c.7.5.7.e.5.b.2.4.8.a.3.0.1.0.5.6.7.3.0.0.0.c.5.a.0.1.a.2.asn6.rspamd.com:query timed out]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260821160921.386690-3-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam
X-Rspam-Status: Yes

Add plugin log update and list functionality. This is needed for the
dynamically loaded plugins to update logging (enabled/disabled) and to
list the source files. Make the functions accessible from plugins.
---
 include/plugin.h |  5 +++++
 src/plugin.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/plugin.h b/include/plugin.h
index 8d2bb08e..c07ae866 100644
--- a/include/plugin.h
+++ b/include/plugin.h
@@ -100,6 +100,11 @@ struct connman_plugin_desc {
 		};
 #endif
 
+void connman_plugin_log_update(const char *pattern,
+				unsigned int set_flags,
+				unsigned int clear_flags);
+int connman_plugin_log_list(GHashTable *hash);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/plugin.c b/src/plugin.c
index 7d730582..664d8bab 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -103,6 +103,40 @@ static bool check_plugin(struct connman_plugin_desc *desc,
 	return true;
 }
 
+void connman_plugin_log_update(const char *pattern, unsigned int set_flags,
+					unsigned int clear_flags)
+{
+	GSList *list;
+
+	for (list = plugins; list; list = list->next) {
+		struct connman_plugin *plugin = list->data;
+
+		__connman_log_update(plugin->desc->debug_start,
+					plugin->desc->debug_stop,
+					pattern,
+					set_flags,
+					clear_flags);
+	}
+}
+
+int connman_plugin_log_list(GHashTable *hash)
+{
+	GSList *list;
+
+	if (!hash)
+		return -EINVAL;
+
+	for (list = plugins; list; list = list->next) {
+		struct connman_plugin *plugin = list->data;
+
+		__connman_log_list(plugin->desc->debug_start,
+					plugin->desc->debug_stop,
+					hash);
+	}
+
+	return 0;
+}
+
 #include <builtin.h>
 
 int __connman_plugin_init(const char *pattern, const char *exclude)
-- 
2.47.3


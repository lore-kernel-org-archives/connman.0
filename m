Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD380FC0A
	for <connman@lists.linux.dev>; Mon, 21 Jul 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107460; cv=none; b=CQ2h2tehCa1pwOQgobJnF1H40PpGTH5/DiBD6FcSflJVCaEIRLWyk5aXqydAldXd/zqgH7Px5mXolwj2N+yK2V9w3NK6aI0zqEGfihIh4mPVCFzn/eUzupV2Xgt9jJ/2V0sRzat0kCiZqVvf/AT4PSnBXU4I2QUpCnNsBneDR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107460; c=relaxed/simple;
	bh=PRhg8UdsQmLvdJxZ93mVdbBoIZcgx1mG5ZwfJYtqpq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=bEeZxqwU7/V6sYi1lgES6PiBpbnhp6yC3lwq2E3ky6729NdlinkVVoGKg3KCMg9h7DVoWE24A9S1MEXLtrHSbLTMntQV0dAIAmAr+dqf8y1CSDcoZJ2lNJViUpWDRIyDDah0AN19GrVuzbM3R0A2PoSYfM5ZpmVClgxnCZGAr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IR4sackj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IR4sackj"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250721141729euoutp026b2e104433c140da8d02ca6ead9a9eca~USe-E8n3M0766107661euoutp02F
	for <connman@lists.linux.dev>; Mon, 21 Jul 2025 14:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250721141729euoutp026b2e104433c140da8d02ca6ead9a9eca~USe-E8n3M0766107661euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753107449;
	bh=CW4KsbUiscuvv8FPYfOFcFLDmjmW/1Mzw90I64XBh2I=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IR4sackj8/xAy4BELQopor/cBqRMXQCSzp4HB6OtwqmKWr32ukYgcy0ua/PeeUBor
	 8n9UmayMbFR0NSylFccuBa0H8bNwC4iCinnK/vFp99Ia4DKKHwgsVHXxOY/S8ud2kA
	 FPL8OeyAb2mgmBZ0JYQ85IDq3ZZnCqii/Kh1eBS8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a~USe_15pQH2573625736eucas1p2c;
	Mon, 21 Jul 2025 14:17:28 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250721141728eusmtip2b9255709572a10520d85e78ccd11f845~USe_x9AyU0558405584eusmtip2w;
	Mon, 21 Jul 2025 14:17:28 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: connman@lists.linux.dev
Cc: m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] Adjust printf(3) formats for 32-bit platforms
Date: Mon, 21 Jul 2025 16:17:12 +0200
Message-Id: <20250721141712.796989-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a
X-EPHeader: CA
X-CMS-RootMailID: 20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a
References: <CGME20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a@eucas1p2.samsung.com>

On 32-bit platforms time_t may be defined as long long int to make it
64-bit wide and y2038 compatible. On 64-bit platform with LP64 data model
ABI long long is also 64-bit, so it is convenient and safe to always
cast time_t to long long and use %lld/%llu format on all platforms.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 src/device.c  |  8 +++++---
 src/dhcpv6.c  | 10 ++++++----
 src/log.c     |  2 +-
 src/ntp.c     |  5 +++--
 src/service.c |  9 +++++----
 5 files changed, 20 insertions(+), 14 deletions(-)

These adjustments were made in response to gcc complaints about improper
arguments for printf-like calls. I haven't checked manually all the
calls in the code and haven't changed those which were not compiled due
to #if-s and #ifdef-s.

diff --git a/src/device.c b/src/device.c
index e07c6d2e..70d37065 100755
--- a/src/device.c
+++ b/src/device.c
@@ -896,8 +896,9 @@ void connman_device_save_last_user_selection(struct connman_device *device)
 
 	keyfile = __connman_storage_load_ins();
 
-	selection_str = g_strdup_printf("%s:%ld",
-			device->last_user_selection_ident, device->last_user_selection_time);
+	selection_str = g_strdup_printf("%s:%lld",
+			device->last_user_selection_ident,
+			(long long)device->last_user_selection_time);
 
 	if (!keyfile) {
 		keyfile = g_key_file_new();
@@ -955,7 +956,8 @@ void connman_device_load_last_user_selection(struct connman_device *device)
 
 				device->last_user_selection_time = last_user_selection_time;
 
-				DBG("%s %ld", device->last_user_selection_ident, device->last_user_selection_time);
+				DBG("%s %lld", device->last_user_selection_ident,
+					(long long)device->last_user_selection_time);
 			}
 
 			g_strfreev(selection_str);
diff --git a/src/dhcpv6.c b/src/dhcpv6.c
index ba54b892..3a00f4b0 100755
--- a/src/dhcpv6.c
+++ b/src/dhcpv6.c
@@ -1493,8 +1493,9 @@ int __connman_dhcpv6_start_renew(struct connman_network *network,
 
 	current = time(NULL);
 
-	DBG("T1 %u T2 %u expires %lu current %lu started %lu", T1, T2,
-		(unsigned long)expired, current, started);
+	DBG("T1 %u T2 %u expires %llu current %llu started %llu", T1, T2,
+		(unsigned long long)expired, (unsigned long long)current,
+		(unsigned long long)started);
 
 	if (T1 == 0xffffffff)
 		/* RFC 3315, 22.4 */
@@ -2394,8 +2395,9 @@ int __connman_dhcpv6_start_pd_renew(struct connman_network *network,
 
 	current = time(NULL);
 
-	DBG("T1 %u T2 %u expires %lu current %lu started %lu", T1, T2,
-		expired, current, started);
+	DBG("T1 %u T2 %u expires %llu current %llu started %llu", T1, T2,
+		(unsigned long long)expired, (unsigned long long)current,
+		(unsigned long long)started);
 
 	if (T1 == 0xffffffff)
 		/* RFC 3633, ch 9 */
diff --git a/src/log.c b/src/log.c
index 77754009..632faee6 100755
--- a/src/log.c
+++ b/src/log.c
@@ -149,7 +149,7 @@ static void __connman_log_get_local_time(char *strtime, const int size)
 	local_ptm = localtime(&tv.tv_sec);
 
 	strftime(buf, sizeof(buf), "%m/%d %H:%M:%S", local_ptm);
-	snprintf(strtime, size, "%s.%03ld", buf, tv.tv_usec / 1000);
+	snprintf(strtime, size, "%s.%03lld", buf, (long long)tv.tv_usec / 1000);
 }
 
 void __connman_log(const int log_priority, const char *format, va_list ap)
diff --git a/src/ntp.c b/src/ntp.c
index 71a0a64b..e61000ec 100755
--- a/src/ntp.c
+++ b/src/ntp.c
@@ -406,8 +406,9 @@ static void decode_msg(struct ntp_data *nd, void *base, size_t len,
 		dbus_message_unref(reply);
 		dbus_connection_unref(connection);
 
-		DBG("%lu cur seconds, %lu cur nsecs, %lu req seconds, %lu req nsecs",
-			cur.tv_sec, cur.tv_nsec, req.tv_sec, req.tv_nsec);
+		DBG("%llu cur seconds, %lu cur nsecs, %llu req seconds, %lu req nsecs",
+			(unsigned long long)cur.tv_sec, cur.tv_nsec,
+			(unsigned long long)req.tv_sec, req.tv_nsec);
 		DBG("setting time");
 
 		__connman_clock_set_time_updated(true);
diff --git a/src/service.c b/src/service.c
index eb5f5bc7..d2627468 100755
--- a/src/service.c
+++ b/src/service.c
@@ -844,7 +844,8 @@ static void save_assoc_reject(gpointer key, gpointer value, gpointer user_data)
 	for (list = assoc_rd->reject_time_list; list; list = list->next) {
 		time_t assoc_reject_time = GPOINTER_TO_INT(list->data);
 
-		val_str = g_strdup_printf("%s_%ld", assoc_rd->bssid, assoc_reject_time);
+		val_str = g_strdup_printf("%s_%lld", assoc_rd->bssid,
+			(long long) assoc_reject_time);
 
 		if (assoc_reject_str->len > 0)
 			g_string_append_printf(assoc_reject_str, " %s", val_str);
@@ -966,7 +967,7 @@ static int service_ext_load(struct connman_service *service)
 		reject_data->reject_time_list = g_slist_append(reject_data->reject_time_list,
 				GINT_TO_POINTER(reject_time));
 
-		DBG("assoc reject [%s_%ld]", bssid, reject_time);
+		DBG("assoc reject [%s_%lld]", bssid, (long long)reject_time);
 
 		g_strfreev(bssid_time);
 	}
@@ -3173,9 +3174,9 @@ static void connect_reason_changed(struct connman_service *service)
 				need_save |= connman_device_set_last_user_selection_ident(device, service->identifier);
 				need_save |= connman_device_set_last_user_selection_time(device, time(NULL));
 
-				DBG("last user selection ident[%s] time[%ld]",
+				DBG("last user selection ident[%s] time[%lld]",
 						connman_device_get_last_user_selection_ident(device),
-						connman_device_get_last_user_selection_time(device));
+						(long long)connman_device_get_last_user_selection_time(device));
 
 				if (need_save)
 					connman_device_save_last_user_selection(device);
-- 
2.39.5


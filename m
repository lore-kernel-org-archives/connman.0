Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203841865E
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B463D73208
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:23 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6E7E873224
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 17/17] service: Leverage '__connman_wispr_cancel'.
Date: Sun, 19 Nov 2023 09:07:13 -0800
Message-ID: <20231119170714.775270-18-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the newly-introduced '__connman_wispr_cancel' in
'cancel_online_check' to ensure that a pending or in-flight WISPr
portal detection request or an "online" HTTP-based Internet reachability
check is canceled not only in the service module but in the WISPr module
as well.

This prevents two concurrent, outstanding, and redundant IPv4 WISPr
requests from being in-flight when 'EnableOnlineCheck' is asserted.

Prior to this change, this redundancy was set in motion by:

    1. The two back-to-back IPv4 probes get triggered by both of the
       following paths:

       a. Triggered from 'default_changed' and 'start_wispr_if_connected'.
          This is the newer path, chronologically, in the code base.

       b. Triggered from 'service_ip_bound', 'address_updated', and
          'start_online_check'. This is the older path, chronologically,
          in the code base.

    2. With the following commits addressed:

        a. 812e171 ("Close three '__connman_wisp_start' failure closure
           holes.")

            * With this fix alone, at minimum, the first probe above (1)
              would have resulted, eventually in a failure closure with
              'complete_online_check'.

        b. 5f95851 ("wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN
           proxy method.") fixed, the first IPv4 probe from (1) no longer
           "falls down a 'hole'" and gets lost (closure- and accounting-
           wise).

            * With this fix, the first IPv4 probe is no longer a complete
              throwaway--it actually succeeds. However, since it does so,
              it becomes the first of the two redundant IPv4 checks.

By employing '__connman_wispr_cancel', 'cancel_online_check' quells the
first IPv4 check triggered from 'default_changed' and
'start_wispr_if_connected' and replaces it, fully (in BOTH the service
and WISpr modules), with the second IPv4 check triggered from
'service_ip_bound', 'address_updated', and 'start_online_check'.
---
 src/service.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/service.c b/src/service.c
index d78ed0123160..9f6e28d34be4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1594,6 +1594,19 @@ static void cancel_online_check(struct connman_service *service,
 		service->online_timeout_ipv4,
 		service->online_timeout_ipv6);
 
+	/*
+	 * First, ensure that the reachability check is cancelled in the
+	 * WISPr module. This may fail, however, we ignore any such
+	 * failures as we still want to cancel any outstanding check from
+	 * this module as well.
+	 */
+	__connman_wispr_cancel(service, type);
+
+	/*
+	 * Now that the reachability check has been cancelled in the WISPr
+	 * module, cancel any outstanding check that may be scheduled in
+	 * this module.
+	 */
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
 		service->online_timeout_ipv4) {
 		g_source_remove(service->online_timeout_ipv4);
@@ -1936,6 +1949,11 @@ static void complete_online_check(struct connman_service *service,
 		type, __connman_ipconfig_type2string(type),
 		success, err, strerror(-err));
 
+	if (!success && err == -ECANCELED) {
+		DBG("online check was canceled; no action taken");
+		return;
+	}
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval = &service->online_check_interval_ipv4;
 		timeout = &service->online_timeout_ipv4;
-- 
2.42.0


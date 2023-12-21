Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B471539E0
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A2D1873202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 646957321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 21/60] doc: Document the 'OnlineCheck{Failures,Successes}Threshold' settings.
Date: Thu, 21 Dec 2023 14:34:28 -0800
Message-ID: <20231221223508.2365510-22-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This documents the 'OnlineCheck{Failures,Successes}Threshold' settings.
---
 doc/connman.conf.5.in | 38 ++++++++++++++++++++++++++++++++++++++
 src/main.conf         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 9049d7037623..bc5a112f758a 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -222,6 +222,44 @@ will transition to READY state, enabling another service to become the
 default one, in replacement.
 Default value is false.
 .TP
+.BI OnlineCheckFailuresThreshold= failures
+When both \fBEnableOnlineCheck\fR and
+\fBEnableOnlineToReadyTransition\fR are asserted, this is the number
+of failed back-to-back "ready" to "online" HTTP-based Internet
+reachability checks that will be allowed before marking a service as
+"failed" from a reachability perspective, sorting it at a lower
+priority than other services not so marked.
+
+Lower values may result in higher-frequency network service cycling
+while higher values may result in a longer period of time before
+failing from a non-Internet reachable service to one that might be.
+
+See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR,
+and \fBOnlineCheckMaxInterval\fR for other values that influence
+network service failure/recovery transition time.
+
+The default value is 6.
+.TP
+.BI OnlineCheckSuccessesThreshold= successes
+When both \fBEnableOnlineCheck\fR and
+\fBEnableOnlineToReadyTransition\fR are asserted, this is the number
+of successful back-to-back "ready" to "online" HTTP-based Internet
+reachability checks that must be met before clearing a service as
+"failed" from a reachability perspective and allowing it to transition
+to the "online" state again, allowing it to sort back to a higher
+priority relative to other network services.
+
+Lower values may result in higher-frequency network service cycling
+while higher values may result in a longer period of time before
+transitioning back to more a preferred, Internet reachable network
+service.
+
+See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR,
+and \fBOnlineCheckMaxInterval\fR for other values that influence
+network service failure/recovery transition time.
+
+The default value is 6.
+.TP
 .BI AutoConnectRoamingServices=true\ \fR|\fB\ false
 Automatically connect roaming services. This is not recommended unless you know
 you won't have any billing problem.
diff --git a/src/main.conf b/src/main.conf
index ddcb3564c246..b0eb93811f85 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -159,6 +159,44 @@
 # default one, in replacement.
 # EnableOnlineToReadyTransition = false
 
+# When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition"
+# are asserted, this is the number of failed back-to-back "ready" to
+# "online" HTTP-based Internet reachability checks that will be
+# allowed before marking a service as "failed" from a reachability
+# perspective, sorting it at a lower priority than other services not
+# so marked.
+#
+# Lower values may result in higher-frequency network service cycling
+# while higher values may result in a longer period of time before
+# failing from a non-Internet reachable service to one that might be.
+#
+# See "OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
+# "OnlineCheckMaxInterval" for other values that influence network
+# service failure/recovery transition time.
+#
+# Default value is 6.
+# OnlineCheckFailuresThreshold=6
+
+# When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition"
+# are asserted, this is the number of successful back-to-back "ready"
+# to "online" HTTP-based Internet reachability checks that must be met
+# before clearing a service as "failed" from a reachability
+# perspective and allowing it to transition to the "online" state
+# again, allowing it to sort back to a higher priority relative to
+# other network services.
+#
+# Lower values may result in higher-frequency network service cycling
+# while higher values may result in a longer period of time before
+# transitioning back to more a preferred, Internet reachable network
+# service.
+#
+# See "OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
+# "OnlineCheckMaxInterval" for other values that influence network
+# service failure/recovery transition time.
+#
+# Default value is 6.
+# OnlineCheckSuccessesThreshold=6
+
 # The style or mathematical series function used to compute the actual
 # time, in seconds, between two "ready" to "online" HTTP-based Internet
 # reachability checks. The value of which may be either "geometric" or
-- 
2.42.0


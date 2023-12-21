Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75BFBA38
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2F76E73202
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:31 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E5AF473230
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 57/60] doc: Document the 'OnlineCheckMode' setting.
Date: Wed, 20 Dec 2023 22:40:01 -0800
Message-ID: <20231221064007.2347566-58-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221064007.2347566-1-gerickson@nuovations.com>
References: <20231221064007.2347566-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This documents the 'OnlineCheckMode' configuration setting.
---
 README                |  91 +++++++++++++++++++++++++++---------
 doc/connman.conf.5.in |  73 +++++++++++++++++++++++------
 src/main.conf         | 106 ++++++++++++++++++++++++++++++------------
 3 files changed, 203 insertions(+), 67 deletions(-)

diff --git a/README b/README
index 75cb549d513e..2dee1e5fe73c 100644
--- a/README
+++ b/README
@@ -408,29 +408,74 @@ from ipv4.connman.net (for IPv4 connectivity) and ipv6.connman.net
 (for IPv6 connectivity). The used URL looks like this
 http://ipv{4|6}.connman.net/online/status.html
 
-When an online check request fails, another one is triggered after a
-longer interval. The intervals follows one of two mathemetical
-sequences, depending on the "OnlineCheckIntervalStyle" setting:
-"fibonacci" or "geometric", with a default of "geometric". The
-geometric setting is the square series of numbers in the range
-specified by "OnlineCheckInitialInterval" and "OnlineCheckMaxInterval".
-The default values for "OnlineCheckInitialInterval" and
-"OnlineCheckMaxInterval" are the range [1, 12], which correspond to the
-following "geometric" intervals, in seconds: 1, 4, 9, 16, 25, 36, 49, 64,
-81, 100, 121 and 144 over that range. By contrast, the correspending
-"fibonacci" sequence over that range is 1, 1, 2, 3, 5, 8, 13, 21, 34, 55,
-89, and 144. The "fibonacci" series and style is more aggressive in check
-rate up to 12 steps (its equivalence point with "geometric" at 144 seconds)
-than "geometric" but backs off far more aggressively past that point
-reaching an hour at interval 19 which "geometric" does not reach until
-interval 60.
-
-See connman.conf(5) for the EnableOnlineCheck option, if you need to
-disable the feature.
-It is also possible to specify other URLs via OnlineCheckIPv4URL and
-OnlineCheckIPv6URL options.
-The range of intervals between two online check requests can be fine-tuned
-via OnlineCheckInitialInterval and OnlineCheckMaxInterval options.
+The online check operates in one of three modes:
+
+  * "none"
+  * "one-shot"
+  * "continuous"
+
+where "one-shot" is the default and is governed by the
+"OnlineCheckMode" setting.
+
+In "none" mode, there are no "online" HTTP-based Internet
+reachability checks. Any connected service and the manager state
+will terminate at the Ready state and will not progress to
+Online.
+
+In "one-shot", the default mode, there is a single, one-shot "online"
+HTTP-based Internet reachability check for the default service (that
+is, the service with the high-priority (metric 0) gateway default
+route). When the check succeeds, the associated service and the
+manager state will terminate at the "online" state. When the check
+fails, subsequent checks will be rescheduled according to
+"OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
+"OnlineCheckMaxInterval" and will continue indefinitely until one
+succeeds or until the service is disconnected.
+
+In "continuous" mode, there are ongoing "online" HTTP-based Internet
+reachability checks for the default service (that is, the service with
+the high-priority (metric 0) gateway default route). As with
+"one-shot" mode, when the first check succeeds, the associated service
+and the manager state will terminate at the Online state. Thereafter,
+subsequent checks will be scheduled according to
+"OnlineCheckIntervalStyle" and "OnlineCheckMaxInterval". When the
+check fails, subsequent checks will be rescheduled according to
+"OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
+"OnlineCheckMaxInterval". When and if "OnlineCheckFailuresThreshold"
+is met, the service and manager state will be demoted to Ready and the
+service will have its "Error" property set to "online-check-failed"
+while subsequent checks will continue. In the interim, if available,
+another service may be promoted to the default service and online
+checks will be initiated for it. When and if, for the demoted service,
+"OnlineCheckSuccessesThreshold" is met, the service "Error" property
+will be cleared and the service state promoted to Online, potentially
+causing it to become the default service again.
+
+See connman.conf(5) for the "OnlineCheckMode" option, if you need to
+disable the feature. It is also possible to specify other URLs via
+"OnlineCheckIPv4URL" and "OnlineCheckIPv6URL" options. The range of
+intervals between two online check requests can be fine-tuned via
+"OnlineCheckInitialInterval" and "OnlineCheckMaxInterval" options as
+well as with the "OnlineCheckIntervalStyle" option.
+
+As intimated above, for the "one-shot" and "continuous" modes, when an
+online check request fails (or, in the case of "continuous" mode,
+succeeds as well), another one is triggered after a longer
+interval. The intervals follows one of two mathemetical sequences,
+depending on the "OnlineCheckIntervalStyle" setting: "fibonacci" or
+"geometric", with a default of "geometric". The geometric setting is
+the square series of numbers in the range specified by
+"OnlineCheckInitialInterval" and "OnlineCheckMaxInterval".  The
+default values for "OnlineCheckInitialInterval" and
+"OnlineCheckMaxInterval" are the range [1, 12], which correspond to
+the following "geometric" intervals, in seconds: 1, 4, 9, 16, 25, 36,
+49, 64, 81, 100, 121 and 144 over that range. By contrast, the
+correspending "fibonacci" sequence over that range is 1, 1, 2, 3, 5,
+8, 13, 21, 34, 55, 89, and 144. The "fibonacci" series and style is
+more aggressive in check rate up to 12 steps (its equivalence point
+with "geometric" at 144 seconds) than "geometric" but backs off far
+more aggressively past that point reaching an hour at interval 19
+which "geometric" does not reach until interval 60.
 
 During the online check procedure, ConnMan will temporarily install
 a host route to both the ipv4.connman.net and ipv6.connman.net so that
diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index bc5a112f758a..966c20709724 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -166,7 +166,49 @@ ConnMan will issue an HTTP GET request to verify that end-to-end
 connectivity is successful. Only then the service will be
 transitioned to ONLINE state.
 If this setting is false, the default service will remain in READY state.
-Default value is true.
+Default value is \fBtrue\fR.
+
+\fBNOTE:\fR \fBEnableOnlineCheck\fR is deprecated; please use
+\fBOnlineCheckMode\fR with a mode of either \fBone-shot\fR or
+\fBnone\fR.
+
+.TP
+.BI OnlineCheckMode= mode
+This indicates the "online" HTTP-based Internet reachability check
+mode and supercedes and deprecates \fBEnableOnlineCheck\fR. Possible
+values for \fImode\fR are \fBnone\fR, \fBone-shot\fR, and
+\fBcontinuous\fR. The default value of \fImode\fR is \fBone-shot\fR.
+
+In \fBnone\fR mode, there are no "online" HTTP-based Internet reachability
+checks. Any connected service and the manager state will terminate at
+the "ready" state and will not progress to "online".
+
+In \fBone-shot\fR mode, there is a single, one-shot "online" HTTP-based
+Internet reachability check for the default service. When the check
+succeeds, the associated service and the manager state will terminate
+at the "online" state. When the check fails, subsequent checks will be
+rescheduled according to \fBOnlineCheckIntervalStyle\fR,
+\fBOnlineCheckInitialInterval\fR, and \fBOnlineCheckMaxInterval\fR and will
+continue indefinitely until one succeeds or unti the service is
+disconnected.
+
+In \fBcontinuous\fR mode, there are ongoing "online" HTTP-based Internet
+reachability check for the default service. As with "one-shot" mode,
+when the first check succeeds, the associated service and the manager
+state will terminate at the "online" state. Thereafter, subsequent
+checks will be scheduled according to \fBOnlineCheckIntervalStyle\fR and
+\fBOnlineCheckMaxInterval\fR. When the check fails, subsequent checks will
+be rescheduled according to \fBOnlineCheckIntervalStyle\fR,
+\fBOnlineCheckInitialInterval\fR, and \fBOnlineCheckMaxInterval\fR. When and
+if \fBOnlineCheckFailuresThreshold\fR is met, the service and manager
+state will be demoted to "ready" and the service will have its "Error"
+property set to "online-check-failed" while subsequent checks will
+continue. In the interim, if available, another service may be
+promoted to the default service and online checks will be initiated
+for it. When and if, for the demoted service,
+\fBOnlineCheckSuccessesThreshold\fR is met, the service "Error" property
+will be cleared and the service state promoted to "online",
+potentially causing it to become the default service again.
 .TP
 .BI OnlineCheckIPv4URL= url, OnlineCheckIPv6URL= url
 Urls (IPv4 and IPv6 respectively) used during the online status check.
@@ -220,12 +262,15 @@ If this setting is true, the HTTP GET request keeps beeing called to guarantee
 that end-to-end connectivity is still successful. If not, the default service
 will transition to READY state, enabling another service to become the
 default one, in replacement.
-Default value is false.
+Default value is \fBfalse\fR.
+
+\fBNOTE:\fR \fBEnableOnlineToReadyTransition\fR is deprecated; please use
+\fBOnlineCheckMode\fR with a mode of either \fBcontinuous\fR or
+\fBnone\fR.
 .TP
 .BI OnlineCheckFailuresThreshold= failures
-When both \fBEnableOnlineCheck\fR and
-\fBEnableOnlineToReadyTransition\fR are asserted, this is the number
-of failed back-to-back "ready" to "online" HTTP-based Internet
+When \fBOnlineCheckMode\fR is "continuous", this is the number of
+failed back-to-back "ready" to "online" HTTP-based Internet
 reachability checks that will be allowed before marking a service as
 "failed" from a reachability perspective, sorting it at a lower
 priority than other services not so marked.
@@ -234,16 +279,14 @@ Lower values may result in higher-frequency network service cycling
 while higher values may result in a longer period of time before
 failing from a non-Internet reachable service to one that might be.
 
-See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR,
-and \fBOnlineCheckMaxInterval\fR for other values that influence
-network service failure/recovery transition time.
-
+See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR, and
+\fBOnlineCheckMaxInterval\fR for other values that influence network
+service failure/recovery transition time.
 The default value is 6.
 .TP
 .BI OnlineCheckSuccessesThreshold= successes
-When both \fBEnableOnlineCheck\fR and
-\fBEnableOnlineToReadyTransition\fR are asserted, this is the number
-of successful back-to-back "ready" to "online" HTTP-based Internet
+When \fBOnlineCheckMode\fR is "continuous", this is the number of
+successful back-to-back "ready" to "online" HTTP-based Internet
 reachability checks that must be met before clearing a service as
 "failed" from a reachability perspective and allowing it to transition
 to the "online" state again, allowing it to sort back to a higher
@@ -254,9 +297,9 @@ while higher values may result in a longer period of time before
 transitioning back to more a preferred, Internet reachable network
 service.
 
-See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR,
-and \fBOnlineCheckMaxInterval\fR for other values that influence
-network service failure/recovery transition time.
+See \fBOnlineCheckIntervalStyle\fR, \fBOnlineCheckInitialInterval\fR, and
+\fBOnlineCheckMaxInterval\fR for other values that influence network
+service failure/recovery transition time.
 
 The default value is 6.
 .TP
diff --git a/src/main.conf b/src/main.conf
index b0eb93811f85..5357edb82f90 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -116,11 +116,51 @@
 # section 4.1).
 # Enable6to4 = false
 
-# Enable use of http get as on online status check.
-# When a service is in a READY state, and is selected as default,
-# ConnMan will issue an HTTP GET request to verify that end-to-end
-# connectivity is successful. Only then the service will be
-# transitioned to ONLINE state.
+# This indicates the "online" HTTP-based Internet reachability check
+# mode. Possible values are "none", "one-shot", "continuous".
+#
+# In "none" mode, there are no "online" HTTP-based Internet
+# reachability checks. Any connected service and the manager state
+# will terminate at the "ready" state and will not progress to
+# "online".
+#
+# In "one-shot" mode, there is a single, one-shot "online" HTTP-based
+# Internet reachability check for the default service. When the check
+# succeeds, the associated service and the manager state will
+# terminate at the "online" state. When the check fails, subsequent
+# checks will be rescheduled according to "OnlineCheckIntervalStyle",
+# "OnlineCheckInitialInterval", and "OnlineCheckMaxInterval" and will
+# continue indefinitely until one succeeds or until the service is
+# disconnected.
+#
+# In "continuous" mode, there are ongoing "online" HTTP-based Internet
+# reachability check for the default service. As with "one-shot" mode,
+# when the first check succeeds, the associated service and the
+# manager state will terminate at the "online" state. Thereafter,
+# subsequent checks will be scheduled according to
+# "OnlineCheckIntervalStyle" and "OnlineCheckMaxInterval". When the
+# check fails, subsequent checks will be rescheduled according to
+# "OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
+# "OnlineCheckMaxInterval". When and if "OnlineCheckFailuresThreshold"
+# is met, the service and manager state will be demoted to "ready" and
+# the service will have its "Error" property set to
+# "online-check-failed" while subsequent checks will continue. In the
+# interim, if available, another service may be promoted to the
+# default service and online checks will be initiated for it. When and
+# if, for the demoted service, "OnlineCheckSuccessesThreshold" is met,
+# the service "Error" property will be cleared and the service state
+# promoted to "online", potentially causing it to become the default
+# service again.
+# Default value is "one-shot".
+# OnlineCheckMode = one-shot
+
+# NOTE: This setting is deprecated; use "OnlineCheckMode" instead with
+# a value of "one-shot" or "none".
+# Enable the use of "online" HTTP-baesd Internet reachability check as
+# an online status check.  When a service is in a READY state, and is
+# selected as default, ConnMan will issue an HTTP GET request to
+# verify that end-to-end connectivity is successful. Only then the
+# service will be transitioned to ONLINE state.
 # If this setting is false, the default service will remain in READY state.
 # Default value is true.
 # EnableOnlineCheck = false
@@ -147,24 +187,28 @@
 # OnlineCheckInitialInterval = 1
 # OnlineCheckMaxInterval = 12
 
-# WARNING: Experimental feature!!!
-# In addition to EnableOnlineCheck setting, enable or disable use of HTTP GET
-# to detect the loss of end-to-end connectivity.
-# If this setting is false, when the default service transitions to ONLINE
-# state, the HTTP GET request is no more called until next cycle, initiated
-# by a transition of the default service to DISCONNECT state.
-# If this setting is true, the HTTP GET request keeps beeing called to guarantee
-# that end-to-end connectivity is still successful. If not, the default service
-# will transition to READY state, enabling another service to become the
-# default one, in replacement.
+# NOTE: This setting is deprecated; use "OnlineCheckMode" instead with
+# a value of "continuous" or "none".
+# In addition to the "EnableOnlineCheck" setting, enable or disable
+# continuous use of "online" HTTP-based Internet reachability checks
+# to detect the loss of end-to-end connectivity.
+# If this setting is false, when the default service transitions to
+# ONLINE state, the "online" HTTP-based Internet reachability check is
+# terminated until a transition of the default service to DISCONNECT
+# state.
+# If this setting is true, the "online" HTTP-based Internet
+# reachability checks continue to be rescheduled to guarantee that
+# end-to-end connectivity is still successful. If not, the default
+# service will transition to READY state, enabling another service to
+# become the default one, in replacement.
 # EnableOnlineToReadyTransition = false
 
 # When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition"
-# are asserted, this is the number of failed back-to-back "ready" to
-# "online" HTTP-based Internet reachability checks that will be
-# allowed before marking a service as "failed" from a reachability
-# perspective, sorting it at a lower priority than other services not
-# so marked.
+# are asserted or "OnlineCheckMode" is "continuous", this is the
+# number of failed back-to-back "ready" to "online" HTTP-based
+# Internet reachability checks that will be allowed before marking a
+# service as "failed" from a reachability perspective, sorting it at a
+# lower priority than other services not so marked.
 #
 # Lower values may result in higher-frequency network service cycling
 # while higher values may result in a longer period of time before
@@ -178,12 +222,12 @@
 # OnlineCheckFailuresThreshold=6
 
 # When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition"
-# are asserted, this is the number of successful back-to-back "ready"
-# to "online" HTTP-based Internet reachability checks that must be met
-# before clearing a service as "failed" from a reachability
-# perspective and allowing it to transition to the "online" state
-# again, allowing it to sort back to a higher priority relative to
-# other network services.
+# are asserted or "OnlineCheckMode" is "continuous", this is the
+# number of successful back-to-back "ready" to "online" HTTP-based
+# Internet reachability checks that must be met before clearing a
+# service as "failed" from a reachability perspective and allowing it
+# to transition to the "online" state again, allowing it to sort back
+# to a higher priority relative to other network services.
 #
 # Lower values may result in higher-frequency network service cycling
 # while higher values may result in a longer period of time before
@@ -211,9 +255,13 @@
 # interval of 6, the time, in seconds, is 8 seconds.
 #
 # "fibonacci" is more aggressive in check rate up to 12 steps (its
-# equivalence point with "geometric" at 144 seconds) but is far less
-# aggressive past that point, reacing an hour at interval 19 compared
-# to "geometric" which does not reach an hour until interval 60.
+# equivalence point with "geometric" at 144 seconds) than "geometric"
+# and yields quicker recovery for transient failures. For example, for
+# an "OnlineCheckSuccessesThreshold" of six (6), "fibonacci" gets the
+# failing service back to "online" in 20 seconds versus 91 seconds for
+# "geometric". By comparison, past 12 steps, "fibonacci" backs off far
+# more aggressively, which is less wasteful, particularly for a
+# metered interface like Cellular, when the failures are more enduring.
 #
 # Default value is "geometric".
 # OnlineCheckIntervalStyle=geometric
-- 
2.42.0


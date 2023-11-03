Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D51D68E
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6A78A73301
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:05:35 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2389973348
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:05:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 3/3] service: Add documentation to WISPr-related functions.
Date: Fri, 3 Nov 2023 14:05:34 -0700
References: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
Message-Id: <E0127206-3280-4DFC-9606-F1E5A0804833@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Add documentation to WISPr-related functions.
---
 src/service.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/src/service.c b/src/service.c
index ecc7d23e..417092c6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1526,6 +1526,31 @@ static guint =
online_check_timeout_compute_geometric(unsigned int interval)
 	return timeout_seconds;
 }
=20
+/**
+ *  @brief
+ *    Cancel any "online" HTTP-based Internet reachability checks for
+ *    the specified network service.
+ *
+ *  This cancels any current or pending IPv4 and/or IPv6 "online"
+ *  HTTP-based Internet reachability checks for the specified network
+ *  service.
+ *
+ *  @note
+ *    Any lingering WISPr portal reachability context will be lazily
+ *    released at the start of the next online check for the service
+ *    and replaced with new context.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which any current or pending IPv4 or
+ *                           IPv6 "online" reachability checks should
+ *                           be canceled.
+ *
+ *  @sa start_online_check
+ *  @sa complete_online_check
+ *  @sa __connman_wispr_start
+ *  @sa __connman_wispr_stop
+ *
+ */
 static void cancel_online_check(struct connman_service *service)
 {
 	DBG("service %p (%s) online_timeout_ipv4 %d online_timeout_ipv6 =
%d",
@@ -1545,6 +1570,32 @@ static void cancel_online_check(struct =
connman_service *service)
 	}
 }
=20
+/**
+ *  @brief
+ *    Start an "online" HTTP-based Internet reachability check for the
+ *    specified network service IP configuration type.
+ *
+ *  This attempts to start an "online" HTTP-based Internet
+ *  reachability check for the specified network service IP
+ *  configuration type.
+ *
+ *  @note
+ *    Any check is skipped, with an informational log message, if @a
+ *    EnableOnlineCheck is not asserted.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to start the "online"
+ *                           reachability check.
+ *  @param[in]      type     The IP configuration type for which the
+ *                           "online" reachability check is to be
+ *                           started.
+ *
+ *  @sa cancel_online_check
+ *  @sa complete_online_check
+ *  @sa start_wispr_if_connected
+ *  @sa __connman_service_wispr_start
+ *
+ */
 static void start_online_check(struct connman_service *service,
 				enum connman_ipconfig_type type)
 {
@@ -3777,6 +3828,28 @@ int __connman_service_reset_ipconfig(struct =
connman_service *service,
 	return err;
 }
=20
+/**
+ *  @brief
+ *    Start an "online" HTTP-based Internet reachability check for the
+ *    specified network service IP configuration type.
+ *
+ *  This attempts to start an "online" HTTP-based Internet
+ *  reachability check for the specified network service IP
+ *  configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to start the "online"
+ *                           reachability check.
+ *  @param[in]      type     The IP configuration type for which the
+ *                           "online" reachability check is to be
+ *                           started.
+ *
+ *  @sa cancel_online_check
+ *  @sa start_online_check
+ *  @sa complete_online_check
+ *  @sa start_wispr_if_connected
+ *
+ */
 void __connman_service_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
@@ -6673,6 +6746,25 @@ static void service_rp_filter(struct =
connman_service *service,
 		connected_networks_count, original_rp_filter);
 }
=20
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check.
+ *
+ *  This retries an "online" HTTP-based Internet reachability check
+ *  for the specified network service IP configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which an "online" reachability check
+ *                           should be retried.
+ *  @param[in]      type     The IP configuration type for which an
+ *                           "online" reachability check should be
+ *                           retried.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr_ipv4
+ *  @sa redo_wispr_ipv6
+ *
+ */
 static void redo_wispr(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
@@ -6681,9 +6773,36 @@ static void redo_wispr(struct connman_service =
*service,
 		type, __connman_ipconfig_type2string(type));
=20
 	__connman_wispr_start(service, type, complete_online_check);
+
+	// Release the reference to the service taken when
+	// g_timeout_add_seconds was invoked with the callback
+	// that, in turn, invoked this function.
+
 	connman_service_unref(service);
 }
=20
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check
+ *    callback.
+ *
+ *  This callback retries an IPv4 "online" HTTP-based Internet
+ *  reachability check for the specified network service.
+ *
+ *  @param[in,out]  user_data  A pointer to the mutable network
+ *                             service for which an IPv4 "online"
+ *                             reachability check should be retried.
+ *
+ *  @returns
+ *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr
+ *  @sa redo_wispr_ipv6
+ *
+ */
 static gboolean redo_wispr_ipv4(gpointer user_data)
 {
 	struct connman_service *service =3D user_data;
@@ -6695,6 +6814,28 @@ static gboolean redo_wispr_ipv4(gpointer =
user_data)
 	return FALSE;
 }
=20
+/**
+ *  @brief
+ *    Retry an "online" HTTP-based Internet reachability check
+ *    callback.
+ *
+ *  This callback retries an IPv6 "online" HTTP-based Internet
+ *  reachability check for the specified network service.
+ *
+ *  @param[in,out]  user_data  A pointer to the mutable network
+ *                             service for which an IPv6 "online"
+ *                             reachability check should be retried.
+ *
+ *  @returns
+ *    FALSE (that is, G_SOURCE_REMOVE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa complete_online_check
+ *  @sa redo_wispr
+ *  @sa redo_wispr_ipv4
+ *
+ */
 static gboolean redo_wispr_ipv6(gpointer user_data)
 {
 	struct connman_service *service =3D user_data;
@@ -6706,6 +6847,48 @@ static gboolean redo_wispr_ipv6(gpointer =
user_data)
 	return FALSE;
 }
=20
+/**
+ *  @brief
+ *    This completes an "online" HTTP-based Internet reachability
+ *    check for the specified network service and IP configuration
+ *    type.
+ *
+ *  This completes a failed or successful "online" HTTP-based Internet
+ *  reachability check for the specified network service and IP
+ *  configuration type. This effectively "bookends" an earlier
+ *  #__connman_service_wispr_start.
+ *
+ *  If "EnableOnlineToReadyTransition" is deasserted and if @a success
+ *  is asserted, then the state for the specified IP configuration
+ *  type is transitioned to "online" and a future online check is
+ *  scheduled based on the current interval and the
+ *  "OnlineCheckIntervalStyle" setting.
+ *
+ *  Otherwise, if "EnableOnlineToReadyTransition" is asserted, then
+ *  counters are managed for the success or failure and state is
+ *  managed and tracked resulting in the potential demotion of the
+ *  service, placing it into a temporary failure state until such time
+ *  as a series of back-to-back online checks successfully
+ *  complete. If the service is a non-default after demotion and it is
+ *  in failure state or if it is the default service, then a future
+ *  online check is scheduled based on the current interval and the
+ *  "OnlineCheckIntervalStyle" setting.
+ *
+ *  @param[in,out]  service  A pointer to the mutable service for which
+ *                           to complete a previously-requested online
+ *                           check.
+ *  @param[in]      type     The IP configuration type for which to
+ *                           complete a previously-requested online
+ *                           check.
+ *  @param[in]      success  A Boolean indicating whether the =
previously-
+ *                           requested online check was successful.
+ *
+ *  @sa cancel_online_check
+ *  @sa start_online_check
+ *  @sa start_wispr_if_connected
+ *  @sa __connman_service_wispr_start
+ *
+ */
 static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success)
--=20
2.42.0


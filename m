Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B61845
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 78BF97314E
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:47:18 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 42595731CE
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:47:18 -0500 (EST)
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
Subject: [PATCH 4/4] wispr: Address unbalanced reference counting with proxy
 handling.
Date: Thu, 9 Nov 2023 20:47:17 -0800
References: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Message-Id: <D5AF6DC1-A78A-4160-986D-1D44AA9463D4@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This balances previously-unbalanced WISPr/portal context reference
counting associated with proxy handling that can lead to a heap-use-
after-free fault.

Prior to this change, 'proxy_callback' contained an unbalanced release
on the reference to a WISPr/portal context that could lead to its
premature destructio and a subsequent heap-use-after-free fault in
'free_wispr_routes'.

This situation could occur, due to this imbalance, when a new =
WISPr/portal
request for given service and IP configuration combination displaced a
prior, but unclosed and pending within 'g_web_request_get' request,
WISPr/portal context leading to its premature deletion. Later, when
the prior 'g_web_request_get' completed, either successfully or
unsuccessfully, this resulted in a different, yet balanced release on
the reference at the end of the 'wispr_portal_web_result' callback to
'g_web_request_get'. This also resulted in its (now redundant) =
destruction.
The heap-use-after-free actually occurred BEFORE the reference release,
in 'free_wispr_routes' since in 'wispr_portal_web_result',
'free_wispr_routes' is invoked BEFORE the reference is released.

This imbalance is addressed by balancing the reference release in
'proxy_callback' with a reference retain prior to either invoking
'connman_proxy_lookup' with the 'proxy_callback' callback or invoking
'g_idle_add' with the 'no_proxy_callback', which ultimately calls
'proxy_callback'.

The address sanitizer report associated with the potential heap-use-
after-free is as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D2188=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x72b0f4b4 at pc 0x000f36b5 bp 0x7eac98c8 sp 0x7eac98cc
READ of size 4 at 0x72b0f4b4 thread T0
    #0 0xf36b2 in free_wispr_routes src/wispr.c:140
    #1 0xf5fde in wispr_portal_web_result src/wispr.c:871
    #2 0x3285e in call_result_func gweb/gweb.c:465
    #3 0x3285e in received_data gweb/gweb.c:920

0x72b0f4b4 is located 100 bytes inside of 108-byte region =
[0x72b0f450,0x72b0f4bc)
freed by thread T0 here:
    #0 0x76abf264 in __interceptor_free =
/data/jenkins/workspace/GNU-toolchain/arm-12/src/gcc/libsanitizer/asan/asa=
n_malloc_linux.cpp:52
    #1 0xf3916 in free_connman_wispr_portal_context src/wispr.c:211
    #2 0xf4706 in wispr_portal_context_unref_debug src/wispr.c:239
    #3 0xf6408 in __connman_wispr_start src/wispr.c:1101
    #4 0x9830a in __connman_service_wispr_start src/service.c:2421
    #5 0x990d2 in start_wispr_if_connected src/service.c:2375
    #6 0x9ae2c in default_changed src/service.c:2637
    #7 0x9afb6 in __connman_service_indicate_default src/service.c:7660
    #8 0x856de in set_default_gateway src/connection.c:509
    #9 0x86e3a in __connman_connection_update_gateway =
src/connection.c:1053
    #10 0x9b0aa in service_update_preferred_order src/service.c:7320
    #11 0x9b2d2 in service_indicate_state src/service.c:7400
    #12 0x9baaa in __connman_service_ipconfig_indicate_state =
src/service.c:7848
    #13 0x9ed28 in complete_online_check src/service.c:2219
    #14 0xf44fc in portal_manage_success_status src/wispr.c:516
    #15 0xf60ac in wispr_portal_web_result src/wispr.c:820
    #16 0x3285e in call_result_func gweb/gweb.c:465
    #17 0x3285e in received_data gweb/gweb.c:920

previously allocated by thread T0 here:
    #0 0x76abfa6c in __interceptor_calloc =
/data/jenkins/workspace/GNU-toolchain/arm-12/src/gcc/libsanitizer/asan/asa=
n_malloc_linux.cpp:77

SUMMARY: AddressSanitizer: heap-use-after-free src/wispr.c:140 in =
free_wispr_routes
---
 src/wispr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index b496b7f9..f3ce123d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1033,9 +1033,18 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
 	 * connman_proxy_lookup, since the former will always result in
 	 * a WISPr request "falling down a hole" that will only ever
 	 * result in a failure completion.
+	 *
+	 * Whether following the connman_proxy_lookup / proxy_callback
+	 * path or the g_idle_add / no_proxy_callback path, both funnel =
to
+	 * proxy_callback. Retain a reference to the WISPr/portal =
context
+	 * here and release it there (that is, in proxy_callback) such
+	 * that the context is retained while the lookup or the idle
+	 * timeout are in flight.
 	 */
 	if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT &&
 			proxy_method !=3D =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) {
+		wispr_portal_context_ref(wp_context);
+
 		wp_context->token =3D connman_proxy_lookup(interface,
 						wp_context->status_url,
 						wp_context->service,
@@ -1046,6 +1055,8 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
 			wispr_portal_context_unref(wp_context);
 		}
 	} else if (wp_context->timeout =3D=3D 0) {
+		wispr_portal_context_ref(wp_context);
+
 		wp_context->timeout =3D g_idle_add(no_proxy_callback, =
wp_context);
 	}
=20
--=20
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762129B4
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3C48B73213
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 00:05:22 -0500 (EST)
Received: from [192.168.1.128] (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 062CC73292
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 00:05:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN proxy
 method
Message-Id: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
Date: Wed, 8 Nov 2023 21:05:20 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

For certain network interfaces, such as Ethernet, that go through the
state machine to 'ready' rapidly, it is possible that the HTTP-based
"online" reachablility WISPr probe will be initiated before the
corresponding network service has its proxy method set. In such
instances, the proxy method is still set to
'CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN' from the initial service
initialization. Consequently, when the WISPr request wends its way to
'wispr_portal_detect', it would previously invoke =
'connman_proxy_lookup'.
Unfortunately, for such a method, there is no corresponding proxy driver
and the lookup will, eventually, unconditionally fail resulting in a
wasted WISPr check.

This change adds =E2=80=98CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN'
alongside 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT' as the two
proxy methods for which a call to 'connman_proxy_lookup' are avoided. =
This
shunts the logic to the 'no_proxy_callback' callback, which assumes a =
direct
proxy method and results in a successful and unwasted WISPr reachability
check for such cases.
---
 src/wispr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index f0138386..e769e294 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1004,7 +1004,15 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
=20
 	DBG("proxy_method %d", proxy_method);
=20
-	if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT) {
+	/*
+	 * Include both CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN and
+	 * CONNMAN_SERVICE_PROXY_METHOD_DIRECT in avoiding a call to
+	 * connman_proxy_lookup, since the former will always result in
+	 * a WISPr request "falling down a hole" that will only ever
+	 * result in a failure completion.
+	 */
+	if ((proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT) &&
+		(proxy_method !=3D =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN)) {
 		wp_context->token =3D connman_proxy_lookup(interface,
 						wp_context->status_url,
 						wp_context->service,
--=20
2.42.0



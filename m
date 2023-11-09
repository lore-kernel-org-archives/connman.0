Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F171A73B
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0ECCC73129;
	Thu,  9 Nov 2023 10:24:51 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B87387317C;
	Thu,  9 Nov 2023 10:24:50 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH v2] wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN proxy
 method.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
Date: Thu, 9 Nov 2023 07:24:49 -0800
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90BC29FA-5BA6-4BD2-8609-98FF22FEAC1A@nuovations.com>
References: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
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
index f0138386..4f28e8bb 100644
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
+	if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT &&
+		proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) =
{
 		wp_context->token =3D connman_proxy_lookup(interface,
 						wp_context->status_url,
 						wp_context->service,
--=20
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BB2D781
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A366D7316C
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:22:37 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 716747319B
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:22:37 -0500 (EST)
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
Subject: [PATCH 1/2] wispr: rename 'portal_manage_status'.
Date: Mon, 6 Nov 2023 13:22:37 -0800
References: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
Message-Id: <B406A371-AF27-487F-AAFC-A3F5DADBF649@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'portal_manage_status' to 'portal_manage_success_status'
as it exclusively handles HTTP 200 "OK" success status and no others.
---
 src/wispr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 64c94a4d..454669bd 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -453,7 +453,7 @@ static void wispr_portal_error(struct =
connman_wispr_portal_context *wp_context)
 	wp_context->wispr_result =3D CONNMAN_WISPR_RESULT_FAILED;
 }
=20
-static void portal_manage_status(GWebResult *result,
+static void portal_manage_success_status(GWebResult *result,
 			struct connman_wispr_portal_context *wp_context)
 {
 	struct connman_service *service =3D wp_context->service;
@@ -783,7 +783,7 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
=20
 		if (g_web_result_get_header(result, "X-ConnMan-Status",
 						&str)) {
-			portal_manage_status(result, wp_context);
+			portal_manage_success_status(result, =
wp_context);
 		} else {
 			wispr_portal_context_ref(wp_context);
 			=
__connman_agent_request_browser(wp_context->service,
--=20
2.42.0


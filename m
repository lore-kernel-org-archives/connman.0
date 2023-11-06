Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B82D781
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B93CC7316C
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:23:00 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 88B99731EE
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:23:00 -0500 (EST)
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
Subject: [PATCH 2/2] Add documentation to 'portal_manage_success_status'.
Date: Mon, 6 Nov 2023 13:23:00 -0800
References: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <184BE851-F653-4B6B-B5DF-DE548DD62F3E@nuovations.com>
Message-Id: <CF8E255B-3775-42DE-86B0-9C3F4A70A57A@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'portal_manage_success_status' function.
---
 src/wispr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 454669bd..f0138386 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -453,6 +453,29 @@ static void wispr_portal_error(struct =
connman_wispr_portal_context *wp_context)
 	wp_context->wispr_result =3D CONNMAN_WISPR_RESULT_FAILED;
 }
=20
+/**
+ *  @brief
+ *    Handle a successful "online" HTTP-based Internet reachability
+ *    check.
+ *
+ *  This handles a successful (that is, completed with a HTTP 200 "OK"
+ *  status code) "online" HTTP-based Internet reachability check
+ *  previously-initiated with #__connman_wispr_start.
+ *
+ *  @param[in]      result      A pointer to the mutable HTTP result
+ *                              for the successful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              handling.
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated the
+ *                              successful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              handling.
+ *
+ *  @sa __connman_wispr_start
+ *  @sa wispr_portal_web_result
+ *
+ */
 static void portal_manage_success_status(GWebResult *result,
 			struct connman_wispr_portal_context *wp_context)
 {
--=20
2.42.0


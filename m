Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA91845
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 50C0F731F7
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:46:27 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1A31073214
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:46:27 -0500 (EST)
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
Subject: [PATCH 3/4] wispr: Add documentation about reference counting.
Date: Thu, 9 Nov 2023 20:46:26 -0800
References: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Message-Id: <7DC71CAA-74A1-4437-8956-4F0B8AB8E13C@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation about the balanced retain/release reference
counting done to handle the weak reference to the WISPr/portal context
maintained by 'g_web_request_get'.
---
 src/wispr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 96c5f454..b496b7f9 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -574,6 +574,11 @@ static void wispr_portal_request_portal(
 		connman_service_get_identifier(wp_context->service),
 		wp_context->type, =
__connman_ipconfig_type2string(wp_context->type));
=20
+	/*
+	 * Retain a reference to the WISPr/portal context to account for
+	 * 'g_web_request_get' maintaining a weak reference to it. This =
will
+	 * be released in the 'wispr_portal_web_result' callback.
+	 */
 	wispr_portal_context_ref(wp_context);
 	wp_context->request_id =3D g_web_request_get(wp_context->web,
 					wp_context->status_url,
@@ -873,6 +878,12 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 	wp_context->request_id =3D 0;
 done:
 	wp_context->wispr_msg.message_type =3D -1;
+
+	/*
+	 * Release a reference to the WISPr/portal context to balance =
the
+	 * earlier reference retained to account for 'g_web_request_get'
+	 * maintaining a weak reference to it.
+	 */
 	wispr_portal_context_unref(wp_context);
 	return false;
 }
--=20
2.42.0


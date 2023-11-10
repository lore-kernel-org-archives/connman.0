Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E11137F
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9679C7315A
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:45:40 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 61E64731F7
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:45:40 -0500 (EST)
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
Subject: [PATCH 1/4] wispr: Add DBG statement to
 'free_connman_wispr_portal_context'.
Date: Thu, 9 Nov 2023 20:45:39 -0800
References: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Message-Id: <C3AD82DD-7F27-4B0E-83CA-2E1F1E17A23D@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a =E2=80=98DBG' statement to =
'free_connman_wispr_portal_context' to
aid in debugging WISPr/portal reference counting errors and
correlating WISPr online checks in flight in a multi-technology
environment with "EnableOnlineToReadyTransition" asserted.
---
 src/wispr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 57e74a83..5f60bed7 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -164,6 +164,13 @@ static void free_wispr_routes(struct =
connman_wispr_portal_context *wp_context)
 static void free_connman_wispr_portal_context(
 		struct connman_wispr_portal_context *wp_context)
 {
+	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
+		wp_context,
+		wp_context->service,
+		connman_service_get_identifier(wp_context->service),
+		wp_context->type,
+		__connman_ipconfig_type2string(wp_context->type));
+
 	if (wp_context->wispr_portal) {
 		if (wp_context->wispr_portal->ipv4_context =3D=3D =
wp_context)
 			wp_context->wispr_portal->ipv4_context =3D NULL;
--=20
2.42.0


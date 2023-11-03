Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C326296
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DF41A73256
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:40:33 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A6ACF7327A
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:40:33 -0400 (EDT)
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
Subject: [PATCH] service: Enhance DBG in '__connman_service_indicate_default'.
Message-Id: <0B51F2F9-E96E-4C79-B757-EC697EE5CAF8@nuovations.com>
Date: Fri, 3 Nov 2023 16:40:32 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This enhances the DBG statement in '__connman_service_indicate_default'
by adding the service identifier. In addition, it aligns the content and
format with other DBG functions in the module to make debugging and at-
a-glance correlation easier, especially in a multi-technology =
environment
with "EnableOnlineToReadyTransition" asserted.
---
 src/service.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 75ed9ccd..ff6ee12f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6746,7 +6746,9 @@ int __connman_service_clear_error(struct =
connman_service *service)
=20
 int __connman_service_indicate_default(struct connman_service *service)
 {
-	DBG("service %p state %s", service, =
state2string(service->state));
+	DBG("service %p (%s) state %d (%s)",
+		service, connman_service_get_identifier(service),
+		service->state, state2string(service->state));
=20
 	if (!is_connected(service->state)) {
 		/*
--=20
2.42.0



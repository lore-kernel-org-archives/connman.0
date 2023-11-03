Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB21D68E
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 980F073296
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:05:10 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 659C0732BB
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:05:10 -0400 (EDT)
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
Subject: [PATCH 2/3] service: Make DBG in 'redo_wispr' consistent.
Date: Fri, 3 Nov 2023 14:05:10 -0700
References: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
Message-Id: <8B16D43F-BED0-46D4-B95D-B8B5BFAFF79F@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This makes the DBG statement in 'redo_wispr' consistent in format and
content with that of 'start_online_check' and =
'start_wispr_if_connected'."
making at a glance correlation of WISPr attempts easier.
---
 src/service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index f6decb77..ecc7d23e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6676,9 +6676,9 @@ static void service_rp_filter(struct =
connman_service *service,
 static void redo_wispr(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
-	DBG("Retrying %s WISPr for %p %s",
-		__connman_ipconfig_type2string(type),
-		service, service->name);
+	DBG("Retrying service %p (%s) type %d (%s) WISPr",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
=20
 	__connman_wispr_start(service, type, complete_online_check);
 	connman_service_unref(service);
--=20
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17E1D68E
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4DDD6731C9
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:04:55 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 17A6F73207
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 17:04:55 -0400 (EDT)
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
Subject: [PATCH 1/3] service: Add DBG statements to 
 '{start,cancel}_online_check'.
Date: Fri, 3 Nov 2023 14:04:54 -0700
References: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
Message-Id: <6EC9F8D9-88C8-45A0-B9E3-99763D0615A1@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds DBG statements to '{start,cancel}_online_check' to aid in
debugging and correlating WISPr online checks in flight in a multi-
technology environment with "EnableOnlineToReadyTransition" asserted.
---
 src/service.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/service.c b/src/service.c
index ddb95143..f6decb77 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1528,6 +1528,11 @@ static guint =
online_check_timeout_compute_geometric(unsigned int interval)
=20
 static void cancel_online_check(struct connman_service *service)
 {
+	DBG("service %p (%s) online_timeout_ipv4 %d online_timeout_ipv6 =
%d",
+		service, connman_service_get_identifier(service),
+		service->online_timeout_ipv4,
+		service->online_timeout_ipv6);
+
 	if (service->online_timeout_ipv4) {
 		g_source_remove(service->online_timeout_ipv4);
 		service->online_timeout_ipv4 =3D 0;
@@ -1543,6 +1548,12 @@ static void cancel_online_check(struct =
connman_service *service)
 static void start_online_check(struct connman_service *service,
 				enum connman_ipconfig_type type)
 {
+	DBG("service %p (%s) type %d (%s) maybe start WISPr",
+		service,
+		connman_service_get_identifier(service),
+		type,
+		__connman_ipconfig_type2string(type));
+
 	if (!connman_setting_get_bool("EnableOnlineCheck")) {
 		connman_info("Online check disabled. "
 			"Default service remains in READY state.");
--=20
2.42.0


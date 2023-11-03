Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F424208
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E9F1F73204
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 18:13:44 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B62E37321E
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 18:13:44 -0400 (EDT)
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
Subject: [PATCH 1/2] service: Add DBG statements to proxy functions.
Date: Fri, 3 Nov 2023 15:13:44 -0700
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
Message-Id: <03547C7B-A302-4CFD-B98E-AA1476A1B8F1@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds DBG statements to 'check_proxy_setup' and
'connman_service_set_proxy_method' to aid in debugging.
---
 src/service.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/service.c b/src/service.c
index 417092c6..c89d720c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1427,6 +1427,8 @@ void =
__connman_service_nameserver_del_routes(struct connman_service *service,
=20
 static bool check_proxy_setup(struct connman_service *service)
 {
+	DBG("service %p (%s)", service, =
connman_service_get_identifier(service));
+
 	/*
 	 * We start WPAD if we haven't got a PAC URL from DHCP and
 	 * if our proxy manual configuration is either empty or set
@@ -3088,6 +3090,10 @@ const char * const =
*connman_service_get_timeservers(const struct connman_service
 void connman_service_set_proxy_method(struct connman_service *service,
 					enum =
connman_service_proxy_method method)
 {
+	DBG("service %p (%s) method %d (%s)",
+		service, connman_service_get_identifier(service),
+		method, proxymethod2string(method));
+
 	if (!service || service->hidden)
 		return;
=20
--=20
2.42.0


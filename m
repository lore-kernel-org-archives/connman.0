Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658E3589F
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 37EFF7314B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 14:29:11 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 00BC9731CE
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 14:29:10 -0500 (EST)
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
Subject: [PATCH 2/2 v2] service: Add documentation to proxy-related functions.
Date: Tue, 7 Nov 2023 11:29:09 -0800
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
 <B5EF6141-E568-42FF-80CD-B010B5ABA14C@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <B5EF6141-E568-42FF-80CD-B010B5ABA14C@nuovations.com>
Message-Id: <142A53C6-7DB5-49AA-8B7C-763412123A9D@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Add documentation to the proxy-related functions, 'check_proxy_setup'
and '__connman_service_set_proxy_method'.
---
 src/service.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/service.c b/src/service.c
index bf26736e..5497c1ee 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1425,6 +1425,32 @@ void =
__connman_service_nameserver_del_routes(struct connman_service *service,
 		nameserver_del_routes(index, service->nameservers, =
type);
 }
=20
+/**
+ *  @brief
+ *    Check the proxy setup of the specified network service.
+ *
+ *  This checks the proxy configuration of the specified network
+ *  service. The network service, @a service, may be set to
+ *  #CONNMAN_SERVICE_PROXY_METHOD_DIRECT if the current internal
+ *  method is empty or if there is no Proxy Auto-configuration (PAC)
+ *  URL received from DHCP or if the user proxy configuration is empty
+ *  or automatic and the Web Proxy Auto-discovery (WPAD) protocol
+ *  fails.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which the proxy setup is to be
+ *                           checked and for which the method may be
+ *                           updated to
+ *                           #CONNMAN_SERVICE_PROXY_METHOD_DIRECT.
+ *
+ *  @returns
+ *    True if the proxy method has been established for the specified
+ *    service; otherwise, false.
+ *
+ *  @sa connman_service_set_proxy_method
+ *  @sa __connman_wpad_start
+ *
+ */
 static bool check_proxy_setup(struct connman_service *service)
 {
 	DBG("service %p (%s)", service, =
connman_service_get_identifier(service));
@@ -3369,6 +3395,21 @@ char **connman_service_get_timeservers(struct =
connman_service *service)
 	return service->timeservers;
 }
=20
+/**
+ *  @brief
+ *    Set the web proxy method of the specified service.
+ *
+ *  This attempts to set the web proxy method of the specified service
+ *  but will fail to do so if @a service is null or is hidden.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to set the web proxy method.
+ *  @param[in]      method   The web proxy method to set.
+ *
+ *  @sa proxy_changed
+ *  @sa __connman_notifier_proxy_changed
+ *
+ */
 void connman_service_set_proxy_method(struct connman_service *service,
 					enum =
connman_service_proxy_method method)
 {
--=20
2.42.0


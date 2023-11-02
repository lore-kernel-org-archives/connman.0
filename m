Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A87219F1
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 84CFE731F0
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 18:52:00 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 46A5F731FD
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 18:52:00 -0400 (EDT)
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
Subject: [PATCH] Const-qualify service comparison functions.
Message-Id: <EBAC877C-BD4C-46DD-A58F-452AC8CBEF7B@nuovations.com>
Date: Thu, 2 Nov 2023 15:51:59 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network service arguments in service comparison
functions to make it clear to the compiler, static analyzers, and
human readers that the functions are strictly observers of service
state with no network service mutation side effects.
---
 src/service.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/service.c b/src/service.c
index 1a674924..9c77be08 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5411,11 +5411,11 @@ void connman_service_unref_debug(struct =
connman_service *service,
=20
 static gint service_compare(gconstpointer a, gconstpointer b);
=20
-static gint service_compare_vpn(struct connman_service *a,
-						struct connman_service =
*b)
+static gint service_compare_vpn(const struct connman_service *a,
+						const struct =
connman_service *b)
 {
 	struct connman_provider *provider;
-	struct connman_service *service;
+	const struct connman_service *service;
 	struct connman_service *transport;
 	const char *ident;
 	bool reverse;
@@ -5443,8 +5443,8 @@ static gint service_compare_vpn(struct =
connman_service *a,
 	return service_compare(transport, service);
 }
=20
-static gint service_compare_preferred(struct connman_service =
*service_a,
-					struct connman_service =
*service_b)
+static gint service_compare_preferred(const struct connman_service =
*service_a,
+					const struct connman_service =
*service_b)
 {
 	unsigned int *tech_array;
 	int i;
@@ -5464,8 +5464,8 @@ static gint service_compare_preferred(struct =
connman_service *service_a,
=20
 static gint service_compare(gconstpointer a, gconstpointer b)
 {
-	struct connman_service *service_a =3D (void *) a;
-	struct connman_service *service_b =3D (void *) b;
+	const struct connman_service *service_a =3D (const void *) a;
+	const struct connman_service *service_b =3D (const void *) b;
 	enum connman_service_state state_a, state_b;
 	bool a_connected, b_connected;
 	gint strength;
--=20
2.42.0



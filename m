Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9696C140
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DCD4A73184
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:30:36 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A5E82732EE
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:30:36 -0400 (EDT)
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
Subject: [PATCH] Const-qualify 'connman_{network,provider}_get_index'.
Message-Id: <F5EB01CB-FAAC-4370-A256-D3920ABFF56C@nuovations.com>
Date: Thu, 19 Oct 2023 14:30:35 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network and provider arguments to make it clear to
the compiler, static analyzers, and human readers that the function
is strictly a getter with no network or provider mutation side effects.

---
 include/network.h  | 2 +-
 include/provider.h | 2 +-
 src/network.c      | 2 +-
 src/provider.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/network.h b/include/network.h
index 5bca62ad..b0c314fb 100644
--- a/include/network.h
+++ b/include/network.h
@@ -85,7 +85,7 @@ enum connman_network_type =
connman_network_get_type(struct connman_network *netwo
 const char *connman_network_get_identifier(struct connman_network =
*network);
=20
 void connman_network_set_index(struct connman_network *network, int =
index);
-int connman_network_get_index(struct connman_network *network);
+int connman_network_get_index(const struct connman_network *network);
=20
 void connman_network_set_group(struct connman_network *network,
 						const char *group);
diff --git a/include/provider.h b/include/provider.h
index 1f120990..3f2e36ad 100644
--- a/include/provider.h
+++ b/include/provider.h
@@ -94,7 +94,7 @@ int connman_provider_indicate_error(struct =
connman_provider *provider,
 					enum connman_provider_error =
error);
=20
 void connman_provider_set_index(struct connman_provider *provider, int =
index);
-int connman_provider_get_index(struct connman_provider *provider);
+int connman_provider_get_index(const struct connman_provider =
*provider);
=20
 void connman_provider_set_data(struct connman_provider *provider, void =
*data);
 void *connman_provider_get_data(struct connman_provider *provider);
diff --git a/src/network.c b/src/network.c
index e3e02d16..d0ecec2e 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1404,7 +1404,7 @@ done:
  *
  * Get index number of network
  */
-int connman_network_get_index(struct connman_network *network)
+int connman_network_get_index(const struct connman_network *network)
 {
 	return network->index;
 }
diff --git a/src/provider.c b/src/provider.c
index e2091846..e3d34d8f 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -535,7 +535,7 @@ done:
 	provider->index =3D index;
 }
=20
-int connman_provider_get_index(struct connman_provider *provider)
+int connman_provider_get_index(const struct connman_provider *provider)
 {
 	return provider->index;
 }
--=20
2.32.0


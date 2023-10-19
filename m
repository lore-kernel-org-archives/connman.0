Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92871208B8
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id F1FE073182
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 16:59:04 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BE38473246
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 16:59:04 -0400 (EDT)
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
Subject: [PATCH] Const-qualify 'connman_ipconfig_get_index'.
Message-Id: <486CCD85-633C-4362-9EF0-D429B88792E9@nuovations.com>
Date: Thu, 19 Oct 2023 13:59:03 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network service argument to make it clear to the
compiler, static analyzers, and human readers that the function is
strictly a getter with no network mutation side effects.

---
 src/connman.h  | 2 +-
 src/ipconfig.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index b955d98b..5e422398 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -334,7 +334,7 @@ void __connman_ipconfig_unref_debug(struct =
connman_ipconfig *ipconfig,
 void *__connman_ipconfig_get_data(struct connman_ipconfig *ipconfig);
 void __connman_ipconfig_set_data(struct connman_ipconfig *ipconfig, =
void *data);
=20
-int __connman_ipconfig_get_index(struct connman_ipconfig *ipconfig);
+int __connman_ipconfig_get_index(const struct connman_ipconfig =
*ipconfig);
=20
 void __connman_ipconfig_set_ops(struct connman_ipconfig *ipconfig,
 				const struct connman_ipconfig_ops *ops);
diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..ce870db6 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1388,7 +1388,7 @@ void __connman_ipconfig_set_data(struct =
connman_ipconfig *ipconfig, void *data)
  *
  * Get interface index
  */
-int __connman_ipconfig_get_index(struct connman_ipconfig *ipconfig)
+int __connman_ipconfig_get_index(const struct connman_ipconfig =
*ipconfig)
 {
 	if (!ipconfig)
 		return -1;
--=20
2.32.0=

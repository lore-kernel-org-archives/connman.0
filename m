Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9A2D62D
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1BEDD73242
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:21:12 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DA689732D2
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:21:11 -0400 (EDT)
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
Subject: [PATCH 5/6] timeservice: Add function documentation for 'ts_reset'.
Date: Wed, 1 Nov 2023 20:21:11 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <EA902C40-CBDD-4218-BA79-90879FFFF31A@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

---
 src/timeserver.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/timeserver.c b/src/timeserver.c
index c41c1798..1d39cbe4 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -398,6 +398,23 @@ static void ts_set_nameservers(struct =
connman_service *service)
 	}
 }
=20
+/**
+ *  @brief
+ *    Reset internal time of day synchronization state and initiate
+ *    time of day synchronization with the specified network service.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           object for which a time of day
+ *                           synchronization with time services should
+ *                           be initiated. Name and time servers from
+ *                           this service will be used for time of day
+ *                           synchronization.
+ *
+ *  @sa __connman_timeserver_sync
+ *  @sa __connman_timeserver_conf_update
+ *  @sa __connman_timeserver_system_set
+ *
+ */
 static void ts_reset(struct connman_service *service)
 {
 	DBG("service %p", service);
--=20
2.42.0


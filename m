Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76828184F
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 43428732B2
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:10 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 09B5473316
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:09 -0400 (EDT)
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
Subject: [PATCH 2/6] timeserver: Expand service debug logging
Date: Wed, 1 Nov 2023 20:20:09 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <14985415-1215-44BA-9F0E-A67DB029EEED@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This expands logging in 'ts_reset' by adding a service pointer and in
'__connman_timeserver_sync' by adding the service pointer, service
identifier, and time server sync reason enumeration and string to
aid debugging.
---
 src/timeserver.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/timeserver.c b/src/timeserver.c
index d23776fa..e5efc716 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -395,6 +395,8 @@ static void ts_set_nameservers(struct =
connman_service *service)
=20
 static void ts_reset(struct connman_service *service)
 {
+	DBG("service %p", service);
+
 	if (!resolv)
 		return;
=20
@@ -431,9 +433,30 @@ static void ts_reset(struct connman_service =
*service)
 	timeserver_sync_start();
 }
=20
+static const char *timeserver_sync_reason2string(
+			enum connman_timeserver_sync_reason reason)
+{
+	switch (reason) {
+	case CONNMAN_TIMESERVER_SYNC_REASON_START:
+		return "start";
+	case CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE:
+		return "address update";
+	case CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE:
+		return "state update";
+	case CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE:
+		return "timeserver change";
+	}
+
+	return "unknown";
+}
+
 void __connman_timeserver_sync(struct connman_service *service,
 			enum connman_timeserver_sync_reason reason)
 {
+	DBG("service %p (%s) reason %d (%s)",
+		service, connman_service_get_identifier(service),
+		reason, timeserver_sync_reason2string(reason));
+
 	if (!service)
 		return;
=20
--=20
2.42.0


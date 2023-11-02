Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539A2D624
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AEE9173190
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:51 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7A1477327D
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:51 -0400 (EDT)
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
Subject: [PATCH 4/6] timeserver: Convert ts_service from a weak to a strong 
 reference
Date: Wed, 1 Nov 2023 20:20:51 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <A7E5D539-D7B5-4BB8-80C3-1ACE6C1E8718@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This changes the semantics of dealing with 'ts_service', the active
network service against which time-of-day synchronization is run,
from a weak (that is, simple assignment) reference to a strong (that
is, uses 'connman_service_{ref,unref}') reference.

This avoids a stale reference that can occur in failure paths
should the time service find itself 'ts_service' referencing
a disconnecting and, consequently, disappearing service.

This stale reference would otherwise lead to a heap-use-after-free
fault when the time services attempts to access the name or time
services associated with the stale service.

By promoting the weak reference to a strong reference, a potential
service deallocation is deferred until 'timeserver_stop' is invoked
and the reference to the service released.

The address sanitizer report associated with the potential heap-use-
after-free is as follows:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    =3D=3D526=3D=3DERROR: AddressSanitizer: heap-use-after-free on =
address 0x72603898 at pc 0x0009b451 bp 0x7e9678f8 sp 0x7e9678fc
    READ of size 4 at 0x72603898 thread T0
        #0 0x9b44e in connman_service_get_nameservers:service.c:2896 =
(/usr/sbin/connmand+0x9b44e)
        #1 0xd485e in ts_set_nameservers:timeserver.c:387 =
(/usr/sbin/connmand+0xd485e)
        #2 0xd4930 in sync_next:timeserver.c:187 =
(/usr/sbin/connmand+0xd4930)
        #3 0xd4e6a in resolv_result:timeserver.c:141 =
(/usr/sbin/connmand+0xd4e6a)
        #4 0x37b5a in sort_and_return_results:gresolv.c:522 =
(/usr/sbin/connmand+0x37b5a)
        #5 0x385e4 in query_timeout:gresolv.c:547 =
(/usr/sbin/connmand+0x385e4)

    0x72603898 is located 88 bytes inside of 408-byte region =
[0x72603840,0x726039d8)
    freed by thread T0 here:
       #0 0x76a0d264  (/lib/libasan.so.8+0x8d264)

    previously allocated by thread T0 here:
        #0 0x76a0da6c in calloc (/lib/libasan.so.8+0x8da6c)
        #1 0x925b4 in connman_service_create =
(/usr/sbin/connmand+0x925b4)
        #2 0x9294c  (/usr/sbin/connmand+0x9294c)
        #3 0x9e844  (/usr/sbin/connmand+0x9e844)
        #4 0x7dda6  (/usr/sbin/connmand+0x7dda6)
        #5 0x7ea18 in connman_network_set_group =
(/usr/sbin/connmand+0x7ea18)
        #6 0x3da36  (/usr/sbin/connmand+0x3da36)
        #7 0x3db56  (/usr/sbin/connmand+0x3db56)
        #8 0xd057c  (/usr/sbin/connmand+0xd057c)
        #9 0xd0882  (/usr/sbin/connmand+0xd0882)
        #10 0xd28da  (/usr/sbin/connmand+0xd28da)
        #11 0xd2ca4  (/usr/sbin/connmand+0xd2ca4)

   SUMMARY: AddressSanitizer: heap-use-after-free =
(/usr/sbin/connmand+0x9b44e) in connman_service_get_nameservers
---
 src/timeserver.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/timeserver.c b/src/timeserver.c
index e5efc716..c41c1798 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -35,6 +35,11 @@
=20
 #define TS_RECHECK_INTERVAL     7200
=20
+/**
+ *  A strong (that is, uses #connman_service_{ref,unref}) reference to
+ *  the network service currently used for time of day synchronization.
+ *
+ */
 static struct connman_service *ts_service;
 static GSList *timeservers_list =3D NULL;
 static GSList *ts_list =3D NULL;
@@ -429,7 +434,16 @@ static void ts_reset(struct connman_service =
*service)
=20
 	ts_recheck_enable();
=20
-	ts_service =3D service;
+	if (ts_service) {
+		connman_service_unref(ts_service);
+		ts_service =3D NULL;
+	}
+
+	if (service) {
+		connman_service_ref(service);
+		ts_service =3D service;
+	}
+
 	timeserver_sync_start();
 }
=20
@@ -529,7 +543,10 @@ static void timeserver_stop(void)
 {
 	DBG(" ");
=20
-	ts_service =3D NULL;
+	if (ts_service) {
+		connman_service_unref(ts_service);
+		ts_service =3D NULL;
+	}
=20
 	if (resolv) {
 		g_resolv_unref(resolv);
--=20
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E60184F
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6C3E673208
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:29 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 354E873246
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:20:29 -0400 (EDT)
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
Subject: [PATCH 3/6] Qualify request to time-of-day sync with connected check.
Date: Wed, 1 Nov 2023 20:20:29 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <6369E876-11A5-4B17-A3B4-BB3A341A223C@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This qualifies the call to '__connman_timeserver_sync' with an
'is_connected' check on the new state of the service in
'__connman_service_ipconfig_indicate_state'. In fact, this leverages
the same conditional that 'nameserver_add_all' is also subject to.
This avoids a heap-use-after-free segmentation fault that can occur
when a network service goes away following link loss or a disable of
the corresponding technology.

Without this qualification, the network service going away will invoke
'__connman_timeserver_sync' with the
'CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE' reason as it cycles from
online/ready to disconnect. As currently implemented, the timeserver
code interprets this as a request to initiate time-of-day =
synchroninzation
with time services using the name and time services of that disappearing
service. As a result, this has two downstream impacts:

  1. In a multi-service connectivity environment, the junior service =
that
     was promoted when the senior service was disconnected and was set =
as
     the active service for time services when 'default_changed' was
     invoked is undesireably displaced by the disconnecting service.

  2. The implication of (1) is that the time service now holds a weak
     reference to the disappearing service in 'ts_service' rather than
     the promoted and new default service. Consequentl, when 'sync_next'
     is next called by time services, it will attempt to get the name
     or time servers for the disconnecting service. Unfortunately,
     these which have gone away, as 'service_free' was invoked on the
     disconnected service after it was wound down. It is the access to
     these name or time servers on the deallocated service object that
     causes the heap-use-after-free segmentation fault.

The address sanitizer report is as follows:

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
 src/service.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 1c2277ba..c1c9a338 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6538,11 +6538,12 @@ int =
__connman_service_ipconfig_indicate_state(struct connman_service =
*service,
 	else
 		service->state_ipv6 =3D new_state;
=20
-	if (!is_connected(old_state) && is_connected(new_state))
+	if (!is_connected(old_state) && is_connected(new_state)) {
 		nameserver_add_all(service, type);
=20
-	__connman_timeserver_sync(service,
-				=
CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+		__connman_timeserver_sync(service,
+					=
CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+	}
=20
 	return service_indicate_state(service);
 }
--=20
2.42.0


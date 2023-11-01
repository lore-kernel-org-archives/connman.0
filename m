Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982133E7
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4D3B5731F8
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 17:30:46 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 142EA73204
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 17:30:45 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Update on Chasing Down a Crash in connman_service_get_nameservers
 on Cellular Service Removal
Date: Wed, 1 Nov 2023 14:30:45 -0700
References: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
 <A6BF0A08-CDFA-4CF4-A373-B130605030C0@nuovations.com>
 <BE0470B2-EB5F-4D6F-8062-0E92C3C48F28@nuovations.com>
 <FE5E3686-1DFC-4216-9A57-90A6114F279D@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <FE5E3686-1DFC-4216-9A57-90A6114F279D@nuovations.com>
Message-Id: <32329477-767D-4FAC-8222-A309F1CA1114@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Oct 31, 2023, at 5:44 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Oct 31, 2023, at 12:18 PM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>> On Oct 19, 2023, at 5:48 PM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>>> On Oct 18, 2023, at 8:00 PM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>>>> I know some of you (Denis, I believe from git log history) are =
working on clang static and dynamic analysis for connman.
>>>>=20
>>>> To the extent it helps, I have been chasing down an issue in =
top-of-tree (53964711baee916ae163e64d5229e3822935e100) in which when =
Quectel / Nimblelink QMI cellular goes away on my system, I get a =
connman signal 11 abort. Unfortunately, there is no backtrace in this =
case since n_ptrs (0) is less than offset (2) in the print_backtrace =
call.
>>>>=20
>>>> Today, doing some other development and debug work, I was able to =
narrow down the downstream cause of the abort. It seems that things are =
crashing somewhere within =
src/service.c:connman_service_get_nameservers().
>>>>=20
>>>> When name servers are established for the cellular service from the =
provider, there end up being two (2) name servers. The core problem =
seems to be that g_strv_length(service->nameservers) incorrectly returns =
7 (it really only has two (2)) which results in:
>>>>=20
>>>> 		for (i =3D 0; i < len; i++)
>>>> 			nameservers[i] =3D =
g_strdup(service->nameservers[i]);
>>>>=20
>>>> attempting to copy strings that do not exist past the end of the =
actual bounds of service->nameservers. So, it would seem that at some =
point, service->nameservers becomes corrupt with its terminating null =
getting overwritten by something else. I=E2=80=99ve get to zero in on =
the nature of =E2=80=9Cgetting overwritten by something else=E2=80=9D.
>>>>=20
>>>> I also periodically get this in the output after an abort:
>>>>=20
>>>> malloc(): smallbin double linked list corrupted
>>>>=20
>>>> I am also able to cause the abort, nearly on demand with near 100% =
reproducibility, by issuing =E2=80=98connmanctl disable cellular=E2=80=99.=


ConnMan Community:

I am able to confirm that the following patch addresses the =
heap-use-after-free issue when Cellular (or, in fact, any network =
service goes away):

diff --git a/src/service.c b/src/service.c
--- a/src/service.c
+++ b/src/service.c

@@ -6527,11 +6651,12 @@
 int __connman_service_ipconfig_indicate_state(struct connman_service =
*service,
    else
        service->state_ipv6 =3D new_state;
=20
-   if (!is_connected(old_state) && is_connected(new_state))
+   if (!is_connected(old_state) && is_connected(new_state)) {

        nameserver_add_all(service, type);
=20
-   __connman_timeserver_sync(service,
-               CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+        __connman_timeserver_sync(service,
+                   CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+    }
=20
    return service_indicate_state(service);
 }

There could also be an argument made that 'ts_service' should be a =
strong (rather than a weak) reference using =E2=80=98connman_service_ref' =
and =E2=80=98connman_service_unref=E2=80=99, as follows:

diff --git a/third_party/connman/repo/src/timeserver.c =
b/third_party/connman/repo/src/timeserver.c

index d23776faa96c..e91715b6452d 100644

--- a/third_party/connman/repo/src/timeserver.c
+++ b/third_party/connman/repo/src/timeserver.c
@@ -427,6 +427,7 @@
 static void ts_reset(struct connman_service *service)
=20
    ts_recheck_enable();

+   connman_service_ref(service);
    ts_service =3D service;
    timeserver_sync_start();
 }

@@ -506,7 +507,10 @@
 static void timeserver_stop(void)
 {
    DBG(" ");

-   ts_service =3D NULL;
+   if (ts_service) {
+       connman_service_unref(ts_service);
+       ts_service =3D NULL;
+   }

    if (resolv) {
        g_resolv_unref(resolv);

Thoughts?

I=E2=80=99ll follow up with a formal patch submission for the first =
patch shortly.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


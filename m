Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63241768
	for <connman@lists.linux.dev>; Tue, 14 Nov 2023 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8A1C57313B
	for <connman@lists.linux.dev>; Tue, 14 Nov 2023 10:45:04 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:1977:2609:55c5:1eeb] (unknown [IPv6:2601:647:5a00:15c1:1977:2609:55c5:1eeb])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4FF1B73142
	for <connman@lists.linux.dev>; Tue, 14 Nov 2023 10:45:04 -0500 (EST)
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
Subject: Re: When 'EnableOnlineCheck' Is Asserted Two Recurring IPv4 and One
 IPv6 Reachability Checks Get Scheduled
Date: Tue, 14 Nov 2023 07:45:03 -0800
References: <5B0B6864-28B9-4891-B30A-6024F9D8CED8@nuovations.com>
 <3497BF07-2F1A-4D75-A955-45BC604F022F@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <3497BF07-2F1A-4D75-A955-45BC604F022F@nuovations.com>
Message-Id: <A1E9F9EF-0B21-470D-AE8C-BBF1548ABB53@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 13, 2023, at 3:16 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Nov 13, 2023, at 10:38 AM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>> The latest issue I am jumping into in top-of-tree now that the two =
heap-use-after-free issues have been
>> addressed is "When 'EnableOnlineCheck' Is Asserted Two (2) Recurring =
IPv4 and One (1) IPv6
>> Reachability Checks Get Scheduled=E2=80=9D rather than one of each. =
Feel free to track progress here:
>>=20
>>   https://github.com/Nuovations/connman/issues/74
>=20
> As each of the above probes come back around to =
=E2=80=98complete_online_check' and then, eventually, =
=E2=80=98reschedule_online_check', from a design perspective, we are =
left with three opportunities to correct what is likely regarded as =
misbehavior here:
>=20
>    1. Prevent two parallel outstanding IPv4 probes from ever being =
rescheduled. However, this only handles the =
=E2=80=98EnableOnlineToReadyTransition' is asserted case.
>        * Given this impartial solve, this seems like like a =
non-starter.
>    2. Prevent the second outstanding IPv4 probe from being issued.
>        a. This would cover BOTH =E2=80=98EnableOnlineToReadyTransition' =
being asserted AND not being asserted.
>        b. Infrastructure-wise, this would require more state in the =
service module to track outstanding probes or different treatment the =
WISPr module in '__connman_wispr_start' wherein an existing, in flight =
context is displaced.
>             * =E2=80=98-EALREADY' could be returned in such a case.
>    3. Prevent the first outstanding IPv4 probe from completing once =
the second outstanding IPv4 probe is issued:
>        a. This would also cover both EnableOnlineToReadyTransition =
being asserted and not being asserted.
>        b. Again, in the WISPr module in =E2=80=98__connman_wispr_start',=
 when the existing =E2=80=98wp_context' context is displaced =
=E2=80=98g_web_unref' would need to be called to destroy the GWeb =
instance, closing the in flight connection which would ensure that the =
first probe never completes, either successfully or unsuccessfully =
(though you could argue the request should still be closed but perhaps =
expanded to include system status, such as -ECANCELED, such that the =
WISPr closure callback could elect to ignore the failure).
>=20
> One could imagine a currently-absent API to help with some of these =
use cases: '__connman_wispr_cancel(service, type)=E2=80=99.

I ended up prototyping approach (3) above, including implementing the =
as-yet-missing '__connman_wispr_cancel(service, type)=E2=80=99, and it =
appears to be working well with very tactical changes, per the raw and =
annotated log traces at:

    =
https://github.com/Nuovations/connman/issues/74#issuecomment-1810434718

Patches forthcoming.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


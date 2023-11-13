Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722420B28
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C96FB730FE
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 18:16:24 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:c8d5:962d:86fc:6954] (unknown [IPv6:2601:647:5a00:15c1:c8d5:962d:86fc:6954])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 819C973129
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 18:16:24 -0500 (EST)
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
Date: Mon, 13 Nov 2023 15:16:23 -0800
References: <5B0B6864-28B9-4891-B30A-6024F9D8CED8@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <5B0B6864-28B9-4891-B30A-6024F9D8CED8@nuovations.com>
Message-Id: <3497BF07-2F1A-4D75-A955-45BC604F022F@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 13, 2023, at 10:38 AM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> The latest issue I am jumping into in top-of-tree now that the two =
heap-use-after-free issues have been
> addressed is "When 'EnableOnlineCheck' Is Asserted Two (2) Recurring =
IPv4 and One (1) IPv6
> Reachability Checks Get Scheduled=E2=80=9D rather than one of each. =
Feel free to track progress here:
>=20
>    https://github.com/Nuovations/connman/issues/74

The annotated logs are at =
https://github.com/Nuovations/connman/files/13342709/connman-github-issue-=
74-log-annotated-output-20231113T1022.txt; however, to recap the =
analysis there, here:

The above annotation covers the analysis for the case when BOTH =
=E2=80=98EnableOnlineCheck' AND =E2=80=98EnableOnlineToReadyTransition' =
are asserted.

The only real practical difference in whether =
=E2=80=98EnableOnlineToReadyTransition' is asserted or not is whether =
you get an extra IPv4 probe as a one-shot up front =
(=E2=80=98EnableOnlineToReadyTransition=E2=80=99 IS NOT asserted) or =
whether you get an extra IPv4 probe on an indefinite, on-going basis =
(=E2=80=98EnableOnlineToReadyTransition' IS asserted).

The core issues that gets things off on the wrong foot are:

    1. There are two back-to-back IPv4 probes that get triggered by both =
of the following paths:
        a. Triggered from =E2=80=98default_changed' and =
=E2=80=98start_wispr_if_connected'.
        b. Triggered from 'service_ip_bound', 'address_updated', and =
=E2=80=98start_online_check'.
    2. With the following commits addressed:
        a. 812e171 "Close three '__connman_wisp_start' failure closure =
holes.=E2=80=9D
             * With this fix alone, at minimum, the first probe above =
(1) would have resulted, eventually in a failure closure to =
=E2=80=98complete_online_check'.
        b. 5f95851 "wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN =
proxy method." fixed, the first IPv4 probe from (1) no longer falls down =
a "hole" and gets lost
             * With this fix, in conjuction with 5f95851, the first IPv4 =
probe is no longer a complete throwaway. It actually succeeds.

With that setup, we now know why we get two (2) IPv4 reachability check =
probes in flight and one (1) IPv6 reachability check probe in flight as =
a service is coming up.

As noted above, =E2=80=98EnableOnlineToReadyTransition' determines =
whether this is a one-and-done condition or is an ongoing condition.

As each of the above probes come back around to =
=E2=80=98complete_online_check' and then, eventually, =
=E2=80=98reschedule_online_check', from a design perspective, we are =
left with three opportunities to correct what is likely regarded as =
misbehavior here:

    1. Prevent two parallel outstanding IPv4 probes from ever being =
rescheduled. However, this only handles the =
=E2=80=98EnableOnlineToReadyTransition' is asserted case.
        * Given this impartial solve, this seems like like a =
non-starter.
    2. Prevent the second outstanding IPv4 probe from being issued.
        a. This would cover BOTH =E2=80=98EnableOnlineToReadyTransition' =
being asserted AND not being asserted.
        b. Infrastructure-wise, this would require more state in the =
service module to track outstanding probes or different treatment the =
WISPr module in '__connman_wispr_start' wherein an existing, in flight =
context is displaced.
             * =E2=80=98-EALREADY' could be returned in such a case.
    3. Prevent the first outstanding IPv4 probe from completing once the =
second outstanding IPv4 probe is issued:
        a. This would also cover both EnableOnlineToReadyTransition =
being asserted and not being asserted.
        b. Again, in the WISPr module in =E2=80=98__connman_wispr_start', =
when the existing =E2=80=98wp_context' context is displaced =
=E2=80=98g_web_unref' would need to be called to destroy the GWeb =
instance, closing the in flight connection which would ensure that the =
first probe never completes, either successfully or unsuccessfully =
(though you could argue the request should still be closed but perhaps =
expanded to include system status, such as -ECANCELED, such that the =
WISPr closure callback could elect to ignore the failure).

One could imagine a currently-absent API to help with some of these use =
cases: '__connman_wispr_cancel(service, type)=E2=80=99.

Any thoughts or feedback welcomed on the scenarios and potential design =
directions to address the issue.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


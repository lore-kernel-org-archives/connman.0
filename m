Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C8111AA
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 05828CECCF;
	Sun, 19 Nov 2023 15:12:43 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 00/17] Address Redundant IPv4 Reachability Checks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231116010259.628527-1-gerickson@nuovations.com>
Date: Sun, 19 Nov 2023 15:12:32 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <542EA7A2-E02E-443E-9061-6C6FA5809D85@holtmann.org>
References: <20231116010259.628527-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This addresses an issue in which, when 'EnableOnlineCheck' is
> asserted, two (2) concurrent IPv4 and one (1) IPv6 reachability checks
> get queued.
>=20
> The issue is addressed by introducing and leveraging
> '__connman_wispr_cancel' in 'cancel_online_check' to ensure that a
> pending or in-flight WISPr portal detection request or an "online"
> HTTP-based Internet reachability check is canceled not only in the
> service module but in the WISPr module as well.
>=20
> This prevents two concurrent, outstanding, and redundant IPv4 WISPr
> requests from being in-flight when EnableOnlineCheck is asserted.
>=20
> Prior to these changes, this redundancy was set in motion by:
>=20
>    1. The two back-to-back IPv4 probes get triggered by both of the
>       following paths:
>=20
>       a. Triggered from 'default_changed' and
>          'start_wispr_if_connected'. This is the newer path,
>          chronologically, in the code base.
>=20
>       b. Triggered from 'service_ip_bound', 'address_updated', and
>          'start_online_check'. This is the older path, =
chronologically,
>          in the code base.
>=20
>    2. With the following commits addressed:
>=20
>       a. 812e171 ("Close three '__connman_wisp_start' failure closure
>          holes.")
>=20
>          * With this fix alone, at minimum, the first probe above (1)
>            would have resulted, eventually in a failure closure with
>            'complete_online_check'.
>=20
>       b. 5f95851 ("wispr: Avoid 'connman_proxy_lookup' call for
>          'UNKNOWN' proxy method.") fixed, the first IPv4 probe from
>          (1) no longer "falls down a 'hole'" and gets lost (closure-
>          and accounting-wise).
>=20
>          * With this fix, the first IPv4 probe is no longer a
>            complete throwaway--it actually succeeds. However, since
>            it does so, it becomes the first of the two redundant IPv4
>            checks.
>=20
> By employing '__connman_wispr_cancel', 'cancel_online_check' quells
> the first IPv4 check triggered from 'default_changed' and
> 'start_wispr_if_connected' and replaces it, fully (in both the service
> and WISpr modules), with the second IPv4 check triggered from
> 'service_ip_bound', 'address_updated', and 'start_online_check'.
>=20
> Grant Erickson (17):
>  wispr: Rename context proxy-related data members.
>  wispr: Add and leverage 'is_wispr_supported'.
>  wispr: Add documentation to 'is_wispr_supported'.
>  service: Document service unref calls in 'cancel_online_check'.
>  wispr: Add documentation to 'wispr_portal_detect'.
>  wispr: Add documentation to '__connman_wispr_stop'.
>  wispr: Add and leverage 'cancel_connman_wispr_portal_context'.
>  wispr: Add documentation to 'cancel_connman_wispr_portal_context'.
>  gweb: Add optional OS error status parameter to 'g_web_request_*'.
>  wispr: Add and leverage an OS error parameter to
>    '__connman_wispr_cb_t'.
>  service: Add IP configuration type to 'cancel_online_check'.
>  gweb: Add reference count debug statements.
>  gweb: Factor out GWeb destruction into 'g_web_free'.
>  wispr: Add '__connman_wispr_cancel' interface.
>  wispr: Add documentation to '__connman_wispr_cancel'.
>  wispr: Avoid double-free in 'free_wispr_routes'.
>  service: Leverage '__connman_wispr_cancel'.
>=20
> gweb/gweb.c      |  88 ++++++++----
> gweb/gweb.h      |   8 +-
> src/6to4.c       |   2 +-
> src/connman.h    |   5 +-
> src/service.c    |  70 ++++++++--
> src/wispr.c      | 341 ++++++++++++++++++++++++++++++++++++++++-------
> tools/web-test.c |   3 +-
> tools/wispr.c    |   8 +-
> 8 files changed, 433 insertions(+), 92 deletions(-)

I got this when trying to build the patch set.

  CC       gweb/gweb.o
gweb/gweb.c: In function =E2=80=98do_request=E2=80=99:
gweb/gweb.c:2357:57: error: comparison of unsigned expression in =E2=80=98=
< 0=E2=80=99 is always false [-Werror=3Dtype-limits]
 2357 |                         status =3D session->resolv_action < 0 ?
      |                                                         ^
gweb/gweb.c:2359:49: error: operand of =E2=80=98?:=E2=80=99 changes =
signedness from =E2=80=98int=E2=80=99 to =E2=80=98guint=E2=80=99 {aka =
=E2=80=98unsigned int=E2=80=99} due to unsignedness of other operand =
[-Werror=3Dsign-compare]
 2359 |                                                 -ENOENT;
      |                                                 ^
cc1: all warnings being treated as errors

REgards

Marcel


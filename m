Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2430D0B
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id C2406CECEB;
	Tue,  7 Nov 2023 16:18:41 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Close three '__connman_wisp_start' failure closure holes.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
Date: Tue, 7 Nov 2023 16:18:31 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FC02AFD-5B9B-4052-B056-2C487B8041ED@holtmann.org>
References: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> There are currently three failure holes in which a request to
> '__connman_wispr_start' is not properly closed.
>=20
>  1. If 'g_web_request_get' fails to generate a successful gweb request
>     and returns a request identifier of zero (0) in
>     'wispr_portal_request_portal'.
>=20
>  2. If the service proxy is set to =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN.
>     This can happen in 'proxy_callback' if WISPr is started and the
>     service proxy method is set latently or is never set at all.
>=20
>  3. If 'wispr_portal_detect' returns non-zero error status in
>     '__connman_wispr_start'.
>=20
> ---
> src/wispr.c | 19 +++++++++++++++++--
> 1 file changed, 17 insertions(+), 2 deletions(-)

this doesn=E2=80=99t apply cleanly.

  CC       src/connmand-wispr.o
src/wispr.c: In function =E2=80=98wispr_portal_request_portal=E2=80=99:
src/wispr.c:551:27: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
  551 |                 wp_context->cb(wp_context->service, =
wp_context->type, false);
      |                           ^~
src/wispr.c: In function =E2=80=98proxy_callback=E2=80=99:
src/wispr.c:885:27: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
  885 |                 wp_context->cb(wp_context->service, =
wp_context->type, false);
      |                           ^~
src/wispr.c: In function =E2=80=98__connman_wispr_start=E2=80=99:
src/wispr.c:1077:19: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
 1077 |         wp_context->cb(wp_context->service, wp_context->type, =
false);
      |                   ^~

Regards

Marcel


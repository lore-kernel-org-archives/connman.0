Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD31D6A8
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2C5B4CECE3;
	Thu,  9 Nov 2023 15:55:24 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN
 proxy method
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
Date: Thu, 9 Nov 2023 15:55:13 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0321788-D827-46F8-807E-591CBD08FC95@holtmann.org>
References: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> For certain network interfaces, such as Ethernet, that go through the
> state machine to 'ready' rapidly, it is possible that the HTTP-based
> "online" reachablility WISPr probe will be initiated before the
> corresponding network service has its proxy method set. In such
> instances, the proxy method is still set to
> 'CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN' from the initial service
> initialization. Consequently, when the WISPr request wends its way to
> 'wispr_portal_detect', it would previously invoke =
'connman_proxy_lookup'.
> Unfortunately, for such a method, there is no corresponding proxy =
driver
> and the lookup will, eventually, unconditionally fail resulting in a
> wasted WISPr check.
>=20
> This change adds =E2=80=98CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN'
> alongside 'CONNMAN_SERVICE_PROXY_METHOD_DIRECT' as the two
> proxy methods for which a call to 'connman_proxy_lookup' are avoided. =
This
> shunts the logic to the 'no_proxy_callback' callback, which assumes a =
direct
> proxy method and results in a successful and unwasted WISPr =
reachability
> check for such cases.
> ---
> src/wispr.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/wispr.c b/src/wispr.c
> index f0138386..e769e294 100644
> --- a/src/wispr.c
> +++ b/src/wispr.c
> @@ -1004,7 +1004,15 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
>=20
> DBG("proxy_method %d", proxy_method);
>=20
> - if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT) {
> + /*
> + * Include both CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN and
> + * CONNMAN_SERVICE_PROXY_METHOD_DIRECT in avoiding a call to
> + * connman_proxy_lookup, since the former will always result in
> + * a WISPr request "falling down a hole" that will only ever
> + * result in a failure completion.
> + */
> + if ((proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT) &&
> + (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN)) {

you don=E2=80=99t need these extra () when using && or ||. And in =
general we don=E2=80=99t use them.

Regards

Marcel


Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3822329
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 5ED1FCECE8;
	Thu,  9 Nov 2023 18:27:24 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] wispr: Avoid 'connman_proxy_lookup' call for UNKNOWN
 proxy method.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <90BC29FA-5BA6-4BD2-8609-98FF22FEAC1A@nuovations.com>
Date: Thu, 9 Nov 2023 18:27:13 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFD99FD2-D083-4333-BF0A-0AF08FF6BB6F@holtmann.org>
References: <CC149471-0111-4BA8-B2D3-A69955FAF607@nuovations.com>
 <90BC29FA-5BA6-4BD2-8609-98FF22FEAC1A@nuovations.com>
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

patch has been applied, but I fixed the indentation of the second line.

Regards

Marcel


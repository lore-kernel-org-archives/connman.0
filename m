Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3C3158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id CD6AECECEE;
	Tue,  7 Nov 2023 20:00:52 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] service: Colocate online check-related functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <B67B48D7-111D-494D-B3F6-86A1652297CD@nuovations.com>
Date: Tue, 7 Nov 2023 20:00:42 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <33831FF4-19BE-4083-84D8-E2261A07125B@holtmann.org>
References: <B67B48D7-111D-494D-B3F6-86A1652297CD@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This spatially colocates the following online check-related service =
functions:
>=20
>   * complete_online_check
>   * redo_wispr_ipv4
>   * redo_wispr_ipv6
>   * redo_wispr
>   * start_wispr_if_connected
>   * __connman_service_wispr_start
>=20
> with these online-check related service functions:
>=20
>   * cancel_online_check
>   * start_online_check
> ---
> src/service.c | 571 +++++++++++++++++++++++++-------------------------
> 1 file changed, 286 insertions(+), 285 deletions(-)

patch has been applied.

Regards

Marcel


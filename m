Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7931C68C
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4700ACECC4;
	Mon, 20 Nov 2023 15:57:07 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231119195148.73668-1-marcus.folkesson@gmail.com>
Date: Mon, 20 Nov 2023 15:56:56 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <466516FC-B75B-478B-BB66-D233B3B5B19C@holtmann.org>
References: <20231119195148.73668-1-marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Marcus,

> Add 'freq' to the parameter list used for WiFi Tethering.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> doc/connmanctl.1.in | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

We don=E2=80=99t use Sob in ConnMan and so I stripped that off and then =
applied your patch.

Regards

Marcel


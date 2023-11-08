Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4958815
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 610A7CECD0;
	Wed,  8 Nov 2023 15:44:51 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Allow running bootstrap-configure from anywhere.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E57C2057-AEAD-49B1-8577-6FD27680A4B2@nuovations.com>
Date: Wed, 8 Nov 2023 15:44:40 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <58F4FE4A-55EB-4072-8E20-E39E307D7918@holtmann.org>
References: <E57C2057-AEAD-49B1-8577-6FD27680A4B2@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> Frequently it is valuable to do non-colocated source and build
> directories. This updates 'bootstrap-configure' such that it may be
> run in any arbitrary directory such that builds so bootstrapped and
> configured may be non-colocated.
> ---
> bootstrap-configure | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/bootstrap-configure b/bootstrap-configure
> index ed5ecd78..d8c9cfce 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -1,11 +1,13 @@
> #!/bin/sh
>=20
> +ourdir=3D$(cd $(dirname "${0}") && pwd)
> +
> if [ -f config.status ]; then
> make maintainer-clean
> fi
>=20
> -./bootstrap && \
> -    ./configure --enable-maintainer-mode \
> +(cd "${ourdir}" && ./bootstrap) && \
> +    "${ourdir}/configure" --enable-maintainer-mode \
> --enable-debug \
> --prefix=3D/usr \
> --mandir=3D/usr/share/man \

can you help me out on how to use it. For me this was always just for =
the devs.

	./bootstrap-configure
	make

And you got started with the git tree. Since bootstrap-configure also =
never made it into any tarballs and that is on purpose.

Before I make any change here, I need to fully grok it since this is one =
of the pieces that I keep consistent across multiple projects.

Regards

Marcel


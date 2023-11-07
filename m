Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD5AD52
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 691F7CECEB;
	Tue,  7 Nov 2023 16:28:21 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] Address -Werror=sign-compare compilation errors.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6ECC162C-D6EF-4043-B58C-C5225E9910F4@nuovations.com>
Date: Tue, 7 Nov 2023 16:28:10 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <41D09C15-1D19-41B5-90B5-DAC7780D8440@holtmann.org>
References: <6ECC162C-D6EF-4043-B58C-C5225E9910F4@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This addresses -Werror=3Dsign-compare compilation errors surfaced by =
both
> GCC and clang/LLVM when --enable-maintainer-mode is asserted.
> ---
> src/dnsproxy.c | 14 +++++++-------
> src/iptables.c |  4 ++--
> 2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index 4ae485f1..03021ba0 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -436,7 +436,7 @@ static void update_cached_ttl(unsigned char *ptr, =
int len, int new_ttl)
> ptr +=3D DNS_HEADER_SIZE;
> len -=3D DNS_HEADER_SIZE;
>=20
> - if (len < DNS_QUESTION_SIZE + 1)
> + if (len < (int)DNS_QUESTION_SIZE + 1)
> return;

I was struggling with these as well and didn=E2=80=99t want to result to =
just casting everything. Fundamentally once you cast you loose any =
benefits of the compiler checking things. Sometimes it is enough to =
re-arrange the statements or pick different variables.

Regards

Marcel


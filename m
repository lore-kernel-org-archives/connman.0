Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BA1E526
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 37EEECECD1;
	Wed, 29 Nov 2023 14:16:04 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/8] log: Refactor debugging preprocessor macros.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231128230847.1224497-2-gerickson@nuovations.com>
Date: Wed, 29 Nov 2023 14:15:53 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3A8D3AA-9EFA-4D23-B4D6-01A96B45E9C0@holtmann.org>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231128230847.1224497-2-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This refactors the debugging / debug log preprocessor-related
> macros. In particular, it:
>=20
>    * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>      instantiates an instance of 'connmand_debug_desc'.
>=20
>    * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>      declares and instantiates an alias (that is, asserts the
>      CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>      'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>=20
>    * Introduces CONNMAN_DEBUG which declares and instantiates
>      an instance of 'connmand_debug_desc', again using
>      CONNMAN_DEBUG_DESC_INSTANTIATE, for controlling an invocation of
>      'connman_debug' with it that includes both the file and function
>      name the macro was invoked in or attributed to.
>=20
>      - The key difference between this and 'DBG' is that this allows
>        the caller to specify the function string rather than relying =
on
>        '__FUNCTION__' (or __func__).
>=20
>    * Redefines 'DBG' against 'CONNMAN_DEBUG' with '__func__' as the
>      function parameter.
> ---
> include/log.h | 34 +++++++++++++++++++++-------------
> src/log.c     |  2 +-
> 2 files changed, 22 insertions(+), 14 deletions(-)

I don=E2=80=99t like this since it ends up bloating the DBG part of it =
and you spent more time making debug look pretty than making the code =
look good.

The kernel has a nice concept with pr_fmt where you can overwrite =
pr_debug on a per file basis. I rather prefer that we adopt such a =
scheme. It will make things a lot simpler and have less boilerplate.

Long term this needs to get all into ELL and we need to use ELL debug =
functionality instead of having separate ones in each project.

Regards

Marcel


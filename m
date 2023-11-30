Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0A134C3
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id EE1C7CECCF;
	Thu, 30 Nov 2023 09:40:07 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 1/8] log: Refactor debugging preprocessor macros.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231129192106.1295868-2-gerickson@nuovations.com>
Date: Thu, 30 Nov 2023 09:39:57 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F8910ED-30EC-41A1-81AA-47D74E4E152A@holtmann.org>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
 <20231129192106.1295868-2-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This refactors the debugging / debug log preprocessor-related
> macros. In particular, it:
>=20
>    * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>      instantiates an instance of 'connman_debug_desc'.
>=20
>    * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>      declares and instantiates an alias (that is, asserts the
>      CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>      'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>=20
>    * Redefines 'DBG' against 'CONNMAN_DEBUG_DESC_INSTANTIATE' with
>      '__func__' as the function parameter.
> ---
> include/log.h | 28 +++++++++++++++++-----------
> src/log.c     |  2 +-
> 2 files changed, 18 insertions(+), 12 deletions(-)

I am bit confused. I thought we leave this out for now and get the fixes =
merged and look into improving DBG.

Regards

Marcel


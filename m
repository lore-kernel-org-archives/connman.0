Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585914AB9
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D740F731A4;
	Wed, 29 Nov 2023 14:22:55 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a] (unknown [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8EB9973225;
	Wed, 29 Nov 2023 14:22:55 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/8] log: Refactor debugging preprocessor macros.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <27BE5445-5F4C-43FD-8913-9EDD7C29FDF9@holtmann.org>
Date: Wed, 29 Nov 2023 11:22:54 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <170632B2-CC29-4ED4-928F-BA2AFB776DCC@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231128230847.1224497-2-gerickson@nuovations.com>
 <D3A8D3AA-9EFA-4D23-B4D6-01A96B45E9C0@holtmann.org>
 <06E9A152-301F-4791-BB06-8CCCE22889CB@nuovations.com>
 <27BE5445-5F4C-43FD-8913-9EDD7C29FDF9@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 29, 2023, at 10:18 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>>> This refactors the debugging / debug log preprocessor-related
>>>> macros. In particular, it:
>>>>=20
>>>> * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>>>>   instantiates an instance of 'connmand_debug_desc'.
>>>>=20
>>>> * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>>>>   declares and instantiates an alias (that is, asserts the
>>>>   CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>>>>   'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>>>>=20
>>>> * Introduces CONNMAN_DEBUG which declares and instantiates
>>>>   an instance of 'connmand_debug_desc', again using
>>>>   CONNMAN_DEBUG_DESC_INSTANTIATE, for controlling an invocation of
>>>>   'connman_debug' with it that includes both the file and function
>>>>   name the macro was invoked in or attributed to.
>>>>=20
>>>>   - The key difference between this and 'DBG' is that this allows
>>>>     the caller to specify the function string rather than relying =
on
>>>>     '__FUNCTION__' (or __func__).
>>>>=20
>>>> * Redefines 'DBG' against 'CONNMAN_DEBUG' with '__func__' as the
>>>>   function parameter.
>>>> ---
>>>> include/log.h | 34 +++++++++++++++++++++-------------
>>>> src/log.c     |  2 +-
>>>> 2 files changed, 22 insertions(+), 14 deletions(-)
>>>=20
>>> I don=E2=80=99t like this since it ends up bloating the DBG part of =
it...
>>=20
>> CONNMAN_DEBUG aside, are you otherwise OK with the clean ups and =
documentation to log.h embodied in this patch?
>=20
> I am fine with all the cleanups, but I prefer you don=E2=80=99t =
introduce CONNMAN_DEBUG and stick with DBG instead and we try to figure =
out on how to make DBG work the way you want to use it.

Resubmitted as a v2 patch with the suggested revisions.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


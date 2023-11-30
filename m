Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450B524A3
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1BF06731A4;
	Thu, 30 Nov 2023 10:43:05 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:9122:acf7:a1da:25ee] (unknown [IPv6:2601:647:5a00:15c1:9122:acf7:a1da:25ee])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C230E731FE;
	Thu, 30 Nov 2023 10:43:04 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 1/8] log: Refactor debugging preprocessor macros.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <5F8910ED-30EC-41A1-81AA-47D74E4E152A@holtmann.org>
Date: Thu, 30 Nov 2023 07:43:03 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8A65857-A8FE-4FE3-B290-4D9A8F2AD26B@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
 <20231129192106.1295868-2-gerickson@nuovations.com>
 <5F8910ED-30EC-41A1-81AA-47D74E4E152A@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 30, 2023, at 12:39 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> This refactors the debugging / debug log preprocessor-related
>> macros. In particular, it:
>>=20
>>   * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>>     instantiates an instance of 'connman_debug_desc'.
>>=20
>>   * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>>     declares and instantiates an alias (that is, asserts the
>>     CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>>     'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>>=20
>>   * Redefines 'DBG' against 'CONNMAN_DEBUG_DESC_INSTANTIATE' with
>>     '__func__' as the function parameter.
>> ---
>> include/log.h | 28 +++++++++++++++++-----------
>> src/log.c     |  2 +-
>> 2 files changed, 18 insertions(+), 12 deletions(-)
>=20
> I am bit confused. I thought we leave this out for now and get the =
fixes merged and look into improving DBG.

As we last discussed on the thread:

>> CONNMAN_DEBUG aside, are you otherwise OK with the clean ups and =
documentation to log.h embodied in this patch?
>=20
> I am fine with all the cleanups, but I prefer you don=E2=80=99t =
introduce CONNMAN_DEBUG and stick with DBG instead and we try to figure =
out on how to make DBG work the way you want to use it.


As discussed and agreed, I dropped the CONNMAN_DEBUG macro from that =
part of the patch set and simply documented the existing macros and =
eliminated the copy-and-paste by preserving the =
CONNMAN_DEBUG_DESC_INSTANTIATE macro. So, as preferred, everything that =
follows remains exclusively with DBG and DBG only.

I remain happy to loop back and improve DBG at a later time. =
Specifically, for the =E2=80=9Ccalled by function=E2=80=9D use case of =
DBG that we discussed, there are a healthy number of existing use cases =
in the code base that would benefit, the most notable of which are the =
=E2=80=98*_{ref,unref}_debug=E2=80=99 functions used for reference =
counting tracking and debugging (the whole reference counting pattern =
seems replicated, ideally it could all be embodied in infrastructure =
written once and instantiated where necessary).

Does that help clarify?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


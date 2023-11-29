Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B730326
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 066CD73207;
	Wed, 29 Nov 2023 12:58:16 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a] (unknown [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 98EA673224;
	Wed, 29 Nov 2023 12:58:15 -0500 (EST)
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
In-Reply-To: <D3A8D3AA-9EFA-4D23-B4D6-01A96B45E9C0@holtmann.org>
Date: Wed, 29 Nov 2023 09:58:14 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <06E9A152-301F-4791-BB06-8CCCE22889CB@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231128230847.1224497-2-gerickson@nuovations.com>
 <D3A8D3AA-9EFA-4D23-B4D6-01A96B45E9C0@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 29, 2023, at 5:15 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> This refactors the debugging / debug log preprocessor-related
>> macros. In particular, it:
>>=20
>>   * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>>     instantiates an instance of 'connmand_debug_desc'.
>>=20
>>   * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>>     declares and instantiates an alias (that is, asserts the
>>     CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>>     'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>>=20
>>   * Introduces CONNMAN_DEBUG which declares and instantiates
>>     an instance of 'connmand_debug_desc', again using
>>     CONNMAN_DEBUG_DESC_INSTANTIATE, for controlling an invocation of
>>     'connman_debug' with it that includes both the file and function
>>     name the macro was invoked in or attributed to.
>>=20
>>     - The key difference between this and 'DBG' is that this allows
>>       the caller to specify the function string rather than relying =
on
>>       '__FUNCTION__' (or __func__).
>>=20
>>   * Redefines 'DBG' against 'CONNMAN_DEBUG' with '__func__' as the
>>     function parameter.
>> ---
>> include/log.h | 34 +++++++++++++++++++++-------------
>> src/log.c     |  2 +-
>> 2 files changed, 22 insertions(+), 14 deletions(-)
>=20
> I don=E2=80=99t like this since it ends up bloating the DBG part of =
it...

Can you clarify? Beyond eliminating the bit of copy-and-paste that was =
previously in log.h prior to this patch, the emitted and compiled code =
is identical.

> and you spent more time making debug look pretty than making the code =
look good.

These are both laudable goals and ends and I don=E2=80=99t see a barrier =
to trading off one for the other.

Making the code look good and function well and correctly is absolutely =
the top priority.

However, at the end of the day, software is software and humans are =
humans and getting to perfect can be asymptotically expensive and, =
perhaps, is never attainable. Moreover, when extending the envelope of =
functionality on a base of software, particular in the face of limited =
internals documentation and little to no spatial or temporal access to =
the original authors of the code to clarify intent, having code that is =
easily debugged (and well documented) is at least as important.

That said, I think the DBG and -d facilities in connman are both useful =
and quite ingenious. They are very effective and work and scale far =
better than sections/modules, etc and other schemes I=E2=80=99ve =
encountered and used in the past.

But, having spent the last week (and, before that, debugging =
WISPr/online check) trying to build an understanding of how and where =
connection.c fits into the overall system, the content and efficacy of =
the debug output is important.

The end goal for this particular patch was, =E2=80=9CHow do I achieve a =
single place for debug-logging the contents of a gateway_config and/or =
gateway_debug structure (which happens at many places in connection.c), =
attribute the output to the appropriate call site and function, without =
copying-and-pasting the DBG to do so in every call site?=E2=80=9D

Absent the approach I took, the other alternative is to include a =
=E2=80=9Cfrom %s=E2=80=9D in the format such that the log output ends up =
being:

connmand[16689]: src/connection.c:gateway_data_debug() from =
__connman_connection_gateway_add() new_gateway 0x7471c060: { index: 4 =
(eth0), service: 0x72503240 (ethernet_0004f31a5ee0_cable), ipv4_config: =
0x7471c030, ipv6_config: (nil), default_checked: 0 }
connmand[16689]: src/connection.c:gateway_config_debug() from =
__connman_connection_gateway_add() ipv4_config 0x7471c030: { flags: 0x0 =
(), gateway: 0x7511d7f0 (192.168.2.1), vpn_ip: (nil) (<null>), =
vpn_phy_index: -1 (<null>), vpn_phy_ip: (nil) (<null>) }

which adds an extraneous bit of information which, since it doesn=E2=80=99=
t aid in debug or understanding, ends up being mental and visual =
=E2=80=9Cnoise=E2=80=9D and doesn=E2=80=99t further the debug goals. =
However, if that=E2=80=99s preferable to the approach I took, I=E2=80=99m =
happy to go that direction and recast the patches toward that end. Let =
me know if that=E2=80=99s an acceptable alternative.

> The kernel has a nice concept with pr_fmt where you can overwrite =
pr_debug on a per file basis. I rather prefer that we adopt such a =
scheme. It will make things a lot simpler and have less boilerplate.

I=E2=80=99d be happy to learn more and take a look. Do you have a link =
from the kernel git that demonstrates this?

> Long term this needs to get all into ELL and we need to use ELL debug =
functionality instead of having separate ones in each project.

That seems like a great outcome and seems like it would work well with =
or without these patches: connman_debug_desc becomes ell_debug_desc, and =
generally anything connman_ or CONNMAN_ namespaced in log.h becomes ell_ =
or ELL_ namespaced and sourced from ell/log.h (or some such) rather than =
connman/log.h.

CONNMAN_DEBUG aside, are you otherwise OK with the clean ups and =
documentation to log.h embodied in this patch?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


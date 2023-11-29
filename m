Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3613ADC
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 21013CECC5;
	Wed, 29 Nov 2023 19:18:58 +0100 (CET)
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
In-Reply-To: <06E9A152-301F-4791-BB06-8CCCE22889CB@nuovations.com>
Date: Wed, 29 Nov 2023 19:18:47 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <27BE5445-5F4C-43FD-8913-9EDD7C29FDF9@holtmann.org>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231128230847.1224497-2-gerickson@nuovations.com>
 <D3A8D3AA-9EFA-4D23-B4D6-01A96B45E9C0@holtmann.org>
 <06E9A152-301F-4791-BB06-8CCCE22889CB@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

>>> This refactors the debugging / debug log preprocessor-related
>>> macros. In particular, it:
>>>=20
>>>  * Introduces CONNMAN_DEBUG_DESC_INSTANTIATE which declares and
>>>    instantiates an instance of 'connmand_debug_desc'.
>>>=20
>>>  * Replaces CONNMAN_DEBUG_DEFINE with CONNMAN_DEBUG_ALIAS which
>>>    declares and instantiates an alias (that is, asserts the
>>>    CONNMAN_DEBUG_FLAG_ALIAS flag) instance of
>>>    'connmand_debug_desc', using CONNMAN_DEBUG_DESC_INSTANTIATE.
>>>=20
>>>  * Introduces CONNMAN_DEBUG which declares and instantiates
>>>    an instance of 'connmand_debug_desc', again using
>>>    CONNMAN_DEBUG_DESC_INSTANTIATE, for controlling an invocation of
>>>    'connman_debug' with it that includes both the file and function
>>>    name the macro was invoked in or attributed to.
>>>=20
>>>    - The key difference between this and 'DBG' is that this allows
>>>      the caller to specify the function string rather than relying =
on
>>>      '__FUNCTION__' (or __func__).
>>>=20
>>>  * Redefines 'DBG' against 'CONNMAN_DEBUG' with '__func__' as the
>>>    function parameter.
>>> ---
>>> include/log.h | 34 +++++++++++++++++++++-------------
>>> src/log.c     |  2 +-
>>> 2 files changed, 22 insertions(+), 14 deletions(-)
>>=20
>> I don=E2=80=99t like this since it ends up bloating the DBG part of =
it...
>=20
> Can you clarify? Beyond eliminating the bit of copy-and-paste that was =
previously in log.h prior to this patch, the emitted and compiled code =
is identical.

my presence is that you use DBG() and only that in your code to have =
debug prints. It is easy to spot and easy to grep for and you can =
compile it into a nop if you want to.

If you need anything else, it should be a one time thing at the top of =
your *.c file. My main model is what the kernel called dynamic_debug.

>> and you spent more time making debug look pretty than making the code =
look good.
>=20
> These are both laudable goals and ends and I don=E2=80=99t see a =
barrier to trading off one for the other.
>=20
> Making the code look good and function well and correctly is =
absolutely the top priority.
>=20
> However, at the end of the day, software is software and humans are =
humans and getting to perfect can be asymptotically expensive and, =
perhaps, is never attainable. Moreover, when extending the envelope of =
functionality on a base of software, particular in the face of limited =
internals documentation and little to no spatial or temporal access to =
the original authors of the code to clarify intent, having code that is =
easily debugged (and well documented) is at least as important.
>=20
> That said, I think the DBG and -d facilities in connman are both =
useful and quite ingenious. They are very effective and work and scale =
far better than sections/modules, etc and other schemes I=E2=80=99ve =
encountered and used in the past.
>=20
> But, having spent the last week (and, before that, debugging =
WISPr/online check) trying to build an understanding of how and where =
connection.c fits into the overall system, the content and efficacy of =
the debug output is important.
>=20
> The end goal for this particular patch was, =E2=80=9CHow do I achieve =
a single place for debug-logging the contents of a gateway_config and/or =
gateway_debug structure (which happens at many places in connection.c), =
attribute the output to the appropriate call site and function, without =
copying-and-pasting the DBG to do so in every call site?=E2=80=9D
>=20
> Absent the approach I took, the other alternative is to include a =
=E2=80=9Cfrom %s=E2=80=9D in the format such that the log output ends up =
being:
>=20
> connmand[16689]: src/connection.c:gateway_data_debug() from =
__connman_connection_gateway_add() new_gateway 0x7471c060: { index: 4 =
(eth0), service: 0x72503240 (ethernet_0004f31a5ee0_cable), ipv4_config: =
0x7471c030, ipv6_config: (nil), default_checked: 0 }
> connmand[16689]: src/connection.c:gateway_config_debug() from =
__connman_connection_gateway_add() ipv4_config 0x7471c030: { flags: 0x0 =
(), gateway: 0x7511d7f0 (192.168.2.1), vpn_ip: (nil) (<null>), =
vpn_phy_index: -1 (<null>), vpn_phy_ip: (nil) (<null>) }
>=20
> which adds an extraneous bit of information which, since it doesn=E2=80=99=
t aid in debug or understanding, ends up being mental and visual =
=E2=80=9Cnoise=E2=80=9D and doesn=E2=80=99t further the debug goals. =
However, if that=E2=80=99s preferable to the approach I took, I=E2=80=99m =
happy to go that direction and recast the patches toward that end. Let =
me know if that=E2=80=99s an acceptable alternative.

We currently only have the PRINT flag (and so does ELL btw), but the =
kernel has a lot more flags that define on how the output looks like and =
what information are printed. I would thing that is the way to go. Have =
a generic DBG statement and then decide from command line or some =
external input what gets printed in the debug logs.

That said, I never thought about printing the call of the current =
function. That is a nice idea and in indeed really useful at times. So =
yes, we should have an option for that.

>> The kernel has a nice concept with pr_fmt where you can overwrite =
pr_debug on a per file basis. I rather prefer that we adopt such a =
scheme. It will make things a lot simpler and have less boilerplate.
>=20
> I=E2=80=99d be happy to learn more and take a look. Do you have a link =
from the kernel git that demonstrates this?

https://www.kernel.org/doc/html/next/core-api/printk-basics.html

This would be a starting point. Essentially you define pr_fmt(fmt) and =
that modifies you pr_* type of functions. If you grep for pr_fmt than =
you see how different subsystems, drivers etc. define it and have =
specific information for their needs.

For example for Bluetooth we did a real simple one:

#define pr_fmt(fmt) "Bluetooth: =E2=80=9C fmt

And that ends up providing the string Bluetooth: as prefix for every =
message printed. Was properly a bad idea, but this way we didn=E2=80=99t =
have to change any log messages we had.

Some add KBUILD_NAME or the DRVNAME or other details in there.

If you look at include/linux/dynamic_debug.h you see all the flags the =
kernel currently supports.

#define _DPRINTK_FLAGS_NONE 0
#define _DPRINTK_FLAGS_PRINT (1<<0) /* printk() a message using the =
format */
#define _DPRINTK_FLAGS_INCL_MODNAME (1<<1)
#define _DPRINTK_FLAGS_INCL_FUNCNAME (1<<2)
#define _DPRINTK_FLAGS_INCL_LINENO (1<<3)
#define _DPRINTK_FLAGS_INCL_TID (1<<4)
#define _DPRINTK_FLAGS_INCL_SOURCENAME (1<<5)

So I prefer to do something similar and then just modify these via a =
command line switch. Right now we basically just do a BLOB pattern, but =
we could do more.

>> Long term this needs to get all into ELL and we need to use ELL debug =
functionality instead of having separate ones in each project.
>=20
> That seems like a great outcome and seems like it would work well with =
or without these patches: connman_debug_desc becomes ell_debug_desc, and =
generally anything connman_ or CONNMAN_ namespaced in log.h becomes ell_ =
or ELL_ namespaced and sourced from ell/log.h (or some such) rather than =
connman/log.h.
>=20
> CONNMAN_DEBUG aside, are you otherwise OK with the clean ups and =
documentation to log.h embodied in this patch?

I am fine with all the cleanups, but I prefer you don=E2=80=99t =
introduce CONNMAN_DEBUG and stick with DBG instead and we try to figure =
out on how to make DBG work the way you want to use it.

Regards

Marcel


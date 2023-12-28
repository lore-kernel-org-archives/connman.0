Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54CF4EC
	for <connman@lists.linux.dev>; Thu, 28 Dec 2023 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 746B7731D2;
	Thu, 28 Dec 2023 11:39:10 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:609a:fa2d:109a:7a40] (unknown [IPv6:2601:647:5a00:15c1:609a:fa2d:109a:7a40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3485573202;
	Thu, 28 Dec 2023 11:39:10 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <52A513BB-2667-45D6-B644-4C4F614AD98A@holtmann.org>
Date: Thu, 28 Dec 2023 08:39:09 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <54BF61F3-98B4-46C3-A726-CC8D8BDFADC5@nuovations.com>
References: <20231223185801.2389526-1-gerickson@nuovations.com>
 <962F7450-B2D2-476D-B0D6-90751F7A8649@holtmann.org>
 <03CF0B0A-0AAF-4DE1-896B-32251D778A36@nuovations.com>
 <52A513BB-2667-45D6-B644-4C4F614AD98A@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 28, 2023, at 1:54 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>>> This converts a potential run time error due to a mis-spelling of =
the
>>>> "General" configuration group name repeatedly used a string literal
>>>> into a potential compile time error due to a mis-spelling of the
>>>> static global that now references it once and only once.
>>>> ---
>>>> src/main.c | 85 =
+++++++++++++++++++++++++++++++-----------------------
>>>> 1 file changed, 49 insertions(+), 36 deletions(-)
>>>=20
>>> wouldn=E2=80=99t be
>>>=20
>>> #define GENERAL_GROUP =E2=80=9CGeneral=E2=80=9D
>>>=20
>>> or
>>>=20
>>> #define GROUP_GENERAL =E2=80=9CGeneral=E2=80=9D
>>>=20
>>> be actually more consistent with the other constants we use here.
>>=20
>> There are definitely an appreciable number of existing preprocessor =
definitions in this file. So, with that in mind, a preprocessor =
definition would be stylistically more consistent.
>>=20
>>> I do like the all upper-case to indicate a constant here (and =
scrapping
>>> the =E2=80=9Cname=E2=80=9D portion).
>>>=20
>>> Otherwise, yes, it is stupid from us to keep using =E2=80=9CGeneral=E2=
=80=9D in all
>>> places :(
>>=20
>> At -O2 optimization, all three approaches are neutral from a =
code-generation perspective. So, the question comes down to one of =
style:
>>=20
>> [ =E2=80=A6 ]
>>=20
>> I=E2=80=99d be happy to re-submit a v2 patch with the preprocessor =
definition.
>=20
> then lets use the preprocessor macro. We defiantly have used that more
> than the global string.

Marcel,

Submitted as v2.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


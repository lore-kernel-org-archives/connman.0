Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2B63B1
	for <connman@lists.linux.dev>; Thu, 28 Dec 2023 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 069EFCECC3;
	Thu, 28 Dec 2023 10:54:45 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <03CF0B0A-0AAF-4DE1-896B-32251D778A36@nuovations.com>
Date: Thu, 28 Dec 2023 10:54:34 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <52A513BB-2667-45D6-B644-4C4F614AD98A@holtmann.org>
References: <20231223185801.2389526-1-gerickson@nuovations.com>
 <962F7450-B2D2-476D-B0D6-90751F7A8649@holtmann.org>
 <03CF0B0A-0AAF-4DE1-896B-32251D778A36@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

>>> This converts a potential run time error due to a mis-spelling of =
the
>>> "General" configuration group name repeatedly used a string literal
>>> into a potential compile time error due to a mis-spelling of the
>>> static global that now references it once and only once.
>>> ---
>>> src/main.c | 85 =
+++++++++++++++++++++++++++++++-----------------------
>>> 1 file changed, 49 insertions(+), 36 deletions(-)
>>=20
>> wouldn=E2=80=99t be
>>=20
>> #define GENERAL_GROUP =E2=80=9CGeneral=E2=80=9D
>>=20
>> or
>>=20
>> #define GROUP_GENERAL =E2=80=9CGeneral=E2=80=9D
>>=20
>> be actually more consistent with the other constants we use here.
>=20
> There are definitely an appreciable number of existing preprocessor =
definitions in this file. So, with that in mind, a preprocessor =
definition would be stylistically more consistent.
>=20
>> I do like the all upper-case to indicate a constant here (and =
scrapping
>> the =E2=80=9Cname=E2=80=9D portion).
>>=20
>> Otherwise, yes, it is stupid from us to keep using =E2=80=9CGeneral=E2=80=
=9D in all
>> places :(
>=20
> At -O2 optimization, all three approaches are neutral from a =
code-generation perspective. So, the question comes down to one of =
style:
>=20
>   text   data    bss    dec    hex filename
>   9817    756    264  10837   2a55 connmand-main.o // "General" string =
literals
>   9817    756    264  10837   2a55 connmand-main.o // "General" static =
const char * const global
>   9817    756    264  10837   2a55 connmand-main.o // "General" =
preprocessor macro
>=20
> I=E2=80=99d be happy to re-submit a v2 patch with the preprocessor =
definition.

then lets use the preprocessor macro. We defiantly have used that more
than the global string.

Regards

Marcel


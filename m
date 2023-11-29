Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046830326
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 8D731CECC5;
	Wed, 29 Nov 2023 18:58:43 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/3] connection: Introduce and leverage
 'ipv[46]_addr_any_str' constants.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52BB6CD9-AB58-450F-9D2F-884FCF69EB37@nuovations.com>
Date: Wed, 29 Nov 2023 18:58:33 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3B4E3CE-B50D-47CC-BB24-0059D8B5A3F3@holtmann.org>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129015253.1254116-2-gerickson@nuovations.com>
 <5225FCB7-A3BB-4E45-B057-FFCA0BA278A6@holtmann.org>
 <52BB6CD9-AB58-450F-9D2F-884FCF69EB37@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

>>> The IPv4 and IPv6 any / unspecified address string literals, =
"0.0.0.0"
>>> and "::" respectively, appear often enough throughout the code where
>>> they warrant referencing through file-scoped constants.
>>> ---
>>> src/connection.c | 28 ++++++++++++++++------------
>>> 1 file changed, 16 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/src/connection.c b/src/connection.c
>>> index 3749d3a59196..66a3bd656db0 100644
>>> --- a/src/connection.c
>>> +++ b/src/connection.c
>>> @@ -57,6 +57,9 @@ struct gateway_data {
>>> bool default_checked;
>>> };
>>>=20
>>> +static const char *const ipv4_addr_any_str =3D "0.0.0.0";
>>> +static const char *const ipv6_addr_any_str =3D "::";
>>> +
>>=20
>> explain to me the double const. And why a variable and not just a =
#define.
>=20
> Were we to declare these as:
>=20
>    static const char *ipv4_addr_any_str =3D "0.0.0.0";
>    static const char *ipv6_addr_any_str =3D "::";
>=20
> This says =E2=80=9Ca mutable pointer to an immutable null-terminated =
character string=E2=80=9D. Consequently, that means somewhere during =
program run time we can do:
>=20
>    ipv4_addr_any_str =3D =E2=80=9CConnMan is the best network =
management program for Linux=E2=80=9D;
>=20
> and subvert the original intent and behavior of the code.
>=20
> As a result of the pointer mutability, the compiler is forced to =
allocate space not only for the initial string value in .text but also, =
depending on the architecture, 4- or 8-bytes in .data in RAM such that =
the run time pointer assignment can be accommodated. So, there are a few =
consequences of this:
>=20
>    1. This isn=E2=80=99t really what we intended, so we end up with a =
potential bug in which the constant we thought was constant really =
isn=E2=80=99t.
>    2. We end up wasting space in .data and, as a result, in RAM for =
behavior we didn=E2=80=99t want or need.
>=20
> By declaring them as in the patch, it says =E2=80=9Can immutable =
pointer to an immutable null-terminated character string=E2=80=9D. =
Because now both the pointer itself is immutable (and cannot be =
reassigned) and the contents it points to are immutable and, due to the =
=E2=80=99static=E2=80=99 storage/scope qualifier, the compiler can =
optimize as it sees fit. No space in .data is consumed and no more space =
in .text is consumed (and potentially less) than had it been a =
preprocessor definition.
>=20
> Does that help clarify?

fair enough. Can you add a small comment above to remind people that =
this is done on purpose. Maybe like this:

/* Declare these as an immutable pointer to an immutable
 * null-terminated character string.
 */
static const char *const ipv4_addr_any_str =3D "0.0.0.0";

Regards

Marcel


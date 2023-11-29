Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55F46B80
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 26F0E731FD;
	Wed, 29 Nov 2023 12:20:06 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a] (unknown [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D170473207;
	Wed, 29 Nov 2023 12:20:05 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/3] connection: Introduce and leverage
 'ipv[46]_addr_any_str' constants.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <5225FCB7-A3BB-4E45-B057-FFCA0BA278A6@holtmann.org>
Date: Wed, 29 Nov 2023 09:20:04 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <52BB6CD9-AB58-450F-9D2F-884FCF69EB37@nuovations.com>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129015253.1254116-2-gerickson@nuovations.com>
 <5225FCB7-A3BB-4E45-B057-FFCA0BA278A6@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 29, 2023, at 5:19 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> The IPv4 and IPv6 any / unspecified address string literals, =
"0.0.0.0"
>> and "::" respectively, appear often enough throughout the code where
>> they warrant referencing through file-scoped constants.
>> ---
>> src/connection.c | 28 ++++++++++++++++------------
>> 1 file changed, 16 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/src/connection.c b/src/connection.c
>> index 3749d3a59196..66a3bd656db0 100644
>> --- a/src/connection.c
>> +++ b/src/connection.c
>> @@ -57,6 +57,9 @@ struct gateway_data {
>> bool default_checked;
>> };
>>=20
>> +static const char *const ipv4_addr_any_str =3D "0.0.0.0";
>> +static const char *const ipv6_addr_any_str =3D "::";
>> +
>=20
> explain to me the double const. And why a variable and not just a =
#define.

Were we to declare these as:

    static const char *ipv4_addr_any_str =3D "0.0.0.0";
    static const char *ipv6_addr_any_str =3D "::";

This says =E2=80=9Ca mutable pointer to an immutable null-terminated =
character string=E2=80=9D. Consequently, that means somewhere during =
program run time we can do:

    ipv4_addr_any_str =3D =E2=80=9CConnMan is the best network =
management program for Linux=E2=80=9D;

and subvert the original intent and behavior of the code.

As a result of the pointer mutability, the compiler is forced to =
allocate space not only for the initial string value in .text but also, =
depending on the architecture, 4- or 8-bytes in .data in RAM such that =
the run time pointer assignment can be accommodated. So, there are a few =
consequences of this:

    1. This isn=E2=80=99t really what we intended, so we end up with a =
potential bug in which the constant we thought was constant really =
isn=E2=80=99t.
    2. We end up wasting space in .data and, as a result, in RAM for =
behavior we didn=E2=80=99t want or need.

By declaring them as in the patch, it says =E2=80=9Can immutable pointer =
to an immutable null-terminated character string=E2=80=9D. Because now =
both the pointer itself is immutable (and cannot be reassigned) and the =
contents it points to are immutable and, due to the =E2=80=99static=E2=80=99=
 storage/scope qualifier, the compiler can optimize as it sees fit. No =
space in .data is consumed and no more space in .text is consumed (and =
potentially less) than had it been a preprocessor definition.

Does that help clarify?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


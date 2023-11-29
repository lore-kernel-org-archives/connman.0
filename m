Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3383219EF
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4230573144;
	Wed, 29 Nov 2023 15:42:49 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a] (unknown [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E7CCD73156;
	Wed, 29 Nov 2023 15:42:48 -0500 (EST)
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
In-Reply-To: <B3B4E3CE-B50D-47CC-BB24-0059D8B5A3F3@holtmann.org>
Date: Wed, 29 Nov 2023 12:42:47 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1771661A-8E38-4466-8CE4-3353EDA7A27B@nuovations.com>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129015253.1254116-2-gerickson@nuovations.com>
 <5225FCB7-A3BB-4E45-B057-FFCA0BA278A6@holtmann.org>
 <52BB6CD9-AB58-450F-9D2F-884FCF69EB37@nuovations.com>
 <B3B4E3CE-B50D-47CC-BB24-0059D8B5A3F3@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 29, 2023, at 9:58 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>>> The IPv4 and IPv6 any / unspecified address string literals, =
"0.0.0.0"
>>>> and "::" respectively, appear often enough throughout the code =
where
>>>> they warrant referencing through file-scoped constants.
>>>> ---
>>>=20
>>> [ =E2=80=A6 ]
>>>=20
>>> explain to me the double const. And why a variable and not just a =
#define.
>>=20
>> Does that help clarify?
>=20
> fair enough. Can you add a small comment above to remind people that =
this is done on purpose. Maybe like this:
>=20
> /* Declare these as an immutable pointer to an immutable
> * null-terminated character string.
> */
> static const char *const ipv4_addr_any_str =3D "0.0.0.0";

Resubmitted as v2.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


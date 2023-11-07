Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC22C872
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3707173176;
	Tue,  7 Nov 2023 10:38:45 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E1F8B7319B;
	Tue,  7 Nov 2023 10:38:44 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Address -Werror=sign-compare compilation errors.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <41D09C15-1D19-41B5-90B5-DAC7780D8440@holtmann.org>
Date: Tue, 7 Nov 2023 07:38:43 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0358404F-A450-4090-A724-8105616E8569@nuovations.com>
References: <6ECC162C-D6EF-4043-B58C-C5225E9910F4@nuovations.com>
 <41D09C15-1D19-41B5-90B5-DAC7780D8440@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 7, 2023, at 7:28 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> This addresses -Werror=3Dsign-compare compilation errors surfaced by =
both
>> GCC and clang/LLVM when --enable-maintainer-mode is asserted.
>> ---
>> src/dnsproxy.c | 14 +++++++-------
>> src/iptables.c |  4 ++--
>> 2 files changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
>> index 4ae485f1..03021ba0 100644
>> --- a/src/dnsproxy.c
>> +++ b/src/dnsproxy.c
>> @@ -436,7 +436,7 @@ static void update_cached_ttl(unsigned char *ptr, =
int len, int new_ttl)
>> ptr +=3D DNS_HEADER_SIZE;
>> len -=3D DNS_HEADER_SIZE;
>>=20
>> - if (len < DNS_QUESTION_SIZE + 1)
>> + if (len < (int)DNS_QUESTION_SIZE + 1)
>> return;
>=20
> I was struggling with these as well and didn=E2=80=99t want to result =
to just casting everything. Fundamentally once you cast you loose any =
benefits of the compiler checking things. Sometimes it is enough to =
re-arrange the statements or pick different variables.

Agreed. I=E2=80=99m happy to take a different approach; however, this =
seemed the most tactical.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


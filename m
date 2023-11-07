Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00526328A2
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CFD0B732F2;
	Tue,  7 Nov 2023 11:20:27 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7E93C732FA;
	Tue,  7 Nov 2023 11:20:27 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] configure: add xz archive support to dist target.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <0689A947-A5B4-4673-A1DF-92CF4880BA09@holtmann.org>
Date: Tue, 7 Nov 2023 08:20:26 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <82C9B46C-20F3-46BD-95AB-EB4301C481CA@nuovations.com>
References: <AF69756E-A74C-417D-B3DF-F8A123C94A50@nuovations.com>
 <0689A947-A5B4-4673-A1DF-92CF4880BA09@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 7, 2023, at 7:57 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> For a given base of connman source code, xz compression results in
>> archives about 30% smaller than gzip.
>> ---
>> configure.ac | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/configure.ac b/configure.ac
>> index 367b5304..4b845027 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -3,7 +3,7 @@ AC_INIT([connman], [1.42])
>>=20
>> AC_CONFIG_MACRO_DIR([m4])
>>=20
>> -AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
>> +AM_INIT_AUTOMAKE([foreign subdir-objects color-tests dist-xz])
>> AC_CONFIG_HEADERS([config.h])
>=20
> I was going to do this when we switch to 2.x numbering. Within a major =
release version, I kept the tarball compression the same.
>=20
> If you think we should switch to 2.x, then we can do that. Or minor =
number is already large ;)

When I am complete with the EnableOnlineToReadyTransition =
implementation, that seems significant enough to warrant a major version =
bump.

Beyond that, I=E2=80=99ve no strong opinion, even with this change =
=E2=80=9Cmake dist=E2=80=9D still produces BOTH .xz and .gz archives. =
You had to add "no-dist-gzip=E2=80=9D to disable .gz archives.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


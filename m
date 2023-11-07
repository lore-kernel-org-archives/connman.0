Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2443158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 02336CECEE;
	Tue,  7 Nov 2023 20:09:29 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] configure: add xz archive support to dist target.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <82C9B46C-20F3-46BD-95AB-EB4301C481CA@nuovations.com>
Date: Tue, 7 Nov 2023 20:09:19 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <003C2A82-9110-4A06-BAB9-59148310E87B@holtmann.org>
References: <AF69756E-A74C-417D-B3DF-F8A123C94A50@nuovations.com>
 <0689A947-A5B4-4673-A1DF-92CF4880BA09@holtmann.org>
 <82C9B46C-20F3-46BD-95AB-EB4301C481CA@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

>>> For a given base of connman source code, xz compression results in
>>> archives about 30% smaller than gzip.
>>> ---
>>> configure.ac | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/configure.ac b/configure.ac
>>> index 367b5304..4b845027 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -3,7 +3,7 @@ AC_INIT([connman], [1.42])
>>>=20
>>> AC_CONFIG_MACRO_DIR([m4])
>>>=20
>>> -AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
>>> +AM_INIT_AUTOMAKE([foreign subdir-objects color-tests dist-xz])
>>> AC_CONFIG_HEADERS([config.h])
>>=20
>> I was going to do this when we switch to 2.x numbering. Within a =
major release version, I kept the tarball compression the same.
>>=20
>> If you think we should switch to 2.x, then we can do that. Or minor =
number is already large ;)
>=20
> When I am complete with the EnableOnlineToReadyTransition =
implementation, that seems significant enough to warrant a major version =
bump.
>=20
> Beyond that, I=E2=80=99ve no strong opinion, even with this change =
=E2=80=9Cmake dist=E2=80=9D still produces BOTH .xz and .gz archives. =
You had to add "no-dist-gzip=E2=80=9D to disable .gz archives.

we switch to 2.x and then do like all the other projects set this up =
with .xz only. I like to be consistent even across projects.

Regards

Marcel


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876C13AFC
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 61DDA73202;
	Wed, 29 Nov 2023 14:53:16 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a] (unknown [IPv6:2601:647:5a00:15c1:382d:cec3:11a2:ed7a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1349B7321A;
	Wed, 29 Nov 2023 14:53:15 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] connection: Rename 'ipv[46]_gateway' gateway config
 field.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <8A90CA5E-4E2E-4A46-B53B-A2A75AAFB369@holtmann.org>
Date: Wed, 29 Nov 2023 11:53:15 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9E64542-16C7-467A-A682-1A0A02CC2E58@nuovations.com>
References: <20231129000816.1230451-1-gerickson@nuovations.com>
 <8A90CA5E-4E2E-4A46-B53B-A2A75AAFB369@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 29, 2023, at 5:18 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> This renames the 'gateway_data' structure 'ipv[46]_gateway' fields as
>> 'ipv[46]_config' to:
>>=20
>> [ =E2=80=A6 ]
>=20
> and now you are killing me since I can=E2=80=99t apply these patches =
since they depend on some changed debug thing.
>=20
> I really like to keep things at just having DBG(). It is easy to spot =
and easy to use. And we can backport and bisect things later on.

Resubmitted as v2.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


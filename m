Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45F3589F
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A48A67334C;
	Tue,  7 Nov 2023 14:29:49 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5A78C73357;
	Tue,  7 Nov 2023 14:29:49 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/2] service: Add Debug and Documentation to Proxy-related
 Functions
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <6E514ADB-AF0C-4140-BAA1-76FB0CFE039D@holtmann.org>
Date: Tue, 7 Nov 2023 11:29:49 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6706B0C1-68A4-4345-9A1C-E105407EE6BC@nuovations.com>
References: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
 <6E514ADB-AF0C-4140-BAA1-76FB0CFE039D@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 7, 2023, at 10:57 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> This patch series adds =E2=80=98DBG' statements and function =
documentation to service proxy-related functions to aid in debugging.
>>=20
>> In a multi-technology environment with =
"EnableOnlineToReadyTransition=E2=80=9D asserted, there seem to be times =
where WISPr =E2=80=9Conline=E2=80=9D checks =E2=80=9Cfall down a hole=E2=80=
=9D due to proxy method initialization. These additions have proven =
helpful in tracking down the issues.
>=20
> I applied patch 1/2, but 2/2 didn=E2=80=99t apply cleanly.

Marcel,

Thanks; 2/2 has been resubmitted as a v2 with "[PATCH 2/2 v2] service: =
Add documentation to proxy-related functions.=E2=80=9D.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


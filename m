Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704636AF0
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9908D73237;
	Tue,  7 Nov 2023 14:38:27 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4F5C37333E;
	Tue,  7 Nov 2023 14:38:27 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Const-qualify 'service' arguments in name and time server
 getters.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <0EAAFB52-7E2C-4831-BAB7-4D1832C9CAF5@holtmann.org>
Date: Tue, 7 Nov 2023 11:38:27 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B49B2CAB-F7CA-447A-8953-288976254E27@nuovations.com>
References: <70D6ACF5-703E-48D2-841A-24E63F889D9E@nuovations.com>
 <0EAAFB52-7E2C-4831-BAB7-4D1832C9CAF5@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 7, 2023, at 7:58 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Const-qualify the 'service' arguments in name and time server getter
>> functions to make it clear to the compiler, static analyzers,
>> and human readers that there are no mutation side effects with
>> such arguments and that the returned results are immutable and must
>> be copied if mutation is desired.
>> ---
>> include/service.h |  6 +++---
>> src/connman.h     |  2 +-
>> src/service.c     | 10 +++++-----
>> src/timeserver.c  | 14 +++++++-------
>> 4 files changed, 16 insertions(+), 16 deletions(-)
>=20
> sadly this one no longer applies.

Marcel,

Thanks; this has been resubmitted as a v2 under "[PATCH v2] =
Const-qualify 'service' arguments in name and time server  getters.=E2=80=9D=
.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


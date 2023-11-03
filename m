Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675424201
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DAED573256
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 18:12:53 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A94A973294
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 18:12:53 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 0/2] service: Add Debug and Documentation to Proxy-related
 Functions
Message-Id: <886269CB-A515-453F-8A14-4500307B0A7C@nuovations.com>
Date: Fri, 3 Nov 2023 15:12:52 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series adds =E2=80=98DBG' statements and function =
documentation to service proxy-related functions to aid in debugging.

In a multi-technology environment with "EnableOnlineToReadyTransition=E2=80=
=9D asserted, there seem to be times where WISPr =E2=80=9Conline=E2=80=9D =
checks =E2=80=9Cfall down a hole=E2=80=9D due to proxy method =
initialization. These additions have proven helpful in tracking down the =
issues.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


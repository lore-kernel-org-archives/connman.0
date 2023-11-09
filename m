Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253863B2
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B3CDE73250
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 23:37:53 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74] (unknown [IPv6:2601:647:5a00:15c1:ec32:172b:4c97:6a74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 748757326B
	for <connman@lists.linux.dev>; Wed,  8 Nov 2023 23:37:53 -0500 (EST)
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
Subject: Heap-use-after-free in 'free_wispr_routes'
Message-Id: <00594AC1-5C85-4FD1-912D-BB0B40426FF7@nuovations.com>
Date: Wed, 8 Nov 2023 20:37:52 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

ConnMan Community:

FYI, I am chasing down another heap-use-after-free fault identified by =
the Arm GNU Toolchain 12.3.1 address sanitizer in =
=E2=80=98free_wispr_routes=E2=80=99. Details are here:

	https://github.com/Nuovations/connman/issues/66

More to follow as I learn / find.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


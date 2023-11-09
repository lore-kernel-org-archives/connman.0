Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F738FA0
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C3A7973161
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 17:21:43 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8F1D5731A2
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 17:21:43 -0500 (EST)
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
Subject: Re: Heap-use-after-free in 'free_wispr_routes'
Date: Thu, 9 Nov 2023 14:21:42 -0800
References: <00594AC1-5C85-4FD1-912D-BB0B40426FF7@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <00594AC1-5C85-4FD1-912D-BB0B40426FF7@nuovations.com>
Message-Id: <CEAB13C2-D3D1-413F-8FAB-19E6F45E35B4@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 8, 2023, at 8:37 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> ConnMan Community:
>=20
> FYI, I am chasing down another heap-use-after-free fault identified by =
the Arm GNU Toolchain 12.3.1 address sanitizer in =
=E2=80=98free_wispr_routes=E2=80=99. Details are here:
>=20
> 	https://github.com/Nuovations/connman/issues/66
>=20
> More to follow as I learn / find.

The root cause seems to be that it is a reference counting issue with =
the =E2=80=98wp_context=E2=80=99. There is an unbalanced unref/release =
in =E2=80=98proxy_callback'. It=E2=80=99s unclear to me whether that =
unref/release is in error and needs to be deleted or if there needs to =
be a ref/retain before =E2=80=98connman_proxy_lookup' / =E2=80=98g_idle_ad=
d' are called in =E2=80=98wispr_portal_detect'.

I=E2=80=99ll research git blame and git log to see if I can back into =
how the code got to its current state.

I=E2=80=99ve added log annotations at =
https://github.com/Nuovations/connman/issues/66#issuecomment-1804774552.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997D110A
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZSfwUXK+"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231129011659epoutp02158a45c22a886159a412bc5c327bc8de~b8yPuwg4O2726727267epoutp02Y
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:16:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231129011659epoutp02158a45c22a886159a412bc5c327bc8de~b8yPuwg4O2726727267epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701220619;
	bh=ML3arrlK8Gfz0KOPimvU/B5vFhFle3+oXvoehB2Mdu0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=ZSfwUXK+L2ERahXCtXtCJcdXTCBBVVJGPP2oQZ5FMMRUT+9q12vmGiM/3yZOl8oZW
	 gJIg0cxaTLeT2gpJ+ZyrJPHb/8tA1rD9oG6vZgiq6NDjd2fvkQdJIFUU5lhAiVoUot
	 D+yEXMKdQ/Pdj/NKPqi1+GclTkGGmmz5NWba3cJk=
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.42.76]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231129011659epcas1p23a80baf507dbc87cca4a89e2e8a273c3~b8yPeUBSw2356223562epcas1p2v;
	Wed, 29 Nov 2023 01:16:59 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-5d-6566910b7a57
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.72.19104.B0196656; Wed, 29 Nov 2023 10:16:59 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: RE: Re: Query about ipv4 connman web page
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231129011659epcms1p57c0faf7151f067f18be5cfef0229f1f9@epcms1p5>
Date: Wed, 29 Nov 2023 10:16:59 +0900
X-CMS-MailID: 20231129011659epcms1p57c0faf7151f067f18be5cfef0229f1f9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCmri73xLRUgw375C0+bImz+PbpF6PF
	/PbbzBaPVsxkdGDxWL97ObvHi80zGT36tqxiDGCO4rJJSc3JLEst0rdL4MqYN62RseA8T8We
	RcuZGxg/cHcxcnJICJhILL+wnbmLkYtDSGAPo8TjuRsYuxg5OHgFBCX+7hAGqREWMJJ4fPIX
	K4gtJKAgseb8fjaQEmEBS4l/B0RATDYBc4nza7JBKkQENCXmLjnLDGIzA4UvLNvBCLGJV2JG
	+1MWCFtaYvvyrVBxUYmbq9+yw9jvj82HiotItN6DmCMBdMyDn7uh4lISh69fZIOwiyV2bDkM
	VVMh0d2zmxXCNpc4tvc5M8QjvhJ3JwaChFkEVCVWL9wOtcpFYk7/a6gztSWWLXwNVs4MdP76
	XfoQJYoSO3/PZYQo4ZN497WHFeaTHfOeMEHYKhLvD/xkg7nswfNPUB96SMyat58REmaBEi2r
	GlgmMMrPQoTsLCSLZyEsXsDIvIpRKrWgODc9NdmwwFA3L7Vcrzgxt7g0L10vOT93EyM4LWj5
	7GD8vv6v3iFGJg7GQ4wSHMxKIrx6H5NThXhTEiurUovy44tKc1KLDzFKc7AoifPGfGpPERJI
	TyxJzU5NLUgtgskycXBKNTBFLL0Ttrj7ctSFGWvZzQ0uhCzc8fnsvh2v+Jh0jFZaRWh8SPbl
	n3HqYv97QaX2aT2Fs3d9mbumd1Nv/8wHj5sKmJn2B2Tm5fNMCPq55sWfA0n+f4xql7x5P/Xc
	6+a571symDSvnvsS6nDNa8Uf97f87e5bBQ2NXH2Fn+wwWiM+W9J5VvIJ2b6jHysq/+8RawvX
	ObPFsO+Y0Y3D1ZOW1yrUZmzoDTmY7ZeVVr9x6SzPer/+czvF/t+W/BThY6D46ydvnWlaSJDK
	x3/3D0ld021mdTT/UOex7NnmhcuP5Or8imO7cuzOkWcS7c9fav+7eoKzMVVjqsK1/a4bD8Vq
	ydqkSbQa3Ob7d2B+TktbschtJZbijERDLeai4kQAnqWfyXoDAAA=
X-CMS-RootMailID: 20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69
References: <CGME20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69@epcms1p5>

Dear Marcel,


Thank you for quick fix.
It is very impressive experience for me.


I hope to ask the following questions.
1. Could you share the reason of =22Connection timeout=22 if possible?
2. When I face ipv4.connman.net/online/status.html access issue, can I repo=
rt to this way?=C2=A0=0D=0A=0D=0A=0D=0ABR=0D=0AWonyoung=20Lee=0D=0A=C2=A0=
=0D=0A---------=C2=A0Original=20Message=C2=A0---------=0D=0ASender=C2=A0:=
=20Marcel=20Holtmann=20<marcel=40holtmann.org>=0D=0ADate=C2=A0=20=C2=A0:=20=
2023-11-28=2018:55=20(GMT+9)=0D=0ATitle=C2=A0=20:=20Re:=20Query=20about=20i=
pv4=20connman=20web=20page=0D=0A=C2=A0=0D=0AHi=20Lee,=0D=0A=0D=0A=0D=0A>=20=
I=20am=20testing=20connman=20on=20Tizen=20platform=20with=20the=20following=
=20URLs=0D=0A>=20=22https://protect2.fireeye.com/v1/url?k=3Da37d3ce5-c2f629=
d3-a37cb7aa-74fe485cbff1-0a4cc3ceca2ef108&q=3D1&e=3De494d81d-c061-4755-8c99=
-c2c5c83bca0d&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=22=
=0D=0A>=20=22https://protect2.fireeye.com/v1/url?k=3D31efc497-5064d1a1-31ee=
4fd8-74fe485cbff1-e6408c7ba2f81bce&q=3D1&e=3De494d81d-c061-4755-8c99-c2c5c8=
3bca0d&u=3Dhttp%3A%2F%2Fipv6.connman.net%2Fonline%2Fstatus.html=22=0D=0A>=
=C2=A0=0D=0A>=C2=A0=0D=0A>=20But=20when=20I=20test=20CURL=20GET=20request=
=20to=20those=20URLs,=20the=20response=20is=20CURLE=2028=20(Connection=20ti=
meout)=0D=0A>=20Could=20you=20help=20to=20fix=20those=20web=20service?=0D=
=0A=0D=0A=0D=0Ashould=20be=20all=20back=20to=20normal=20now.=0D=0A=0D=0A=0D=
=0ARegards=0D=0A=0D=0A=0D=0AMarcel=0D=0A=0D=0A=0D=0A=0D=0A=0D=0A=0D=0A=0D=
=0A=C2=A0=0D=0A=0D=0A

Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C79175A64
	for <connman@lists.linux.dev>; Thu,  4 Jun 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535638; cv=none; b=okQxbesedshmN0vtgla1eTKjCtukMqfaK9GNYWR9WEdT/fb35GPtkApfJSxHY+VATOW7M0M4fwxDSnrwfKlBwPVEEpedVWOG1y7wydPD5tXaXv1rrQEbJdl8zqpVxWTK9Y4t8yKAIpOcGmYVx26eG50mAgHZU0xse3APYbFYjEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535638; c=relaxed/simple;
	bh=K8fYPiit7cdoHRJHVsVSj4QPCTzjveXxf7Q1OtoJUek=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=Nerg1N6Ga7cvin5IFaJxLcmEbl4efbJS4A6u8v10/ewtFwdbHdRZa+yT7r3N7XWbfGsgULD5bE7NN7/AdaqWBCf9hxokX9phA0MaueiPtb0llfH74KO92G6wy4B8pc3v52ob9UAjscyR6T+hoAIcYkusxQuHHBR75ie2/qAV65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=apqIA3bn; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="apqIA3bn"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260604011347epoutp02b684b6d95839128125b8ce02238ce858~1u7g7QBpi1680216802epoutp02i
	for <connman@lists.linux.dev>; Thu,  4 Jun 2026 01:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260604011347epoutp02b684b6d95839128125b8ce02238ce858~1u7g7QBpi1680216802epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780535627;
	bh=K8fYPiit7cdoHRJHVsVSj4QPCTzjveXxf7Q1OtoJUek=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=apqIA3bn69kB2Dp1DmU/p30ISoeOxbfU8lteI2+JQIN4WtAWOOZNfvO3KAuJcaSOG
	 4lnWLSBGjGbc2IhiblE5rSED99CbQBtinCBUzwboCc7xCFYUkRkUNN1YSXn573wVk5
	 Qswgdp6Y8MBw5kebFnjuk99GSlUya768W6idHtfI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20260604011347epcas1p36c89eff13b56f940f9ce59cff476c031~1u7gX1cHm1325813258epcas1p3x;
	Thu,  4 Jun 2026 01:13:47 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.109]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gW65k3pv5z2SSKk; Thu,  4 Jun
	2026 01:13:46 +0000 (GMT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: [ISSUE REPORT] connman ipv4 server no response
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
CC: =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db@epcms1p5>
Date: Thu, 04 Jun 2026 10:13:46 +0900
X-CMS-MailID: 20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db
References: <CGME20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db@epcms1p5>

Dear Marcel and connman server engineers,

Hello, this is Wonyoung Lee working in Samsung Eletronics.
I had reported connman server issue before Nov 2023.

One of Samsung device uses ipv4.connman.net/online/status.html to check int=
ernet connectivity.
However, currently it has no responsed as timeout (CURL error 28)
I have checked the issue in South Korea.

Could please you check it ASAP?


The following email thread is the issue that I reported in Nov 2023.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hi Lee,

> Thank you for quick fix.
> It is very impressive experience for me.
>=20
>=20
> I hope to ask the following questions.
> 1. Could you share the reason of =22Connection timeout=22 if possible?
> 2. When I face https://protect2.fireeye.com/v1/url?k=3D1976931a-78fd8651-=
19771855-74fe485fb305-851354a353402d09&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a=
01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html access =
issue, can I report to this way?=20

after fixing ipv6.connman.net <https://protect2.fireeye.com/v1/url?k=3Dbe9c=
a340-df17b60b-be9d280f-74fe485fb305-8fbadceb1da3c1e7&q=3D1&e=3Db29b7ab0-c5d=
f-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv6.connman.net%2F> it took away=
 capacity from ipv4.connman.net <https://protect2.fireeye.com/v1/url?k=3D85=
3a0b6d-e4b11e26-853b8022-74fe485fb305-c3b592569573a2ff&q=3D1&e=3Db29b7ab0-c=
5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman.net%2F>. Seems the=
re are a lot of systems capable of IPv6 these days compared to back in the =
days when the service was created. The majority is still IPv4, but I have s=
een substantial IPv6 usage recently. So just increasing the capacity for IP=
v4 leveled this back to normal.

You might have noticed that ipv6.connman.net <https://protect2.fireeye.com/=
v1/url?k=3Da6941fc0-c71f0a8b-a695948f-74fe485fb305-4fd99c96e08c8959&q=3D1&e=
=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv6.connman.net%2=
F> went through actually and ipv4.connman.net <https://protect2.fireeye.com=
/v1/url?k=3D29c3bf12-4848aa59-29c2345d-74fe485fb305-6ed4e43dcdcfbd31&q=3D1&=
e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman.net%=
2F> took a connection timeout hit every now and then (still a large percent=
age succeeded). The preference of answering IPv6 over IPv4 is something tha=
t I don=E2=80=99t=20understand=20and=20I=20have=20to=20investigate=20(for=
=20pure=20personal=20interest),=20but=20that=20should=20no=20longer=20be=20=
an=20issue.=0D=0A=0D=0AIssues=20can=20be=20reported=20here=20or=20the=20new=
ly=20created=20Slack=20channel=20(which=20I=20still=20have=20to=20put=20int=
o=20the=20README).=0D=0A=0D=0ARegards=0D=0A=0D=0AMarcel=0D=0A=3D=3D=3D=3D=
=3D=3D=3D=3D

Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CE3AFB06
	for <connman@lists.linux.dev>; Mon,  8 Jun 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907558; cv=none; b=cbEQjqvLS8PBsNAoM+tw//vZZfTGRqUmSs6hqcvPNc5MdmDd3gULKiu87jpOGm8rGmrSRQJbS4Y2ARZX0DzvnVTFmb/ZaWD563oH7hHQ+JMD8+9pjxPqHpke+RA+svaZvE8uGmoEaxbgP4cNTAeFXfydgwXVG5kbibmuHPI1+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907558; c=relaxed/simple;
	bh=mRMmnVyaQZvLvo/vH2aNkpNa2Sy31H2DBofkC9WKTDg=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=EuRymGy/aZ1zwqo5w51u0kYvkp7GpGQ+1G7uG8K4A4WSyxPE+wg/4EkOSOT/QtFttFjF/rChba58I+M0hFusirNPIM6S9lZL5W7N/aoMJ8Kyur/mZo7fOy3gJg9/YfFx4+ya3+vCrik6NonMR+JBvQYNEvueMZt52XluQbI2gVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OZjiKAa+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OZjiKAa+"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260608083233epoutp04f9c22b5a35d43c41bd8e46f6b67e1f87~3DfwRZyl-1282412824epoutp04k
	for <connman@lists.linux.dev>; Mon,  8 Jun 2026 08:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260608083233epoutp04f9c22b5a35d43c41bd8e46f6b67e1f87~3DfwRZyl-1282412824epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780907553;
	bh=mRMmnVyaQZvLvo/vH2aNkpNa2Sy31H2DBofkC9WKTDg=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=OZjiKAa+azXOy5IpI42J91gm2tO7R5rMQHG65dPVztf5Z1f/qQ4Qs2gwgN70ZEx9q
	 QxxrFKiRo1Tsd/NSApR6dryppHngpQXF0tF1NNNzA2pO98wSwx01MZkSseqHs+tmIC
	 6iq4RwYh6GYkiEdb4wwlIq4AKUwSXvk1fYM/IB0k=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20260608083233epcas1p3bb2cddebefb1a9ff4fa1da875d403957~3Dfv94_It1796017960epcas1p3Q;
	Mon,  8 Jun 2026 08:32:33 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.99]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4gYlf90ZC2z6B9mF; Mon,  8 Jun
	2026 08:32:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: FW: RE: (#67371691) [ISSUE REPORT] connman ipv4 server no response
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>, Bytemark
	<support@bytemark.co.uk>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>
CC: =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260605044542epcms1p5828aae799c74b4d70eb9a5c7d9218e49@epcms1p5>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260608083232epcms1p7c080661174e0560b501d06510149998e@epcms1p7>
Date: Mon, 08 Jun 2026 17:32:32 +0900
X-CMS-MailID: 20260608083232epcms1p7c080661174e0560b501d06510149998e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260604011624epcas1p38a4d94267682f5b804a8e943b36ded58
References: <20260605044542epcms1p5828aae799c74b4d70eb9a5c7d9218e49@epcms1p5>
	<604c4c36a9b774238b55a66b64254c39@bytemark.co.uk>
	<tickets/3637333731363931@support.bytemark.co.uk>
	<20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db@epcms1p5>
	<CGME20260604011624epcas1p38a4d94267682f5b804a8e943b36ded58@epcms1p7>

Dear Marcel and connman server team,

This is the 3rd email request about the http://ipv4.connman.net/online/stat=
us.html .
One of Tizen based devices have used above URL to check the interent connec=
tion.
There are lots of VOCs in Korea about this connection error.

Could you check this issue ASAP?

BR
Wonyoung Lee

---------Original Message---------
Sender: =EC=9D=B4=EC=9B=90=EC=98=81=20<wy1115.lee=40samsung.com>=20SmartThi=
ngs=EA=B0=9C=EB=B0=9C=EA=B7=B8=EB=A3=B9(APC)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=
=9E=90=0D=0ADate:=202026-06-05=2013:45=20(GMT+9)=0D=0ATitle:=20RE:=20(=2367=
371691)=20=5BISSUE=20REPORT=5D=20connman=20ipv4=20server=20no=20response=0D=
=0A=0D=0ADear=20connman=20server=20team,=0D=0A=0D=0AThere=20are=20lots=20of=
=20VOCs=20caused=20by=20connman=20ipv4=20server=20issue=20in=20Korea.=0D=0A=
=0D=0AAnd=20I=20am=20trying=20to=20access=20ticket=20URL=20which=20you=20sh=
ared=20before=20(https://support.bytemark.co.uk/en/tickets/view/67371691),=
=0D=0Ahowever,=20I=20could=20not=20access=20it.=0D=0A=0D=0ACould=20you=20sh=
are=20the=20current=20status?=0D=0A=0D=0A=0D=0A---------Original=20Message-=
--------=0D=0ASender:=20Bytemark=20<support=40bytemark.co.uk>=C2=A0=0D=0ADa=
te:=202026-06-04=2010:16=20(GMT+9)=0D=0ATitle:=20(=2367371691)=20=5BISSUE=
=20REPORT=5D=20connman=20ipv4=20server=20no=20response=0D=0A=0D=0A-=23-=23-=
=20Please=20reply=20above=20this=20line=20-=23-=23-=0D=0A=0D=0ADear=20wy111=
5.lee=40samsung.com,=0D=0A=C2=A0=0D=0AWe=20have=20received=20your=20request=
=20and=20someone=20will=20be=20looking=20at=20it=20shortly.We=20are=20commi=
tted=20to=20resolving=20every=20ticket=20as=20promptly=20as=20possible,=20a=
nd=20we=20encourage=20you=20to=20let=20us=20know=20if=20you=20have=20anyadd=
itional=20concerns=20or=20questions=20by=20replying=20to=20this=20email.You=
=20will=20receive=20an=20email=20when=20any=20action=20has=20been=20taken=
=20on=20your=20ticket.=0D=0ATicket=20Details=0D=0ATicket=20=23:=2067371691=
=0D=0A=C2=A0Subject:=20=5BISSUE=20REPORT=5D=20connman=20ipv4=20server=20no=
=20response=0D=0A=C2=A0Department:=20Technical=20Support=0D=0A=C2=A0Status:=
=20Open=0D=0A=C2=A0Priority:=20Standard=0D=0Awy1115.lee=40samsung.com=0D=0A=
User=20-=2004/06/2026=2002:14=0D=0ADear=20Marcel=20and=20connman=20server=
=20engineers,=0D=0A=0D=0AHello,=20this=20is=20Wonyoung=20Lee=20working=20in=
=20Samsung=20Eletronics.=0D=0AI=20had=20reported=20connman=20server=20issue=
=20before=20Nov=202023.=0D=0A=0D=0AOne=20of=20Samsung=20device=20uses=20ipv=
4.connman.net/online/status.html=20to=20check=20internet=20connectivity.=0D=
=0AHowever,=20currently=20it=20has=20no=20responsed=20as=20timeout=20(CURL=
=20error=2028)=0D=0AI=20have=20checked=20the=20issue=20in=20South=20Korea.=
=0D=0A=0D=0ACould=20please=20you=20check=20it=20ASAP?=0D=0A=0D=0A=0D=0AThe=
=20following=20email=20thread=20is=20the=20issue=20that=20I=20reported=20in=
=20Nov=202023.=0D=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0AHi=20Lee,=0D=0A=0D=
=0A>=20Thank=20you=20for=20quick=20fix.=0D=0A>=20It=20is=20very=20impressiv=
e=20experience=20for=20me.=0D=0A>=0D=0A>=0D=0A>=20I=20hope=20to=20ask=20the=
=20following=20questions.=0D=0A>=201.=20Could=20you=20share=20the=20reason=
=20of=20=22Connection=20timeout=22=20if=20possible?=0D=0A>=202.=20When=20I=
=20face=20https://protect2.fireeye.com/v1/url?k=3D1976931a-78fd8651-1977185=
5-74fe485fb305-851354a353402d09&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f=
015&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=20access=20iss=
ue,=20can=20I=20report=20to=20this=20way?=0D=0A=0D=0Aafter=20fixing=20ipv6.=
connman.net=20<https://protect2.fireeye.com/v1/url?k=3Dbe9ca340-df17b60b-be=
9d280f-74fe485fb305-8fbadceb1da3c1e7&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01=
fa44f015&u=3Dhttp%3A%2F%2Fipv6.connman.net%2F>=20it=20took=20away=20capacit=
y=20from=20ipv4.connman.net=20<https://protect2.fireeye.com/v1/url?k=3D853a=
0b6d-e4b11e26-853b8022-74fe485fb305-c3b592569573a2ff&q=3D1&e=3Db29b7ab0-c5d=
f-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman.net%2F>.=20Seems=20t=
here=20are=20a=20lot=20of=20systems=20capable=20of=20IPv6=20these=20days=20=
compared=20to=20back=20in=20the=20days=20when=20the=20service=20was=20creat=
ed.=20The=20majority=20is=20still=20IPv4,=20but=20I=20have=20seen=20substan=
tial=20IPv6=20usage=20recently.=20So=20just=20increasing=20the=20capacity=
=20for=20IPv4=20leveled=20this=20back=20to=20normal.=0D=0A=0D=0AYou=20might=
=20have=20noticed=20that=20ipv6.connman.net=20<https://protect2.fireeye.com=
/v1/url?k=3Da6941fc0-c71f0a8b-a695948f-74fe485fb305-4fd99c96e08c8959&q=3D1&=
e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv6.connman.net%=
2F>=20went=20through=20actually=20and=20ipv4.connman.net=20<https://protect=
2.fireeye.com/v1/url?k=3D29c3bf12-4848aa59-29c2345d-74fe485fb305-6ed4e43dcd=
cfbd31&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4=
.connman.net%2F>=20took=20a=20connection=20timeout=20hit=20every=20now=20an=
d=20then=20(still=20a=20large=20percentage=20succeeded).=20The=20preference=
=20of=20answering=20IPv6=20over=20IPv4=20is=20something=20that=20I=20don=E2=
=80=99t=20understand=20and=20I=20have=20to=20investigate=20(for=20pure=20pe=
rsonal=20interest),=20but=20that=20should=20no=20longer=20be=20an=20issue.=
=0D=0A=0D=0AIssues=20can=20be=20reported=20here=20or=20the=20newly=20create=
d=20Slack=20channel=20(which=20I=20still=20have=20to=20put=20into=20the=20R=
EADME).=0D=0A=0D=0ARegards=0D=0A=0D=0AMarcel=0D=0A=3D=3D=3D=3D=3D=3D=3D=3D=
=0D=0AYou=20can=20review=20the=20ticket=20by=20going=20to:=0D=0A=C2=A0https=
://support.bytemark.co.uk/en/tickets/view/67371691=0D=0A=C2=A0=0D=0AKind=20=
Regards,=0D=0A=C2=A0Bytemark

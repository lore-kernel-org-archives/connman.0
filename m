Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B4320CD9
	for <connman@lists.linux.dev>; Fri,  5 Jun 2026 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780634749; cv=none; b=uhWVpetXSiE9OL36z6VpcuKQKdPU8fxTRF4Eiu+Vn3WRki1LbM7hz/Xib3LbD5s/G9PLY3c0htmAQ551Oxsou+cHmfk342XDl+ZdKkf8QOC1htRCekhjRu2q+1Ye2apj5NPWdoVrH0xzuHxX2QYpDxC8UzPg2GKi2b5nJX4wCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780634749; c=relaxed/simple;
	bh=YBVMe/NMSktjopQyJhCT6V5v97DEzT49QBw/VN/9XOY=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=b2/O6dbEZe+jpm/zk8qYKTc1JJ2Wu7acFUV3VYMkJ9LbKP0rDgJDTqEyBHGWE1Ec/CTg4JdoNxXV4VD3G7LsopvD2+D641iytuwqTwBM2Cqh81HmHd8ohXum22IN+uNZF9HTG1ZfBF1FwP3TFZ3+bADPQ+R6BZaCbYCayvq7x/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LRl3wNPb; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LRl3wNPb"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260605044543epoutp01eb16050a3223f829d98dce59df42cacc~2Fd11lyLc0195201952epoutp016
	for <connman@lists.linux.dev>; Fri,  5 Jun 2026 04:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260605044543epoutp01eb16050a3223f829d98dce59df42cacc~2Fd11lyLc0195201952epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780634743;
	bh=YBVMe/NMSktjopQyJhCT6V5v97DEzT49QBw/VN/9XOY=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=LRl3wNPbGfmt2uQPGm7YBAhRHlOn0nc62s3PHuTITlaNQ6NsSY84MVkNGgA37Y1PD
	 rOtYtFngza2eBxPXzsATa7qLqsOVadb0Nq09X55F4ZIPpXY8ybKzConHhw6xwRORgF
	 iBmTxqLvbe2HTIvMJAJkoqa+6pdkLNPGEycuyIfU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260605044543epcas1p1cd4101305dc58f43c82db67b3068c2b2~2Fd1jB7Tr2804128041epcas1p1H;
	Fri,  5 Jun 2026 04:45:43 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.106]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4gWplp560yz3hhTF; Fri,  5 Jun
	2026 04:45:42 +0000 (GMT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: RE: (#67371691) [ISSUE REPORT] connman ipv4 server no response
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: Bytemark <support@bytemark.co.uk>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>
CC: =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <604c4c36a9b774238b55a66b64254c39@bytemark.co.uk>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260605044542epcms1p5828aae799c74b4d70eb9a5c7d9218e49@epcms1p5>
Date: Fri, 05 Jun 2026 13:45:42 +0900
X-CMS-MailID: 20260605044542epcms1p5828aae799c74b4d70eb9a5c7d9218e49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260604011624epcas1p38a4d94267682f5b804a8e943b36ded58
References: <604c4c36a9b774238b55a66b64254c39@bytemark.co.uk>
	<tickets/3637333731363931@support.bytemark.co.uk>
	<20260604011346epcms1p57f7879c63ce2b091dbd27370e88798db@epcms1p5>
	<CGME20260604011624epcas1p38a4d94267682f5b804a8e943b36ded58@epcms1p5>

Dear connman server team,

There are lots of VOCs caused by connman ipv4 server issue in Korea.

And I am trying to access ticket URL which you shared before (https://suppo=
rt.bytemark.co.uk/en/tickets/view/67371691),
however, I could not access it.

Could you share the current status?


---------Original Message---------
Sender: Bytemark <support=40bytemark.co.uk>=C2=A0=0D=0ADate:=202026-06-04=
=2010:16=20(GMT+9)=0D=0ATitle:=20(=2367371691)=20=5BISSUE=20REPORT=5D=20con=
nman=20ipv4=20server=20no=20response=0D=0A=0D=0A-=23-=23-=20Please=20reply=
=20above=20this=20line=20-=23-=23-=0D=0A=0D=0ADear=20wy1115.lee=40samsung.c=
om,=0D=0A=C2=A0=0D=0AWe=20have=20received=20your=20request=20and=20someone=
=20will=20be=20looking=20at=20it=20shortly.We=20are=20committed=20to=20reso=
lving=20every=20ticket=20as=20promptly=20as=20possible,=20and=20we=20encour=
age=20you=20to=20let=20us=20know=20if=20you=20have=20anyadditional=20concer=
ns=20or=20questions=20by=20replying=20to=20this=20email.You=20will=20receiv=
e=20an=20email=20when=20any=20action=20has=20been=20taken=20on=20your=20tic=
ket.=0D=0ATicket=20Details=0D=0ATicket=20=23:=2067371691=0D=0A=C2=A0Subject=
:=20=5BISSUE=20REPORT=5D=20connman=20ipv4=20server=20no=20response=0D=0A=C2=
=A0Department:=20Technical=20Support=0D=0A=C2=A0Status:=20Open=0D=0A=C2=A0P=
riority:=20Standard=0D=0Awy1115.lee=40samsung.com=0D=0AUser=20-=2004/06/202=
6=2002:14=0D=0A=20Dear=20Marcel=20and=20connman=20server=20engineers,=0D=0A=
=0D=0AHello,=20this=20is=20Wonyoung=20Lee=20working=20in=20Samsung=20Eletro=
nics.=0D=0AI=20had=20reported=20connman=20server=20issue=20before=20Nov=202=
023.=0D=0A=0D=0AOne=20of=20Samsung=20device=20uses=20ipv4.connman.net/onlin=
e/status.html=20to=20check=20internet=20connectivity.=0D=0AHowever,=20curre=
ntly=20it=20has=20no=20responsed=20as=20timeout=20(CURL=20error=2028)=0D=0A=
I=20have=20checked=20the=20issue=20in=20South=20Korea.=0D=0A=0D=0ACould=20p=
lease=20you=20check=20it=20ASAP?=0D=0A=0D=0A=0D=0AThe=20following=20email=
=20thread=20is=20the=20issue=20that=20I=20reported=20in=20Nov=202023.=0D=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0AHi=20Lee,=0D=0A=0D=0A>=20Thank=20you=20=
for=20quick=20fix.=0D=0A>=20It=20is=20very=20impressive=20experience=20for=
=20me.=0D=0A>=20=0D=0A>=20=0D=0A>=20I=20hope=20to=20ask=20the=20following=
=20questions.=0D=0A>=201.=20Could=20you=20share=20the=20reason=20of=20=22Co=
nnection=20timeout=22=20if=20possible?=0D=0A>=202.=20When=20I=20face=20http=
s://protect2.fireeye.com/v1/url?k=3D1976931a-78fd8651-19771855-74fe485fb305=
-851354a353402d09&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3=
A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=20access=20issue,=20can=20I=
=20report=20to=20this=20way?=20=0D=0A=0D=0Aafter=20fixing=20ipv6.connman.ne=
t=20<https://protect2.fireeye.com/v1/url?k=3Dbe9ca340-df17b60b-be9d280f-74f=
e485fb305-8fbadceb1da3c1e7&q=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=
=3Dhttp%3A%2F%2Fipv6.connman.net%2F>=20it=20took=20away=20capacity=20from=
=20ipv4.connman.net=20<https://protect2.fireeye.com/v1/url?k=3D853a0b6d-e4b=
11e26-853b8022-74fe485fb305-c3b592569573a2ff&q=3D1&e=3Db29b7ab0-c5df-40c5-9=
f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman.net%2F>.=20Seems=20there=20a=
re=20a=20lot=20of=20systems=20capable=20of=20IPv6=20these=20days=20compared=
=20to=20back=20in=20the=20days=20when=20the=20service=20was=20created.=20Th=
e=20majority=20is=20still=20IPv4,=20but=20I=20have=20seen=20substantial=20I=
Pv6=20usage=20recently.=20So=20just=20increasing=20the=20capacity=20for=20I=
Pv4=20leveled=20this=20back=20to=20normal.=0D=0A=0D=0AYou=20might=20have=20=
noticed=20that=20ipv6.connman.net=20<https://protect2.fireeye.com/v1/url?k=
=3Da6941fc0-c71f0a8b-a695948f-74fe485fb305-4fd99c96e08c8959&q=3D1&e=3Db29b7=
ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv6.connman.net%2F>=20wen=
t=20through=20actually=20and=20ipv4.connman.net=20<https://protect2.fireeye=
.com/v1/url?k=3D29c3bf12-4848aa59-29c2345d-74fe485fb305-6ed4e43dcdcfbd31&q=
=3D1&e=3Db29b7ab0-c5df-40c5-9f7f-1a01fa44f015&u=3Dhttp%3A%2F%2Fipv4.connman=
.net%2F>=20took=20a=20connection=20timeout=20hit=20every=20now=20and=20then=
=20(still=20a=20large=20percentage=20succeeded).=20The=20preference=20of=20=
answering=20IPv6=20over=20IPv4=20is=20something=20that=20I=20don=E2=80=99t=
=20understand=20and=20I=20have=20to=20investigate=20(for=20pure=20personal=
=20interest),=20but=20that=20should=20no=20longer=20be=20an=20issue.=0D=0A=
=0D=0AIssues=20can=20be=20reported=20here=20or=20the=20newly=20created=20Sl=
ack=20channel=20(which=20I=20still=20have=20to=20put=20into=20the=20README)=
.=0D=0A=0D=0ARegards=0D=0A=0D=0AMarcel=0D=0A=3D=3D=3D=3D=3D=3D=3D=3D=0D=0AY=
ou=20can=20review=20the=20ticket=20by=20going=20to:=0D=0A=C2=A0https://supp=
ort.bytemark.co.uk/en/tickets/view/67371691=0D=0A=C2=A0=0D=0AKind=20Regards=
,=0D=0A=C2=A0Bytemark

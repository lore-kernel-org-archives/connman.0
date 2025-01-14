Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1A224B16
	for <connman@lists.linux.dev>; Tue, 14 Jan 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818577; cv=none; b=qIYcAClMhK0Z8/jPP6mXTYwZZIcTMJjxMUPtA1ujefG098F9Fzq7vEh2S9V2hGPaMbJw4zN2mOgCK/uwyWwy7TwHYWpbppd+sFhTZqeo1yjhag0ZwSyGHN/UQrOkSsvVaYJTj+uvuGb6VnVejot+WgWhJ/0pLCZA1xfYkWfOrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818577; c=relaxed/simple;
	bh=6FdtQa7a30+7kPdro1+uH4wYvrjLWVPoKVHbj98xBLU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=RNlkH01VAv4iQTt+YJ8SjpvLzmA9i2ngt6K28cSC7Cn8lLKZvLVjhP07UEkaMFLZKZSsZ4O940ODf7ulU4orre2Bt5ynWjXFoUNr5wc6sG2b1neBC9D2qQ1jw220j+9BVHUWwUnK4V/Yx09s3QlgA4hhoKvwyIWwz9fYrCP9A6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PuS+MOoZ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PuS+MOoZ"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250114013607epoutp01494d0bb130fb727eec68a229dbd830fa~aa0jhugo40274002740epoutp01q
	for <connman@lists.linux.dev>; Tue, 14 Jan 2025 01:36:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250114013607epoutp01494d0bb130fb727eec68a229dbd830fa~aa0jhugo40274002740epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736818567;
	bh=6FdtQa7a30+7kPdro1+uH4wYvrjLWVPoKVHbj98xBLU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=PuS+MOoZLthkeqPGp5uRvposw44y4NaeVo2PhC9wE8bNZON7qGS+OXWCI6G4cSYar
	 AJxyU3VvLdAaLoNBzsQBQ8FeT2+Vnr0EN54pIuPVmncrb0tMqU2K1H0MQPXRo+Neu7
	 215qI+nqRPb/+gjlx+c6Ht3r0TZSVEJc2qL1OZn0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20250114013606epcas1p4c38f3e4777e912d8e6ef7dfb6160fb05~aa0jSnu6a0205002050epcas1p4n;
	Tue, 14 Jan 2025 01:36:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.134]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YXBY11FG1z4x9QH; Tue, 14 Jan
	2025 01:36:05 +0000 (GMT)
X-AuditID: b6c32a37-17dea70000005b53-56-6785bf855f8b
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.A0.23379.58FB5876; Tue, 14 Jan 2025 10:36:05 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: RE:(2) Query about ipv4 connman url
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: Grant Erickson <gerickson@nuovations.com>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>, =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <3A14F323-D214-48D5-AA9E-952E739AB1EB@nuovations.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250114013604epcms1p78058ccc87d02a107531b8de40dbb4e54@epcms1p7>
Date: Tue, 14 Jan 2025 10:36:04 +0900
X-CMS-MailID: 20250114013604epcms1p78058ccc87d02a107531b8de40dbb4e54
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmnm7r/tZ0g5tXWCw+bImzeDu3hcni
	4LMbjBbfPv1idGDxWL97ObvHi80zGT3edu9m8ujbsooxgCUq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj+6YX7AVH7Spav21la2B8Y9PF
	yMkhIWAiceLtUWYQW0hgB6PE6Y8ZXYwcHLwCghJ/dwiDmMICOhKLPjtCVChIrDm/nw0ibCnx
	74AIiMkmYC5xfk02SIWIgL7E1fXN7F2MXBzMAtMZJa5MmcgCsYhXYkb7UyhbWmL78q2MIDan
	gJPEt8Uf2SHiohI3V7+Fs98fm88IYYtItN47ywxhC0o8+LmbEWbOvUUXoWYWS+zYchiqpkKi
	u2c3K4RtLnFs73OwOK+Ar8SbBUvB6lkEVCVWfj8CtctFoqO7lw3EZhbQlli28DUzyF/MApoS
	63fpQ4T5JN597WGFeWXHvCdMELaKxPsDP9kgbCmJB88/QZ3jIbHl/V9GUDgICZxllPh28CXz
	BEb5WYiwnYVk2yyEbQsYmVcxiqUWFOempxYbFhjDYzM5P3cTIzi5aZnvYJz29oPeIUYmDsZD
	jBIczEoivEvYWtOFeFMSK6tSi/Lji0pzUosPMZoC/TmRWUo0OR+YXvNK4g1NLA1MzIyMTSwM
	zQyVxHkvbGtJFxJITyxJzU5NLUgtgulj4uCUamCKrUz0f5H38DCP7JTdT/g3t7IWvuV7/2nz
	Duk1svZT7AOUCtQOKd5//N/J+k/esm7zzgD/3H6VY1K1L3IdnGq8vGvdnaYdinH5Y6V5t++g
	xul9JcpKTCErEqQDbr1/Vx5UESCy8YXZA7W/7s/8r4jKzVutvWiNjTdTxJyWyLBY5lUnru93
	UXJ401JQEeFq1s/7K3Ruc49q5fyyy28P/Yp0vsQmHDN7av+3kNdmu6r/m0qE8f6eJ/qxb+tM
	nQffL3U154jd1z6qW+djL2bll75G8xuL510v4SLRn+evB4mblfhk1dU1rXmu5fBS5uir1wxK
	K39+kzuzetVjjY9Lmb7ct14XdFDrpkVWyNRZK5VYijMSDbWYi4oTAbUqG/X3AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10
References: <3A14F323-D214-48D5-AA9E-952E739AB1EB@nuovations.com>
	<20250113022533epcms1p528f3b6b01aadaf75e214c2769dca6c95@epcms1p5>
	<CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p7>

Dear Marcel

Could you watch the issue when calling=C2=A0=E2=80=98ipv4.connman.net=E2=80=
=99,=20response=20of=20curl=20is=207=20(Error=20code)?=0D=0AI=20remember=20=
that=20we=20had=20discussed=20the=20similar=20issue=20at=20Nov=202023.=0D=
=0A=0D=0ABR=0D=0AWonyoung=20Lee=0D=0A=C2=A0=0D=0A---------=20Original=20Mes=
sage=20---------=0D=0ASender=20:=20Grant=20Erickson=20<gerickson=40nuovatio=
ns.com>=0D=0ADate=20:=202025-01-14=2007:33=20(GMT+9)=0D=0ATitle=20:=20Re:=
=20Query=20about=20ipv4=20connman=20url=0D=0A=C2=A0=0D=0AWonyoung=20Lee:=0D=
=0A=0D=0ARegrettably,=20I=20have=20no=20further=20visibility=20into=20the=
=20=E2=80=98ipv=7B4,6=7D.connman.net=E2=80=99=20servers.=20To=20the=20best=
=20of=20my=20knowledge,=20these=20are=20completely=20and=20exclusively=20ad=
ministered=20by=20Marcel=20(on=20CC).=0D=0A=0D=0AFor=20what=20it=20is=20wor=
th,=20I=20have=20been=20noticing=20similar=20availability=20issues=20with=
=20=E2=80=98ipv=7B4,6=7D.connman.net=E2=80=99=20on=20my=20end.=0D=0A=0D=0AB=
est=20regards,=0D=0A=0D=0AGrant=0D=0A=0D=0A>=20On=20Jan=2012,=202025,=20at=
=206:25=E2=80=AFPM,=20=EC=9D=B4=EC=9B=90=EC=98=81=20<wy1115.lee=40samsung.c=
om>=20wrote:=0D=0A>=0D=0A>=20Dear=20Grant=20Erickson,=0D=0A>=0D=0A>=20Kindl=
y=20remind=20for=20this=20topic.=0D=0A>=0D=0A>=0D=0A>=20=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20Dear=20Grant=20Erickson,=0D=0A>=
=0D=0A>=20As=20you=20said,=20cURL=20RESULT=20=5B7=5D=20in=20the=20debug=20l=
og=20is=20status=20code=207=20of=20curl.=0D=0A>=20This=20issue=20had=20not=
=20happened=20before=207th=20Jan(KST)=20with=20the=20same=20version=20of=20=
my=20software=20and=20the=20same=20network=20env.=0D=0A>=20And=20it=20is=20=
experienced=20not=20only=20by=20me=20but=20also=20by=20others.=0D=0A>=20So=
=20I=20am=20wondering=20the=20reason=20why=20it=20surddenly=20starts=20to=
=20response=20status=20code=207=0D=0A>=20Is=20it=20possible=20to=20check=20=
the=20reason=20on=20the=20server=20side?=0D=0A>=0D=0A>=20BR=0D=0A>=20Wonyou=
ng=20Lee=0D=0A>=0D=0A>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0D=0A>=20On=20Jan=208,=202025,=20at=2012:21=E2=80=AFAM,=20=EC=9D=
=B4=EC=9B=90=EC=98=81=20<wy1115.lee=40samsung.com>=20wrote:=0D=0A>>=20I=20a=
m=20testing=20connman=20on=20Tizenplatform=20with=20the=20following=20URLs=
=20=22https://protect2.fireeye.com/v1/url?k=3D4ccfcac0-2d44dff9-4cce418f-00=
0babffae10-994c06701b573d69&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&=
u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=22=0D=0A>>=20Howev=
er,=20I=20often=20get=20the=20curl=20errorwhen=20calling=20above=20URL=20li=
ke=20below.=0D=0A>>=0D=0A>>=2001-08=2014:17:39.029+0900curlRequest(1299)=20=
>=20=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=5Bhttps://protect2.fireeye=
.com/v1/url?k=3D7ffd22e2-1e7637db-7ffca9ad-000babffae10-eee25d3176242b54&q=
=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman=
.net%2Fonline%2Fstatus.html=5D=0D=0A>>=0D=0A>>=2001-08=2014:20:07.949+0900c=
urlRequest(1299)=20>=20=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=5Bhttps=
://protect2.fireeye.com/v1/url?k=3D48f1bda2-297aa89b-48f036ed-000babffae10-=
3fee45b801578822&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3Dhttp%3A=
%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A>>=0D=0A>>=2001-08=20=
14:20:34.189+0900curlRequest(1299)=20>=20=5B0;33mcURL=20RESULT=20=5B7=5D=20=
with=20URL=5Bhttps://protect2.fireeye.com/v1/url?k=3D5bde5bcd-3a554ef4-5bdf=
d082-000babffae10-5851179a5d5da000&q=3D1&e=3Dbee29355-a62c-420a-8105-985586=
5ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A>>=
=0D=0A>>=2001-08=2014:20:59.639+0900curlRequest(1299)=20>=20=5B0;33mcURL=20=
RESULT=20=5B7=5D=20with=20URL=5Bhttps://protect2.fireeye.com/v1/url?k=3D586=
e64ab-39e57192-586fefe4-000babffae10-47741276e19feaa4&q=3D1&e=3Dbee29355-a6=
2c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstat=
us.html=5D=0D=0A>=0D=0A>=20From=20the=20'curl'=20man=20page,=20shell=20stat=
uscode=20=E2=80=987'=20seems=20to=20be:=0D=0A>=0D=0A>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=207=C2=A0=20=C2=A0=20=C2=A0=20Failed=20to=20connect=20to=20hos=
t.=0D=0A>=0D=0A>=20and=20would=20indicate=20that=20thev4.connman.net=20host=
=20may=20be=20unreachable.=20Can=20you=20confirm=20that=20is=20the=20case=
=20whenyou=20see=20status=20code=20'7'?=0D=0A>=0D=0A>=20Historically,=20Mar=
cel=20has=20need=20toprovision=20more=20capacity=20or=20make=20other=20twea=
ks=20to=20the=20servers=20to=20accomodateshifts=20in=20load=20or=20usage.=
=20That=20may=20or=20may=20not=20be=20the=20issue=20here.=0D=0A>=0D=0A>=20B=
est,=0D=0A>=0D=0A>=20Grant=0D=0A>=0D=0A>=20--=0D=0A>=20Principal=0D=0A>=20N=
uovations=0D=0A>=C2=A0=0D=0A>=20---------=20Original=20Message=20---------=
=0D=0A>=20Sender=20:=20=EC=9D=B4=EC=9B=90=EC=98=81=20<wy1115.lee=40samsung.=
com>SmartThings=EA=B0=9C=EB=B0=9C=EA=B7=B8=EB=A3=B9(DPC)/=EC=82=BC=EC=84=B1=
=EC=A0=84=EC=9E=90=0D=0A>=20Date=20:=202025-01-08=2017:21=20(GMT+9)=0D=0A>=
=20Title=20:=20Query=20about=20ipv4=20connman=20url=0D=0A>=C2=A0=0D=0A>=20D=
ear=20Connman=20maintainer,=0D=0A>=0D=0A>=20I=20am=20testing=20connman=20on=
=20Tizen=20platform=20with=20the=20following=20URLs=20=22https://protect2.f=
ireeye.com/v1/url?k=3D25559616-44de8336-25541d59-74fe485fb347-90034a678477a=
ad8&q=3D1&e=3D853dee28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttp%3A%2F%2Fipv4.co=
nnman.net%2Fonline%2Fstatus.html=22=0D=0A>=20However,=20I=20often=20get=20t=
he=20curl=20error=20when=20calling=20above=20URL=20like=20below.=0D=0A>=0D=
=0A>=2001-08=2014:17:39.029+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcURL=
=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttps://protect2.fireeye.com/v1/url?k=
=3D3bc104f9-5a4a11d9-3bc08fb6-74fe485fb347-697674be91cb099f&q=3D1&e=3D853de=
e28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%=
2Fstatus.html=5D=0D=0A>=0D=0A>=2001-08=2014:20:07.949+0900=20curlRequest(12=
99)=20>=20=1B=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttps://prot=
ect2.fireeye.com/v1/url?k=3Df3db889a-92509dba-f3da03d5-74fe485fb347-d4003b8=
f2d5a9845&q=3D1&e=3D853dee28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttp%3A%2F%2Fi=
pv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A>=0D=0A>=2001-08=2014:20:34.=
189+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcURL=20RESULT=20=5B7=5D=20wit=
h=20URL=20=5Bhttps://protect2.fireeye.com/v1/url?k=3De5e7d178-846cc458-e5e6=
5a37-74fe485fb347-3619efd282405050&q=3D1&e=3D853dee28-cd77-4b60-a7a4-9f143f=
814a83&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A>=
=0D=0A>=2001-08=2014:20:59.639+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcU=
RL=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttps://protect2.fireeye.com/v1/url=
?k=3Df87c18a1-99f70d81-f87d93ee-74fe485fb347-c814b1991fd237fe&q=3D1&e=3D853=
dee28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonlin=
e%2Fstatus.html=5D=0D=0A>=0D=0A>=20In=205th=20trial,=20its=20response=20was=
=20normal=0D=0A>=2001-08=2014:21:19.969+0900=20curlRequest(1299)=20>=20=1B=
=5B0;33mcURL=20RESULT=20=5B0=5D=20with=20URL=20=5Bhttps://protect2.fireeye.=
com/v1/url?k=3D66d84b4d-07535e6d-66d9c002-74fe485fb347-fb5c65c2e4b54654&q=
=3D1&e=3D853dee28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttp%3A%2F%2Fipv4.connman=
.net%2Fonline%2Fstatus.html=5D=0D=0A>=0D=0A>=0D=0A>=20May=20I=20know=20the=
=20reason=20and=20how=20to=20avoid=20CURL=20error=207?=0D=0A>=0D=0A>=20BR=
=0D=0A>=20Wonyoung=20Lee=0D=0A=0D=0A--=0D=0APrincipal=0D=0ANuovations=0D=0A=
=0D=0Agerickson=40nuovations.com=0D=0Ahttps://protect2.fireeye.com/v1/url?k=
=3D388f8bc2-59049ee2-388e008d-74fe485fb347-0ca97d824587a917&q=3D1&e=3D853de=
e28-cd77-4b60-a7a4-9f143f814a83&u=3Dhttps%3A%2F%2Fwww.nuovations.com%2F

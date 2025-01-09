Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423DB677
	for <connman@lists.linux.dev>; Thu,  9 Jan 2025 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388532; cv=none; b=LtZS4qIlyIGBv2gClQAESqaGrYvGXJOd80bGKvHlkAYYwyf0fUaxKWnjCwmnqdRcUUZOX4paKpuYOXhShQ2x0de6D1P49EdRdE+Hy6lKmI+GzZi/5Y1TqZScqK/edWTlYH4drLCa+GYCQww7WIEhlN9vagufOr+qQa2theW5dSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388532; c=relaxed/simple;
	bh=XY6nKLJPS6dFdxqttijr7ohwdndAueySRoHyZotA9L0=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=N2KUyiNhLO482kezAY68T8rOK99TianWH9Pe4M0DwwCjaoI5+OCLw0hrQ116/oaWjTwJWhtSmw8xapSsk14fFmrAxqv8uiRFq977zJcJ6mN6+vRT62+1xwquUFyvGYuJAtw3dIbKn+nVIeJmMWS9kEa8/Ekaaycl2IpeXnyExsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K1X3peV9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K1X3peV9"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250109020841epoutp03e5d6ca49748ad83cba602b2b7f01cdc4~Y5CkaPiQf2422724227epoutp03D
	for <connman@lists.linux.dev>; Thu,  9 Jan 2025 02:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250109020841epoutp03e5d6ca49748ad83cba602b2b7f01cdc4~Y5CkaPiQf2422724227epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736388521;
	bh=XY6nKLJPS6dFdxqttijr7ohwdndAueySRoHyZotA9L0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=K1X3peV9ft0i0Rbw5Ef27x+jHLy//TDzvfUmnULZjeJ4l4hu3Gx02QMo+IdzXdVrz
	 ejKzwZGxBLnME+ArgaLGdcyeUm9amNSrhWJZ29TiV8jFap3nApoTQOi6hNhKgbvO+/
	 hTwVOAfv4Q4xG0w6GlzqRiriDroDlfWkOI4QPx+o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250109020841epcas1p13090fbda6f6afac762373557e8da7002~Y5CkHIOZ70834808348epcas1p1d;
	Thu,  9 Jan 2025 02:08:41 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YT7Vw22Zxz4x9Pv; Thu,  9 Jan
	2025 02:08:40 +0000 (GMT)
X-AuditID: b6c32a4c-ad1fe70000007bf7-1b-677f2fa8e799
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.4F.31735.8AF2F776; Thu,  9 Jan 2025 11:08:40 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: RE: Query about ipv4 connman url
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "gerickson@nuovations.com"
	<gerickson@nuovations.com>
CC: =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5@epcms1p3>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250109020839epcms1p35b4f4fa626da03ed7b6e5a20b0fb2aff@epcms1p3>
Date: Thu, 09 Jan 2025 11:08:39 +0900
X-CMS-MailID: 20250109020839epcms1p35b4f4fa626da03ed7b6e5a20b0fb2aff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmvu4K/fp0g1vnuCw+bImzeDu3hcni
	4LMbjBbfPv1idGDxWL97ObvHi80zGT3edu9m8ujbsooxgCUq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITujfcMl5oL1ahWLnn1gaWC8otLF
	yMEhIWAi8fK5eRcjF4eQwB5GiZ9nlzOBxHkFBCX+7hDuYuTkEBbQlNgw6wwTiC0koCCx5vx+
	NpASYQFLiX8HREBMNgFzifNrskEqRATmM0oc/6EHYjMLmErsWzOZEcSWEOCVmNH+lAXClpbY
	vnwrWJxTwE9i+amrUDWiEjdXv2WHsd8fmw8VF5FovXeWGcIWlHjwczdUXEri8PWLbBB2scSO
	LYehaiokunt2s0LY5hLH9j4Hi/MK+Ep8W3iPFeRkFgFVibeXoMa4SDy7/5Ed4mRtiWULXzOD
	lDADPb5+lz5EmE/i3dceVphPdsx7wgRhq0i8P/CTDeaaB88/QX3oIbHl/V9GSLhOZZTomHWL
	aQKj/CxE0M5Csm0WwrYFjMyrGKVSC4pz01OTDQsMdfNSy+ERmpyfu4kRnOK0fHYwfl//V+8Q
	IxMH4yFGCQ5mJRFeS9nadCHelMTKqtSi/Pii0pzU4kOMpkCvTmSWEk3OBybZvJJ4QxNLAxMz
	I2MTC0MzQyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamIoK9Bm/Cnjd11nG+N90i4tp5JmK
	wPCngqnlvpIbnRoP37r6Ls+KS0yCqbRc5KfIA5tpy+2mze6Yxfo1Q8sruHjb2zt3/t1849V0
	r5ynh/UeB+vX+x+c3V/Eq4YLuSd95F23bM+TEB+7DeICbPbTW/+wLX623eXhuedPgp+d1ju6
	vEQ77OTK9ZbWbY6iNYdueCY6vmsyeX7Dnv3fb6/K41u/Ou/KXXzq5fNm/8V35B9n1Z1/tNeq
	7PBCgV0lCiG9Fyfar9Xo6p/D+b44M7hu21MW/4aFxWUzXdPaNm5JMsz6emNy8F0zv8vNncFZ
	bddqbzWeeHPY937GDC/WTTZHeJNXvZ0p8e/jyRxd1zm83kosxRmJhlrMRcWJAOOSCkz6AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10
References: <20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5@epcms1p3>
	<CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p3>

Dear Grant Erickson,

As you said, cURL RESULT =5B7=5D in the debug log is status code 7 of curl.
This issue had not happened before 7th Jan(KST) with the same version of my=
 software and the same network env.
And it is experienced not only by me but also by others.
So I am wondering the reason why it surddenly starts to response status cod=
e 7
Is it possible to check the reason on the server side?

BR
Wonyoung Lee

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
On Jan 8, 2025, at 12:21=E2=80=AFAM,=20=EC=9D=B4=EC=9B=90=EC=98=81=20<wy111=
5.lee=40samsung.com>=20wrote:=0D=0A>=20I=20am=20testing=20connman=20on=20Ti=
zenplatform=20with=20the=20following=20URLs=20=22https://protect2.fireeye.c=
om/v1/url?k=3D4ccfcac0-2d44dff9-4cce418f-000babffae10-994c06701b573d69&q=3D=
1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman.ne=
t%2Fonline%2Fstatus.html=22=0D=0A>=20However,=20I=20often=20get=20the=20cur=
l=20errorwhen=20calling=20above=20URL=20like=20below.=0D=0A>=0D=0A>=2001-08=
=2014:17:39.029+0900curlRequest(1299)=20>=20=5B0;33mcURL=20RESULT=20=5B7=5D=
=20with=20URL=5Bhttps://protect2.fireeye.com/v1/url?k=3D7ffd22e2-1e7637db-7=
ffca9ad-000babffae10-eee25d3176242b54&q=3D1&e=3Dbee29355-a62c-420a-8105-985=
5865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A=
>=0D=0A>=2001-08=2014:20:07.949+0900curlRequest(1299)=20>=20=5B0;33mcURL=20=
RESULT=20=5B7=5D=20with=20URL=5Bhttps://protect2.fireeye.com/v1/url?k=3D48f=
1bda2-297aa89b-48f036ed-000babffae10-3fee45b801578822&q=3D1&e=3Dbee29355-a6=
2c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstat=
us.html=5D=0D=0A>=0D=0A>=2001-08=2014:20:34.189+0900curlRequest(1299)=20>=
=20=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=5Bhttps://protect2.fireeye.=
com/v1/url?k=3D5bde5bcd-3a554ef4-5bdfd082-000babffae10-5851179a5d5da000&q=
=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2F%2Fipv4.connman=
.net%2Fonline%2Fstatus.html=5D=0D=0A>=0D=0A>=2001-08=2014:20:59.639+0900cur=
lRequest(1299)=20>=20=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=5Bhttps:/=
/protect2.fireeye.com/v1/url?k=3D586e64ab-39e57192-586fefe4-000babffae10-47=
741276e19feaa4&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3Dhttp%3A%2=
F%2Fipv4.connman.net%2Fonline%2Fstatus.html=5D=0D=0A=0D=0AFrom=20the=20'cur=
l'=20man=20page,=20shell=20statuscode=20=E2=80=987'=20seems=20to=20be:=0D=
=0A=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A07=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0Failed=20to=20connect=20to=20host.=0D=0A=0D=0Aand=20wo=
uld=20indicate=20that=20thev4.connman.net=20host=20may=20be=20unreachable.=
=20Can=20you=20confirm=20that=20is=20the=20case=20whenyou=20see=20status=20=
code=20'7'?=0D=0A=0D=0AHistorically,=20Marcel=20has=20need=20toprovision=20=
more=20capacity=20or=20make=20other=20tweaks=20to=20the=20servers=20to=20ac=
comodateshifts=20in=20load=20or=20usage.=20That=20may=20or=20may=20not=20be=
=20the=20issue=20here.=0D=0A=0D=0ABest,=0D=0A=0D=0AGrant=0D=0A=0D=0A--=0D=
=0APrincipal=0D=0ANuovations=0D=0A=C2=A0=0D=0A---------=20Original=20Messag=
e=20---------=0D=0ASender=20:=20=EC=9D=B4=EC=9B=90=EC=98=81=20<wy1115.lee=
=40samsung.com>SmartThings=EA=B0=9C=EB=B0=9C=EA=B7=B8=EB=A3=B9(DPC)/=EC=82=
=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0ADate=20:=202025-01-08=2017:21=20(GMT+9)=
=0D=0ATitle=20:=20Query=20about=20ipv4=20connman=20url=0D=0A=C2=A0=0D=0ADea=
r=20Connman=20maintainer,=0D=0A=0D=0AI=20am=20testing=20connman=20on=20Tize=
n=20platform=20with=20the=20following=20URLs=20=22http://ipv4.connman.net/o=
nline/status.html=22=0D=0AHowever,=20I=20often=20get=20the=20curl=20error=
=20when=20calling=20above=20URL=20like=20below.=0D=0A=0D=0A01-08=2014:17:39=
.029+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcURL=20RESULT=20=5B7=5D=20wi=
th=20URL=20=5Bhttp://ipv4.connman.net/online/status.html=5D=0D=0A=0D=0A01-0=
8=2014:20:07.949+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcURL=20RESULT=20=
=5B7=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/online/status.html=5D=0D=
=0A=0D=0A01-08=2014:20:34.189+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcUR=
L=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/online/statu=
s.html=5D=0D=0A=0D=0A01-08=2014:20:59.639+0900=20curlRequest(1299)=20>=20=
=1B=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttp://ipv4.connman.ne=
t/online/status.html=5D=0D=0A=0D=0AIn=205th=20trial,=20its=20response=20was=
=20normal=0D=0A01-08=2014:21:19.969+0900=20curlRequest(1299)=20>=20=1B=5B0;=
33mcURL=20RESULT=20=5B0=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/online=
/status.html=5D=0D=0A=0D=0A=0D=0AMay=20I=20know=20the=20reason=20and=20how=
=20to=20avoid=20CURL=20error=207?=0D=0A=0D=0ABR=0D=0AWonyoung=20Lee

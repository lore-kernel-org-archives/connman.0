Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD39463
	for <connman@lists.linux.dev>; Mon, 13 Jan 2025 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735147; cv=none; b=UVnUGai4brgB5HY51alGmDUSjOQ0mE9YFzJfxs8QVtWCUyn6iHiiKyntUcS13vYptWY/rxfNcL+7s1ZC1n+9MAK6BEa7qJmbasLYCm/WpMHRXHvHWAuvtEq5tLEue+0ULniGbSJ7w1FHox/MMo3D2Rz7yvjxzCawxjlcrCJJkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735147; c=relaxed/simple;
	bh=UOBt5qD4SXpnydhEzKHC/oifsXT6vrxCFJDRcRVwdWQ=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=RMpzeWMybehCp0fQGPL4xsl2hZ6D4Kj3SvykUA42xnFbpK/nGqwdJGrT91+ffrrSWLPozqzj+JG8g0Ge735MCKwNfEEE7Qf4me15V6zo6pEQIvzwHHaAw2UPbTfu1xr42xl0P4v5fV8VBKGSn3ywO0r9MC4sFpmdd5ZD85r7Afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WFqbk/ON; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WFqbk/ON"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250113022536epoutp029b3021f5f82de94f4f89c0e66b102aaa~aH2eaPfzK1721217212epoutp02C
	for <connman@lists.linux.dev>; Mon, 13 Jan 2025 02:25:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250113022536epoutp029b3021f5f82de94f4f89c0e66b102aaa~aH2eaPfzK1721217212epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736735136;
	bh=UOBt5qD4SXpnydhEzKHC/oifsXT6vrxCFJDRcRVwdWQ=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=WFqbk/ON8H1X72P807y5xhmdducLjWN2Fq1WUjctFwPfRZV67XV+IPSqOI4creaMD
	 bRwXcEPmYP323FPfQmjVpqbbms5Sil+6fqOYPhacNr9jq9afR8cOpLkqnFR/shYDCz
	 YuOzJQMHA1VKwKWQ6pC38Cbcjc8RohlwdsSPkLbk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20250113022535epcas1p4445cc3e693531ec8b1a6fb14e063369f~aH2eK-mu70411904119epcas1p4F;
	Mon, 13 Jan 2025 02:25:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YWbhZ6ZrZz4x9QB; Mon, 13 Jan
	2025 02:25:34 +0000 (GMT)
X-AuditID: b6c32a37-17dea70000005b53-c3-6784799d1c7e
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.A5.23379.D9974876; Mon, 13 Jan 2025 11:25:33 +0900 (KST)
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
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250113022533epcms1p528f3b6b01aadaf75e214c2769dca6c95@epcms1p5>
Date: Mon, 13 Jan 2025 11:25:33 +0900
X-CMS-MailID: 20250113022533epcms1p528f3b6b01aadaf75e214c2769dca6c95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmvu7cypZ0g56n4hYftsRZvJ3bwmRx
	8NkNRotvn34xOrB4rN+9nN3jxeaZjB5vu3czefRtWcUYwBKVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ3x+/4t5oK36hVP1j5lamD8p9rF
	yMkhIWAice7YGfYuRi4OIYEdjBIHH95j6mLk4OAVEJT4u0MYpEZYQFNiw6wzTCC2kICCxJrz
	+9lASoQFLCX+HRABMdkEzCXOr8kGqRARmM8ocfyHHojNLGAqsW/NZEaITbwSM9qfskDY0hLb
	l2+FiotK3Fz9lh3Gfn9sPlRcRKL13llmCFtQ4sHP3VBxKYnD1y+yQdjFEju2HIaqqZDo7tnN
	CmGbSxzb+xwszivgK3G3ayPY9SwCqhJzZh9igqhxkdjTuoIJ4k5tiWULXzODvMIM9O36XfoQ
	YT6Jd197WGHO3zHvCVSrisT7Az/ZYM558PwT1FseElve/2WEBFSgxKsFj9knMMrNQgTnLCTL
	ZiEsW8DIvIpRLLWgODc9tdiwwBgeg8n5uZsYwUlMy3wH47S3H/QOMTJxMB5ilOBgVhLhfSPY
	mC7Em5JYWZValB9fVJqTWnyI0RTozYnMUqLJ+cA0mlcSb2hiaWBiZmRsYmFoZqgkznvmSlmq
	kEB6YklqdmpqQWoRTB8TB6dUA9PxAKGW8l2b6wX0bS9u5PwlGjGn3cIw3Wqls5vQUu+tOyZ4
	BVj/XJ0qf6qjtu5u1yGO8o0BD712RE79LSd8+9vuN7G+v/tYe4x4Fxm+2VG86uCtBsd/Nbb8
	6/1P2PgvFmBe3vHUxFmj9J5cx0lm/iDRq0ZTdwS1Oudbnw7Ynlf6L6lfeomHKmdezuIJ7+PF
	HI4L+TuU7J+2vt+jRqrD0yk24fb8yUKlVcs1+q5/2vFHqCphxs7XM+P//e91XbPYz+7brzkz
	PSJq/Rf8U95x6/2005PnnDmj4fHkf92BjTI7f9Xa5/54EmymnRvYqPXx7kFb5ZOzM+Qk/TQe
	fl+1LTa/wem5faElxzXJma7fDiqxFGckGmoxFxUnAgClPFAM6wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10
References: <CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p5>

Dear Grant Erickson,

Kindly remind for this topic.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

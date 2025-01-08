Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8113B288
	for <connman@lists.linux.dev>; Wed,  8 Jan 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324517; cv=none; b=jc6Pw3RKt8HPEsa0qay0Q+D4Z0H4l42ldx90tKeSLNKa91xyDf3JOrKOwkQNEr0xUf1URvqZXuzSXopdvtthGMnC5qAX7TjYy6hGKj7kBZD7vXrP3Ua4HmznKdico77aSgrno2SjfNOk6/bXgluEJMwHGBHK7hBHl+fxNQ2Cpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324517; c=relaxed/simple;
	bh=F0xFZxGsZfZB2k7JMAfO1wpkU98UaNdj7NCm7Rol+h0=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=UsjFo4izR1QF/6uPSWEQzXTIp370+HyN0Mxqtkv85E3KnvhQ++ZTp+3PrhVvoN8IWC3g4SF9rA6KZQsYRvEqc8P/MKnxN5rMtS50qvpc1qDyfW4TPtEZ0c4XqRgGcZ0JnWzA99bpRTiepIHBgfTUESiop4eOz+f8S19RK9089c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C47pNm9v; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C47pNm9v"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250108082151epoutp036c4bf5f06cef56c624cb6dee358a313c~YqfGcT_Dw1211412114epoutp03u
	for <connman@lists.linux.dev>; Wed,  8 Jan 2025 08:21:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250108082151epoutp036c4bf5f06cef56c624cb6dee358a313c~YqfGcT_Dw1211412114epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736324511;
	bh=F0xFZxGsZfZB2k7JMAfO1wpkU98UaNdj7NCm7Rol+h0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=C47pNm9vm/8biILOcsNvReUNsn6IPb8nhKHFTBNQ3Qv9nqWGmhk9XGz5OOClBqARr
	 Z0YkK2xMjrYRQw7lu/FWG2Syt2t/EOCY9XxpSGibNFCWoB1tZfjrRg0w0f0Psq4Yv3
	 wneJCSF6vhdDtBfiYTdAob47xmCoKBJSz43X4xyI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20250108082151epcas1p4337e13cf43d9ab58c1618f91a639cc44~YqfGNFJQp1147011470epcas1p4j;
	Wed,  8 Jan 2025 08:21:51 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.145]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YSgqy5JwGz4x9Pr; Wed,  8 Jan
	2025 08:21:50 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-21-677e359d0146
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.C6.23869.D953E776; Wed,  8 Jan 2025 17:21:49 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: Query about ipv4 connman url
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>,
	"marcel@holtmann.org" <marcel@holtmann.org>
CC: =?UTF-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5@epcms1p3>
Date: Wed, 08 Jan 2025 17:21:48 +0900
X-CMS-MailID: 20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmge5c07p0gz3fOCw+bImzOPjsBqPF
	t0+/GB2YPdbvXs7u8WLzTEaPvi2rGAOYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
	DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
	TAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM3a/nshccI6zomH2K/YGxk7OLkZODgkBE4nXUx6y
	dzFycQgJ7GCUOPhoPnMXIwcHr4CgxN8dwiA1wgKqEoeunGEGsYUEFCTWnN/PBlIiLGAp8e+A
	CIjJJmAucX5NNkiFiECaxMpFnWwgNrOAqcS+NZMZITbxSsxof8oCYUtLbF++FSouKnFz9Vt2
	GPv9sflQcRGJ1ntnmSFsQYkHP3dDxaUkDl+/yAZhF0vs2HIYqqZCortnNyuEbS5xbO9zsDiv
	gK/Eqwk/wHpZgD45d+wr1C4XiSvTutgh7tSWWLbwNdjjzAKaEut36UOE+STefe1hhTl/x7wn
	TBC2isT7Az/ZYM558PwT1FseElve/2WEBFSgxIHOfvYJjHKzEME5C8myWQjLFjAyr2IUSy0o
	zk1PLTYsMILHYHJ+7iZGcMLSMtvBOOntB71DjEwcjIcYJTiYlUR4LWVr04V4UxIrq1KL8uOL
	SnNSiw8xmgK9OZFZSjQ5H5gy80riDU0sDUzMjIxNLAzNDJXEec9cKUsVEkhPLEnNTk0tSC2C
	6WPi4JRqYMoLDNMKXrwzaef0Tw5rbrhubti+jqc0IH4Sz883+w5pM6vNmF2h86PPdXGEDNuy
	K94nI6SmMPx9f3f1moi+u1w5e/n2WEovq5yTrtx5QOXLHavud44ML9asc91W52OSIO12lt3l
	tSxf2K047pUfV5idaSsX3h3/Z+LixJiExM1Tiw/d55EqO5mxz0atYOplGcu9E3yvvbtksWRF
	0a0HXctO7trWcn6FUElvX9RDrrcvGdNevs3JmLViyr5pHB224asuHDlUcoKrYVmshli8Y3XT
	gq9rDDNmirz8Jjoh9V3g3sgpLxO6xRX1WNcGvPBk3H3+r0du4HS5pqCG5uocse/CK50q219O
	O2B7c2mF2hQlluKMREMt5qLiRACK0fTy4QMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10
References: <CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p3>

Dear Connman maintainer,

I am testing connman on Tizen platform with the following URLs =22http://ip=
v4.connman.net/online/status.html=22
However, I often get the curl error when calling above URL like below.

01-08 14:17:39.029+0900 curlRequest(1299) > =1B=5B0;33mcURL=20RESULT=20=5B7=
=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/online/status.html=5D=0D=0A=
=0D=0A01-08=2014:20:07.949+0900=20curlRequest(1299)=20>=20=1B=5B0;33mcURL=
=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/online/status=
.html=5D=0D=0A=0D=0A01-08=2014:20:34.189+0900=20curlRequest(1299)=20>=20=1B=
=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttp://ipv4.connman.net/o=
nline/status.html=5D=0D=0A=0D=0A01-08=2014:20:59.639+0900=20curlRequest(129=
9)=20>=20=1B=5B0;33mcURL=20RESULT=20=5B7=5D=20with=20URL=20=5Bhttp://ipv4.c=
onnman.net/online/status.html=5D=0D=0A=0D=0AIn=205th=20trial,=20its=20respo=
nse=20was=20normal=0D=0A01-08=2014:21:19.969+0900=20curlRequest(1299)=20>=
=20=1B=5B0;33mcURL=20RESULT=20=5B0=5D=20with=20URL=20=5Bhttp://ipv4.connman=
.net/online/status.html=5D=0D=0A=0D=0A=0D=0AMay=20I=20know=20the=20reason=
=20and=20how=20to=20avoid=20CURL=20error=207?=0D=0A=0D=0ABR=0D=0AWonyoung=
=20Lee

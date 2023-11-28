Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BC7E8
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ApVEHaVO"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231128064604epoutp0453a69a075336d10e51768abd6909bd5d~btoSc5r_P1880118801epoutp04b
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 06:46:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231128064604epoutp0453a69a075336d10e51768abd6909bd5d~btoSc5r_P1880118801epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701153964;
	bh=qWpzNbpainInhOgR/mfCBgmJmnuWOG7vxOUwdYPO2XI=;
	h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
	b=ApVEHaVO47ReRM3tBuNqeyJoibe+QhKC8Qou6fFevBuoebip1uVy4uTvVMxuO9iRd
	 Hgd5Mt7ZdtthccZk5gW0eTEQ3T9rDI3chqmhArx4wJVjSlwg27t1kJwPbaF6GfcSa4
	 S6wfSyBpGbYrADIS4AC3jwH6Itev2d7fm/lj6+U0=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231128064604epcas1p266f0a33a8ccad9d1fc73d68c8e23098b~btoRpMRRC0612406124epcas1p2B;
	Tue, 28 Nov 2023 06:46:04 +0000 (GMT)
X-AuditID: b6c32a35-eabff70000002610-64-65658cab7d3e
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.CD.09744.BAC85656; Tue, 28 Nov 2023 15:46:03 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: Query about ipv4 connman web page
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231128062351epcms1p15c1bd5c840503579f22a7d9887c49606@epcms1p1>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231128064603epcms1p425b92ba530ab3632c5763bb901118105@epcms1p4>
Date: Tue, 28 Nov 2023 15:46:03 +0900
X-CMS-MailID: 20231128064603epcms1p425b92ba530ab3632c5763bb901118105
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCmge7qntRUgwk9ZhYftsRZzO1vY7V4
	tGImo8XfVU9YHFg8XmyeyejRt2UVYwBTFJdNSmpOZllqkb5dAlfGuf4tzAVNzBUHjk5ibmDc
	wdTFyMkhIWAi8eZcOzOILSSwg1Gi52JuFyMHB6+AoMTfHcIgYWEBLYmDl2YwQZQoSKw5v58N
	pERYwFLi3wEREJNNwFzi/JpskAoRgRyJCbdXsUIM55WY0f6UBcKWlti+fCsjiM0p4Cfxfv5F
	qBpRiZur37LD2O+PzWeEsEUkWu+dZYawBSUe/NwNFZeSOHz9IhuEXSyxY8thqJoKie6e3VAz
	zSWO7X0OFucV8JX4fGMf2HwWAVWJff07oR53kdj24i3YHGYBbYllC18zg7zCLKApsX6XPkSJ
	osTO33MZIUr4JN597YF7a8e8J1BjVCTeH/jJBnPag+efoN71kJg1bz8jJNCmMkpMf8s5gVF+
	FiJoZyFZPAth8QJG5lWMYqkFxbnpqcWGBYZ6xYm5xaV56XrJ+bmbGMFJQMt0B+PEtx/0DjEy
	cTAeYpTgYFYS4dX7mJwqxJuSWFmVWpQfX1Sak1p8iFGag0VJnJf5UW+KkEB6YklqdmpqQWoR
	TJaJg1OqgWnyvxUT/DZIOyRn7trr//nfc/40pV11Yd+iv5ks4L8t27fiq++q/n7RxrRbjxef
	eaDHr/R8af3kKQwXdSa0XN2os6rqCt+55HLvz2blk+5uv1kfcnxG/Ow9+Xt9eBcwlEw2Z2r7
	kv4oaDbbnYtKh/jjrKW2xF8XvC3c9eeQ53auM6/O92/qLl+u726s3sy4Yv/6T6c3vb/seXTd
	puevzk5d7X9w17aeUxkPe+/Ob/G8c9Ivc2rMjX9vNjVoC30Ty1txxvrtwpc/yq+IXfjD2St7
	Z9ahRaFtRpeig1Rbc2WYvkzluKaV1a4nKTF1e0UB3xufF1MS/2Xd4j5zosLbP2ayZ+qdGrOe
	uq5Jvw40sz0/r8RSnJFoqMVcVJwIAHSYnW5xAwAA
X-CMS-RootMailID: 20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69
References: <20231128062351epcms1p15c1bd5c840503579f22a7d9887c49606@epcms1p1>
	<CGME20231128052502epcms1p4a229137cf6d9bb65b8e463a873688e69@epcms1p4>

Dear Connman maintainer,


I am testing connman on Tizen platform with the following URLs
=22http://ipv4.connman.net/online/status.html=22
=22http://ipv6.connman.net/online/status.html=22


But when I test CURL GET request to those URLs, the response is CURLE 28 (C=
onnection timeout)
Could you help to fix those web service?



BR
Wonyoung Lee


=C2=A0=0D=0A=0D=0A

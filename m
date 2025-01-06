Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF040C8DF
	for <connman@lists.linux.dev>; Mon,  6 Jan 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736129404; cv=none; b=Mdl6W/yaUC34WMxUuw7EH4EYI0sTVQt+g6sFC8ExEBCfM9q7pDgZ1GiEqSUc+GK807tox9ZnnWesrK2By94RRZxDkLLKVA5ckgieTeJWEOU+isY2/u5vjBa10Hj3dF6DpXBgBdHtzZH573bMjaCEUmLZ5iaM2MTu+a+AoD85T4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736129404; c=relaxed/simple;
	bh=Ehkf9NxGmgIksMeIanh/2cku11YIzIJcszuAnA8zBFM=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=IEwj+p0Yxpm7pZGPaLUnaIlG+4sbyHQNN1mcMRxudMGiL/Iwnh9JOaAbeSWY8t3Phr0+TSnjlAlfP4zqNIxuA/ZPucmeGFIFAUg3tQxJpc2HXQuyO7mrfX/5SZdwVJu8zYsfVfKNklvU0HdVKsefyoQQ498hEiBqOjnl+8f4Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Axjrj4ZV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Axjrj4ZV"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250106020959epoutp01631e239abf0035b66218048522dd94cf~X_H2i6lF82088420884epoutp01V
	for <connman@lists.linux.dev>; Mon,  6 Jan 2025 02:09:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250106020959epoutp01631e239abf0035b66218048522dd94cf~X_H2i6lF82088420884epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736129399;
	bh=Ehkf9NxGmgIksMeIanh/2cku11YIzIJcszuAnA8zBFM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=Axjrj4ZV9jfu+nkInbkHMqW1zZqZc8z8jneTajMY7heYPAjOhDG6nENyJFkJOw9BT
	 cP55IePvZi1vm5+UOKR0n6EZFHbbKq2srQu8+4jPkO4kEVe2I9rsxNB8q7hmO29yuJ
	 K8B3g5Ouec9lynya1wJvIVdi1XQreGUjVvPWyJUg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250106020959epcas1p3f3b61ffd737c04f2088c15190d31f0cc~X_H2YpCFj1156811568epcas1p3P;
	Mon,  6 Jan 2025 02:09:59 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YRHgq1S5yz4x9Q2; Mon,  6 Jan
	2025 02:09:59 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-10-677b3b7742d6
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.7F.23253.77B3B776; Mon,  6 Jan 2025 11:09:59 +0900 (KST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Subject: Send again due to delivery etiquette [Query about ipv4 connman web
 page]
Reply-To: wy1115.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "connman@connman.net"
	<connman@connman.net>, "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Grzegorz Zakiewicz <g.zakiewicz@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9@epcms1p5>
Date: Mon, 06 Jan 2025 11:09:58 +0900
X-CMS-MailID: 20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmvm65dXW6wbMPHBa75/xnsfiwJc5i
	65KH7BbfPv1idGDxWPppP7vH+t3L2T1ebJ7J6NG3ZRVjAEtUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGvW1PGQvmMlW0fZnJ0sD4gLGL
	kZNDQsBEovPAL5YuRi4OIYEdjBK3zqwBSnBw8AoISvzdIQxSIywQLLFgyjWweiEBBYk15/ez
	gZQIC1hK/DsgAmKyCZhLnF+TDVIhIjCZUeLSanOQMLOAgcTGrYIQi3glZrQ/ZYGwpSW2L98K
	dYCoxM3Vb9lh7PfH5kPFRSRa751lhrAFJR783A0Vl5I4fP0iG4RdLLFjy2GomgqJ7p7drBC2
	ucSxvc+ZIf7wlZi4mw8kzCKgKnFl+1eoVheJyY17wdYyC8hLbH87hxniYk2J9bv0IcJ8Eu++
	9rDCXL9j3hMmCFtF4v2Bn2ww1zx4/gnqKw+J7T9uQYMpUGLusausExjlZiECcxaSZbMQli1g
	ZF7FKJZaUJybnppsWGAIj7/k/NxNjOAEpmW8g/Hy/H96hxiZOBgPMUpwMCuJ8GZpVKYL8aYk
	VlalFuXHF5XmpBYfYjQFenMis5Rocj4wheaVxBuaWBqYmBkZm1gYmhkqifOeuVKWKiSQnliS
	mp2aWpBaBNPHxMEp1cBUbKG/61aKv3/nhYJtk2NDdyQ3rtlSfuWRwbt1Wwozl218y5x9Rf/e
	z608+zs2sySUxinf9Pgp+S7b9X72+T1J677fcMvjNjO2PX8jqCfvUWWbM9sHt9+CyTKJDMsm
	L+jZ/S6VrS6vWzZSVPbo9V9n1uSfXnwrfXq/c83FZifvBRoLRHR2qXjG1n6t7pohYvUta/Wr
	rD3zxPNa7+td7Jo2X7r8Nq/foaxVSbq7RJeaWmxvZdvzWT54vqdPXLXAvl+lx76vvJ9UvuSd
	2eRpQYXX/Lg+nGfmXFC3Obtq1loTz0jnMz1vJnJfZTNI+GA+VYlVSv6sWLDw4qttvpxdi5PN
	l01d9G6bXaJ9mvHCxw+VWIozEg21mIuKEwEEcjaG6QMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9
References: <CGME20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9@epcms1p5>

Dear Connman maintainer,



I am testing connman on Tizen platform with the following URLs "http://ipv4.connman.net/online/status.html"

Result Status: 200 OK with empty body



As far as I remember, the response has body text in the response before.

Could you check it?

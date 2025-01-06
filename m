Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E9C8DF
	for <connman@lists.linux.dev>; Mon,  6 Jan 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736129529; cv=none; b=MvkEArw1nP27Q9OZQQXFr5Xa5CgPKCXpIGEFyqp3oos5lQ9E0TvxZX69iOw/CHlFm4WbgmJa3OZreeKaAof0pvM9/GVfD8UOpaZShxL9ZZZUZOZCCuh5aVDFjCxi6G+zTNMOQdPvzVOmJiaABdrOtvZVy0uZBdB4tWXV0wqQLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736129529; c=relaxed/simple;
	bh=Ehkf9NxGmgIksMeIanh/2cku11YIzIJcszuAnA8zBFM=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=tcy32WeF3YoFcYE+4sn3y78WS+E5v8/gB0qpFQ4PNbSYH5oE0D1ZEQAdhhokvJZjkF1d4BhkuwlD9JTTqCWYwJ+p6ZWDCAEppHwV4TKAmpVYqahCoKXdaGju+4Emcf3Hi0zi4NKxhPmLI8HP2V6LNYzKrWw242XixMmyJIoeXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qaBujD4B; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qaBujD4B"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250106021205epoutp04f0f7192a6d9876197ac78a29e27328cf~X_JrYZlWa1139211392epoutp04s
	for <connman@lists.linux.dev>; Mon,  6 Jan 2025 02:12:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250106021205epoutp04f0f7192a6d9876197ac78a29e27328cf~X_JrYZlWa1139211392epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736129525;
	bh=Ehkf9NxGmgIksMeIanh/2cku11YIzIJcszuAnA8zBFM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=qaBujD4B1qHfbDvmcNds9zLIfaRXJm+Mp199yMGnmO8EHcoIAHo555s5c1dZI7Tva
	 szinl1WgiNjy1gJbEMADPmMcGFyH1NonlxplUg9pAaqzDsvivehvNwgzRKKHoPMzbn
	 XjVO/XeIhsSu1tD2yIcwRndaT2nfkI2cQ8/jDt30=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250106021205epcas1p31cde5fec0b4ba9d7e45453042bf29f2a~X_JrI0Y-n2832628326epcas1p3r;
	Mon,  6 Jan 2025 02:12:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.132]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YRHkD3TSQz4x9Q9; Mon,  6 Jan
	2025 02:12:04 +0000 (GMT)
X-AuditID: b6c32a37-171e970000005b53-f7-677b3bf44750
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.E7.23379.4FB3B776; Mon,  6 Jan 2025 11:12:04 +0900 (KST)
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
To: "marcel@holtmann.org" <marcel@holtmann.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
CC: Grzegorz Zakiewicz <g.zakiewicz@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250106021204epcms1p8d2c0f0211503bc768cf2703096f67a3e@epcms1p8>
Date: Mon, 06 Jan 2025 11:12:04 +0900
X-CMS-MailID: 20250106021204epcms1p8d2c0f0211503bc768cf2703096f67a3e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7bCmge4X6+p0g8MHpC0+bImz2LrkIbvF
	t0+/GB2YPdbvXs7u8WLzTEaPvi2rGAOYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
	DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
	TAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM+5te8pYMJepou3LTJYGxgeMXYycHBICJhKvni1m
	ArGFBHYwSvw/r9/FyMHBKyAo8XeHMEhYWCBYYsGUa4wQJQoSa87vZwMpERawlPh3QATEZBMw
	lzi/JhukQkQgTaJl8zxWkDCzgIHExq2CEHt4JWa0P2WBsKUlti/fCrVfVOLm6rfsMPb7Y/Oh
	4iISrffOMkPYghIPfu6GiktJHL5+kQ3CLpbYseUwVE2FRHfPblYI21zi2N7nzBB/+Eo0TzEA
	CbMIqEpMbLoNdYKLxKJbH8FsZgF5ie1v5zBDXKwpsX6XPkSYT+Ld1x5WmOt3zHvCBGGrSLw/
	8JMN5poHzz9BjfSQ2P7jFjSYAiVWXv/PPIFRbhYiMGchWTYLYdkCRuZVjGKpBcW56anFhgXG
	8OhLzs/dxAhOVVrmOxinvf2gd4iRiYPxEKMEB7OSCG+WRmW6EG9KYmVValF+fFFpTmrxIUZT
	oDcnMkuJJucDk2VeSbyhiaWBiZmRsYmFoZmhkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1M
	DyZlRPS4sWxhMWBafMbPwl2uZNUD3Uaz0+tVTzyRSb1ot2Ryu8budWd8vNbrWvwP3nFgJ9O7
	5Ydvq06P0PlYc2tTfsBJjdY6q41TSpxD6uebcYZ92NyglHV454SIpz3FGxlzf5hM+cesZnxS
	pkGi7McplpNSW+PcjbnY1E7u+rW3R1Luwh2dC1bmiVZm0t9OeOkwTrwdHRK8+ciubR/mRhjL
	Ck/TuKxy4B+D7ve16kaOPZfn/tNXWx9z2dFDpLx2l5jBvMATulZRTLEln7Tarnz3Mp/wZ1fA
	yq77ZUv7FgQeE8r99uEj36opT1Q2p5lM8PGUW/Lp4IaZ8v8WTjR3mHNpIadP0x22T+48sVov
	lViKMxINtZiLihMBuAA+gt4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9
References: <CGME20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9@epcms1p8>

Dear Connman maintainer,



I am testing connman on Tizen platform with the following URLs "http://ipv4.connman.net/online/status.html"

Result Status: 200 OK with empty body



As far as I remember, the response has body text in the response before.

Could you check it?

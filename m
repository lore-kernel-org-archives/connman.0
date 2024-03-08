Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAE173
	for <connman@lists.linux.dev>; Fri,  8 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908611; cv=none; b=V3gD48kvRZKNo9UVLFgi8fZSTPIJPY45sxnDI3wa0ZkzzM0wbxzr1kG1pA1u/VinIik7OQ51hEtPQJnrLlT1HZDpz5EX7p8MhnXVtXAnh7YtyeH4gaWjcFw6oPS1+213jRfimoGvzxDJTSplrebMoBFNSxN9qigfjWiuIqFX7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908611; c=relaxed/simple;
	bh=o+pI6goGlNb5Q63p1HbeuLhPKFSrla/73vdFpBsAlPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ajBxn6chgfiiRAfrg0HpYKbjai5hfXj8kAbZXmYuPAyNeZf7uSiJDdVhm7ze1+57BxRHRoIlCuHwqUn7ISMuQOBQcApGIChwn2E49pER5Xd7ZdAyMpHK91LxH1+H1UU8s5WjYuiODOzVq54zbvwvFGMphvaTT3KWWvCX9tzmPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=twzyH8Ec; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="twzyH8Ec"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240308143646euoutp012cbbf287e2529cab480af85ad1ee29f7~60NF66Nk60570505705euoutp01b
	for <connman@lists.linux.dev>; Fri,  8 Mar 2024 14:36:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240308143646euoutp012cbbf287e2529cab480af85ad1ee29f7~60NF66Nk60570505705euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709908606;
	bh=KOBwWSSdKwWI+mb/p4Rm7Hs1C/Jr8vgCrh+4+9MISDo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=twzyH8EcvslEHvenqHTVJxUQKdbRKEBz8q7JUb/1Ri/eHSSFiQT+1C2RS8fF40S26
	 1NxX1q095KuLpr51W416wF97CH9Le5vK4whSe1PVtcX/5TqMFFHkGxMaLoju7l+xVe
	 p+9kRL1YDM6xHAMdDVBIcmk3xP2R7KcyPQAf3jSo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240308143646eucas1p1b32914cfa43985a3fc54d8854781074d~60NFpaFAy1625716257eucas1p1Z;
	Fri,  8 Mar 2024 14:36:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.C1.09552.E722BE56; Fri,  8
	Mar 2024 14:36:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240308143646eucas1p27188a613c06f17d0cca6e239622d5ee7~60NFTS1Od2099020990eucas1p2B;
	Fri,  8 Mar 2024 14:36:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240308143645eusmtrp2b1f7742c7d42154235f63942ac4e01fd~60NFSCAU-2310823108eusmtrp2r;
	Fri,  8 Mar 2024 14:36:45 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-20-65eb227e0cf4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DE.06.10702.D722BE56; Fri,  8
	Mar 2024 14:36:45 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240308143645eusmtip2341958d5d92028620f5752cbed7005c7~60NFHwhRz1705217052eusmtip2V;
	Fri,  8 Mar 2024 14:36:45 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: connman@lists.linux.dev
Cc: m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] Ignore network devices used by NBD
Date: Fri,  8 Mar 2024 15:36:30 +0100
Message-Id: <20240308143630.2195695-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7p1Sq9TDbb3C1h82BJn0fhpLrPF
	zUMrGC3WHrnL7sDi8WLzTEaPvi2rGAOYorhsUlJzMstSi/TtErgy+lY3sRfM5Kz4e38xUwPj
	evYuRk4OCQETiXdblzCC2EICKxglFrT6dDFyAdlfGCX+7p7ABOF8ZpR419rGCtMxa9szVojE
	ckaJVe23mCGcF4wS5//vBpvFJuAo0b/0BFiHiIC0xJ8fN4D2cXAwC5RKvP9lChIWFjCWuNMz
	B+wMFgFVieN/ZjCD2LwCthIXF59lASmXEJCXWPxAAiIsKHFy5hMWEJtfQEtiTdN1MJsZqKR5
	62ywEyQEJnJI/Ni7lRHiUBeJG9tnQ9nCEq+Ob4F6WUbi/875TBAN7YwSTVcWskI4ExglPnc0
	MUFUWUvcOfeLDeJoTYn1u/QhDnKUWN3MC2HySdx4KwhxA5/EpG3TmSHCvBIdbUIQM1Qk1vXv
	YYGwpSR6X62AusZD4sP1jywTGBVnIflsFpJvZiGsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0
	L10vOT93EyMwVZz+d/zrDsYVrz7qHWJk4mA8xCjBwawkwsti8TJViDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgSnyh+mctSwrwz1i9TmifJ8k+lUuPCt5
	RjBygURM3K50qYUr1/GWPVVoePXvas7nBDl3pWeFQo9yMkVl1mWoTXOPF18aHS52+5DUzN0q
	Pts/VnUcZNV3vWlrtmb9NaklepsMzuyRTov4Z+PT9y2QUUyT5R6v6oarDVP6H8kf22oScVZ3
	c76Nb0TL5c4iM+PotmuX3QXius4/E/17agVnjv5GoyvrP6tZ5oWuV5RP/aaVtewRSwiPwqaC
	bEuuiP2+VvEnjk+7nXXwmN2K5VkOKg6+k5pTr0z4YPFg/pb6lxeWS5k4RWjU6bB48Wqtcq+c
	5Cfd8uTShQcLE3ur9Ez6/Fys2BbKxCc8n5Cu9kpBiaU4I9FQi7moOBEAwueMxIQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t/xe7q1Sq9TDf6ss7D4sCXOovHTXGaL
	m4dWMFqsPXKX3YHF48XmmYwefVtWMQYwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehl9K1uYi+YyVnx9/5ipgbG9exdjJwcEgImErO2PWPtYuTi
	EBJYyigx688Nxi5GDqCElMTKuekQNcISf651sUHUPGOU2LfsCjNIgk3AUaJ/6QlWEFtEQFri
	z48bYEOZBcolPjXfZwGxhQWMJe70zAGLswioShz/MwOsl1fAVuLi4rMsELvkJRY/kIAIC0qc
	nPkELMwsoC6xfp4QSJhfQEtiTdN1Fojp8hLNW2czT2AUmIWkYxZCxywkVQsYmVcxiqSWFuem
	5xYb6RUn5haX5qXrJefnbmIEBvq2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrwsFi9ThXhTEiur
	Uovy44tKc1KLDzGaAj0wkVlKNDkfGGt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Yklqdmp
	qQWpRTB9TBycUg1MMbvVakMjudWVLzD8sT+Tr1Lre+VefZtNo+V/xTf9Tx25z0t7f91lJH8m
	4sX8f7/ObTAqfpDgYHfsQ8wlA02BA0pCf7P2bH2ywXfXkhWHS5fonrovEa1/b/rMOd2y87h8
	rpu+nxd8S79WeP8KPkPB2ZdCDM2fx/mm+JRmL46e8yXOmMGvN8ukRCeiN+Me98ev/5ZcqA7+
	GmDad0B4QonZ2euiTMpsb99Ftdy2CJxjZpx6iKs0141fsWbazh2ue7TkJ3bqypi0P7lZa8XI
	XBm7t/DPLav72dLvWbavWzFTZVH+g3OJ4stDrsh6HpKv6U/69/+QjnS2VGyK/zkmZS6uaeHs
	W/pljaLyHvx46a7EUpyRaKjFXFScCAB3OzHK/QIAAA==
X-CMS-MailID: 20240308143646eucas1p27188a613c06f17d0cca6e239622d5ee7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308143646eucas1p27188a613c06f17d0cca6e239622d5ee7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308143646eucas1p27188a613c06f17d0cca6e239622d5ee7
References: <CGME20240308143646eucas1p27188a613c06f17d0cca6e239622d5ee7@eucas1p2.samsung.com>

Add support for ignoring devices used by NBD to mount root the same way
ConnMan ignores devices used for NFS roots. nbdroot= nbddev= parameters
are used by Debian and Tizen initramfs scripts to configure NBD for
mounting as root device.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 src/inet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 8a1e3423..5032cf25 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -5086,6 +5086,10 @@ static int get_nfs_server_ip(const char *cmdline_file, const char *pnp_file,
 	for (pp = args; *pp; pp++) {
 		if (!strcmp(*pp, "root=/dev/nfs"))
 			break;
+		if (!strncmp(*pp, "root=/dev/nbd", strlen("root=/dev/nbd")))
+			break;
+		if (!strncmp(*pp, "nbddev=", strlen("nbddev=")))
+			break;
 	}
 	/* no rootnfs found */
 	if (!*pp)
@@ -5095,6 +5099,8 @@ static int get_nfs_server_ip(const char *cmdline_file, const char *pnp_file,
 	for (pp = args; *pp; pp++) {
 		if (!strncmp(*pp, "nfsroot=", strlen("nfsroot=")))
 			break;
+		if (!strncmp(*pp, "nbdroot=", strlen("nbdroot=")))
+			break;
 	}
 	/* no nfsroot argument found */
 	if (!*pp)
-- 
2.39.2


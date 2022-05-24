Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E47F4
	for <connman@lists.linux.dev>; Tue, 24 May 2022 09:59:27 +0000 (UTC)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220524095335epoutp02da277ff02e3e5f567b82a1e35ca2741f~yAdIbibDE2133621336epoutp02B
	for <connman@lists.linux.dev>; Tue, 24 May 2022 09:53:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220524095335epoutp02da277ff02e3e5f567b82a1e35ca2741f~yAdIbibDE2133621336epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1653386015;
	bh=/crxtonkEonK8MzJC4bf/h5bboPLOUYvlIkz2bSyFHA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=E99xVFHyMnbG8/YgbMvn0cUei7VtOsbbbfK0X2ZezKRxVZDCz42vhMshm08MDg21L
	 aTQ3XssEuHXRIc0Tiao177gVOB1r3hE66DgMpPSIKWQ93ofm32HmebIN8vb8YSplat
	 hnglMie8DY2G/0YZHFIqk+qqXwPJ+LtDj/dyX2II=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220524095333epcas1p292eac1cfdc71bbf700ac0ac6449ed296~yAdHXX7YM2804328043epcas1p2e;
	Tue, 24 May 2022 09:53:33 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4L6qJs32Zwz4x9Q0; Tue, 24 May
	2022 09:53:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.A3.10063.D1BAC826; Tue, 24 May 2022 18:53:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20220524095332epcas1p43ec50919c2e0eac3b3b87c64b7c526ca~yAdF17qgW0289202892epcas1p4d;
	Tue, 24 May 2022 09:53:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220524095332epsmtrp2c9518d6e6ae4cd75d63c05794ad51617~yAdF0-ZUn1573815738epsmtrp2L;
	Tue, 24 May 2022 09:53:32 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-20-628cab1d2e47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.72.11276.C1BAC826; Tue, 24 May 2022 18:53:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220524095332epsmtip2bef8f8292d90b4f980674c974cb1ffa0~yAdFpLhzG1813118131epsmtip2F;
	Tue, 24 May 2022 09:53:32 +0000 (GMT)
From: Seung-Woo Kim <sw0312.kim@samsung.com>
To: connman@lists.linux.dev
Cc: sw0312.kim@samsung.com, jeik01.kim@samsung.com
Subject: [PATCH] wispr: Prevent use-after-free from __connman_wispr_stop()
Date: Tue, 24 May 2022 18:59:21 +0900
Message-Id: <20220524095921.13971-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmnq7s6p4kg3snhCw+bImzOLqK02LG
	5JdsDsweLzbPZPTo27KKMYApKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
	LzE31VbJxSdA1y0zB2iFkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3
	uDQvXS8vtcTK0MDAyBSoMCE7Y+3RkIKznBVdszawNjC2c3QxcnJICJhIbD+/hamLkYtDSGAH
	o8S0X99YQRJCAp8YJZqvGEDY3xglJm526WLkAGvo+RkIUb+XUWLO2pPMEM4XRol3PbPYQBrY
	BHQk9i/5DTZIREBa4s+PG+wgNrOAkcS9njtgNcICXhKT2w6B1bAIqEosWH8YrIZXwFpi5o9L
	LBDXyUtc2HCLFSIuKHFy5hMWiDnyEs1bZ4MtlhCYzi6xvGkHG0SDi8TbuTsYIWxhiVfHt7BD
	2FISn9/tZYNoaGaUeP/sFiOE08MosWHaAqh1xhL7l05mAvmTWUBTYv0ufYiwosTO33MZITbz
	Sbz72sMKCQpeiY42IYgSFYmdRyexQYSlJGZtCIYIe0h0fDrGDAnEWIkV7XNYJjDKz0Lyziwk
	78xC2LuAkXkVo1hqQXFuemqxYYEhPEqT83M3MYLTmJbpDsaJbz/oHWJk4mA8xCjBwawkwpsS
	1pMkxJuSWFmVWpQfX1Sak1p8iNEUGMATmaVEk/OBiTSvJN7QxNLAxMzI2MTC0MxQSZx31bTT
	iUIC6YklqdmpqQWpRTB9TBycUg1Mxv0cLhdiayVcm868i4rL+ty26MAbrrK/9ZEN83TWWn7Z
	dP6DnMHEE+drlKeGfi7/KS12mG/xe5PeA9NPfe15Xdd14+/9Q07Ooo/vr5ii91FfVtq+r+Nx
	UOcFf/9Ms+Szz4pNvsf+Dd9TxiZ///fTr9Mz/r86JDlbafnzic89dTnWRzws3P1vxnKjlwU3
	vWubv2R+3vRw58Ej78Ik3lzf98Z1bjnbglaeGS8v6ygL7FJ9zqD29eVmx/y8lESP/I+tH0pD
	nszZuGBJ2IPa1abte4LmshrrBehUTy9eWhpc7SD/bq7Edve5Md1+hg1Hn8351pfA32Qe7fp7
	QbDnSVFP44QLby/o/hPV1mPfsOL2XCWW4oxEQy3mouJEAPRjErfsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LZdlhJXldmdU+SwflT/BYftsRZHF3FaTFj
	8ks2B2aPF5tnMnr0bVnFGMAUxWWTkpqTWZZapG+XwJWx9mhIwVnOiq5ZG1gbGNs5uhg5OCQE
	TCR6fgZ2MXJyCAnsZpSYP40PxJYQkJKY+207I0SJsMThw8VdjFxAJZ8YJe5Pf8sKUsMmoCOx
	f8lvMFtEQFriz48b7CA2M9DIWbcvMoHYwgJeEpPbDoHVsAioSixYfxishlfAWmLmj0ssELvk
	JS5suMUKEReUODnzCQvEHHmJ5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFi
	bnFpXrpecn7uJkZwWGlp7mDcvuqD3iFGJg7GQ4wSHMxKIrwpYT1JQrwpiZVVqUX58UWlOanF
	hxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDZSDSLnbq19XFip+NV0+KllyzZni5b
	lOFwT2HRiZnLzmwSybELmR5e7uhdvqSnwyGwe+9P3fMlW3/V2T1ZpvtcUi3l0feFPhEiiptD
	j84zzZe9xy/evPGcrfClli0RDwpvbI4IfOZ35s+uYCm//Tavv+XoT7DvUrB+9jp95vJP7VbK
	V49d/C6qxfPybqiof1WnTzP3h5/SzksK3XLfzO38fzDyztqXZidEhbmfZ3C11Yj9OMm0vn37
	04x/C265f5s1ibO3+e3795ql30RYv3v8qxC7KxvtGeKSzzQ1L+/AuV/dD35Ybneqb+Kb6cGQ
	cUJMqirwUN/HaTfvzRKKsf1YNs9Zh3XNgYb2f4v1DeYqsRRnJBpqMRcVJwIA4RscCpoCAAA=
X-CMS-MailID: 20220524095332epcas1p43ec50919c2e0eac3b3b87c64b7c526ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220524095332epcas1p43ec50919c2e0eac3b3b87c64b7c526ca
References: <CGME20220524095332epcas1p43ec50919c2e0eac3b3b87c64b7c526ca@epcas1p4.samsung.com>

From __connman_wispr_stop(), list element wispr_portal freed by
g_hash_table_remove() is accessed. Prevent the use-after-free by
accessing the list element before free.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 src/wispr.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 22ecd937e1fe..7d4a3f54b24b 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1038,17 +1038,11 @@ void __connman_wispr_stop(struct connman_service *service)
 	if (!wispr_portal)
 		return;
 
-	if (wispr_portal->ipv4_context) {
-		if (service == wispr_portal->ipv4_context->service)
-			g_hash_table_remove(wispr_portal_list,
-					GINT_TO_POINTER(index));
-	}
-
-	if (wispr_portal->ipv6_context) {
-		if (service == wispr_portal->ipv6_context->service)
-			g_hash_table_remove(wispr_portal_list,
-					GINT_TO_POINTER(index));
-	}
+	if ((wispr_portal->ipv4_context &&
+	     service == wispr_portal->ipv4_context->service) ||
+	    (wispr_portal->ipv6_context &&
+	     service == wispr_portal->ipv6_context->service))
+		g_hash_table_remove(wispr_portal_list, GINT_TO_POINTER(index));
 }
 
 int __connman_wispr_init(void)
-- 
2.19.2


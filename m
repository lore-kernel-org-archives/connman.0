Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BA153812
	for <connman@lists.linux.dev>; Mon, 26 Aug 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672047; cv=none; b=Pt/EM8as+fDzuhQWf1dWrWupRQSg8iVVvlDGQiTKfSpQSc4K5kKK/DJM9OPBWf8rkl89lga/FZqYi5G7Hkfmd79q5U/l1GyeZ9q81GOyY+eA6/Kh1reHr0tfg2yoUfgURXomiZ+0K7YL/s2ezLyKGmksgfBBxXTfjOSiT/eXN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672047; c=relaxed/simple;
	bh=bZQWG+IV4eyJ2mIguYX/Bcu6sbR0+2nml3c1Z5vOGwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=FZ7srQ2K28TrECeBzsZhJA5K+OrOxqMlp1u/+SnCKiY2N/IhkPZ4smIgleGcOhoB74MqeOC9cb1WoX3sAEnjboRm6nBwRxzgmfuV4U8e/5KpTkRblnQ/ueJAcmUvoRyOlx4fphWDPoMDIAvke+JHQHE4fNRUPmdYtZu0+V/R9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tUfxKKnC; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tUfxKKnC"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240826113403epoutp04fdd2a7e9f886d4fbda6c1340b6aa788c~vRBXlj42A3183231832epoutp04j
	for <connman@lists.linux.dev>; Mon, 26 Aug 2024 11:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240826113403epoutp04fdd2a7e9f886d4fbda6c1340b6aa788c~vRBXlj42A3183231832epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724672043;
	bh=/gRKrveYq7IBU3cAbbNXA/Dk4qS+MHwwNs+zkVwyP+0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tUfxKKnCUKJKM0h8oOuWcsUiG8ociOMoo8qkmF3+K9q0QmdJZBV3Z2vbMUCdApdXd
	 GyhGBE5c9BkHj3F1+M/fioiVJxA6OYsepnxPLc39bcuIJ/oDa9SpejQoOaNYzwZX3n
	 ZIcorxWFhsVerP8a/woHVZQtTSWaY139q4iSnV5I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240826113402epcas1p2c046ba1e0049310a9a351344d016d9e8~vRBXT-zfg1550415504epcas1p23;
	Mon, 26 Aug 2024 11:34:02 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WspV14h8Zz4x9Pp; Mon, 26 Aug
	2024 11:34:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.AA.08992.9286CC66; Mon, 26 Aug 2024 20:34:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240826113401epcas1p32f1a3cbc1306e7545b235d515343c62c~vRBV4e1on2471424714epcas1p3N;
	Mon, 26 Aug 2024 11:34:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826113401epsmtrp1cd5b8d752a82fa8eab54ac283d4eec64~vRBV3XK6i0135501355epsmtrp1j;
	Mon, 26 Aug 2024 11:34:01 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-57-66cc6829911f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.02.08456.9286CC66; Mon, 26 Aug 2024 20:34:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826113401epsmtip2029aee23e52bea8854037adbc816fdc6~vRBVriO4v0413304133epsmtip2R;
	Mon, 26 Aug 2024 11:34:01 +0000 (GMT)
From: Seung-Woo Kim <sw0312.kim@samsung.com>
To: connman@lists.linux.dev, denkenz@gmail.com
Cc: wangfe@nestlabs.com, sw0312.kim@samsung.com, dh79.pyun@samsung.com
Subject: [PATCH] dhcp: clear c_gateway and c_prefixlen before remove
Date: Mon, 26 Aug 2024 20:33:57 +0900
Message-Id: <20240826113357.1794-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmnq5mxpk0g+uXlCw+bImzmPFf0WLJ
	949sFjMmv2SzOPbrMbMDq8fOWXfZPV5snsnosbV7IptH35ZVjAEsUdk2GamJKalFCql5yfkp
	mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
	pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGdO+OxVM5qq4/LqDqYFx
	KUcXIweHhICJxMGFQl2MnBxCAjsYJVrbJbsYuYDsT4wS83YcY4ZwvjFK9O59xwZSBdJwaeMn
	NojEXkaJZVeOQ1V9YZQ4/+g2O0gVm4COxP4lv1lBbBEBPYnrz36AxZkF3CTOnPjP2MXIziEs
	4CKx1hUkyiKgKvFqYyMziM0rYCWxftlbqF3yEhc23GKFiAtKnJz5hAViirxE89bZzBA1u9gl
	bu7lgrBdJFq2TGGEsIUlXh3fwg5hS0m87G9jBzlTQqCZUeL9s1uMEE4Po8SGaQtYIKqMJfYv
	ncwEChZmAU2J9bv0IZbxSbz72sMKCS1eiY42IYhqFYmdRyexQYSlJGZtCIYIe0i8a7/EDgnQ
	WIlVr/eyTGCUm4Xkg1lIPpiFsGsBI/MqRrHUguLc9NRkwwJDeCQm5+duYgSnNC3jHYyX5//T
	O8TIxMF4iFGCg1lJhFfu8sk0Id6UxMqq1KL8+KLSnNTiQ4ymwDCdyCwlmpwPTKp5JfGGJpYG
	JmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwTdxrob41Z57jH3WnmJIzYSfb
	+S2+l7eeOK/opiq8VsdDZOU5/o9bO8SWrYpS+LmBxarmiP+Pf75Riycf+BVun75YpH7nmTjn
	PSuOWu+MU7NzUTzBrTp7o3FCW7TEA6+Xs2fMCk0oqk6eZB55bn1Dc4/SgzP1YW7rLgQ5bv/+
	wN/w6pU5zxbXHm2fwV68sfzkCS/WpE59E9O5IjcdRVzXngi6bTnpo9KNKwfLX6rMfmWebLhh
	ZcKXk+n7VWPn6e0rFkvkYN2W9LWjje+Y3Bur1JPb9mxM+pu//pf2vAe1qwXb914t5K7v47q8
	JCey5cJyVz6VbcJcqw7k5jGdk1cquui134n95WOpOX4SicqcSizFGYmGWsxFxYkAJ5ysG/ID
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSvK5mxpk0g3kf+Cw+bImzmPFf0WLJ
	949sFjMmv2SzOPbrMbMDq8fOWXfZPV5snsnosbV7IptH35ZVjAEsUVw2Kak5mWWpRfp2CVwZ
	0747FUzmqrj8uoOpgXEpRxcjJ4eEgInEpY2f2LoYuTiEBHYzSjRNucACkZCSmPttO2MXIweQ
	LSxx+HAxRM0nRonLU76wg9SwCehI7F/ymxXEFhEwkPj38RcziM0s4CXx9dchoF52DmEBF4m1
	riBRFgFViVcbG8EqeAWsJNYve8sGsUle4sKGW6wQcUGJkzOfsEBMkZdo3jqbeQIj3ywkqVlI
	UgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHn5bWDsY9qz7oHWJk4mA8xCjB
	wawkwit3+WSaEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxS
	DUxLzppnzGu80/2x58unMrcMG/YFvXPWd6us7bP/tPVFVsBMuzmye4xiF6ytmWw9JcWmPX+J
	yF8OyXss/4/ff6rCxhJQ2JcRVb35/knpqg2Xt57cPX/Tm0tKe9mCw/e2/M1irhS8qmrWembR
	Da0FRTaC7yJ9OOZenflkj75X+b9Ff04vP3XPo3OyQKDs2ofrBd54HNjfu3t+kPYUlSNfoz98
	uLVxViKPsFtCvqCJD8/NpstSW/kYknwYbU6dN+Vc+SvRd+ll3eo3+043dy3sWX3th1jAujYm
	y00TpZbytrMXcgmJPNn8+nfpqZchKxWc2Eslf5UKqxv9Oy8by+vTcbkoougTZ6RNfH/coi2b
	ToQrsRRnJBpqMRcVJwIAYtn4za4CAAA=
X-CMS-MailID: 20240826113401epcas1p32f1a3cbc1306e7545b235d515343c62c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826113401epcas1p32f1a3cbc1306e7545b235d515343c62c
References: <CGME20240826113401epcas1p32f1a3cbc1306e7545b235d515343c62c@epcas1p3.samsung.com>

Before calling __connman_ipconfig_address_remove(), for specific
ipconfig->method cases, clear c_gateway and c_prefixlen to
prevent use-after-free.

Fixes: d593e995c7c7 ("dhcp: Remove old IP and gateway address")
---
 src/dhcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/dhcp.c b/src/dhcp.c
index 18dbab27151a..c84f1de410fb 100644
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -471,9 +471,17 @@ static void lease_available_cb(GDHCPClient *dhcp_client, gpointer user_data)
 
 	DBG("c_address %s", c_address);
 
+	old_method = __connman_ipconfig_get_method(dhcp->ipconfig);
+
 	if (g_strcmp0(address, c_address)) {
 		ip_change = true;
 		if (c_address) {
+			if (old_method == CONNMAN_IPCONFIG_METHOD_AUTO ||
+			    old_method == CONNMAN_IPCONFIG_METHOD_DHCP) {
+				c_gateway = NULL;
+				c_prefixlen = 0;
+			}
+
 			/* Remove old ip address */
 			__connman_ipconfig_address_remove(dhcp->ipconfig);
 		}
@@ -487,7 +495,6 @@ static void lease_available_cb(GDHCPClient *dhcp_client, gpointer user_data)
 	} else if (prefixlen != c_prefixlen)
 		ip_change = true;
 
-	old_method = __connman_ipconfig_get_method(dhcp->ipconfig);
 	__connman_ipconfig_set_method(dhcp->ipconfig,
 						CONNMAN_IPCONFIG_METHOD_DHCP);
 
-- 
2.19.2


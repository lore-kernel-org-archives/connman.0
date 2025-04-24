Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D3223DEE
	for <connman@lists.linux.dev>; Thu, 24 Apr 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494781; cv=none; b=CTPYTY0rNqskfG0st8x8Hc5vR3rMmaItXK6AA4zAyir/5Tlt69V9KiUtLwQcUa+TojVEGfm/wjU1XGX6G4lpXGXsKPeXhnfEcWvzHMVl7OCwRBLC5VNntqjMaexJte+29v7k1Uf2urS/wj9wGEa2NUi0lm+mehY4LlE0csUcpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494781; c=relaxed/simple;
	bh=Jzjd4K+MQBj1PK++Cr5jTRo+djW1JttLKsYxP8NCTJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmdSx9gABUqcDD9EjPufCOtPXhsNGqZOrf/EjF2ub9DeAcjY5Y1Wj48EvcqRHMQyNKVkpNOVLBNFstxU7TjyDR0R2nHUsn4HqhS8VGjNWGc5GUBlpv7XzYCPCSrVbwIgbC/oX++95OtOHPiYjxAXr1J2wIJyWV16tBVPog23OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O3nvHK005713
	for <connman@lists.linux.dev>; Thu, 24 Apr 2025 04:39:38 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhat6pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <connman@lists.linux.dev>; Thu, 24 Apr 2025 04:39:38 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 04:39:37 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 04:39:35 -0700
From: Praveen Kumar <praveen.kumar@windriver.com>
To: <connman@lists.linux.dev>
CC: Praveen Kumar <praveen.kumar@windriver.com>
Subject: [PATCH] dnsproxy: Fix NULL/empty lookup causing potential crash
Date: Thu, 24 Apr 2025 11:39:29 +0000
Message-ID: <20250424113929.1748926-1-praveen.kumar@windriver.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5fOgyWCOFSweOMd_TpHXZy949YhMymx-
X-Proofpoint-ORIG-GUID: 5fOgyWCOFSweOMd_TpHXZy949YhMymx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3OCBTYWx0ZWRfX8sr3EaKl1yGD 7tipGwo+0JbKT/mZtZRpuBwVo6MRKsAEjA8A+TE5SH1fAP+L6YPyCXvh+lap8S61VNhHdMgB0G4 TiAYmh0MXODzStTHrLgG4ppugZkhxRoZeN6IrfFYDOytHgvYXQW+nr3wgYK45WyYV9zFUC+g82+
 uULAs0p3ZiTqXHCpljCKnr9Pb0KER6a8Onx/5kHQOzhzN/Xn8F2snlCoqX3yO4wczwHpRk6F8FD j1GuQA2P1y1VPaYrx4QdnQlLfMKAQVnIEReO5rarjqveriGZDMdpM90vEyMAyutt2JmC/gVd2kN Lcybkv9cTkeGlMa/Y3e99DYArMwxWRNdE5SnUkMxIch3CAMh7AZosbSYoH/UNpcpFX/UkmDvSGy
 fCW5t9crgBrEGGNkjsJZ9ha981mi6zeui8iPvwPuptncMZ0nCadZZI5ctuANJ1SZZE7Mo2QD
X-Authority-Analysis: v=2.4 cv=Sa33duRu c=1 sm=1 tr=0 ts=680a22fa cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=LfCRiSK6E2ommS8cWT4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 mlxlogscore=991 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240078

In ConnMan through 1.44, the lookup string in ns_resolv in dnsproxy.c
can be NULL or an empty string when the TC (Truncated) bit is set in
a DNS response. This allows attackers to cause a denial of service
(application crash) or possibly execute arbitrary code, because those
lookup values lead to incorrect length calculations and incorrect
memcpy operations.

This patch includes a check to make sure loookup value is valid before
using it. This helps avoid unexpected value when the input is empty or
incorrect.

Fixes: CVE-2025-32743

Signed-off-by: Praveen Kumar <praveen.kumar@windriver.com>
---
 src/dnsproxy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index f28a5d75..15917eda 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1686,6 +1686,10 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 {
 	int sk = -1;
 	const char *lookup = (const char *)name;
+
+	if (!lookup || strlen(lookup) == 0)
+		return -EINVAL;
+
 	int err = ns_try_resolv_from_cache(req, request, lookup);
 
 	if (err > 0)
-- 
2.40.0


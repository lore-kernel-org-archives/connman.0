Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442311;
	b=mdtQHrNVrz65bIJdgEIPas36ziWcRN+Egw1ozt6mg/dIUJYM+XPJw816C8cks1PP3OVd
	 JSiGqIJ/l2W5vddN7Qc01p+eDysvC1IEnjwRME57Ha765d0BbSLFScw8+ZhaLz/bfy2sk
	 bsHyHVJKUFVbZBrR+fLPl9lQNzjTIbqL5TkHF3MLglFxqraGsQDnbDg7PO6PoT5UaPYsO
	 q1wj/kIMBBVrYq8Tmxo5RdzYWScfFTMOLodKkrUScIDuqVSlItKd1XkjBZaj+ryRPnpVm
	 KtSgPSdwprmzcXo/6p6f7T6WO1RwKcesxcV7uECinbClx4vpWUT04gEaZ7Am4hztIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442311;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=7PTRdKnbN286N6eRGYJOBl7FrPUnnEKuyQZ96RFy5pc=;
	b=p/AM0XGQnHWN6mhnxFttruLG9hlZ5cBUR+v90dYwRc+j2NoCYA6FYPykVvx16VPmdlzb
	 UVPs25N2s1bPhkRX3TVsTPF6uJCYT/Fjz6itMijoXo1Nb7OrS6PDxcyk5RCPU6vVOHxX3
	 bEnDL0QUuVngxUZJ9a09+Pt1frmQNOOwvl8Sxl5melAq3auzljWy31xnPysrVHsps5xok
	 H04ic9dD8carJvLhLlwTUvD8bLOLqce+/f/U/HY8vHiPFkrCUptO4Z28Hq3BG6Q1nQ+vy
	 fh4foQS0T/wsInlGIWMuEeqIGJtR/loOrwbXaqSPMM1GvVuxHfcA2dynF4KBiW6+yhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=IIbsM+DH;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508F606A31C
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 00:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6508F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=IIbsM+DH
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8AFC616004A;
	Wed, 11 Nov 2026 19:11:49 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 29FB8124C53;
	Wed, 11 Nov 2026 19:11:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] gateway: Fix lost default gateway demotions
Date: Wed, 11 Nov 2026 16:11:47 -0800
Message-ID: <20261112001148.1610052-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=7PTRdKnbN286N6eRGYJOBl7FrPUnnEKuyQZ96RFy5pc=; b=IIbsM+DHkWQvUAc8/MET9ynxGMsG5dRIm3Rbsbvgd7W4RIX3O7e19pGbihHBIrHp2FU48FL3i5Ydx3tusOWdFk4X12qFDHEMygVxmJmvbzGkIvnECX1RbZ3MIMmyeBKa14aatIyqZ0FUICTtl5nAQ9zl2PITDo5ZWFQTII5zHuYH0n3MMh5OJbl2Tsp/htjeAGSPJ5nDtf7ldFgMV9I9HS6LqizUYNFzhB9SDZZ0TysBIn0GdYCauDSSbC9ZIn79rCIPBiqqf5K51eV1iCyXJGqJVXuKjhQlZCYPJ5eom9YJ36imOrl59Q512iYDJ24m/k877L0o+8PombODwU/ywg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

__connman_gateway_update demotes the default route of every active
gateway other than that of the default service and then, if any
demotion succeeded, promotes the default service's gateway. However,
each demotion overwrote rather than accumulated the outcome:

    updated4 = status == 0;

Since low-priority default routes were introduced, every connected
service's gateway is active. Demoting a gateway that is already
low-priority fails with -EALREADY, so whichever gateway the hash
iteration visits last decides. With three or more connected services,
a failed demotion of a junior service erases the successful demotion
of the former default before it. The new default's gateway, still
active at low priority, is then not promoted, there is no high-priority
default route, and, since only a promotion calls
__connman_service_indicate_default, the new default service is never
signaled as such and is not online checked.

This is how a service that meets the continuous online check failures
threshold, for example Ethernet behind a failed upstream, is sorted
below the Wi-Fi and cellular services but remains the only service
with a default route, while the Wi-Fi service, now first, stays
"ready" indefinitely.

Accumulate the outcomes, as before low-priority default routes, so that
any successful demotion promotes the default service's gateway.
---
 src/gateway.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index b2c211e2dc8d..2314ddb126bf 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -3957,7 +3957,8 @@ bool __connman_gateway_update(void)
 			status = DEMOTE_DEFAULT_GATEWAY(current_gateway,
 						type);
 
-			updated4 = status == 0;
+			if (status == 0)
+				updated4 = true;
 		}
 
 		type = CONNMAN_IPCONFIG_TYPE_IPV6;
@@ -3969,7 +3970,8 @@ bool __connman_gateway_update(void)
 			status = DEMOTE_DEFAULT_GATEWAY(current_gateway,
 						type);
 
-			updated6 = status == 0;
+			if (status == 0)
+				updated6 = true;
 		}
 	}
 
-- 
2.52.0


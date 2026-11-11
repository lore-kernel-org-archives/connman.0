Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440030;
	b=j2zRVOe1guRwCAyvSs3JIgnUeGZE6ZsmHK91Pqh21WcqqF4U9V8qBto/Yr9tMjsGl6z4
	 mxVt2s/V+8fTYJzf71phYxoadw6Oib5kIRYGcK5ZK719us9MpNI2HQ5+KGOx2u6qT/7u8
	 7Eh5XB8I12L6t9tEL/82sroa3V7keXPk/RtwUSuxtkd1ciZpunDtZpWN9r49b/VNzE9yP
	 NMMD/jIncP9HJpZ2ALY++lWbs5M5uLZCdErdu25LDg/fb0Y88s8JEFs/37cGD5gkh5p7s
	 mg/T9Hv3j1JPl2rdu1ccuSon1Ryc4aCbzvyrzi4edPZv0Es1DgiaxmjiwzKzbIpqZog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440030;
	h=DMARC-Filter:Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:To:
	 X-Mailer:DKIM-Signature:X-Scanned-By;
	bh=Ya2e75XAZ/Qo84MM/Ruf7AydrX0gIAYjiXVwS4g0F4Q=;
	b=NGNF05gdQbtKVLOuHo1iMGuMdGbC2lUPrvYZpZJwiJCnRIx1DMg04ID4H5D8NfZW10+x
	 ubKR3MP44WmoFr4lV6tJrJGlJpR3KqgWN2E0UjhNGeaOejfTC+45wAFCcQQKD3BmoHi0w
	 U3gMvZnHPomy+I87T2np2LLlWYH80AMaDioiGXJ/dgz+EU7oXC6lD5I+Tujrj2Y0grQV+
	 eUgU9HTdki+2+p2S8oJ0R/29nj0krI6VG32fR4qsHOovZxpQWLZFzkHAYty+X6Wh0l+n7
	 3r/lsuaN+Y1qDKcP6h909FJxMQ7PJBScfeXysrU/bD7WdrGklDnwS/XE7drjFzmwulQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=DyTmkcWC;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AE606A326
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 23:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33AE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=DyTmkcWC
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6387C1602AB
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 18:33:42 -0500 (EST)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 26D5D124C7B
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 18:33:42 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.4\))
Subject: wispr: Leaks Redirect URLs
Message-Id: <8028821B-69D5-4ED9-9B43-E54008775B4E@nuovations.com>
Date: Wed, 11 Nov 2026 15:33:31 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3864.700.51.1.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=Ya2e75XAZ/Qo84MM/Ruf7AydrX0gIAYjiXVwS4g0F4Q=; b=DyTmkcWCptR+Ob15sOAHuAx8HAYiGOkP/vDEHEtNVwxCJnuNRcgAge4nOZTAZTECUB8ETVlEJhURaSD4v5FQyUccEQb7AlK3bHja4oqcp2urh2ZUMc6OpOhFJ8+pUNIXRdcOmXLzy9AllLyy24/92Me3PUL5e7WUGx+CLA8I2CWnQjIuxLDbx/Fm/vHbHuuQfTR/6r4Uq6teTiG1A7eWb0SbwT+uapqeUZZZg+440AF/FYqvc+cxAJWu/VR+6o+aeON5bH0AAlXSiatLtO+mXTjsjTZ4XaZlk/8Bs5vOF1js0DarjOdVydrX9qWCJshusVWuhKhgh6yBag+zhyflaQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Team Connman:

    https://github.com/Nuovations/connman/issues/148

Patch forthcoming.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


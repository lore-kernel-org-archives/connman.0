Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B21BDE6
	for <connman@lists.linux.dev>; Mon, 19 Aug 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102130; cv=none; b=kKGAPKk9TjompuYdO9eD+Y09sDiRM3/hX6qXtsQIlIVWEug29a97UrM+0onuGkbbIYTEYtqsxHQHW07Vm0zod7T09+FXD7p9p3S1q6IqauoX7YfwHyvwBRAv+84IIjrSiOZQyb5AmywV+0wsvHlDTDEzMuNj4EerPbUAHeJASDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102130; c=relaxed/simple;
	bh=WojPbrsgLuAdBP9t63XZPODGxijHOTNgGumNuvPsaHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEbv5Ff+P9bjXxCGGOxCgTLZZFDvRfbao26qQRiPlRC6sj32kdrgHxAAJsizxIZRn4ig57I2N8L1zxUoxMwcyvZ+edT6nhFIkC7fjERQgQmh83cASnly33hzCz8/anYw5QnjXaMRi/VTJnr4e43eLGySU+DWzL5unNeiNuhq7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=petri.us; spf=pass smtp.mailfrom=petri.us; dkim=pass (2048-bit key) header.d=petri.us header.i=@petri.us header.b=rGoGrW8o; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=petri.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=petri.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=petri.us header.i=@petri.us header.b="rGoGrW8o"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <jonah@petri.us>)
	id 1sg9ie-00Cdat-95
	for connman@lists.linux.dev; Mon, 19 Aug 2024 23:15:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=petri.us;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=Fr0a5zgYgrWYoK9HbfqM33JU/Ck1N5NNMKNbpDbPEUI=; b=rGoGrW
	8oKr/fDb6761kCjZ4z8wCZrEhWRrkEJ4M13hpYcHYpO7Wh+2qmA0t9VEjEGLQEJe9IWF7aqB03W/y
	LehK8CnMd4JAA4LE648rvgLD/jyFMXpqFeBa+lcRjCxrPwZTi4Y0lK00832e1/v+1Vu0SmlwRDf3i
	uDnaJdJfPJL3OvkXMbOLypc5vGn1Idlh0IyLehzB+NVFJZFV5qF4wJQUGCjvJ5ugESvybMfMncQfK
	8iInC6aqXOBZR4/G5nNzbSAODOherkOWUDRAgMoHlq51fkrs78BN/7lObZqztlstHHZ4J66+lLV6Y
	/RS/MeoMJ5aeAz/lthzC5Sz6ipAg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <jonah@petri.us>)
	id 1sg9id-0005ty-R3
	for connman@lists.linux.dev; Mon, 19 Aug 2024 23:15:15 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (799462)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sg9ib-00GArj-Ks; Mon, 19 Aug 2024 23:15:13 +0200
From: jonah@petri.us
To: connman@lists.linux.dev
Cc: Jonah Petri <jonah@petri.us>
Subject: [PATCH] gdhcp: nul-terminate return for 0 sized option value
Date: Mon, 19 Aug 2024 17:14:54 -0400
Message-Id: <20240819211454.1255654-1-jonah@petri.us>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonah Petri <jonah@petri.us>

In the field I have seen some dhcp servers return a code 252 response
with a zero length.  In this case, this code has len=0 < optlen=1, in
which case the returned string never gets terminated.  Using g_malloc0
causes it to always get zero-terminated.
---
 gdhcp/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index c9234a18..db8e0596 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -1865,7 +1865,7 @@ static char *malloc_option_value_string(uint8_t *option, GDHCPOptionType type)
 			((unsigned)len / (unsigned)optlen);
 	if (upper_length == 0)
 		return NULL;
-	dest = ret = g_malloc(upper_length + 1);
+	dest = ret = g_malloc0(upper_length + 1);
 	if (!ret)
 		return NULL;
 
-- 
2.34.1


Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E717BB6
	for <connman@lists.linux.dev>; Mon, 12 May 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039706; cv=none; b=e3JOferpcu1Br01Ci9VHpCVr+h8SuCfCPXd8ojPi2LC99cCTQcxP7FpM9aZ18JFfcCAiWBlA+E2tX69FCNFSl4756xVToa+1AMaPQvTfi2heTHX4b7JSZF43Q2Nax8mwJ9aAG4IFG5lb39xPDQPMfGubfAuLtIXysXQvnj/l0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039706; c=relaxed/simple;
	bh=klXZOjLBGVsYp/b+xdSpQd2BoWc2ZMDF4iOL2izyODA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hwO+QnlWdGONWe2169z2oIStO/yiZHgh2iMkRWK5EblHkYvmeGGvZfoqIA/W3KOm9njOYvdwfBXYmUSI2/TOZhGDcPzlVLsDPubj/i4OKTYWrdmUT1jEmaL16+OGT+a8yv7/lmaWGasue82OYFW3fcBsjygMDMS2Ek/IeKakex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ddZdVlki; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ddZdVlki"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b291093fso3191104f8f.0
        for <connman@lists.linux.dev>; Mon, 12 May 2025 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747039702; x=1747644502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7OEnkAOJ/6/TD/MfQCyymBINdrfGDywhdVSmnWsJC0=;
        b=ddZdVlkiienmnqv25d4Y9YqVaZfvUjZyhr6BAjuPSgN+OQR79tH0ADEHIaFBVnrPn+
         Egg+UVfQTLNpSY4ld8f9ANdlvDsEbrwj6JN8oUWEdw9ODrsxk7k+UTQ4S1Jz2LwIKjfA
         R5ylw1jWneU/KQYynJDqW/H1twjippGe8WGdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039702; x=1747644502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7OEnkAOJ/6/TD/MfQCyymBINdrfGDywhdVSmnWsJC0=;
        b=pkbqnCL9IHOpaOsA0MhesK78zRwTvemy2xT//9z5YBFgv3QiQSrke3DUxXr4QV6Pdf
         bV717ATQxK+8C56ywANJ2VwO+evrrADtXk2/ZaWLwaISiKKU/wgS+dugh9VE1hdOR2Rg
         HxqTejtKmqImgLo/kjw2H091EEu6aw81XYuBA6yUP8cy0vbya4l4S9n+eTQCHaP2Vbmg
         HZGxvjRFa5wkEQtZYJ/Z3XJ0ccX3pqCvh8BnkHp6OY9EWr+pxEO8J8Ehvm3Df2JSJWTO
         a/+P5BJI2w1MtD6jMrHv+3rzjQkl639Y3QtqVUTOFqDmJXPJcEboKUHqB7cOcltCZyBN
         hPBA==
X-Gm-Message-State: AOJu0Yzk+r91XtJaH91Wz3D/1oSlGJgUlBmkfBO3oYIJuZnC4JP2A2Mk
	hixf1mKo8iBl0ztkE26EUAQsrpfDa+99IRuJLW4K+Rpqrm0rHF5RU42y8xyEhAfZjYoqq8bkMcc
	HSXAXMwm5
X-Gm-Gg: ASbGncsXc/qdadkllVMKdyETCdOixRMdSe6URr4126R9uewI8V78/jvyfcJYOM7xV7k
	IS1AN9I5tam0yaO2/tUh0rKH7s6mHUj9l+glNj7t5jCdCnIMx/I56MGb2qzK7ukveU+GQ0AAQeS
	IY8vraBAxcIhRpQ7KlW6Xu7W2DtOpzwfcCov1b51Fzt+xA/To8v3Faspb1bG9l4hFdpbMBWGqJK
	vYFtYR7CxegkXSUPRVg0tDqVd2e9OY/s/Fp2QTWCSdbpA88+emWWoyiX+20njYRe3P57DoowsjK
	+OTovWb+keyHl/gk8kRIWOzhEtIxODsI7DMUv7wloNL/NoytdFEFE/1jZWXv7E2X206nvAJBI6n
	HuEe698z2ZY+bu8RqdGhhrkXWOg==
X-Google-Smtp-Source: AGHT+IEPFa9dkzZgNmhzo3mSZ+7BFMqw9IKO/CtY6SYMKzKVd9hMNkfHIyPqmZhZmLXxsVFgzfwlIg==
X-Received: by 2002:a5d:55d1:0:b0:3a1:fc5b:372a with SMTP id ffacd0b85a97d-3a1fc5b37cemr7415878f8f.24.1747039702185;
        Mon, 12 May 2025 01:48:22 -0700 (PDT)
Received: from panicking.fritz.box (p5b26784b.dip0.t-ipconnect.de. [91.38.120.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5e1sm11529359f8f.89.2025.05.12.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:48:21 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	=?UTF-8?q?=EC=8B=A0=EC=9C=A4=EC=A0=9C=28=ED=95=99=EB=B6=80=EC=83=9D-?= =?UTF-8?q?=EC=86=8C=ED=94=84=ED=8A=B8=EC=9B=A8=EC=96=B4=EC=A0=84=EA=B3=B5?= =?UTF-8?q?=29?= <ioerts@kookmin.ac.kr>
Subject: [PATCH] dnsproxy: Address CVE-2025-32366 vulnerability
Date: Mon, 12 May 2025 10:48:18 +0200
Message-ID: <20250512084818.411262-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 신윤제(학부생-소프트웨어전공) <ioerts@kookmin.ac.kr>

In Connman parse_rr in dnsproxy.c has a memcpy length
that depends on an RR RDLENGTH value (i.e., *rdlen=ntohs(rr->rdlen)
and memcpy(response+offset,*end,*rdlen)). Here, rdlen may be larger
than the amount of remaining packet data in the current state of
parsing. As a result, values of stack memory locations may be sent
over the network in a response.

This patch adds a check to ensure that (*end + *rdlen) does not exceed
the valid range. If the condition is violated, the function returns
-EINVAL.
---
V1->V2:
	- resent using proper inline patch
---
 src/dnsproxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 7ee26d9f..1dd2f7f5 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -998,6 +998,9 @@ static int parse_rr(const unsigned char *buf, const unsigned char *start,
 	if ((offset + *rdlen) > *response_size)
 		return -ENOBUFS;
 
+	if ((*end + *rdlen) > max)
+		return -EINVAL;
+
 	memcpy(response + offset, *end, *rdlen);
 
 	*end += *rdlen;
-- 
2.43.0


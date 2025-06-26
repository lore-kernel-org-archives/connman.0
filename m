Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CC191F7E
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922921; cv=none; b=FBQWNmalLedy3qFd0BcMI8unIpIL3JsGFK9YJEwdegGrwNGWmPOjPYbWDB7iV9Q6coPMFIDyGX48GJpEY9ajv5crbI2mt6fmgUmuHJ3aO11Tw03CtaSQA0u9wbRumx3hOE3+0FYkHzwQXnM47jOfh+88fhOWpRAAU31Z/CP0GZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922921; c=relaxed/simple;
	bh=+s0nuCq1Q3DYdxTp30NaklEpGODPqO8jSmiFll2SlVs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JrUnq//GfiBX1mWJnlpiTEiNySCQHtHYKB0fIooN9zm35Z5CyZCIiCkoZwLXckvtuQpxg16/1kqyfhLXzXKyO/EY7doRD/1JNFKSqWTTs4cL5s7MsTVtR1iAAPvfbyxUw0jZjJvFSupam46JvnJYr8j5UbDEu+pAbA0gppOwCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LND3XOFy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LND3XOFy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so4523235e9.1
        for <connman@lists.linux.dev>; Thu, 26 Jun 2025 00:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1750922915; x=1751527715; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvh9Ej5ffyLrN+pRxR3PgJtopR+gCpW3zccB2EzJW9Q=;
        b=LND3XOFy4uIwHsG1B3PtjwShM/FX9zznvq7+VjBxmrE9f5jCC1/Pbgyb4IlhQNjPPx
         WGFJZM+9HodlUcqmniG4/yzDbL1OX3WzWqFi6jgV6ILo+l3Sf8/uzVIvtNVDNvy/Yjlu
         IYlvkciIDlOGwrDRcMfz2f0viDKVmyWUx+pMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750922915; x=1751527715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvh9Ej5ffyLrN+pRxR3PgJtopR+gCpW3zccB2EzJW9Q=;
        b=UQI1T+7JftmAkOnsj1iL6rZdHEBqh3eIL9taHtQQ4J4eg94A5vQDgV1d4W2+Ou0lw9
         Tq8Z3i52ZuOed57r5UxTarRvd+vc3NI1Sy21QoszHNbVfVL8TjzlAMFDvw+Lqm62qNr6
         YPHFWlwHOCSAb8bUj59VS8G49/sGQaPGn5HX529jrXd5/jCEf9xGUb3+syugK7KYP4Yp
         DvMappasSFYK0B4VkrfzSbhBTRbU6i9N3Y19skCvZ4aeOmyAhPWaHAgVGIS9NoEjJ6RJ
         WaYu8sY7wrD2h+BSilUagykfK4pZRp0llWCWYEjZQJ8fsSfJh3hllfpDl6U2Incbb57h
         I2Qw==
X-Gm-Message-State: AOJu0YyaNjMOzQeB8LQj4HXJ/dGY1U1uNIIS1AJifkFM4otVW3WUJ4zK
	z8Q42ghTv7yqQlGJfEN6S5JlvA/KgXcJYldDUkIELQvhe2kOkLVADHGNi9i/eH3zk2DJdEm8nOZ
	PpqO8TXw=
X-Gm-Gg: ASbGncumGzfnUVuiynuRmq2Rs6VCZdFP879SOXRfj/5DIbsJRB8tGvDvAesC2mE1ZwO
	hsZOHNm7EI74u5te1/nNtuFcNvJ7hlHl//RDfABUiP5Jeioqpe0U6Qzhnu5Q+AP45lkeFbfqy1S
	aSwVXpn8EuKTE1cbZs3D2CyQdFA1oK2pD6gcROMy+gNP09qJcAv9tj+ohkz9o486iLfl2pxEQVo
	AkXBmwOXr8JkIbZhe5UjBwdcYQNPdQXM70PTkaUO6Nszw9G4EXpYCUtycjwKwvZeBxSaAXReeOf
	UGh8XIFOh1OWg5IOTAZJeyLt7hvEsCoeGQFZ9AGEjjK866+2orBC/i4GB5SgOXdEMdPExNrKDwh
	VUAvSmAKfxGbD6cQA1R5kBOehxdrLCwFAz1lbnAbwWgQ=
X-Google-Smtp-Source: AGHT+IHVDTivz9xQKTKrXnw8aWN5juChsDkVy7hisitIGBCcD7TK5xt14soXC+9Ur6FrzknafcltCA==
X-Received: by 2002:a05:600c:19c9:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-453889e9057mr23949915e9.14.1750922914595;
        Thu, 26 Jun 2025 00:28:34 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8382-0206-0000-0000-0000-05fa.ipv6.o2.cz. [2a00:1028:8382:206::5fa])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453883d81besm19856585e9.38.2025.06.26.00.28.33
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 00:28:33 -0700 (PDT)
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 0/3] API to list and remove known services
Date: Thu, 26 Jun 2025 09:27:43 +0200
Message-ID: <20250626072822.1941-1-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Based on past discussions with Daniel Wagner, I've tried to adapt the
patches according all the comments I've found in mailing list history,
namely, compared to v2:
- consistent use of object path in the API calls
- avoid usage of glib types
- some formatting issues

	Roman

[1] https://lore.kernel.org/connman/20211014073337.wvlnjeognyhlw5dw@carbon.lan/
[2] https://lore.kernel.org/connman/20211028061618.cgmgprc7fo2nlpf2@beryllium.lan/
[3] https://lore.kernel.org/connman/20220828141921.zhtha3rxnjqoic3c@beryllium.lan/

Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62EF51005
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDLf7hVG"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1ea98ad294cso576fac.3
        for <connman@lists.linux.dev>; Wed, 22 Nov 2023 08:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700671859; x=1701276659; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbcqvxiiKAYQNAhkOISl0b3YeZ66rLAl3ZUSHumac6k=;
        b=XDLf7hVGp47HN2yQ/KcUrqyj2iRs+IrSIAUBsieXpgUU3rFybRPkvVmxeLwy0wl3vz
         1F8InS5K4iCdGUjaFIYANuxno6FxIRDWkqVUPBFFSIwTad5vQXzf8VHBnnoWFnuslUc4
         mxH9llNZaMM8vfs5VsGwIgIvEkA7FdpU+OyfoXhPDijJ8jynH/nBfsSqH7zHmUB/gR2p
         9tAJeJFhvbKurUKBOY1hYaxqydpguMEdLVtQrYOrHm5646lSmOvnbmv6eD5/alwiV3SU
         eIDuGbsxWZv3digL7uR1yH4A1lq/K/Q0npUoqKaMLE9xLWL6pfYdDqGPINX917fdXcFq
         qecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700671859; x=1701276659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbcqvxiiKAYQNAhkOISl0b3YeZ66rLAl3ZUSHumac6k=;
        b=aYOrzoBmWvbr47LIDwuBgKe54Diy09nbNCvRsM/kSm8tJiBmt9x3FWYefCJ8OOCWpq
         U/S5Rchjifq0c9JzL1B9ky4t/knuBIbPYWVUk1wEHjhhvTac0iS1sg/Axe+a9uJLjQ3c
         LEpF3/lmNB1FfFBn1lEyrdvBNm8GTwSmlnB0mwHXakpRvo2FPIwRIWSacEh+bolIydKq
         gjH0V7/IFsunbe7dg34+ya6gibArjPz7dlKXMMvjvfimZFRxmFZtvZvAtK+7BisNYqi8
         0O574VNipFkxP36xstgG04WPR+SQ4Ha0OYLKIly/Ahs3APfKBzd0wThqJsIIUUxbCq2J
         yJog==
X-Gm-Message-State: AOJu0YxVtH9zUP7lP6OoATu/SK4jn4dajK/2GCRMXCU0Kp0btpxDw4CX
	1LMB8S5cN7j12pRhj9iazRnjL9+63/0=
X-Google-Smtp-Source: AGHT+IFJQVy0HH+bCocpA7/SeEF4/dOcBiV4t7mAKA1Py+dfHSqZnFOHlWJOKFxaLIRFCY5Ut1oeJA==
X-Received: by 2002:a05:6870:3b16:b0:1f5:7d47:718b with SMTP id gh22-20020a0568703b1600b001f57d47718bmr3738850oab.1.1700671858991;
        Wed, 22 Nov 2023 08:50:58 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gl10-20020a0568703c8a00b001e9a253afa3sm425oab.49.2023.11.22.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:50:58 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 0/1] RFC: dnsproxy changes
Date: Wed, 22 Nov 2023 10:47:35 -0600
Message-ID: <20231122165010.1217488-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had some changes to the DNS Proxy code lying around in an old branch.
I do not know anything about these, but maybe this is useful to someone,
especially since the dnsproxy code seems to be full of compile warnings.

These apply cleanly on top of the 1.31 tag.

Denis Kenzior (1):
  dnsproxy: Changes

 src/dnsproxy.c | 251 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 228 insertions(+), 23 deletions(-)

-- 
2.42.0


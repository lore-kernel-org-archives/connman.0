Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF514884C
	for <connman@lists.linux.dev>; Mon,  8 Apr 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615077; cv=none; b=fmKseKaLX6tTxWW3x8VUKA6gn00T0ThxqfnDtG6Ak4uf/yYbbHQSx4RAWSAgpbHPXhwkCG+Oidl9s90/FlML5p+ZuYsSSsTzI1WPgUWkMgiFdtbGPK/xtTejPJWDC7H9CHjbzj/jpZzs6E46k/D3uE+NE4HETkCy2do30F2cqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615077; c=relaxed/simple;
	bh=FrR1ba+N+sXg2wsx82xial3pm6DjjkU15v/uwEfW2c0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OlIJfuJEds4r7CRbhHi+jc959ihaBPSrPgRs3algA5vvRSiHkSWJ6MtnM0CzhZ5f7a7hgKVMGUoE7SPlBPYHUq3NPVz0x/1RufxFnuCLi5IiWZBx6s4Ya8x5L3eps1H0K/XKfmgYqauoPCH5nC3REA1L6D88Bq1u6HxDbadpSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J17xNnir; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J17xNnir"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa4204bacdso802047eaf.2
        for <connman@lists.linux.dev>; Mon, 08 Apr 2024 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712615074; x=1713219874; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FN9uKDQK7wEwcoggZMXUrUh81YT/xpHW5MHm+1ba/hA=;
        b=J17xNnirqG0NJj+X4WPaM/usRQRUc+E2NQ8RzyMZoRcWOD4P7oF+BLfwa+fRz7YHnO
         lWLTkoTEImTZZ54mCie4gDkWRcRdC/9IvwS22ZvUeTWry1s4m2KmP0OYbQgPTJjtGZ8K
         c/jeYZWamcGkb8aQlDJGUy6jDtVrwAw5HSo1uFykfFYvUpK365ZXbLd+SleDd9Qaafot
         hrBY9UjhQrV7UBaVUS7/aCeEEKYb8ILur9iva2HwpLa6s6naU7Hk/EbpnrH2s7Jsn8vZ
         6TNJjFk2sHt8inkXG0rpJ6b9dgj3shsx+L6R1zpieyq6FhmuEN0XaloBTtll23ClVB5Z
         s25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712615074; x=1713219874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FN9uKDQK7wEwcoggZMXUrUh81YT/xpHW5MHm+1ba/hA=;
        b=OOmuE5cK9DOfZnzO4HLAIizKV5AUbEXYn+tw5/r7doalAV2LiGBJyMaTh3sp8urriS
         lClj5VOei3aJ6lkHWFEPXvLXlIGb0so7kRtggEo1QdMhmrn/sgMqZj5VguwtleydHZvR
         zUvNpAvk0M/5JqxhebMuQDrfkFVkes4u3YY1dmlyB4K+PblxVVVpBWI6D8gce11D9Hox
         It/X3634+HCvj26uqxXIQAfYl6yiZaMeITfXULPwMN/ywg+UGn+LvHBoQCOHlSozvt5D
         y59NwKdvuUPugTcnQefwix66JmI9UswRDpYxmGOTOcEjxT0dTrBPPRDfycxtUZrr5MVJ
         y6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0b4LNSZZEXdiG4ZiRRrtCKBNP0I4JWDi4ZfcAuDj3Ot0AH3JABBHCjcYhOboGI2c9RynFlE48VD6teTNK96+A4A0MpvLesw==
X-Gm-Message-State: AOJu0YwuZAaRDW7bH7uLeYE1KKjaEqP3O5DSa53/mlFTeX622/Qb9DFR
	+u3DAQROMclvuDI6o8v138rNobJ3pFSzemL8rQacpoS9dR+/MXRt
X-Google-Smtp-Source: AGHT+IGabqlOkJALkWf3iIttna6cZhQMgkhBhWSJFApeWSXzWws+rMOt+MJvWnly+SKiZfNe1pBHlg==
X-Received: by 2002:a05:6358:7d90:b0:17e:bbaf:406c with SMTP id z16-20020a0563587d9000b0017ebbaf406cmr10797560rwf.28.1712615074501;
        Mon, 08 Apr 2024 15:24:34 -0700 (PDT)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id y7-20020a63de47000000b005e838b99c96sm6213485pgi.80.2024.04.08.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 15:24:34 -0700 (PDT)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH] dnsproxy: Fix cached ttl update
Date: Mon,  8 Apr 2024 15:24:31 -0700
Message-Id: <20240408222431.94411-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was exposed after fixing the signedness comparison warnings
found in dnsproxy.c update_cached_ttl() consistently comes up two
bytes short when processing the last record.
---
 src/dnsproxy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d4242560..506e1b9d 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -508,8 +508,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 	if (answers == 0)
 		hdr->aa = 1;
 	else {
-		const int adj_len = len - 2;
-		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
+		update_cached_ttl((unsigned char *)hdr, len, ttl);
 	}
 
 	debug("sk %d id 0x%04x answers %d ptr %p length %zd dns %zd",
-- 
2.34.1


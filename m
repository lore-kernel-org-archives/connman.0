Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAE1D63E4
	for <connman@lists.linux.dev>; Tue,  7 Jul 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415829; cv=none; b=SqpCtaKLnyA5CoaMCDRJ7ZVdnlCySlWJPhhze2vpRucNYADlAvASW9ZfavV9rK1jok2kCYHHyMIirYUUjNNe18Z7G022qKDtTTxFhU51lVuw3GTEMtn7AJkJCTJMxifV3kh8AkcBrjhLM9Xab8BfOWtmSwU9tdSVt2nuONuurlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415829; c=relaxed/simple;
	bh=YdHPtT+tXinq+fB6kwXYGqs9DVlcpzjzeg5/7ME8Qwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6IRHi+LM6nwRqWRtFhIq69KRXZo1fJF7mexSm+A7V4CDDxHLlEqEjwCmLUoXYYw9vlguwhf1qkTp4tzlmfaql2L6cA45S1fhf2MmqYmIOL3mYTI/cqUaW5lSORW/O2eQWajxKmx2Otw7qZ4GQqVRY1+nzRtQoUeNieLEYIDoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIa7VIjV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIa7VIjV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso15237395e9.0
        for <connman@lists.linux.dev>; Tue, 07 Jul 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415827; x=1784020627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wK6cjAZKk/Nsbef8sAsl1MFZmqYQLc3my0prtnCrtao=;
        b=EIa7VIjVKXEcbeg5shmsn0hhdkrrFu0A/w4acLLquKAr0l5sGTCHqNegkMbNSKeLaf
         tgIu3MBif7uUyrN07ULC3vYIoqja5wXuat2b+4+iZQu4a/QQlhhQ3GROM1irdhi7zIft
         bO/A+TrGzd8LXzgEhreGlQVsTbDNmPWjBqNBY1rH4Pnyz2tMrxWb+mw93LUBKQEGib5C
         FP6FNCnjXY3Xzn39NbFDXB7LsgVwYR1jIoxwc1PA4LJpn3Fd2t9ngYv/G85TWuj7jv2O
         gk4BV3wiY7elMFRPWVQ4ZBvvmS8wLpFU312HsnkekgeViZG0H0/7oGCYvEmWW1V/H0pr
         ZppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415827; x=1784020627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK6cjAZKk/Nsbef8sAsl1MFZmqYQLc3my0prtnCrtao=;
        b=cehtyagDORDqYB3zkK1SU31ay4Ll5UDw8XqYdjWJM9u6fGchYFeiBiKSaK+QQHOXQf
         /ZPqYMxRe2iMTP23F5U2TGpq6IWwjR/rxXeLM/m7sXHNifnaKIviIM+0MrTOyiu+uWkh
         nyfQ6wqTH2gs8PLjuebHKz216wGJazofdFWRqZjDvSJwY4AOeMEa7nKBZlAO78XCumEt
         1rIcSF0YNvb+iFllVI1jsb0c79gIJxIUDJFgzjnE2YzMoW/Fqtu9y6IiX2FO5CF73j9X
         /15tLvCUsKO1AV/puoYSbVMTF6G8+gkG0+GNp0G8rSAmxEq6DbrWqpvvxx8RQZjhgoaU
         QrhA==
X-Gm-Message-State: AOJu0YwEiQf/LmXdVDhdK5sZbY8rDeqIbQY4sN3qeRma8xjWOB4I/YeK
	yiqlS+Qf0TxKrv012gGm5gaDlXLBK9nu5xhGGAUr2+UtzB7KYB2h+VlaAnEYGNd0sRk=
X-Gm-Gg: AfdE7cns4+YvkORfhXL2WceUxcEQs6NQXztWCzJNc7bXc8GwpogsiAekiNls6Nw7p9m
	rbw8gXrflVYFhhNaNXQfqaTC7yrr8y5pOnlouktz2PMOISWljVPqbmmuz7L870yHOIMUOzb59hq
	UbtCUl2QtEK50TGoEMy+YTDbQO6tqw5XROYmbCmY1zNau0DG2n7nqrGw5npm8KT73jQesLSXSks
	sLMcYzJE+gd0y1h+cs8V1XFzImgO3yxQBaxdsjmfnG6h/jw3oAB3lOTpRQhjeFLUb0z4poAT5S1
	hguWxoeP+drJWo65A49npBwVMz0d/GamrfSDFjxG9zcAoO+UZ+jQvvB4IuE7z8p9EjY3vZMQgZR
	8HopOI9d+OsNP5qB5LHS8bOggdDrwklQtDbbmzHhntwo6ou6KoyBvgluUOrut4N1EYNihabb/gv
	rnkh9OX+yXSpvEr98hsMkDECjbohRagZ5z+nm603nafDtGQ+MhIa/f5z8pFw==
X-Received: by 2002:a05:600c:46c7:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-493df22862dmr50849705e9.22.1783415826575;
        Tue, 07 Jul 2026 02:17:06 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:90ff:59e6:6895:a56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm63406665e9.13.2026.07.07.02.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 02:17:06 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 0/2] gweb/wispr: Normalize received HTTP header field names
Date: Tue,  7 Jul 2026 11:16:43 +0200
Message-ID: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes connman correctly handle HTTP response headers
from modern servers that send field names in lowercase, as
permitted by RFC 9110 Section 5.1.

The first patch normalizes incoming header field names to lowercase
at parse time in gweb and updates the lookup path accordingly.
The latter updates wispr call sites to pass lowercase names,
consistent with the normalized store.

Giuseppe Eletto (2):
  gweb: Normalize received HTTP header field names to lowercase
  wispr: Use lowercase header field names in g_web_result_get_header
    calls

 gweb/gweb.c   | 19 ++++++++++++++++---
 src/wispr.c   | 12 ++++++------
 tools/wispr.c |  4 ++--
 3 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.50.1


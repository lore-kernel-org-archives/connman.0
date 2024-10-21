Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8D1FDFA7
	for <connman@lists.linux.dev>; Mon, 21 Oct 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551484; cv=none; b=Wr/RNIe1xuH883nrfXBGcdB4304HmSnzjGlL3MkxqouJtyFPka68qt4N1d989mUY8i45VbZfG4fuWgoMDsu08NqVAVif4qy7gsdvI9JM8Wu1r4I3wNkpte9BvGkuPVbb7nwpTEBKz42cG+gQ37oRmwMQ/q9cAJTfaDEeSIHUvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551484; c=relaxed/simple;
	bh=VGEkKDfXyuOk79An5BLqK+udS9Jp0QiyOZlvBO8+g7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZEDjc2qSA1o3KJXdXTkq/x6iesW02Qas9KiyJ3XREcnjlAC9TJ9XhgIK5pdAy/Kjdz8RlVVBUrSWXHYq+VWnDH355crZKfH2Gdq73F1J63Ne8lz7JwEoyUXOP+n/CZkusrDtJ6BobH9sPSlBhmDsRz6mILOiVZwdtKhIY/2kjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=dNjByhIk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="dNjByhIk"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so3815639a91.0
        for <connman@lists.linux.dev>; Mon, 21 Oct 2024 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1729551482; x=1730156282; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ap+30r/J98v6zlhunHqcv8500H8w0UA4bbT0E/RLgHA=;
        b=dNjByhIky5d4AplPg1VAFoXLztj/YRsoEc97sW81OwvhfA92I8KoT5KfhVgjXtRIZa
         5xq2uBRrLoigIcsfU6zZ/stgzS2FSNkzY0XlzT0KxgPhk6Whj1nOKOvsxU2NOUpaGN09
         izdHYk1Sfz9GvQFah2YJnKjNcQczQT5+QBEb0UltsTesHfQfJsoRXU3qXIIJCC+AqvuK
         3kWhKChhXYQL+F65nyz8R5UgKgfxcUgTCf2jXIDi+RcniBUM2r0U/QOEkCN1DUB2Psme
         MRNWrAUuo58hKkkcl5ckyY2LT8pjPAxnUhyUkTdXnB3gKzeEGQsuhCpdYqeSje1SmaTS
         nMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551482; x=1730156282;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+30r/J98v6zlhunHqcv8500H8w0UA4bbT0E/RLgHA=;
        b=Yq1ccppHUTOY/mRljIOc0M4AKJG1+5wUXyegAKl8r0mqLUuwUc0BsaXvD3kqLu4OK8
         s/ECwiTIKhfLG6t6/SlbMuRS6hIRlhwYDgcN+QXC+173jC8rjDY/pavX3PZuq8yxy6/v
         LzgEIrh3Y6lx4t2tir1BCeVbcMyIa+aITmILm7rf2uNYnt22Vxr/LJLkmgFCfVHONVdT
         gkxZQCWCov+1OJ6Qw4BbQiwZDYrCTP2bNo7e6q+/K1uUxhSXtM9l7QfXhdPfffG50PZW
         1bAGhYApUsVu9lbNXoC4tuQhBGgD0MVHA6Nz+GtL69TnSTgiZWQlIRamIz2gMpBueilO
         h1+A==
X-Gm-Message-State: AOJu0Yxlgezp6B4UktvjdK7J1CYeq3aWr8rdzvXTO3agJ0oVfcrBYCTp
	YC5bqIsgmBeR7EYKl/OGuKRWU+YuGYZ0Ntfd7zc+ouX/Ry8d98/kBqLf74tuGYpfsJ+XtcwLLMA
	TxcdRl9+JViQzd+DmtjsBtVwQLzuZsOTs4kwJa0nKRnULM92r08LIA7R4ZgxRl73hoQwVG8vv7k
	u672by1wA/YgidfpWIhpmL4mmz/RhuqOIR7FjHaNz+CE+Ryv9XEg/MMQ==
X-Google-Smtp-Source: AGHT+IFu0oI/l5Ik/9zBgzE8ndOsNy7Le9Bw4pBog/g9XL5enPgi86IYHWy2eHssutsYqvxIQp0rAA==
X-Received: by 2002:a17:90b:8b:b0:2d8:7561:db71 with SMTP id 98e67ed59e1d1-2e5ddc5c654mr758168a91.25.1729551481979;
        Mon, 21 Oct 2024 15:58:01 -0700 (PDT)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad25c227sm4598886a91.6.2024.10.21.15.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:58:01 -0700 (PDT)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: connman@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>,
	Chris Johnson <chris.johnson@getcruise.com>
Subject: [PATCH] gsupplicant: fix ASAN issue
Date: Mon, 21 Oct 2024 15:57:38 -0700
Message-ID: <20241021225738.3057955-1-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

The problem is `bss` and `bss->path` can be used after being freed, in
this line:

  g_hash_table_replace(bss_mapping, bss->path, interface);

This is because the following call:

  g_hash_table_replace(network->bss_table, ...)

could call remove_bss(), which will free both `bss->path` and `bss`.

So this commit switches the order of these statements.

Additionally, change `g_hash_table_replace` to `g_hash_table_insert`. We
already checked that `network->group` doesn't exist in
`interface->network_table` at this point.

Co-Authored-By: Chris Johnson <chris.johnson@getcruise.com>
---
 gsupplicant/supplicant.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 1b92ec44..f3be9e7b 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -1708,7 +1708,7 @@ static int add_or_replace_bss_to_network(struct g_supplicant_bss *bss)
 	network->config_table = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
 
-	g_hash_table_replace(interface->network_table,
+	g_hash_table_insert(interface->network_table,
 						network->group, network);
 
 	callback_network_added(network);
@@ -1735,9 +1735,8 @@ done:
 	}
 
 	g_hash_table_replace(interface->bss_mapping, bss->path, network);
-	g_hash_table_replace(network->bss_table, bss->path, bss);
-
 	g_hash_table_replace(bss_mapping, bss->path, interface);
+	g_hash_table_replace(network->bss_table, bss->path, bss);
 
 	return 0;
 }
-- 
2.47.0


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.

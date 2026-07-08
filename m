Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BB3BAD92
	for <connman@lists.linux.dev>; Wed,  8 Jul 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533418; cv=none; b=D/UEsb+vXpEi1GmigFc0kJg0BC+dtfA9+fZ3HDNgd0irV8OLaS/W+UpVw0aRwxPM5W4WtLonpzfuvaKpAy2rOdJ0TR24Od/mBrjrWcV8kqIypWz7vHC0sExiNhTIw6LQdLiOc6OjIqQI1AUyvpHbgY61DOJkgotPLw/WKQ7QY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533418; c=relaxed/simple;
	bh=Gx8vGj/MIeVyWi/Jn5qdPunlg4RMpV153aC5oSsW+II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7GzrTQvvdkD9RSKfrkfEw/vyqArKdB4o8DkJLTUXh75SxLtG4ECOoMNKEZy4imEry8QwKzfdjNVdT9Zvll2RneoIb0EkmjOlPPm5hM37OCaP9kqVz+sLOV3cWYBJ+hHgpCDruv5H6yIdThF7bdFiesdAgc2XavZ4v+NCmWNBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU+4HExW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU+4HExW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so7659485e9.0
        for <connman@lists.linux.dev>; Wed, 08 Jul 2026 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533416; x=1784138216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wrS++91CmpxbpHj4CTehAegUm6udRlSyDqXn5jwJLXA=;
        b=AU+4HExWhs4U11RSCjXU8XdAV1pNEMd7GnXeWpA5G18rkasv4URN08QXpA9yDJhnBh
         vUzGAnsWoBw6JcX4K5CgAqBF4ZUQb4Nz0s4y9/ljroyMBMAmU34yuBUNkkZt0knEe9rK
         6aR118dgaBZnYzj2smrQm2It/n7zzQY1Q0glikOT//E7MRn6JzX8yE+Sy3YIxpEZJsjd
         GL+Zei+8jzygzLU7EvACVjV3mdPMgHp6y5/3RrEWMlO25llA04QYGQgBzSUQbOTmks2O
         p3IBdNeMUcnHrvVKH/FBBLVtyGS2RtWX8sbFoaxx+jAHTTqrb6Edi0Y7XTEQNoS1gN6a
         x6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533416; x=1784138216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wrS++91CmpxbpHj4CTehAegUm6udRlSyDqXn5jwJLXA=;
        b=AP05eGX+1Vyj5zeQMPuyAImj+xXsDPPmw/qhwtflvsFFdryrvMwGOVYxSG6p4ro2L2
         Yg38TrFQJXqatEr4dmELzs2V+lX/gJpfTcrLAox5CDTdT2A6Vbw5lk3RjHPQGPOP7eap
         SRb1snOy94hm+ZT7cFRAAdiWZLtu32pg5HkVk5ZKIr2kuf4G3PYOQarVU2ARRYoMZogT
         3daASBiZF0BhOREb/5j9An+sg8B7PWX48g8pmce8p3448uxyK9AzJ9lpIfJgzFkOv2lS
         6EtVEaBdGRdl0LQa0W/dg7j4M3+kYfm3DHwEL0BIsGaNxiJXL6oZ3a62wdmUkRt3hmCA
         WGFA==
X-Gm-Message-State: AOJu0YwDHKqW4It/zMgjdyRh1+JOU7SuX8/PDZ7OcNkYXjFNkzUdrbIR
	rOArmg2CtQX6yR9BKHuMCi89paUVssTWi85ESX6cnKWN71qESP22C+8+mWfx1N2m
X-Gm-Gg: AfdE7ckBEUyVyWXsJmhUl434f4QwTlk7MYjqg39n85Q2kxNDNzDMP/Dw+c3j58JinCY
	TF+0hBCMAEIyfWbvwSabpb9AKFdvVRa1RTyFrrEYzvs/zbgUILtQJ8mHxNYe5sLN6VZf3Y7MzGk
	n8Cf6IRqj/ps9xQ9938+15MPJNzqW/ePUKhMVzg3NAhOoONz8d/cwVvFtIy8LZjF3hFj9Neq5Tw
	wG5M92A56UMHswVGTSBOiJqiIz5xywNBQUjvd7r8453x0wIyvwjrIJXdQeo57TKeETkrr/tmQ+R
	66ryvA3+R2NW8suugzv4FIrvteacEPAmEvnzEtg3N08ctwu1DGgpNTrG5gROBvLb17IHhQlxoL6
	2DmZ0VTe5d/21kL6hV8LVannvJ3hMnu+nPv3HNKdKuX5i2ho552weP0sZg//nFSjAGQeCU+7RP6
	+DOrvdRRbbZpPph8sEjk6JwfJnOngdxgHs7ygmiY37uKlARlE9xnQZ5wh4Fw==
X-Received: by 2002:a05:600c:c1c8:10b0:493:9661:f55d with SMTP id 5b1f17b1804b1-493e68e8a57mr30984395e9.30.1783533415870;
        Wed, 08 Jul 2026 10:56:55 -0700 (PDT)
Received: from Mac.degu-bleak.ts.net ([2a07:7e81:8205:0:5dc4:6779:6584:5b39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm48061787f8f.7.2026.07.08.10.56.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 10:56:55 -0700 (PDT)
From: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
To: connman@lists.linux.dev
Cc: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
Subject: [PATCH 2/2] service: Ignore invalid UTF-8 service name
Date: Wed,  8 Jul 2026 19:56:50 +0200
Message-ID: <20260708175650.16177-3-giuseppe.eletto98@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708175650.16177-1-giuseppe.eletto98@gmail.com>
References: <20260708175650.16177-1-giuseppe.eletto98@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

service_load() reads the WiFi service name from the per-service settings
file and stores it in service->name, which is later sent over D-Bus
in append_properties(). Like the tethering identifier and passphrase, a
corrupted settings file may contain a name that is not valid UTF-8, and
appending such a string to a D-Bus message aborts connmand.

Names obtained from a scan are already sanitized by create_name() in
gsupplicant, but the value loaded from storage is not. Validate it with
g_utf8_validate() and ignore it when it is not valid UTF-8.
---
 src/service.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/service.c b/src/service.c
index d5869b14..067ddd46 100644
--- a/src/service.c
+++ b/src/service.c
@@ -678,6 +678,14 @@ static int service_load(struct connman_service *service)
 
 			name = g_key_file_get_string(keyfile,
 					service->identifier, "Name", NULL);
+
+			if (name && !g_utf8_validate(name, -1, NULL)) {
+				connman_warn("Ignoring invalid Name for %s",
+						service->identifier);
+				g_free(name);
+				name = NULL;
+			}
+
 			if (name) {
 				g_free(service->name);
 				service->name = name;
-- 
2.50.1


Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF586116
	for <connman@lists.linux.dev>; Mon, 28 Aug 2023 11:19:00 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so4186127a12.0
        for <connman@lists.linux.dev>; Mon, 28 Aug 2023 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693221538; x=1693826338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TyooQ9rtGzfrWKD19SnOmXig3xziHK/DeVY5vipTdDQ=;
        b=KOoHNq8MAA7JwDin1F3NH4Bjf2hdKUGM/t5GVT2XCD+kfb1wgFCKJeI5R9hVj1afl5
         BUv0drGQQ0JPDvZgdB1L4Gu9FxkR3NWTBtXGgkZdWHPm+rQ+SKzA4urD3v+AZYRxJnAS
         ZHFlnD1StP7i25uoL+xsiBKNLp7TyYLOqi76Zer7JrwqX/AN7DEOePJGsULbhfqbS8Kg
         cPQAw6MI5bz5mKs0O8Wkz0Ef6Hdd9zUfyinYDjD47m2ktIQ24yKoTmgmnguBL86hRg2l
         6sL0r4+ZUJuaEyXmhfK1NjFxROjtpaglxTqrg9qcqO4qfkBh1omzs/rSdjYhFmlzGTMp
         kAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693221538; x=1693826338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyooQ9rtGzfrWKD19SnOmXig3xziHK/DeVY5vipTdDQ=;
        b=Z36wqlxNvDMGCFB6kfDZcbvZrvtNLJbK6EutOV6tA8cy3gLephjcZLbXolGS5Dikbt
         sx/29ipLmMpHZJDPARvS+sc6KLVF2SodkA428bpiEIOa3rHs/74KMucbSIDiBTpNfO9I
         YfJkK6GxSMuc/B7zdKA3zItyHc24+V8sFcYJJAdZK5AQbsXSwMtcZzfOpWhwEzWYKNMe
         7KRenxfZjACWQ7ArE/KMqOwUuaLrc4qgmOJ67GjwkeUZ4msDyUgZ5dvkt5TeB/1AHtrx
         bih8iJ+iFiNoN34DziyfbFMrd6dUmGKxfvCkV2IyRt1d92odqiNUwEByVxx/5bSipuuT
         ocPg==
X-Gm-Message-State: AOJu0YxjPL7y8yEy1qEBqY4zmH3yOKhfLJCxA0joMx1BLBtpIQOBqd5N
	/XUsmYxUI6P8MOMwZCjTQI5dWkj9umk5gw==
X-Google-Smtp-Source: AGHT+IFEhBFQpQwTX3eUzvCdpPUGfRyzUeOJxrsEGFlNNnHrB+YJOX6jmSHM4CCDCtNn6FG0MbdPvw==
X-Received: by 2002:a17:906:519e:b0:9a1:b85d:c95d with SMTP id y30-20020a170906519e00b009a1b85dc95dmr14663482ejk.50.1693221538159;
        Mon, 28 Aug 2023 04:18:58 -0700 (PDT)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id ks10-20020a170906f84a00b00997cce73cc7sm4529144ejb.29.2023.08.28.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:18:57 -0700 (PDT)
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
Subject: [PATCH] Don't add route for invalid dst and gateway address combinations
Date: Mon, 28 Aug 2023 13:18:46 +0200
Message-ID: <20230828111846.2170668-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't add route for link-local or unspecified destination address
coupled with unspecified gateway address.

When the machine has multiple interfaces, it may occur that some
of them don't have a DHCP server behind them, and there is no
fixed address assigned to them either.

Such interfaces get a link-local address assigned by Connman and
routes are added to them with 0.0.0.0 gateway address on IPv4.

Adding such routes breaks networking because these routes behave
exactly like the default route but they take precedence over the
default and are the equivalent of /dev/null for network packets.

Observed with virtual veth* interfaces created by docker where
only the bridge interface has a DHCP assigned address.
---
 src/inet.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 4039a73c..3465d50c 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -611,6 +611,16 @@ int connman_inet_add_network_route(int index, const char *host,
 	addr.sin_addr.s_addr = inet_addr(host);
 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
 
+	/*
+	 * Don't add a routes for link-local or unspecified
+	 * destination address coupled with unspecified gateway.
+	 */
+	if ((!host || is_addr_ll(AF_INET, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET))
+			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET))) {
+		close(sk);
+		return -EINVAL;
+	}
+
 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family = AF_INET;
 	if (gateway)
@@ -745,6 +755,7 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
 					const char *gateway,
 					unsigned char prefix_len)
 {
+	struct sockaddr_in6 addr;
 	struct in6_rtmsg rt;
 	int sk, err = 0;
 
@@ -753,6 +764,19 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
 	if (!host)
 		return -EINVAL;
 
+	if (inet_pton(AF_INET6, host, &addr.sin6_addr) != 1) {
+		err = -errno;
+		goto out;
+	}
+
+	/*
+	 * Don't add a route for link-local or unspecified
+	 * destination address coupled with unspecified gateway.
+	 */
+	if ((!host || is_addr_ll(AF_INET6, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET6))
+			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET6)))
+		return -EINVAL;
+
 	memset(&rt, 0, sizeof(rt));
 
 	rt.rtmsg_dst_len = prefix_len;
-- 
2.41.0


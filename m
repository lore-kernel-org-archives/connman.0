Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584094;
	b=bQAIz8Ft/n3qE5vf8bgjHwkPdYnNtYtJnuQ5VRxYtd5z3VvEBn1dHR1pvSn8HNs9BUOo
	 1HLkTinvUKNApvVPj6x7jokAQ+dP1S8YEvnxXiwTs3UMfPSClS0zko/4CxIUPiTTkGwId
	 RW8QvrG55E8PgbuxtJBw7aqIn36wsa38YKxKArLq+HIbYzLf2L6JEXAddJo7zMgPphB8g
	 BVujL+ahDmVIHPCwwhhpe8zFv3rURMYCKoRvXEMkaKmn9l/IFrkdMl0s0kx1BouMTvEH3
	 1V4GFfumeXixBD4NmKXDcbT6cOqt6XePkxWwlgHhIEgIK3vZwarEYeUMbd79IPN7TxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584094;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2dF7f1eoeHnw/x4PKO4ZX7eCZJn5rdFe06kw29o5fk8=;
	b=FeO5RrEJUavXnpFIEsU8Nsb08lGoFalgRo8mqw5/+B6UfOHr6OCFQYUITfzCX7k4sxl+
	 Q8m8/fscBH/GJZj5WTVvpdPYsxkvrw4N0cdMSteG2NJ9egxnqpPdUbq0XNlxH+STwtmHk
	 HoISt9hayENOdMyrxSzIwmoLhccS0ZeJbe/S1bR5hq15EEzLZdVANTUr9rbBkEnFkLM7j
	 bG39MbtoeIhSe7nwvCo5m3ZyhhNkep53KjWpuGQvGFG9sj35FKKLwfxwontJ7n22mRqiT
	 Y2tF+g1WwDrKQDpdBVJfZ/XetAVUoXU+j2AKSuAHXqGXMZncIkzyqZcAQ9zR9m+l0Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODUgmaZp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02D606A335
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODUgmaZp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584093;
	b=IQFH915/qyqW3Cp+f6McQ65T5ujJTblz/YaGpar+yWrAdlaXhwOQ6qXzjUUke+CCGFVF
	 ems3CHUpaEkmouFg4c+CfvYZYq/gyL0MQzY8L0K2FZ/YtVzbheDM7iH8KC/mSofOiTeq8
	 9bXZ5MoTTllHUxtWyH7jODR76EU2vP2oTfWXctUx48drYf6A6YzGVFtVfvwWCwhCBUwD1
	 dhwKE81S+yRw4lJ3W+8vSJr17oleEL2H3eVKdVLZsWO+LL9oUOrLUMPItI82tk53eEfXr
	 K220DUwOXDhWi1G1uUep8go3Z0dnlk6JSeMX337LfrITJPThNXYzevvL7ZSjTMRXqMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584093;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=2dF7f1eoeHnw/x4PKO4ZX7eCZJn5rdFe06kw29o5fk8=;
	b=XZRCpsr+ImzNaNrOVPsx3i2ctDsGKDB+b6I4gLjNYiPlvWvPn9Rg0h5B9N+8lW+qrfrK
	 ooEyGe9zI88IMcePzXu5rqoK3SUoSCfz/dlxWPQx1MAg3Mo7FDeto8r4RzKldLN6sfRoV
	 UwpmZ8tsaOn3RXJNwkkON+GMhv4AoJ2Ko1pyz2k13fzsRefu5NYwTni5zeMQIl+NENKkY
	 yz/exRU9ARvEZukgPQ+hD2Nd9cvTQjO4RwB4+SzHt3a3SargR/JlTUkFngQffZh4bnxQF
	 WFbFKZdUJASr9lw2NebpVa9Xz9LTHmhAWaXkL13EiO5CpcLFusZ+H81FbhCQasHMdDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CAE771F000C5
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584093;
	bh=2dF7f1eoeHnw/x4PKO4ZX7eCZJn5rdFe06kw29o5fk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=ODUgmaZpmE3GjG8C0kOzxyvW8sayTzUIULNhWNJh4NoINKCYAT2fb9DyrH0vb9eGr
	 Q5nIwqt0JfKit+Gq1TxHZZ6xaFIsg+qNvt1wv3KSeFibk4/VyiiFtkk4fZpdfJVAE0
	 2jICeisJSFX5iWlKzFKmCJDDMWUtnxnSmZQPA0g4eYFuObXq0wzvCtT8IOX1AhIFcT
	 xRrTJVKuFZcS6gGLDrOEUYf6fLfYmiQlEu+etXl/0YKRyC5NzQ8clXphtJ99ppTxJK
	 cFbnxK5d0H6isOMAzCbt/5jS8g5Obf9nhn53wbJC5qqm7gmk9fgyuUuTfx+6W9mTMZ
	 T2QC6Xt4EjN2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BFDEE4996F
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:56 +0100
Subject: [PATCH 6/7] openconnect: Do not take _MASKLEN for _MASK in split
 routes
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-openconnect-gp-fixes-v1-6-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=1287;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=QZ8vedk6HgQFH3L8Fjs7zuQ1HtVz3MBoj3nizmjgk7g=;
 b=AIPHSIV5g8xRn4ibUefkGDGJcoi5oAVpp+xEnSjThggCjpnxSn8T9tyOmeWKN4bOTKEOVZeuY
 4Pj24t5lmngBER8z2814rq0+aqhvS454L4UzqbQiM/hGtQ9wb4ofMm0
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

oc_route_env_parse() tested "_MASK" with strncmp() before "_MASKLEN",
so CISCO_SPLIT_INC_n_MASKLEN also matched and, depending on the order of
the environment, the IPv4 dotted netmask was replaced by the prefix
length that connmand then passed to inet_addr().

Compare the suffixes exactly: _MASK for IPv4, _MASKLEN for IPv6.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index 7901a8d7..876d4142 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -1831,11 +1831,11 @@ static int oc_route_env_parse(struct vpn_provider *provider, const char *key,
 
 	*idx = g_ascii_strtoull(start, &end, 10);
 
-	if (strncmp(end, "_ADDR", 5) == 0)
+	if (strcmp(end, "_ADDR") == 0)
 		*type = VPN_PROVIDER_ROUTE_TYPE_ADDR;
-	else if (strncmp(end, "_MASK", 5) == 0)
+	else if (strcmp(end, "_MASKLEN") == 0 && *family == AF_INET6)
 		*type = VPN_PROVIDER_ROUTE_TYPE_MASK;
-	else if (strncmp(end, "_MASKLEN", 8) == 0 && *family == AF_INET6)
+	else if (strcmp(end, "_MASK") == 0 && *family == AF_INET)
 		*type = VPN_PROVIDER_ROUTE_TYPE_MASK;
 	else
 		return -EINVAL;

-- 
2.50.1



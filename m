Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584093;
	b=vKQAsQDM1N2fKPU08hxnStGdlYQ160bUDRL4I+vB8oPihzHMtqOaeTiDMb7lBraklDfL
	 zidoUqU8A9+JItYiIQnvk5KwWeHuct3lxRruH4DdKv8OBk79awu/xx8VF2h98jOXiggpt
	 YmE/15Oha7hZJQlNwqarq/A0igdZEIjTuLuZ1U7AUtJ42m4Zg6V4aberIxknFcGe6ABow
	 y4LP0NmwNO7Pad+qBMnc4qyPzspaZsvA1UPjYi6aHGEYPV2/zgvTOIk+kwQUYm1TJHITE
	 /bhrKbFfhw18kHGhElYjMcf044nn7bWqFk5W805T2lDIA3nZxe6DLE/Ds6G/immKV9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584093;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OoZxN+T936p9F347YzwOL5YryJ0N/9XJijIdAmeGyuc=;
	b=FEoZnL+HJ/6GjWLzqqXHsPw5bh3/DBfmXxzEzxHM4eq8SnU4G6y3fBdqyWf4QXGc2K7Q
	 37s9bjFzIMdkOccbdsaC/GgPW8YRvUyIXwdaDkIA06pBbtklPK2lJY6HHFEwCCPVgPusi
	 N2Ap6G3D+G3WxusZ1n1cFANzmRpRk7CtiO7D8Pl4KGgUkTvFHg6o3znTAZY0RCxxz4HNy
	 tPBt2Ch0F42lQjGA8FwhFqXDyt20djG9AiZe4OjKiPMlpATA8WV9ZvQ+r2Oct9IcZPExi
	 Rey4rs+/sNceg2PlWENu+xYXDLLkjlPv+WZ2U5tfJ+KPVpsR8KnC1Qk77m3yxZpIaOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEblKV2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74147606A333
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEblKV2Q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584093;
	b=sqm2+9shbT8dxtn+Md6TVJDFcP+qTo4zzQCD2IDxpdjS1Y2uPu86Ms+UnlSJ8om1R3do
	 DEe4FeVDjLmPw7Soczkw4wp8uEQlsthk4FnL1ZgqS+/i3Sr5x4KKKS2kj3R9SqrO++mOh
	 WUBV6Csaf6J57kEsb/qoiz97ve+lO1YcXgVoj+vYJ2woiHJXwimjOUwsXbjryLqW78pYw
	 qbuppU/y9pgIjQhgEX0lwU44zcl4RUykwdSYtIdOqTRlCFJM53zapoHxh2Z5cUrSBD4rH
	 6ZW4gLaIRt27ojKTMf7w690d9+AXg9LtnWXePI0wUV7WpdymxIEmzG7a9B1P4LnzK4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584093;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=OoZxN+T936p9F347YzwOL5YryJ0N/9XJijIdAmeGyuc=;
	b=FavhXbPBvkHYUKuskotXRYsoZF91k2stj4ClWtx9bZDnBel/b5skW+kPyW4nQX06omE5
	 hnP51WQS8If8SN/yNn51t7b6PQCgyQShbtvkQFcoGJ4mTPmyu8ENasm8iG4vQT8yRlVsD
	 pTI9yRBnoac+NQyildq8uBl1f/hB8lpGSvyqm7kJdzgHcmhBj5ae5iLdQATkcL8LTaCV/
	 Fn/au4m8wHoZALruJS+OHXhUb8EKj2hviGVRBYfJIvI/ajht4MoCV9jEuMPZYlZ3MomcQ
	 L1sLyuzajaxGBSxwK/KRSIEG9dvK7aoj3JWSKLHLA3kZYTj9s7D/zuCMgLvCtfccuMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C70C21F000C4
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584093;
	bh=OoZxN+T936p9F347YzwOL5YryJ0N/9XJijIdAmeGyuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=ZEblKV2Qgsi5nCEKDibuidBza/nHa40JqqGYln83AIVFSK8JJ1W+HmtKtZsVWOjDb
	 CeGMegUN3IRB+8zOLzmhPBzYzU8RSqW+a+ruB2n/NgWI5fxA966D0Weeme4cp6m6Dt
	 JpO0F3twsd8Z3vImMhhrxnkd1UPQWnusL24mdCGAtIcotuhOq8+azNWMY0EnqPfjWq
	 wu08VWsP36aaJxpXijklE+MX9HkZqcMcp5q0CMe0Bf7kroXtvI0gHMh7IiWGzXp67v
	 W59WJzDKbSnaSY8q41Qt6hy2XD/jtlNtv1QxqXcnuhBLnxgf6rhIIez0qWwBjEC6XM
	 k6O9dt9MDgQFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ABA304996B
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:55 +0100
Subject: [PATCH 5/7] vpn-provider: Signal routes without gateway
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
Message-Id: <20261113-openconnect-gp-fixes-v1-5-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=1298;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=RzDvYQdf2sJ/hchp5S6KtuhyCFEUNm7OdvGDxv1QMfw=;
 b=/LT7/bhaX5/QVPlYhgbDv/ei51lF8Su6mfd1sOJSCybuiFZON5LzCzlFln+e5I0mEJ9DyHLsq
 1yMu/2Er7aYBAiuB/sRCgoeswuAxPc+F9l+12qjccJtShJMv3TJS+Oi
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

Split routes pushed to openconnect (CISCO_SPLIT_INC_n_ADDR/_MASK) have
no gateway, so vpn_provider_append_route() never scheduled the
ServerRoutes change and connmand, which ignores ServerRoutes when
reading the initial connection properties, never installed them. A
split tunnel then either sent all IPv4 through the VPN default route
(SplitRouting false) or could not reach the VPN networks at all
(SplitRouting true).

Signal the route as soon as it has a network and a netmask, the
gateway being optional.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/vpn-provider.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index dafdaffa..e8e24a9f 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -3158,7 +3158,12 @@ int vpn_provider_append_route(struct vpn_provider *provider,
 		break;
 	}
 
-	if (route->netmask && route->gateway && route->network)
+	/*
+	 * Gateway is optional: split routes of e.g. openconnect
+	 * (CISCO_SPLIT_INC_*) have only address and netmask and must still
+	 * be signaled as ServerRoutes, otherwise connmand never adds them.
+	 */
+	if (route->netmask && route->network)
 		provider_schedule_changed(provider);
 
 	return 0;

-- 
2.50.1



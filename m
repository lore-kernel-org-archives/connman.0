Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584092;
	b=b05v37TiG0rjKzhhdzZv3zkIyWYlslH3TdRaVv696GwFJwXXIfCtQPYHEoRHdQ8pp2My
	 em/fPfP6k1ubNTZFcMXc7qnLWoZsCFndw250Zpkf9rFYkaUyYsjegNCUCmgva1TNQApN3
	 V6kItmqDtw5PRTnF1mQsuWfMF9t4yq5sBksQgXh4r3DCNV/Z4CRHfSfJmkjXVQQhLMMq0
	 mD3c7lu3W+SirWC/0DFiQQuY1FPuD5CtZbvi/wKjM1R9FLn6dS4tEOwP8QgS/ot10s480
	 6MmfTZmfO0Z/7mIE17W48jymq5hIhfnjnIrvna7Mv/fiEOR0samZuIAvZMASLawnODA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584092;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LKqiusUC6k9CAUQl7ntCz1PVVX8cHh5vew/gb3VI4mc=;
	b=CHYS2sdCsyXhyYqGIr2D6UYsk008MnqwHhe4g0wSrUH5XTPlP4eVeAh0OSGfJKfunR7r
	 mlOC3ts3sovSt2n0g0MyefCY16AQ6DuYsja1cVG+y1gJAX0SSA5FsBMycSDcVqIuvO0Fx
	 Aq7Hyl1cP4/48Uu7ytVEYiVU1pqW1fEaSXupFVsDcdm8eWIMy+2IMQUwzhZ/0bLm0SL+g
	 9sbTDdQMxmxH1k30PwDYqdlRCLlW69m8ChXdfW2hmjdrbLxSHoj2TMLk5ZRkcEBh5XNN0
	 yPR90iTyF6LNmnSCNhdZvdTqPkK6rtQEKEBShZeO6KoLheLA/VoXm+CjnkneAnyhV6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KEnTDu/O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E0606A331
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEnTDu/O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584092;
	b=U5Bezg+sj7QAxOuaE/4fSeUrZ4OWlXvUNQKKlWGvlEPlz2YyaEGIe/ZfL5e4hLct587s
	 Vrp34k0KiG/PzMmVMEpJZb3lnti7IJK8UVJNaFGHxuWrrRa0TSxxMHQ4wBEKri/Njtk9Q
	 egqU+YNWSYDJ7CW4mUai7e3tan+9pil4oW1XrxGYh/lEKTKS71meiwh5uHTnLhNNE9axt
	 AOVKgv6GCBvwVYO4KfmQF2mA+Z0B+k6DMM9VzrWs1wz5qEnxfziv3JllA3V6ArGVBNCy2
	 oZpMiB5lNph6nUH9eWI0yIMWTKxo1+XUZlk3eUJ0ed2lVH+rZcG+qOic+zok/pnqZpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584092;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=LKqiusUC6k9CAUQl7ntCz1PVVX8cHh5vew/gb3VI4mc=;
	b=pWhqgQhs02bVyF2NZBxiivnpVHU8TaJ5WGLXb35vzQ9PdcvUp4jPNQ1cDxKd08x9R7mn
	 br14TzulzPLTpvCGAuPqfRiv6j6CfYBt3cbZN/FML0DAcGdNTeTn6IdbOaf8xGOsRcZiu
	 mqneWl1Smkoj2r63oovnTQu/3qjKerwWYBJ2zp5xcLjuoyxSwkBXmK59RF8Arw5N0y2Yy
	 HjyfnxethwAY5Hxd8yrkTnHt8EKPBdtiCta980+D+fvHmzumjZtGA0HWivsxLV4IwU5lu
	 qM/SIFnPuNqdZnhj+0boTTeSY6VyhnK8NRqrHzs5y0u6kNXY8dWw68iqZLspDHSkPGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DAEB31F000C6
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584092;
	bh=LKqiusUC6k9CAUQl7ntCz1PVVX8cHh5vew/gb3VI4mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=KEnTDu/OucE9lrC0IHwqsMZIMi9s+4NVdSvexRlLm+Jcbb1rE3cIKqQp0v82JbPNm
	 0zJzL9Z8/Sn/+QgkOOKb6RQbWzt3rQtLkSklHMCCif/5BGuqXHguDxMYsu3sMqRkZT
	 +qTcOnWqITX+Fc+YJUhXlwVvMULFQrUKZCRpbAm0YEqvUr8teL8LygdKhMHbrGcmWO
	 WAcRm4w9W88TZG30sojZYFF1H8tc3CV8FzvYzGjCXSKdrSjBnORv1uAcWZm/u8Al/V
	 TAUYsrCdOtDTonIt6P1bHYS++hgl4RfRSuhDDIU30uRI75ou8tMfEaNHMvj59WzeW2
	 xnK/ESMs5hXPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 660FD47815
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:52 +0100
Subject: [PATCH 2/7] openconnect: Do not treat reconnect reasons as
 disconnect
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
Message-Id: <20261113-openconnect-gp-fixes-v1-2-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=1525;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=h8wCuXfu5LBZiPAFN7yuQFV+dbuBM65vaTOmx5XuB0w=;
 b=+PbEDTbxNakDh3cLgOwSwS0bxDEXPYUwbcuFtNLWEkrPlOab2GYxf8LbNkjRJLMhAr7HDxCIr
 JipgzeI2skhBoEenpHX98b+sveU5capAjMHE86+HebuQ8M78fTAmLnH
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

[openconnect] Do not treat reconnect reasons as disconnect.

When the connection is interrupted, e.g. after the device has been
suspended, openconnect keeps the tun device and reconnects by itself.
It calls the vpnc-script with the "attempt-reconnect" and "reconnect"
reasons, but oc_notify() handles every reason other than "connect" as
VPN_STATE_DISCONNECT.

As a result connman-vpnd tears the provider down while openconnect is
still running: the tunnel is lost, the openconnect process is left
orphaned and the UI stays in the "Disconnecting" state.

Return VPN_STATE_UNKNOWN for these two reasons so that the state is
kept as is while openconnect reconnects.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index 5ea12c62..4585d785 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -292,6 +292,15 @@ static int oc_notify(DBusMessage *msg, struct vpn_provider *provider)
 		return VPN_STATE_FAILURE;
 	}
 
+	/*
+	 * openconnect keeps the tunnel up while it reconnects (e.g. after the
+	 * device has been suspended) and reports it with these two reasons.
+	 * They must not be treated as a disconnect.
+	 */
+	if (!strcmp(reason, "attempt-reconnect") ||
+				!strcmp(reason, "reconnect"))
+		return VPN_STATE_UNKNOWN;
+
 	if (strcmp(reason, "connect"))
 		return VPN_STATE_DISCONNECT;
 

-- 
2.50.1



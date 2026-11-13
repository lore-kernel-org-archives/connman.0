Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584093;
	b=vjjBdbok2v/UCjGQm2AKv4y2whDQOxsgToBbXbVksSCvjj0UtwhYdqUDeaAYGAF7qIzr
	 HObgBhQPJAbKnrJ1UnV+P68dA4h0h6HPoFXbhbuXW0DWqECRLlVgV1QX97EWhHptzJLJs
	 pF20N0o12qImjRZE07DRotCYM+cwmvIDif57TJ7OlX7oTCcWkcC26aFzS3U+byCaIw7mB
	 KrYzVtgRtkY4aLW+7P08qxWNZaCRr2AQoGadtRCfazNGpqLUoj7xsu+tHOJM5bqYWZJdY
	 qspHoctDmlXy0yUBpb0g5a38cqkYrEnPtMBZcJa4Q2oybins63cZgCzRmQLYMQ7HNLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584093;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lZ6hfCMk6UEqJIU7mDtUUGMBYjcD8CPr9CCX2WOhclo=;
	b=W0kWzqaJNhgK4PdMOBBS83HCCA9iL/2d8ObTlCwErMa1W3J6/6xcjSNtIImG2EhYuWgN
	 KFDHs8vgixGU/14zSWhHd6uKJoI7CBPKheVOgv+GePhl6rgAQAkkKRZS4Hj7SWNbL5M8v
	 sv3YYMPi9QJcMZZjzXG5CGWfR0NU5KJanKw4XKu9oassu62I4OQUQD7fB7KW0KzYuVj0V
	 ZsmJ812sFuclajd8GEaGu8CDPSJm5STkRmRGjJpcBF71eFWLF9lyt9CkLY/vsJJ1IGU6r
	 BweI2T3e+dkHSF3OGHdGdc5h6b8vYMR1nmKHnp4s9sBluQ4BMbhnA+o7er/RnMWjtHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg6ls2Yh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D65606A332
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg6ls2Yh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584093;
	b=VYrhaYPZYd7/krmiyRaRAtSiMT/n9zLBsiH77uo5npOiT5AIH3RNnPe51eHSnt63jLjd
	 NfuktY0t9VqqE7AdMV8eIL+muMkFTcNrt2Eq76gqsb3+taAOZ1i+SbOLUpKZ2UKfwW3A1
	 y/RHbMNGq5vRIwOB3uhLzGS0F/i3ln0NS5BQJ3ogs8VY5oPBKJ8gHX3hxiOTPmhp0rhkw
	 ZO9/eWiUnk/Z7/aXgXOQa+5NLt1s2FiENQ3dyPOEvedzoA6/29La+6RRFlM60Jalqw/BB
	 nPiSdaPJsuihmPlWS9hDXWEb5L5WGeBYgMiKY+VsIhx7nmFPemywVVR7AkmkXn9nPcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584093;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=lZ6hfCMk6UEqJIU7mDtUUGMBYjcD8CPr9CCX2WOhclo=;
	b=noa7fillVOd3oV4IKILIczy/5OOdDqa4szV8olGsVBRZTYviD4cVHDPNsgLPOkzHq2nU
	 xEJT5vIp534g6p0o6nu4AuiesZlpm0rAPvsTDGfH7MOBWMPepgwvnvenPLvsY5I0UhBVP
	 pzXr2wvfQHfaVUJKO9SowZpm4VAnOJCe0TC6Qdu5D0sX5w5abBLlDxl2XdxQx5saEUFZj
	 ytd8u4t6svhWmTFD2/8oHGjcXw22JomtfhCQUkiTuad+cgPD/Qw882JqQCTpWJFYORTuY
	 eyonDQG1C3sk6SybKaOYr4jkVjoUWHyc0Wszl6hxz34TqNEcubm8JGsZzGZAYk6Y72w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 039AC1F000C7
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584093;
	bh=lZ6hfCMk6UEqJIU7mDtUUGMBYjcD8CPr9CCX2WOhclo=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=Jg6ls2YhjCLQnRdKXFC4bZ3AbINeWD69Yk7SHxuHlZfl8ok9Gozy/OFr3n6bJwRBU
	 74ftFGe11r6rThWlGcgAyFJtfLA7MWzgCH2UgncAuIhZyzIXt5F+vjgySvyCj21w1f
	 SIRoV374TH9bPQc7QHpCcoeGrw+tmNF103t248vnS4ykL31TjtDe6Rm8h9f/1byON2
	 NRD697i2yYpbA9AaRZpeSlne3VJy1F/1VZkbcPZyR/ActhseXHaWxUFMlSek5mVjmt
	 vFY1txump9o7y5zD/HLowPZV/gw4fjpx9tV0tmzllW4KraRUqU1FxOdwhtjkHRgAbB
	 rK6oBNPfTg3Yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7D02048CF8
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:53 +0100
Subject: [PATCH 3/7] openconnect: Fill the GlobalProtect "passwd" form
 field
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
Message-Id: <20261113-openconnect-gp-fixes-v1-3-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=1136;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=fjQR+ao1UtzVB/b/9INjX1ZWPyBqc18L/LG296YWuSM=;
 b=8D0A/gOmfLIpMzwG1GRQ2grbHUThkRjeB5CjXlLO41z3rjICjhur35MOUlUPM/B/A5IFP14Jg
 WFXdHd77TDmAawOToBLRGfMjVaLoZaMQaWi9cxglviEsaE4+E3HPQJM
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

[openconnect] Fill the GlobalProtect "passwd" form field.

process_auth_form() only fills password fields whose name starts with
"password". The GlobalProtect login form names its password field
"passwd", so it was left empty and the server rejected the login with
an empty password, again and again.

Also fill a password field named "passwd".

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index 4585d785..03adf9bf 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -917,7 +917,9 @@ static gboolean process_auth_form(void *user_data)
 			if (user)
 				opt->_value = strdup(user);
 		} else if (opt->type == OC_FORM_OPT_PASSWORD &&
-				g_str_has_prefix(opt->name, "password")) {
+				(g_str_has_prefix(opt->name, "password") ||
+				!g_strcmp0(opt->name, "passwd"))) {
+			/* GlobalProtect names the password field "passwd" */
 
 			const char *pass = vpn_provider_get_string(
 						data->provider,

-- 
2.50.1



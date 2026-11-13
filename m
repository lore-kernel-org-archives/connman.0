Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794584092;
	b=mps90oUZkR3XlBKfpyOwR6Eazn8ap8wpujPd9WaJNPz4r8eTu1Ct5D1xIL3UwSFulkj1
	 mn6//Vabza2vvxh96g9jw7cyK2y2HlK81XN6FL/oqMyt808QRuXc14fms2sGBLSFdJ7EE
	 x1RKKf6cUTs2unBSOwVj0x3sEMt0k8L3z4W/iMQieu9JKRYyk60gX0Sqm7U0LrILe+PQE
	 5++Z4g6E8gsvNdz1o1FO/PDBxCGrk0HVAaIbahvnr8mu8o/APNeIKhpe8w1gocRJ+2e5J
	 WcnIFFHK8dDxep1p/SFcMX8nAjGafdnlPQwWE7UuX7z3DkWGuCJyFyBxBUvkWHSA4uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584092;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w92mUEJBQu9FDtF+cS0UJD/Q1YR1jstJw2Rr57Dob0U=;
	b=MB7/5uyf74i8cyvh5T6jq86x9j1pxhO5a/ldo3oICQs68xMMRrS9feWwPL7t666DLFb0
	 zl/Kyb0TN11CJ/fTVEarBM5chjwfizrceERg1bR1yqE5++tabbb62ulmr4BiFNCCflC5d
	 9/+xLXOAQ1Z4ZUrHtkaQ27i8aqGUfsoarteuH0pe4A89RHTqquml/MtTpli7pp+VoiG3Z
	 pZ+nPZoj9WkXEhgl5bdIVXUIjE9iw68vMuNGszajBc3HG7YVuBP9TbHZDENEfVXAeDXSH
	 VZoFVYEUonvxtlBO6xxSNcIF1qdh7Em66JdtpASd2GODRi2P86fzHGXm3cT83UwZieg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFZzOn94;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D2606A32D
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFZzOn94
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584092;
	b=xhqiTStJPfZV0Spzq+Y67O6voZu9V7a/zhII+8/bN+BuqkptbuCcpmzQGqGjxEMxft1v
	 Z8hSlBEXGVAKn3PyzeBBSw0iBg/sCLD8s5tblKSwgE+9ARLnoCwhaza4ZxC2k08sJ6rUU
	 WQOwnEiNycvq2vPQTgezldHZ0YlC92VKOisbmac9UycJ3X6wDVSJtpcQuOvZkygOmuVR8
	 K39XxYOcB/5lxQFoUMkaNoPRqD1dCFEnjQE2t8jA8F7CEbhr6/OHIHxIYvoqDrS5Wwfhh
	 2uqmxLAEK61n8SjA9rrH3fFFZFCMCWfRI632PYvzl43SHqJ8/SfZJlz1LdLHJYU66cA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584092;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=w92mUEJBQu9FDtF+cS0UJD/Q1YR1jstJw2Rr57Dob0U=;
	b=1rioetpc76YYADrE4k/S/VCZQRC07iz5ClYgXjB5WqHM0pOOqWZaOsObadKT20S+krSj
	 SWTso9pjb/P1B1FiW06T7z23AhzVKoC3p0SFOMYNeKhHHPch/ycIUO1e2DML5yZIrmOqu
	 0WLzhp1eC/B2eSjj8bLDGlJjLLIVEzYi/F0awPL2Z4DV3WaLISH5enRGeVnOHWI4d34cn
	 Anp6EREZosRvNyzcGKr+XPQJOQPFbbB6mC+smK30jaMWInHffWxzYdZPTXUp9IMRIf7XU
	 cjEDMkDVW5Q51FELSXhS+aSY0b1QaMO9unxCk+G45Oyl6W+5EdwJJs0UhtA4Os0VPLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C517C1F000C5
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584092;
	bh=w92mUEJBQu9FDtF+cS0UJD/Q1YR1jstJw2Rr57Dob0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=WFZzOn94wGuclsVUeE4cR1J9+BB2xm1u/W7A0Se50CyeYBVtpsTam77w8wiy2/mXi
	 QxreExxd4zIGt7sSLumV5dOcHksQo2fXdvAJHC+AyVbUVqqE8AmbATcDBsdlI4BnHw
	 cLnzpvp8dg8s4BJZK/liVb/M6tuvCyT8nyvu6nUq0afeY1Q5niNxBzsb2RBfLyTccG
	 ekE1tZdtp81YO1z5mYd/gbK/z/D0H6D+kTTyQTp2fj+QNtudiCQAN/paJgqWGuspS3
	 cLDPioR0gG86jw5KfL9OwwetHa+5pWXzJNHTsXEjZm7uQ2N1uCyrNwJ9S4cXl5asSh
	 oudUiWCjRV5zQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4E477477FE
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:51 +0100
Subject: [PATCH 1/7] openconnect: Set protocol before obtaining the cookie
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
Message-Id: <20261113-openconnect-gp-fixes-v1-1-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=1759;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=B2eOoJPDN7wXiN/iF0W3kHne01yKJDfCDB/JMINC1P4=;
 b=KW2ueShkRyjnFkIucNm3yfB6r9aDchQd/sr1Ye/FRm8LjeaCdBQ+zo6UKZnwSB+P7MT967DCL
 j+4O3IbYngWCcORmo1KoFw2BXMZnd8ffVvXE2GK9qjex/ZYHHWb8hAy
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

[openconnect] Set protocol before obtaining the cookie.

OpenConnect.Protocol was only passed to the openconnect process started
after authentication. The built-in authentication done by connman-vpnd
with openconnect_obtain_cookie() therefore always used the default
AnyConnect protocol, even for GlobalProtect and Pulse/NC servers.

With a GlobalProtect gateway this sends an AnyConnect POST to the
gateway, which answers 404, and the connection can never be established
with the userpass authentication type.

Call openconnect_set_protocol() before obtaining the cookie, as the
openconnect --protocol option does.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index fb63a1a3..5ea12c62 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -1004,6 +1004,7 @@ static int authenticate(struct oc_private_data *data)
 	const char *cert = NULL;
 	const char *key = NULL;
 	const char *urlpath;
+	const char *protocol;
 	const char *vpnhost;
 
 	DBG("");
@@ -1036,6 +1037,13 @@ static int authenticate(struct oc_private_data *data)
 			oc_progress,
 			data);
 
+	/* Same as openconnect's --protocol, needed before obtaining the cookie */
+	protocol = vpn_provider_get_string(data->provider,
+						"OpenConnect.Protocol");
+	if (protocol && *protocol &&
+			openconnect_set_protocol(data->vpninfo, protocol))
+		connman_warn("Unsupported OpenConnect protocol %s", protocol);
+
 	/* Replicating how openconnect's --usergroup argument works */
 	urlpath = vpn_provider_get_string(data->provider,
 						"OpenConnect.Usergroup");

-- 
2.50.1



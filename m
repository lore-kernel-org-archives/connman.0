Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584093;
	b=adgLZVzfZUFiJGHI2DCwrnOz58muSimm7xb29MFigRQnnIKnN4+9sQx7C4Lxv9Tr4pPJ
	 vSziYOBXeScls4TOEQMhlWrNSFCXBIsOntBCPvqpbRtlxwrewGTorJR7wKy47D1k3VosW
	 00+ablckfsP9rK01j56b5jY6S5rpVgtnMPBiiU2STkRJlVABKuK7JKb8CZ+A1xuaU73EN
	 4znzSgoYfcMg029BQxSYuqhkNJK1P7tteKXnlwU+hxZ1mNDbapgjJWo9YI2PnBb+1c3CC
	 9lE+IgbUKVaGe0PyNcdRSnM5F06G3ABJPCMMMy+q6SgfYkbGQVSa8bU7ZkiTw6KCWnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584093;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=N22sTO4p1xYujt5YJXR058tfMujbRX/F4pjtiOUGgQk=;
	b=n0Fu1+jSoS+oeTqwjjqDP70eCiasaU3ojFhLJPHxx/2bMcoAFdRHC0umgNAtPqwa+IeU
	 V37lJCKfPBwa57+OzNBmUKyDQUUO7UXsa2i5cMddZWiSdDgGLEVtuBJIz2MfWDIP03YsX
	 XvFcWmkgbpjFXx2CE3St7h/Sya7oMtqczSUEMM6zoRYIpiouMkEsCx/WLdr+cTRlibauU
	 6v/+0S2uTa3vGA4fDSeMgMijGSx4enOy/hxuPqncL4aj8Fgep66h1WrZ9t+EP3wtK2ZG/
	 rJCEfHvhR8a6e5i3k/fxMgklVrWmFpkc+12lZ1vlvPTBdbc4r+k/IiZg5YsRXdISuSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4mvR8CE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3877606A332
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4mvR8CE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584093;
	b=iqt9s08W3GD5KVhUshyL/35AWnhTeYIXuUws0sfR+dcjhuiniDlR8T0tYMc80HGGlz3M
	 RgMCRqCl/OqWrqWRnKqtNlCtreyWcA4E5RSNK2/pZ0DQdhi43+HzcY5D71bYY3guHuMCd
	 o5S5hJTU6FM1dEmz1O59efBcdasGAzGFLxEAe+3H1rXRQc9dkxXflqJjJZ7ujRmOqO1sQ
	 QPdczOSGdOWs8oH6wG6xf1alAKt1BMCQPjoWDfSJxptCLkgY4jBPg9hoq1U9bGZvfEaK3
	 CMQJS3D4bx6BT++fx/SqC3X/r4cnDvkJ814eaQHpC7EYkPyg2m2Zu9ENFnGalAH38eQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584093;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=N22sTO4p1xYujt5YJXR058tfMujbRX/F4pjtiOUGgQk=;
	b=oh7yoFp6LK2GWk4cypGZAp2ZUQcXaDWpuELObiAxRMZ/dyMd5xYiBBM3A5MSOLYYhOCq
	 RHsbAu0qrOrB1hBpsSDAoibnoRhpxFgdeBwG0YnQzeTaxm2oknRp0w/44RowuHJ/0CEFq
	 oNXch/He8iRhjCpBX5pdEeNFaOMGF+xq+N4sO6ix7yIUDCTwkPTZMcE3TVpqvK5F/X4e7
	 QazXgqUuZ4V4012ZONA9zBOBVQgoUBn/Ccy6MONrBLKM4HkjbMWEfcfcsqw6hmMDVX3qQ
	 dEKmVHJJ7nHhR4oBQGiEEifi6CW0W81uNTb2id8SQhq6KIsToJZ9Ii1eP46FRVaTGEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DAD381F000C9
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584093;
	bh=N22sTO4p1xYujt5YJXR058tfMujbRX/F4pjtiOUGgQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=j4mvR8CE+QxSFkQLot4ne4ovQm1QE5WnoqjrcqzIK0B1M54pP0HbJK4wpCRBPr1Wq
	 S+IAO49NbBmkyrOgVBxkmNdx/LvCdUTCJArv4JTWlm7WClOF5JbnT3St1rBl4GHG8S
	 JuclipVr0Thpnz3iPBaLDj94DtKk29QuXKnUzgQRoUXSUTJNBZNcsY04KCsjlf9KD2
	 +CN/S03O2qhKpSbQwzDm13isQo4h7bc90CEgH6v2EgbqJ0cgatFGmdFunbrM+eLRDZ
	 2xlyrULzLfHfelmnJ34tkm74Y8joYz4Sa0zKWDn1DFqJVpmi8sxs5bpmIj8HthxMPI
	 GxjyCEraPrgFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D78A349973
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:57 +0100
Subject: [PATCH 7/7] openconnect: Offer the username again on the next
 login
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
Message-Id: <20261113-openconnect-gp-fixes-v1-7-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=2709;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=KBSqCdQfMpgssekgPPwFWdPoKYC0mjws6mr/VymvQzs=;
 b=8YgL+UXWU9hsM4gHf/tIkZRVUxF2ncaMjYvEPL9SFfWAdqx5vCUegpxg4Mj9kvfvDQimmR515
 xC5RPZShLo1ADaPiMfiT6/QIwbPi8albV8HluwRo/fWf9VZKeNvSIRs
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

The username was never pre-filled in the credentials dialog: the plugin
passed the username value to vpn_agent_append_user_info(), which expects
the provider key, and the username was cleared to "-" together with the
password after every connection attempt. Once the cookie had expired
(e.g. after the VPN was fully down for the night), the user had to type
it again.

Keep the username when the credentials are cleared, give the key to
vpn_agent_append_user_info() and do not offer the "-" placeholder as a
value. Password and cookie are still cleared as before. The username is
kept in memory only; persisting it is left to the VPN agent.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 7 +++----
 vpn/vpn-agent.c           | 3 ++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index 876d4142..b8cd3aab 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -483,8 +483,8 @@ static bool strv_contains_prefix(const char *strv[], const char *str)
 static void clear_provider_credentials(struct vpn_provider *provider,
 						bool clear_pkcs_pass)
 {
+	/* The username is kept: it is offered again on the next login */
 	const char *keys[] = { "OpenConnect.PKCSPassword",
-				"OpenConnect.Username",
 				"OpenConnect.Password",
 				"OpenConnect.SecondPassword",
 				"OpenConnect.Cookie",
@@ -1465,7 +1465,6 @@ static int request_input_credentials_full(
 	const char *path;
 	const char *agent_sender;
 	const char *agent_path;
-	const char *username;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	int err;
@@ -1534,9 +1533,9 @@ static int request_input_credentials_full(
 	case OC_CONNECT_COOKIE_WITH_USERPASS:
 		/* fallthrough */
 	case OC_CONNECT_USERPASS:
-		username = vpn_provider_get_string(data->provider,
+		/* The key of the username, not its value */
+		vpn_agent_append_user_info(&dict, data->provider,
 					"OpenConnect.Username");
-		vpn_agent_append_user_info(&dict, data->provider, username);
 
 		use_second_password = vpn_provider_get_boolean(data->provider,
 					"OpenConnect.UseSecondPassword",
diff --git a/vpn/vpn-agent.c b/vpn/vpn-agent.c
index ab6fea55..e58bf2eb 100644
--- a/vpn/vpn-agent.c
+++ b/vpn/vpn-agent.c
@@ -123,7 +123,8 @@ static void request_input_append_user_info(DBusMessageIter *iter,
 
 	if (data->username_str) {
 		str = vpn_provider_get_string(provider, data->username_str);
-		if (str)
+		/* "-" means cleared */
+		if (str && *str && g_strcmp0(str, "-"))
 			connman_dbus_dict_append_basic(iter, "Value",
 						DBUS_TYPE_STRING, &str);
 	}

-- 
2.50.1



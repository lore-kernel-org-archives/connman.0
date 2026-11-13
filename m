Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584093;
	b=BhR98ElPkP1sinheoWnC5Wqg5vJrsHmXObgnOyDBtr3jQVtr+3gGGPA2bYCcdg/iBOY1
	 /lZ7sz+1S5LTUV0E044RC3fiQwEiKjjaaoQ4Ik43KSMNUVaqflOMpGdfwWOP0j3Mf5R04
	 IX3oOUv+cH5mfrU8HCfkFUqougZnSL6vIE+t+2PgY30AI21Pwlx+GeJY86/0QNXtExLSH
	 o3JL54V+vLyl6Gr1TxxaU/mAt8nZhRIJdVyFKPVotNLe6xoXbcjlJYRkT10n6AcY4ZlGR
	 oofKOz5L0AMe1OFla3RZKJUGtkudWuvelieOA9d22YOgUCoa7st3HOJyn+VNPs2J0FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584093;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wpq5oqXrfFMgeoTBkVi9gxsrcQYvd4tS51lIwu2wT+0=;
	b=cdEBDwfdeNBAeuFvSAX4KpzLUkJpL3fxwBLYCjeRZNjI6A7OCBMf2hHtTLC1aA2GA2D9
	 hlkGTgX5QX7nisgORpR/alsQdqEobhKHc+fPtD2B9aC4xmGEGjQeD7J5FSoYBH0Im+04m
	 gzA7puulPiZFdP8TWDJBdl0G/BHCMjN+4TBAES+OOdqUM09hTYemLDijB9cVz1CVqQL7w
	 NZ+GCsgT8Su/NNxOlLqop3ogSh+jpRBDaTMWvUOlXpwOlljes7L1pBJKnp+jaa51zBC5d
	 uJiHQ0hmEEoB/oCVG+kOlrmZQTVBwakxgRm3n1wdZEGZhLbumcnqTPfIl/5gPdVcGGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK25jP4+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE653606A332
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK25jP4+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584092;
	b=IHqMCbsNHffWN9pFqAgF75OTxuFFSLZ9lMaXIdzs2S+L3jW4R92oH6ew0hSjgGZ51Lwp
	 M0xk8sw43H6pby89FGe6HWrEVy/2DW9T5Lfk9e5NztOrlpXXbcTZuXLjFRG6CJtCqmWs4
	 h/PNuodoHyv2wZuT/ui6ae4cdkCIM8trme5ebOxH3L72z76MPjr9VH7VJFmePm1xTlAAL
	 1ePntbDvX6NzA54MdVRSJ9wztxFj/hBVH19KLIvJaS91DtfVmBUl44F6E96jvyjNEIoM+
	 JS7HuGaRdbMD61Xzdzn82kQqxiDTLjRYlZpCMRM3ZauoReWuE/Uyu4r8N82jhk10Qww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584092;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=Wpq5oqXrfFMgeoTBkVi9gxsrcQYvd4tS51lIwu2wT+0=;
	b=yn5gESv+IcZ/pHh6IuSGq/gmvosrMVvcm3QMVjMbwPLjEyPChACfmws8D8yJxs35IzPl
	 cGB1JZQWB1GzCvmxUl/u7+2suSlO0CKk2RPQ86oRSseFOJQiuHd0fkXmlT31fNQ6YjaEP
	 Ocabjc8hoqqdwP82dnh38ggMsCprdtM2OSDDYi8NgJmZGA8Yy9MPUfHUuHgrvG6yTDWIh
	 AwLzqFkNkYiktB9APXLGuNd6CQ7i6+N+yqKl/iKcVefaRE1yQO8JC+CpKUyS0SQUkKstH
	 /QUDEqrc4H98yzuKosiQPli9WamSvnToBNklEs2TsB+f9XD8E7HZcyS39HsghnMMuow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15B2D1F000C8
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584092;
	bh=Wpq5oqXrfFMgeoTBkVi9gxsrcQYvd4tS51lIwu2wT+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=GK25jP4+n/sqSBvE/l4fPInesG7MeqwaYRr9TfqFh4Kl9wYoteauaiae2yIJ4LFQ5
	 znvYWLu0tji+nLQXzcWA574t2p0jWSLfrrD2DBAYsJ4KghDNQ5aYCZqHxHSxjDEvB1
	 oESaVP4KB/z+3Qc98VsgiGe2YdpXRHC+gHcVGCQag7VVAQZpNF7HzL9nQNdPaEEYTS
	 WnC/56sQsOTO0+M71TIhjEQ3BzjiGs/8Sv3mUULPFonQLuDDwUaNPaqYowe6u6nc9L
	 wofaAz1UBANU3i1Q3444If65do8Bq8PH9RcffuJ09Fs/9DcuCS/Hsk9lcvnrTGprWX
	 UIJiUYobG1T2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9630E4953D
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:34:54 +0100
Subject: [PATCH 4/7] openconnect: Limit repeated credential forms
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
Message-Id: <20261113-openconnect-gp-fixes-v1-4-1f7f6922d88f@gmail.com>
References: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
In-Reply-To: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=2237;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=mUj9AmNEhvJsj6vIuOhSebdh13ZYfRNcPvX+3ApgS0M=;
 b=erDPVwViBUCM/9/dMUiG8EO9WdzmJNEWMiirokedV0ZHH4fTsn40u01OCIcb4GYxr2HcxgDyk
 aE1YHzROY98DXVr5WySBiPJKNsJS5XbJvwpkINMF7wb9mayXEMzO+r5
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com
Content-Transfer-Encoding: 8bit

From: Stéphane COLIN <bigbob.fun@gmail.com>

[openconnect] Limit repeated credential forms.

With the userpass authentication types the same stored credentials are
submitted every time the server sends the login form again. When the
server rejects them, connman-vpnd keeps resubmitting them in a tight
loop (about 50 attempts were seen against a GlobalProtect gateway),
which may lock the account.

Give up after OC_MAX_USERPASS_FORMS (3) forms: report an authentication
failure and clear the stored credentials so that the user is asked for
them again on the next attempt.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 vpn/plugins/openconnect.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index 03adf9bf..7901a8d7 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -92,6 +92,8 @@ enum oc_connect_type {
 static const char *connect_types[] = {"cookie", "cookie_with_userpass",
 			"userpass", "publickey", "pkcs", NULL};
 
+#define OC_MAX_USERPASS_FORMS 3
+
 struct oc_private_data {
 	struct vpn_provider *provider;
 	struct connman_task *task;
@@ -111,6 +113,7 @@ struct oc_private_data {
 	enum oc_connect_type connect_type;
 	bool tried_passphrase;
 	bool group_set;
+	int userpass_forms;
 };
 
 typedef void (*request_input_reply_cb_t) (DBusMessage *reply,
@@ -848,6 +851,22 @@ static gboolean process_auth_form(void *user_data)
 	switch (data->connect_type) {
 	case OC_CONNECT_USERPASS:
 	case OC_CONNECT_COOKIE_WITH_USERPASS:
+		/*
+		 * The same stored credentials are submitted every time the
+		 * server sends the form again. Stop after a few rounds so that
+		 * rejected credentials do not hammer the server (and lock the
+		 * account) in a tight loop.
+		 */
+		if (++data->userpass_forms > OC_MAX_USERPASS_FORMS) {
+			connman_warn("Credentials rejected %d times, giving up",
+						OC_MAX_USERPASS_FORMS);
+			vpn_provider_add_error(data->provider,
+					VPN_PROVIDER_ERROR_AUTH_FAILED);
+			clear_provider_credentials(data->provider, true);
+			data->err = -EACCES;
+			form_data->status = OC_FORM_RESULT_ERR;
+			goto out;
+		}
 		break;
 
 	case OC_CONNECT_PKCS:

-- 
2.50.1



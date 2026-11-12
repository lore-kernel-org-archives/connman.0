Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514693;
	b=Ft9orCv09aXOE6/0Uhbm32ez00U2Q+cZRvF4qamF1xcotWiiUPImwccB9j7H2SqrSv6u
	 3rqxSiR80mcvd4hETTHwXOtl7Czy1GzNdf5coviq/54oS7k6GgLUDDRQVy0cpLug5uoQR
	 M9wkFjkBO+ulbz7WVrF14FkIg6088axWTznCt+1lMn+M6JGnWZd/L66z9sGwuowG6FvR6
	 GsB3uRxRfmNg5MMtoQtU+DKha4nOLPeTYsZ+jB6LgEqjFUW2VX3GdC5byGrbn64PxTIYR
	 1tUOJ4RkH+nXPgUrNPAC6/BEK0wfmpXTmKz/AfsSQy9dns/ak8WCsoRr1NU1+KVz2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514693;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=T5UgmurF0qqrU/alHRg0xnUqZdUTOCSRPSCKiVIVtOQ=;
	b=J4SpGBOL8yYkwWHAgfKMZhjjK8fBrLgLkhOAxMSzp6hW1orHUpmFqa74VKNnfX4TxBaS
	 VtUSg96z3/S2x468Dv760uF2FhcKUERt9n7cMBdQzTD+Oq95rmPRQWLYyCffiyUwLhqAO
	 bfTF4/yBbz21Uhe5oBqErZHBR5PSyyp8vohfWlomvt9AoOOGejMcix3MoFhDc4k6feqtY
	 lCEgOTZo/OZJ99K5CzsjeS9S4vXYZRtUEHkhrksaSUi/uEzQ4kBp92n5KrKlhd9sI4Bzy
	 a4mAwQgbEwgj39oYJB4jVPBw2dtZusqkOaFzAVhExm49n6QUaiqWlS83YAcWZQRVS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=dAfUY8lB;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF749606A31C
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 20:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF749606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=dAfUY8lB
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E610716004A
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 15:18:10 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 92FA2124C65
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 15:18:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] iptables: Address -Werror=clobbered compilation errors.
Date: Thu, 12 Nov 2026 12:18:09 -0800
Message-ID: <20261112201809.1626562-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=T5UgmurF0qqrU/alHRg0xnUqZdUTOCSRPSCKiVIVtOQ=; b=dAfUY8lBD6HWOAk1dJr1Rpffg8MQ+gVm/MZieMv7MI9U1VDyhc3OiOCuWF2av2few7gJwu8IVW4CuiljeKEqpnLtYBz7Wcj975lPc2xaqTT0j2ePMvfTCKfxs3EWSzwEeFfdJJS5vICVJFonCtblnEWT3lBY14nG0dhL8Vt2Zgd2iqZofRXQQeJWnXTLzWVm3YeCWZ+BgKSCQeJAgMIJwu8PcrxSJ/qjdrRFyekejrE1yPwu1/hAWsQbUtxBbm5so6ahae3NiZ+EwViFaPkNVk0C+0rFONhsu0G1kXMik5TfL9ihMACLErJAuZobPeI59IcNEk9OUGgU3ha9SWjQFw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This addresses -Werror=clobbered compilation errors surfaced by GCC
in 'prepare_target', 'parse_xt_modules', and 'final_check_xt_modules'
when --enable-maintainer-mode is asserted, optimization is enabled
(that is, --disable-optimization is not asserted), and connman is
configured with --with-firewall=iptables:

    src/iptables.c:2666:14: error: variable 'is_builtin' might be
        clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    src/iptables.c:2666:26: error: variable 'is_user_defined' might be
        clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    src/iptables.c:2667:16: error: variable 'chain_head' might be
        clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
    src/iptables.c:3070:36: error: variable 'rm' might be clobbered by
        'longjmp' or 'vfork' [-Werror=clobbered]
    src/iptables.c:3170:36: error: variable 'rm' might be clobbered by
        'longjmp' or 'vfork' [-Werror=clobbered]

Each of these automatic variables is live across the 'setjmp' that
guards the xtables calls, and C11 7.13.2.1 leaves non-volatile
automatic objects indeterminate after 'longjmp' if they were modified
after 'setjmp'. No current 'longjmp' return path reads them, so this
is not a live defect; however, qualifying them 'volatile' is the
idiomatic way to make that so by construction and quiets the
diagnostic. The cost, a handful of extra loads and stores outside any
hot path, is immaterial.
---
 src/iptables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/iptables.c b/src/iptables.c
index a81a07792e9f..38caa4ea5b13 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -2663,8 +2663,8 @@ static struct xtables_target *prepare_target(struct connman_iptables *table,
 							const char *target_name)
 {
 	struct xtables_target *xt_t = NULL;
-	bool is_builtin, is_user_defined;
-	GList *chain_head = NULL;
+	volatile bool is_builtin, is_user_defined;
+	GList *volatile chain_head = NULL;
 	size_t target_size;
 	int err;
 
@@ -3067,7 +3067,7 @@ static int parse_xt_modules(int c, bool invert,
 				struct parse_context *ctx)
 {
 	struct xtables_match *m;
-	struct xtables_rule_match *rm;
+	struct xtables_rule_match *volatile rm;
 	struct ipt_entry fw;
 	struct ip6t_entry fw6;
 	int err;
@@ -3167,7 +3167,7 @@ static int parse_xt_modules(int c, bool invert,
 
 static int final_check_xt_modules(struct parse_context *ctx)
 {
-	struct xtables_rule_match *rm;
+	struct xtables_rule_match *volatile rm;
 	int err;
 
 	for (rm = ctx->xt_rm; rm; rm = rm->next) {
-- 
2.52.0


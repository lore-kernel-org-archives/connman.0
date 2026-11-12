Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527765;
	b=z68dj37jmhNskozy3VRuQVdEMyDtoGnrZHrdFEzOWCCSR7GfJbB5qFzXdGLVVOxhku/h
	 gSx8WKCnyCHy0bz2Mo5wJ6ifw+bb/uw4DJVBYqy30S9y4j7mHIeYwwGBk6ccMLEvZNKxV
	 zuCLVQ7igvwzLEhFP6TfOYiHsQQ+VmMA5xTeR7M/SQvidS18XqRkt5ENVVGqJIt/FpQcp
	 buH746dd152PvUiReWmyWM/qvWvLHi5mnJFzzXaSTPFSOUHNUw6XmqgY/JjDIB7P01E8I
	 4sc+i/MHQZab5e1Eg/0zm2iohvwhrgQj/1Q8TFR8c43cBbpUq8X7lFNdm2SEY/trvFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527765;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=ryyGO/+NBwVfD2FctIRYwRnsnFzKSxZ1tlmaeo2Foh4=;
	b=LBakiprvvLZThbU6NKn96OKypyj6MTT3lERwq8EUolawnvObN9izKKJaQgP3PDNZQM8y
	 9iY6OXkiScWelSUIUPelSBE2AbE5CqVd8kXwB9bGvGKD4YEQAp8LQCk+qC5Yc44CoioCN
	 Z1OSbXXHV2Cd/l1lOwKZDHmAxmeaBwpA02JOYFfeRR8NwqU1MAXjyfQChbT1gKV3SI/oL
	 lHfWX5npEYoSQiPQhNYnUee6CFjy+Jd8qqw2fpySQ19MUE0Gn+KlaGgEtGvPI36YMNXF5
	 VNEQX6z7Lp/KPArCv9y9plJucOYKxmGHkRzceT1iIOyQI8xcyURi/lgg7eilBu7ACUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=ErCIgAbO;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D0606A321
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 23:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 052D0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=ErCIgAbO
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4D22716025A
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:56:04 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 02071124B8D
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:56:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] unit: Address -Werror=unused-but-set-parameter compilation errors.
Date: Thu, 12 Nov 2026 15:56:02 -0800
Message-ID: <20261112235602.1627184-1-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=ryyGO/+NBwVfD2FctIRYwRnsnFzKSxZ1tlmaeo2Foh4=; b=ErCIgAbO+KRRytZqvVcP1DX7QR+IISqGF8qSnymR0losRd6eO5Uc0WQqb6dl+EhiopUAMwPbLOcRiIgNkie58Qi8fVt5/dXbKKFuDNxN4cHMhN6qb1gQprtFxprgalpRe6wbIDwHFJFFVGlRLd5HA6iIh0GKxjo4r4eQSaZaUVv68LZEJ0NVtiOJz2W9bxs9bmSVvxULIGslTmDDq340LQZ2E2hTCjeOGx9w5LYrCmKAQ5yqn5Ii4ifq5bFnoRraTndYTZR4McoKPuJPZ21WQH58ZvZnnydlltv5L6KqGqtx9TWrbQo2ViuH7PGE8jQbGEdlMupw3nBj/sDSjLr50A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This addresses a -Werror=unused-but-set-parameter compilation error
surfaced by both GCC and clang/LLVM in the 'getsockopt' socket dummy
in the iptables unit test when --enable-maintainer-mode is asserted
and connman is configured with --with-firewall=iptables:

    unit/test-iptables.c:302:58: error: parameter 'optval' set but not
        used [-Werror=unused-but-set-parameter]

Each assignment to 'optval' only changed the dummy's local copy of
the pointer and never reached the caller, so the assignments, and the
always-NULL locals they assigned from, are removed. Behavior is
unchanged.
---
 unit/test-iptables.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/unit/test-iptables.c b/unit/test-iptables.c
index a96d8679f46b..5be41ac683a9 100644
--- a/unit/test-iptables.c
+++ b/unit/test-iptables.c
@@ -302,11 +302,6 @@ int socket(int domain, int type, int protocol)
 int getsockopt(int sockfd, int level, int optname, void *optval,
 			socklen_t *optlen)
 {
-	struct ipt_getinfo *info = NULL;
-	struct ipt_get_entries *entries = NULL;
-	struct ip6t_getinfo *info6 = NULL;
-	struct ip6t_get_entries *entries6 = NULL;
-
 	DBG("");
 
 	g_assert_cmpint(global_sockfd, ==, sockfd);
@@ -318,11 +313,9 @@ int getsockopt(int sockfd, int level, int optname, void *optval,
 		switch (optname) {
 		case IPT_SO_GET_ENTRIES:
 			DBG("IPT_SO_GET_ENTRIES");
-			optval = entries;
 			break;
 		case IPT_SO_GET_INFO:
 			DBG("IPT_SO_GET_INFO");
-			optval = info;
 			break;
 		default:
 			DBG("optname %d", optname);
@@ -335,11 +328,9 @@ int getsockopt(int sockfd, int level, int optname, void *optval,
 		switch (optname) {
 		case IP6T_SO_GET_ENTRIES:
 			DBG("IP6T_SO_GET_ENTRIES");
-			optval = entries6;
 			break;
 		case IP6T_SO_GET_INFO:
 			DBG("IP6T_SO_GET_INFO");
-			optval = info6;
 			break;
 		default:
 			DBG("optname %d", optname);
-- 
2.52.0


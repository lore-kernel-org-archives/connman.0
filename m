Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F631922FD
	for <connman@lists.linux.dev>; Sat, 18 Oct 2025 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760822665; cv=none; b=GTAR86L/JhkKArtQT19ieRAMzjGvXoTvsyFmbqHPozsDc6xF9Mx/aBAgKYCvZeWIwtvxGgzpHHxgeXi2qH8EPA+Mig8UJsvz4bc2RosrbnEGu//OJEuNHR4RXQqDadO5VefFTb8H8dFW3AZccfGrpIiAPd0frbOX+Kdnh1uGs24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760822665; c=relaxed/simple;
	bh=eJumQze/AaPD2enjbV6T5+89EAx9wr8oqRaxqJOFHKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1FK22dN5M9lMz7VPwtf+GdzGMnHmvN5QX0oLPYhfwp/0Pz0qHVRkqngAsfvuq+XThKm0z+2ff9cc7naEwevHUOn4YfeoTB5GA7Mivf4Ps52/KCl3L4SC4m6j5q0Zlfh1SZOgPpOwANABKr/5HvvXrGa1FVbLx0jA4gwLHAlM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org; spf=pass smtp.mailfrom=cold-front.org; dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b=gKRN3diq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEgUWegS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cold-front.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cold-front.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cold-front.org header.i=@cold-front.org header.b="gKRN3diq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEgUWegS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C5E5EC0093;
	Sat, 18 Oct 2025 17:24:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 18 Oct 2025 17:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1760822662; x=1760909062; bh=0rxVhcNvTK
	epnXqphbjpAgpdar0f4NtSf0e4ylkvzYU=; b=gKRN3diqcodKRO2FEwFitfhmXC
	BWo0w/x77XVHcUdFq1vySTzJUbI10f4fZv9b1KS6YdRmzeH27iG9XIppLO1e9jrY
	w40p1v2scAKOaa1PmIbP5XRrtHtTheGj27pa/UYefDwm427hAU1VCrZl+SliLMUw
	yrXCKj6LsIJeydrqK6vdJVVRv60O5iKj+nq81vFj550RBqFBdLUfqWDmVYCuyWPP
	QmRR0L0gnocMcUxvgBACby6MEnzkA2TDitSRgNf8/wMcL1sc0RBTpxkO2cWfNtFH
	tGqgyC+nARphNeBoMty6o+pGOzGptHNc63xRwrvefH5oS5ogSV39OVS6Je2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760822662; x=1760909062; bh=0rxVhcNvTKepnXqphbjpAgpdar0f4NtSf0e
	4ylkvzYU=; b=ZEgUWegSjXUSxsMempCSILhEImkUhHknBT2ICN4Sjh1T8WS7N9a
	m7uJwdSXqnXm+D87AdvUnCFww2rTKX/FDw05Ttv5+1pLh6bFkVeH1VYohjnJ7/Nx
	SOGnK7XS81oB5oWGXtC2K/hAsmpgsPWQwtXxK7+Ds/o3b11phr/bAuxGifaU+Xl8
	fBXGVLt/CFwcimGqPBIx0UindhSj3g6+hiiYRCFTm36G7369lDAFJh4MyXyskOHl
	w6vbQMIfI1vcazDkKTMI3eWb/P95koaEwGvGw7839f6oc9ciKOk3iniWgwqiHqoL
	TpbZu0grA5TR/SdZ/nbtQl0j+jU0Li57zhg==
X-ME-Sender: <xms:hQX0aAleDhdGvixWHSFkpJWg5EiPxmjHha12GgH7zQAic2aUEdZWYg>
    <xme:hQX0aF2_eRD_rI00NiTIkAMOVvK7CgQ6-R80lKADaiAAfft518Acoo_dkBdNWQGnY
    oZKqlbknkrELj3W3aSoM_OQxPaaPr4cigsF7lzDv38AfKPthffKzw>
X-ME-Received: <xmr:hQX0aMT-yKkOm5shgM91ci7koUT5gRLJ-2ZGl28YybSGR2NOxX972h1uQpZX06gOH96Ui5ov2lBeyx0ZrYdcV7WsH_sO4JiYkzzcnAyhTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefluhhsthhinhcuuehrohhnuggvrhcuoehjshgsrhhonhguvghrsegt
    ohhlugdqfhhrohhnthdrohhrgheqnecuggftrfgrthhtvghrnhephefhffevhfektdeife
    evvdekvdektdeggfdtgfdufeduueevffduvefhffekjefgnecuffhomhgrihhnpehgnhhu
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorhhgpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhnnhhmrghnsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhssghrohhnuggvrhestgholhguqdhf
    rhhonhhtrdhorhhg
X-ME-Proxy: <xmx:hQX0aHvaAtw6TwhDf1LlT-nS5Xdz-sTq4P6O8PdeX7F-Wam56Oj7Og>
    <xmx:hQX0aBYGrDrvvfCrEMkF2jnVBATZtTAgB8U7KiNHb8ZIuHU7OcWvMA>
    <xmx:hQX0aMtGltaeXP5YgEWFRctqzrzMybRRKwqqOaSYhixOFVP2Wel1Bw>
    <xmx:hQX0aDE5T4o3DHCeXi02qnB_yB8jXN4EOf1yg9rD-Rp5ZbPnYKXYBg>
    <xmx:hgX0aL8kQIxYZMLxUnNL_-LfWb7hvu7c6RZ9Iq_CTMfLM731LimrnOR3>
Feedback-ID: iea0042cb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 17:24:21 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: connman@lists.linux.dev
Cc: Justin Bronder <jsbronder@cold-front.org>
Subject: [PATCH] client: set rl_prompt after saving
Date: Sat, 18 Oct 2025 17:24:11 -0400
Message-ID: <20251018212411.181909-1-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readline 8.3 crashes when rl_save_prompt() is called without
rl_set_prompt() being called first [1].  This means that interactive
connmanctl immediately crashes upon invocation. As we're about to clear
the line anyways, we can just set the buffer to an empty string as well.

Alternatively, I believe that both rl_set_prompt() and rl_replace_line()
could be replaced by a call to rl_message("") but I don't want to
expand the scope of this patch.

1. https://lists.gnu.org/archive/html/bug-readline/2025-07/msg00007.html

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 client/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/input.c b/client/input.c
index 78319ff8..27c281d1 100644
--- a/client/input.c
+++ b/client/input.c
@@ -62,6 +62,7 @@ void __connmanctl_save_rl(void)
 		saved_point = rl_point;
 		saved_line = rl_copy_text(0, rl_end);
 		rl_save_prompt();
+		rl_set_prompt("");
 		rl_replace_line("", 0);
 		rl_redisplay();
 	}
-- 
2.51.0


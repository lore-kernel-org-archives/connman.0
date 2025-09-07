Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C24A06
	for <connman@lists.linux.dev>; Sun,  7 Sep 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233140; cv=none; b=u5VuE9su4Jm7tFFZSIj+5RUkO3VXhmoWT89BZV0QaeQtHbi31r3EpYDYXakGLL6g/6j/eTVtNfCYBfXdPFFSqCcKLVmEs2I6kdKXj74YRBSj5hDpVCS6Bz2bGPTBFbOt7O+5uTRJt+Gy18LsANTWCzlaUIZFz8rQ1fV5TzHes4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233140; c=relaxed/simple;
	bh=S3cgJ7qkDcIYrOx0G7FKfFKSRXIWgs0mpHgkgsyLxRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rvI0MK6NMCpMbeSPGcwVS19Kwgc+jR6Y6bZQW9I4oXc36pl0vVfZodt/2nrdGxokxCPHCg00ivzK+ZbSld0xxhZIssMnanPx7xvLdTPqC/blxnm2flrtRrWy8x+TNk4UUs01+kn2amzkpwk+P31MyIzWd6bwhf95JBqKOM+MuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=peter.tatrai.ext@siemens.com header.b=FPNh6Oql; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=peter.tatrai.ext@siemens.com header.b="FPNh6Oql"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250907081846355bc8e67100020701
        for <connman@lists.linux.dev>;
        Sun, 07 Sep 2025 10:18:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.tatrai.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lQvEprI4yLFkTgEJuTxz/vKHY3Y5RdehcTqahXuMC/o=;
 b=FPNh6Oqln7vJXUupL8jNUYd2tEdJ48p1WIiIIPxagprl94ZwTaLWLmKVjC1FNkRV48yZU5
 n6MNs5Ob3lnGI6i369eSa0GHr6c/gNwL2tOBLMYBVc4v2xiFht35FBAtpid6E98x4RJULsBu
 DmVDPdZ1qmXWDdS+bW93zRzFDNssKeiAoLu+uj2AoEkDV75tD9G9sKMwB3/L9FOFnZuW+fGj
 iM8OaQ0sQ3XVpg7/HU2Ompm1Ayln2VMQ8cQK8ge9ZGJKvvAYD6lPRFifuLNOZOkdRDqF/0zT
 DqSvZgpChNAEXpeIlyIaMhiRZYYczSswJqrsH7MCkW+Pn/SCEpqndyAA==;
From: "P. Tatrai" <peter.tatrai.ext@siemens.com>
To: connman@lists.linux.dev
Cc: Peter Tatrai <peter.tatrai.ext@siemens.com>
Subject: [PATCH] connman, vpn: avoid hiding implementation-reserved symbols
Date: Sun,  7 Sep 2025 10:18:44 +0200
Message-Id: <20250907081844.1558-1-peter.tatrai.ext@siemens.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328017:519-21489:flowmailer

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

When using 'local: *;' in the version script, all symbols, including those
reserved for the implementation (such as _IO_stdin_used), are hidden. This
causes glibc's libio to misdetect the libc version, leading to a crash when
glibc prints to stdout (e.g., with connmand --help) on PowerPC.

Change 'local: *;' to 'local: [!_]*;' to avoid hiding symbols starting with an
underscore, as recommended in glibc bug 17908
(https://sourceware.org/bugzilla/show_bug.cgi?id=17908). This ensures libio can
correctly detect the libc version and prevents the crash.

Reference: https://sourceware.org/bugzilla/show_bug.cgi?id=17908

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
---
 src/connman.ver | 2 +-
 vpn/vpn.ver     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/connman.ver b/src/connman.ver
index 03a0eec0..b75e90dc 100644
--- a/src/connman.ver
+++ b/src/connman.ver
@@ -3,5 +3,5 @@
 		connman_*;
 		g_dbus_*;
 	local:
-		*;
+		[!_]*;
 };
diff --git a/vpn/vpn.ver b/vpn/vpn.ver
index b8877064..5cad344c 100644
--- a/vpn/vpn.ver
+++ b/vpn/vpn.ver
@@ -4,5 +4,5 @@
 		vpn_*;
 		g_dbus_*;
 	local:
-		*;
+		[!_]*;
 };
-- 
2.39.5


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3A33A6F2
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435090; cv=none; b=OAYwycw/shIrnQ96ThEUG1BrSATchWJmpGZBwzV9rCnrJu57lFACS9ClUhhMZoVOpcbX4+xt/ENJydjqDQgvIzJgkxacdICyVmBo4UsNUf+H7blczjINTrM1BeJwzn6ykMeya3+VfUfmUJVlnYNNFHPiOwLkXtwxRcsElj/3IlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435090; c=relaxed/simple;
	bh=yaD4pNAdijEevJgN7ouiY8j/DcReHKqIaTluMpFZ3ZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN2rjG04BD2ZtaWfHHXI8iHZSMChMFgHEYUGc2Xvay7zCLGz2fKYTDBiN+e+cZTuVubKH63GBB9QAIYtDLs6rK541/Xw2yVJ29HNKO4k+lY4GiDOl7XIqR/bIIJmx7mowVCXODP5n+AbQ7R4FlHnc3DSmv75oAA7sgZYfaD1p+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=18vA7WA4; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="18vA7WA4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ytRm2GmDRDq0jQaKkgI1XZHlDgjdsaaJMPypmX9G+Jw=; b=18vA7WA4+uDb6bkJA+VNPVqD08
	yYg9yjA0tWerAdjZsLZPs/g99bHleTu4qQZ+GSkp+UmD6IOPNTbSrzQfiAlz1HcPbBNv83I7a8azW
	D2t84ZjtZOiY3CppNgAJ4aHwA6URDuKusAk1e2HUAQiOzm0SaDDdOqf4piObaZkboGJqAzgU9Noab
	ZUc/bSqCIrObtKQh6BBteiHVySzJ8qeF8uTc1S3tK7GjzYay9Qq+x+L78xsMkRXA2ywQIFcaNE6sz
	bKRSNsGU72RerS4cOTfZ9HEQF403nWkgCxQfYs8KTAsazC7H0XXeAF5rr/IYrzC4LzPmd+peu939x
	kiPI+qug==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-23
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/9] pptp: Drop loglevel to 0 to reduce logging
Date: Mon, 26 Jan 2026 15:43:43 +0200
Message-ID: <20260126134410.55749-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The plugin fails to connect if --loglevel is missing. Keep the option
but set level 0 to reduce logging.
---
 vpn/plugins/pptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vpn/plugins/pptp.c b/vpn/plugins/pptp.c
index 171f66d4..2ae4e0f3 100644
--- a/vpn/plugins/pptp.c
+++ b/vpn/plugins/pptp.c
@@ -526,7 +526,7 @@ static int run_connect(struct pptp_private_data *data, const char *username,
 
 	/* Create PPTP options for pppd "pty" */
 	pptp_opt_s = g_string_new(NULL);
-	g_string_append_printf(pptp_opt_s, "%s %s --nolaunchpppd --loglevel 2",
+	g_string_append_printf(pptp_opt_s, "%s %s --nolaunchpppd --loglevel 0",
 				PPTP, host);
 
 	connman_task_add_argument(task, "nodetach", NULL);
-- 
2.47.3


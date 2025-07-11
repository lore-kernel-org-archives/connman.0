Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9772E7BA4
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=TvsrcvvFMFQ6sKiaJQqxMAkTaHz1bvyrSKbh+2XcisuOCP+w/GVSLvbHjAZQuBm9woOyKPLbguxb06w4Hs0cQT2ElnvNRKWoppwk+cVhwfPzSo2CVHw+5/tkozxD0dd29L2l1qmsewdZuEOjFOeREsmAPdpeB/mS6i2BfXdImt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=elCcltYFEVf5DTnnQ7mBVMt8Ig9IPfuBUbujjFRR0bU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEhZMDt7AuHo4WtrlJkhMlzbaKKs/yMaXkL1F9Ng1tNNSF4r3hsRuR2tlydXcmAcG1uyhWTIiW7QHxIA+/xWfbxXhA6t6t1HP236YR0M3++mOa5NAwzxqLyO1Po5FyQgU++1k+plDVoEl8hWpmVVYWSXuc6tqTkPDn1QDqlLSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=tXniI2dO; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="tXniI2dO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aaa6mCWObOCeD+66hhxBz6bJbBhxv/c/b+LoCC7tPeo=; b=tXniI2dOYDxKrvUTYT/JaetfJB
	5QN4HBr7QKrMuS5e2R0oEYr/KoljTQqK5KhhlyKnqCyraQFOq1q2f4f0H7k0wL9oSBqIXUZ+Bex9M
	23tZ2OSD6LN5pES4FgI8qFsVep1iN46CLaYNAKH1O2NUJC7otuiA67CMmwb3Jy8hRSIR+Z5ZQOY1U
	8yqnM8kSyJfN+1sBNka9DxhQvYnWA47iVO5CJIxPwMmdAoG+4xwZSZDN/EhFlcyHV/BugtTzRSCH1
	nysvF00la9gbuJ39nQ9kiB0/I1Xnej3pgcpvk1jBh1WBjKFcTEg6LnpZZgAu4usFX4XoNRzuJRyef
	K0Z+f5UQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj0-003kbq-2f
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:42 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/45] agent: Cancel agent request on NoReply D-Bus error
Date: Fri, 11 Jul 2025 17:26:52 +0300
Message-Id: <20250711142736.1757060-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Handle also the NoReply D-Bus error as this is commonly sent back when
the timeout set for the request is exceeded. Canceling the request later
becomes impossible as agent->pending will be set to NULL in
agent_finalize_pending(). Thus, making later calls to
connman_agent_cancel() to not to close down agent dialogs but instead
they are piled up on top of each other.
---
 src/agent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/agent.c b/src/agent.c
index 23517d9b..e2d1ef09 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -201,7 +201,9 @@ static void agent_receive_message(DBusPendingCall *call, void *user_data)
 	if (dbus_message_is_error(reply,
 			"org.freedesktop.DBus.Error.Timeout") ||
 			dbus_message_is_error(reply,
-			"org.freedesktop.DBus.Error.TimedOut")) {
+			"org.freedesktop.DBus.Error.TimedOut") ||
+			dbus_message_is_error(reply,
+			"org.freedesktop.DBus.Error.NoReply")) {
 		send_cancel_request(agent, agent->pending);
 	}
 
-- 
2.39.5


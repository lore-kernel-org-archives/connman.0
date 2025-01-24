Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2557224B0A
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745206; cv=none; b=Wmmy36dr0p3uNLiPGkk15yKtTmoGxTP0SRwZwvYjFSfYMXqzL6Clv4U8CPq3yq8lwZFnYktPdx2D1XIJGCN81LMlxbExZKaBlfSRxkX5lYzMwjwnMCwmH1PCnvt6LzU8MXjdS9NxgysmcnjynTSXFJJMUcg9GMYtpgQymOJaShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745206; c=relaxed/simple;
	bh=elCcltYFEVf5DTnnQ7mBVMt8Ig9IPfuBUbujjFRR0bU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhtU/8/X2aUGxBcjLbhYUQ6GMRMZAk65tDQ5fV0k5oCvJWzTrEepX/mymGS4DRF4msOSWZBmQHjzCsubN5MFSjlslHJrkAEd2gPqDdyO4zr3d3efGKUAD5MtuDSpaiUhRhkBaQaAlFARgbP1hgkLFX/IGNDh7mwvy6QVDlcQ9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=yyQEdm0X; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="yyQEdm0X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aaa6mCWObOCeD+66hhxBz6bJbBhxv/c/b+LoCC7tPeo=; b=yyQEdm0X+y3sGmBzjAYt1GNbhw
	292zSOB8Uhn+eqAf+KT8I5vNxfQO7I477fTdMeoEugIs+KIzP8a8+vDNQNd6mOwPAyHWjjI5UZ0ng
	o72YktbA1fxiP1P8XI2BTMy/WVC6IiPYn/S1WFFeNQCuqeuC/TiwuxUkxP3KEnV+2TGFDOqx/cxBb
	KGnw10x632tOejS9hFkwfTKJ0MP5gIqCor1ciiUyL5ek7hBlpKMUBLCdi7JYZGA7Zw4CZhEpheWWg
	cltjZvqh5JX/qNGqI5lCEWFPNub/F3sXDz9AIMW3qDxXeknPfuZ+tJEmv3dxcZNlh+RJ5vLH3m/sK
	3jFKNaSg==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-1j
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/11] agent: Cancel agent request on NoReply D-Bus error
Date: Fri, 24 Jan 2025 20:58:35 +0200
Message-Id: <20250124185845.1546384-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
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


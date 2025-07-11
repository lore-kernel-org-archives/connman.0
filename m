Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219D2E7BB6
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244076; cv=none; b=EwtlX/iVgm24vy34vN0J6stoqrLJbIthBeLtRcKeDBCJka6kgZIesF34zs9Hw8EeNn/ool2aDrdAPNOMlUoDKrRyarhEXgUqslLv2x82st+DwjMcJbksokIw7R04OmnBfRFvF6H5sL6Z3ZCG9iP6S83IHelAlhQlQb0dFZs/2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244076; c=relaxed/simple;
	bh=+3iaIsLDPAn4AflHYqSqvoZX2+TadFiXiKPnoDMzZZg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKz7RhCkNg34tlTSMyeHsbNodDQH6t8SynaCix/sSTztZTICC4W7Bm+9eGQ1HrH1PU+8TuUJz02LrpLzzHeC6H/TiWHMddD+6xJPTCjAUMSV5C4NYqSJHSKb4dUgr4RcoHK9N1Ctl552GwlmaN1p4P4D7fhow6dj/l3g6KgnYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=AApzw55d; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="AApzw55d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qVa0sSH0K/CJNT4olYz1WfDI7ea9jVIcUuTtxD/bYkw=; b=AApzw55dYGGop27m+gC4jMyZsH
	0/smWgkiaxKF1XU+AOt9i2xHLmLzj2ABRPxvH7eL1hkE9PPO0fLiSyXjrDJ9xvVO73Q8UAzgt0mIb
	i7S/CdUP/1sNiHA/exrncvsLoqe6ju0/MIeHL9edF29PIMChYQXEHtItQWQ9alT1cCItlcstQ59Vs
	g1Nz/TkjJ/dEHA/Z1urgIAxe7SCsDBQ1vyUln43wKrHcK/r4ADzqTZsd5xLb3z9amD7W3FOKwUw3z
	0AcCjJTJVVmFmFTnZTmPBIGCIMPSKyRxeMyebhB+1CsOlFecOqx7axl3yqv0ABv3gZkH71No9O4e/
	mSOAZh0Q==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-0t
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/45] doc: Update VPN documentation for association state
Date: Fri, 11 Jul 2025 17:27:02 +0300
Message-Id: <20250711142736.1757060-12-jussi.laakkonen@jolla.com>
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

Add brief descriptions of the association state. Add it to parameter
descriptions as well.
---
 doc/vpn-connection-api.txt | 4 ++--
 doc/vpn-overview.txt       | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/vpn-connection-api.txt b/doc/vpn-connection-api.txt
index 2d3e0078..df070957 100644
--- a/doc/vpn-connection-api.txt
+++ b/doc/vpn-connection-api.txt
@@ -104,8 +104,8 @@ Properties	string State [readonly]
 
 			The connection state information.
 
-			Valid states are "idle", "failure", "configuration",
-			"ready", "disconnect".
+			Valid states are "idle", "failure", "association",
+			"configuration", "ready", "disconnect".
 
 		string Type [readonly]
 
diff --git a/doc/vpn-overview.txt b/doc/vpn-overview.txt
index d2d14a0c..74f5695e 100644
--- a/doc/vpn-overview.txt
+++ b/doc/vpn-overview.txt
@@ -66,7 +66,12 @@ VPN agent interface described in vpn-agent-api.txt is used for
 interaction between the connectivity UI and ConnMan. A VPN agent
 registered via Management interface gets requests from the VPN plugins
 to input credentials or other authentication information for the VPN
-connection and offers information about the VPN to be connected.
+connection and offers information about the VPN to be connected. When
+waiting for input via VPN agent the state of the VPN is "association"
+and after getting the input the state transitions to "connect". If the
+VPN does not wish to use VPN agent this can be explicitly defined by
+implementing "uses_vpn_agent()" returning "false" indicating that the
+state is transitioned to "connect" when connecting the VPN.
 
 In addition to basic credentials, there are additional types of optional
 and control parameters. The user can dictate whether to store the
-- 
2.39.5


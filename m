Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AC21A450
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745282; cv=none; b=i8yl7nDuJZnbbqBr5pNcN+0P8JOGGAPu/kmqXlZInIaEdQjdLXn/KP9WGknvg2vFMXKVBYTxYkW7sRlfmxwNuDhWPSd0utXLxVzy0rr1rIIIwTZDwmjcGUKKVHR15VGYMrZXtNyBk+y8LauDIJ4+M+hRrU2QqwZ1uMHuoULaMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745282; c=relaxed/simple;
	bh=+3iaIsLDPAn4AflHYqSqvoZX2+TadFiXiKPnoDMzZZg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAF+2ry4PER13Ry1ScdIY+Tzk3odNC7O7jcxJJ0BnU87d+5Kpmufr/w0FXgSQK9AY3qhXDxBfTkTpq6/0Q5qi74wy2kgRx8s43I+IYcghZPj2mdJDZX3pSstWGM3o3B2cMfdfIhFJ+PLV/VB10TT9junx0MYaro9LlEI6mxO7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=JWuFRnmN; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="JWuFRnmN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qVa0sSH0K/CJNT4olYz1WfDI7ea9jVIcUuTtxD/bYkw=; b=JWuFRnmNQeU0hSClY5qdmR2F05
	+8bQOq4K6zDQsUV3cefXl/dNNBhFQaMeqy/7EE28YOg3KmXNyOYgRPt9BF0ckMnc1Vj581I1sKLF3
	IyyIymaW0DqmfBp/xbI2fetsClaJDufLdbJF0PirO7xGniJO38NyrUb9KN4WkNh1OaksEHVUTf3SU
	iT4x776PVjhhf7dkZPcIOLzQUHlGb0brsJZibuttnkAPhlH1XZGwMgUsAqwM/skNJ4TydJZi6OavC
	aicg7OR6DbVDTMYmwGpLEBS3lTD46ygPbmUlIYKEYICsAkqGnJwsyW75+fis0aQTWEHb5U4fZ+VjK
	6n1xtmMg==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-3C
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:53 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/11] doc: Update VPN documentation for association state
Date: Fri, 24 Jan 2025 20:58:45 +0200
Message-Id: <20250124185845.1546384-12-jussi.laakkonen@jolla.com>
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


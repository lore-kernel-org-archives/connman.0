Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00C27C84E
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099618; cv=none; b=kgOJ3IAJcwD1W8mqTzMiJhbixXOz7oUL7PCI6ghe60e1T3mBsgM48K5iU0sxJqP6CUzbcU6iOaV+psd8D4owjIwJ+NWLcUKlXA68qiYSXtsse2fSMhWkS1CoG1oVlR9KARATNr3XoBwKXgA82hkWjfOm+CWtElvp0BQDJs4nk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099618; c=relaxed/simple;
	bh=/Pt8cBAREe2ePT/GUtGRctlI4Xd9o52To25/Vc76c1c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYNyCS7VCGXf0o8uMtdNzN05aCoZlsANJQM5O4ij3yDQwWHd8vG0RYt7e+UFwN9BIzU4mF2zp8/sYerpEC9hFGwIdyMYbi8oqewe0k+68kWs+YnPzXoyBqPo2bZx+gxdVlMh+aqUYQUJkUxh6DoMIgs05gMS5c3i0SZyhlh6F30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=uPtZqy/x; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="uPtZqy/x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j0c+wT7uG2YDBH00dxmHGHQvX1iSDA+ApxSdKDCzHS8=; b=uPtZqy/xNjvpfb9uLiBu/VFj0r
	zG0KK8XrwpwRP4O34wx8CcMtn4yOJWR+HDllYEQIaGh5yhu045+/U/q18czdcGMy0+kdJcTlSvurN
	TkoSJUAGbIiOfu66JBmVFzocacFXy12z4xfSGWkoeAvh6Pbv66juQ3Vh+O0oExqhfHivb4pRG0LNO
	yxjgez0k4doE5JqeuWq4NXd2DzEUqHo1cf1Svi7BFp7FLOLRAnQlVXKvXaYgckXlw8IbmLHm0eWw2
	zXlv4eB74pcoUmOT7q8OzAMqxFd6e9uVfHUF86t5WZKPqmSS7w0FYrmrdNHusjp9uPfC9hzub5OI5
	k3Ql6D7A==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-1J
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 10/42] doc: Update VPN documentation for association state + agentless VPN
Date: Wed, 13 Aug 2025 18:01:42 +0300
Message-Id: <20250813150214.189282-11-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Add brief descriptions of the association state. Add it to parameter
descriptions as well.

Add a note about using VPN_FLAG_NO_AGENT when VPN agent is not to be
used with the VPN.
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
index d2d14a0c..f5ca8013 100644
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
+using VPN_FLAG_NO_AGENT flag in initialization indicating that the
+state is transitioned to "connect" when connecting the VPN.
 
 In addition to basic credentials, there are additional types of optional
 and control parameters. The user can dictate whether to store the
-- 
2.39.5


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D632248BA
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745320; cv=none; b=rSI2fsoBMf0r0CHSSr7pJZJ0UqWUp3E4/Rv599SwbXld1VA51FNIfhFtW+XQnMAWWobIraPoc4S+ku36KS58tKZRYrjuExJ8ThczVs+bVGrFbmY7k6NkzXzxEBnjUBFpGxJlq2A8baRmama3GLTlMG/moz/PoMedqqnhTQrhVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745320; c=relaxed/simple;
	bh=WGLV2bnx8PWJ4B+jGZh6ftvShg8bRqUjfeR92AM0ndQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saH4hShb28FVl9WB8cGCxXCESc8vwXthT65iz+unlSPNFaz7HdvHvmRm0G8fripLX3nfoBxg3z58oiUzroV5AAeDxKqmcbmR7fpgN/VJsyDI/zaIxHQe1LQE+E/SdtnxTWoqQunEchDBqyVDuqx1vy65r3jd4ptXzl6qnFClx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=RKCgGe0M; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="RKCgGe0M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eS61vsjboJ7zzbZQnprh7PovZIEFHBIt4PUCW1plUmk=; b=RKCgGe0MEifGghZwisWIQi/pNX
	9/giMYqvu/Ipswxfv29fjBk9ynmQLZL+EICRMTAwXQQeojdaR4usJm5boEZKjHIxQRWlUmVufpjFo
	ZMjI5wwMs1OR84YhZQ//PQ2OyZpnyqdw0w0DU/y07HsD9b+u0EHT9MWwr4dG5WrSsXKYJ3m9keV82
	ndPfl/3yD8rfW6sgkubcFLZ0wsMwN03cPAFAoBfZMYw/N+LLsj3cMDwTD9H/o8wjOxQwEVIDjv2l4
	dN1LsUSC2Dwo1nUA/BJvhTPZWmC6dGFvzopzc1y7LwB1Kq9f61wSwLgK56FSaHJijmyTojf8Qa2AO
	c1323BJQ==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2B
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/11] vpn-agent: Do connect state transition after input dialog check
Date: Fri, 24 Jan 2025 20:58:38 +0200
Message-Id: <20250124185845.1546384-5-jussi.laakkonen@jolla.com>
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

When the VPN requests input (credentials) via the VPN agent the
vpn_agent_check_and_process_reply_error() does transition the state of
the VPN provider to connect state when there is no error. This is done
to facilitate the transition from the association state to connect
state as each VPN should use this function to verify the D-Bus reply
and, thus will be called after each reply.
---
 vpn/vpn-agent.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/vpn/vpn-agent.c b/vpn/vpn-agent.c
index ab6fea55..f1cc7e36 100644
--- a/vpn/vpn-agent.c
+++ b/vpn/vpn-agent.c
@@ -257,8 +257,12 @@ int vpn_agent_check_and_process_reply_error(DBusMessage *reply,
 
 	dbus_error_init(&error);
 
-	if (!dbus_set_error_from_message(&error, reply))
+	if (!dbus_set_error_from_message(&error, reply)) {
+		DBG("Dialog without error, set provider %p to CONNECT",
+					provider);
+		vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 		return 0;
+	}
 
 	if (!g_strcmp0(error.name, VPN_AGENT_INTERFACE ".Error.Canceled"))
 		err = ECANCELED;
-- 
2.39.5


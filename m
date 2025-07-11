Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDB2E7654
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244074; cv=none; b=BHAUqbfGCakmhl22dDyFDjmK7MSwpy+zlHnomMRsXP0NlfgPbvoWeVnQQyRctkdWJuPYwpf/GxJL2/nGk1b9KqbLp8iF73OajFPPe2rnqE76EP0Ud31fysXWtBYOra+xa0ltfZkyN1FGVbRchws2Q9FQK+E+LHMKEZk7luVgTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244074; c=relaxed/simple;
	bh=WGLV2bnx8PWJ4B+jGZh6ftvShg8bRqUjfeR92AM0ndQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCVnJL/t68xaZT7/jo2nVnDfopEaBsEfP/7t4cnjDg3DD4rehmBXF0KUhQllXNnRs2ZpC6KY7p/FAsdLXIFzSe7zG2WLjAfw8CkIeLjwV6Jf3L3Ecn106Rjn75S9FDfb5qAup5tWlEhL2Unzx3/zTbb8qOd7+XHLnQ3R9eUYUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=TH21JqoR; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="TH21JqoR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eS61vsjboJ7zzbZQnprh7PovZIEFHBIt4PUCW1plUmk=; b=TH21JqoRZjCJpar9gvWdtVsve4
	8DaWob8ESq7xMloMvEPDqvEQlv7AdRi1cLkRZ837XwtRmnWuIKM/n2AWA2mwOJatL3FlWV8mLv5e0
	RMC3asl2pj0zZez8ycfkFLW0YHM/rPUBU8MCIJiX+ojqQq4+OxF49vtJsDiuHHhC2RqAjCTJJ563s
	4uZlQXMzCOrAjKM2ra7aejz0cL3yIBulX3uBQjQ+kKYzl0JDikG2MO0Eoryil+JFwUk+uPnRfmOaB
	iEHcQs+HxFjBhd7Tv+N4tvftjgbGXZOEmcFeIejWtJe8mMdeuhLs+Vq1dz8hTGa6NQHHijO2MD+ko
	AcFEu1NA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj0-003kbq-35
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:42 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/45] vpn-agent: Do connect state transition after input dialog check
Date: Fri, 11 Jul 2025 17:26:55 +0300
Message-Id: <20250711142736.1757060-5-jussi.laakkonen@jolla.com>
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


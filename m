Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0323A9B1
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098947; cv=none; b=edZyc8d9sfs6X16ysZ/xDSLnjdWUyVkFjNvd5rs6mMRvvt1obURKpukDuEVP6uUP9Suy8eatzmPjipirzUMwt8CMkD9H79A1kjbwZn7+8nrGfxBgxzuTT02wsdJLL9nn328u5/F5RvMEcU/UT+VVhEoQnP9zLkFiJNj7KGb7BBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098947; c=relaxed/simple;
	bh=WGLV2bnx8PWJ4B+jGZh6ftvShg8bRqUjfeR92AM0ndQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjFPbrMIqZ78qxsMBvjPhyX++b04qDk99Xt4EJqXq4iqmkBb1SvvI7UgFqBEMfa5Kk6XC6QYhQuGckR6DRph2Egwu6AqrH189oc59g57Nab0EVZOWQUOleGyg+Pohr+QCPrORPCf7ouYxtFHPZLnKA0KBj4qb9hkcLfinZkWLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=uQVofgTe; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="uQVofgTe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eS61vsjboJ7zzbZQnprh7PovZIEFHBIt4PUCW1plUmk=; b=uQVofgTeYvCgwKTpul47vriEKE
	H+ldlLTWzJz9NyF4anoU0fFnWf26cFTL4F3pTCpQxp6fBTb6lbnXKeFssnvG31y8l+gpEEs0JEGGO
	oOhMMy0wTfeQ2aTqpFlvutHuXjKTQ4ahM8ky5abqhrF58y2JVg91G9x79XdRyHYw7F/H+Cco41cEg
	l2YsFU31PXL/dUdI4FxxEiIsPBkURbEI3Av4yH86IZu5sENX66XVWb9vAkA6GBbl3g1oLsvJTICI8
	ibjjReJfuVarzjwjF7jlLBId/3of2kZ4suHsVxji7C0xE/J+KxnEH8tRYbWWvcKB639RGqTBgqcGU
	s4GMmXiQ==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-0J
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 03/42] vpn-agent: Do connect state transition after input dialog check
Date: Wed, 13 Aug 2025 18:01:35 +0300
Message-Id: <20250813150214.189282-4-jussi.laakkonen@jolla.com>
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


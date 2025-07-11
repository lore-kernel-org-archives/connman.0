Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084252E7F08
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=JQb9NO23aj2H0Y+2wlsJm0S8TsohwI2KLw+FO1mgO2P7qT8ZPWxxizdw0I9BVqJIVlTTrJ/cBmKg/UAZ3nGj2ePcliuzIaTh530efLwPHZbJzBbuRoWkdIuiU1MkFX3dJNbbDdIqY+dGGu2SoLmbfpy49kdUxhmh2q8+51bDBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=b61AZKTs88XfBFS4nR6dkhwHoVtpnzcoky+qevdqVP0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aq6B628uz+qkZkEWvCLpDnsPrTOIl9u9wLaXVeGzes/kZN+3NoJrWkP++zSx2kLxOUGSxm2xAlGsyYPctBjFW6sqamS6TOjwNScCVWcsIrEVtJ+cNE27yEk99Fj5fX6O94X5H7nQ/yd9ogxX4f0dozacgSnAAwpW52AL0iwF4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=RvVgBWsn; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="RvVgBWsn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9NmnCHBhSSrWGE2etZ6nUwJEnI7M2/HxS0M9+DcTTiM=; b=RvVgBWsnwEz4Ln0rpqfPyxmNZj
	CWqgfLl3Z1NEMB+Rv/u8Z9bBOoNTyKgReShZQdOvjDzRBSeKxikU3IkSWWptzY11edxf1rr17c0WK
	fk7Dwl2yu/2p7LtniVWz/tZR6nKYUrAR1mr8cmOy/gcDIVHq1nARZi6ZrrISQfGtnw0Bzow2eRqfF
	hagZ6jjug0RLmi9Ae3PSm/KZAoGmILot+0x4J/TLP3oSliugmFUAyKy2UDMfvPugzWU2YmafLXmb8
	ddzZakS6966sKQYE0y/vvWk5c3VaFZ5wQmXkRwUFVphPhl7PjQC3Q8mhyH+jZsljT6PV7XHpIvygx
	Ps1i+7Aw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-23
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 41/45] service: Send the DNS servers of VPN's transport when VPN is ready
Date: Fri, 11 Jul 2025 17:27:32 +0300
Message-Id: <20250711142736.1757060-42-jussi.laakkonen@jolla.com>
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

Add a new property to be sent from the VPN service's path when the VPN
reports being ready. This is sent similar to other DNS service lists
when they change but with name "TransportNameservers".

The reason for doing this is that WireGuard does the periodic DNS
reresolve after getting connected, and the reresolving needs to be
done using the DNS server(s) of the transport service, and not the ones
WireGuard has set up.
---
 src/service.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/service.c b/src/service.c
index 28e6192c..eabd009d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4929,6 +4929,30 @@ static void dns_configuration_changed(struct connman_service *service)
 	dns_changed(service);
 }
 
+static void vpn_transport_dns_changed(struct connman_service *service)
+{
+	struct connman_service *transport;
+	const char *ident;
+
+	if (!service || service->type != CONNMAN_SERVICE_TYPE_VPN)
+		return;
+
+	ident = connman_provider_get_string(service->provider, "Transport");
+	if (!ident)
+		return;
+
+	transport = connman_service_lookup_from_identifier(ident);
+	if (!transport)
+		return;
+
+	DBG("transport %p/%s", transport, ident);
+
+	connman_dbus_property_changed_array(service->path,
+				CONNMAN_SERVICE_INTERFACE,
+				"TransportNameservers",
+				DBUS_TYPE_STRING, append_dns, transport);
+}
+
 static void domain_changed(struct connman_service *service)
 {
 	if (!allow_property_changed(service))
@@ -9396,6 +9420,9 @@ static int service_indicate_state(struct connman_service *service)
 							"WiFi.UseWPS", false);
 		}
 
+		if (service->type == CONNMAN_SERVICE_TYPE_VPN)
+			vpn_transport_dns_changed(service);
+
 		gettimeofday(&service->modified, NULL);
 		service_save(service);
 
-- 
2.39.5


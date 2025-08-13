Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1D23B611
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098929; cv=none; b=YNjrUvB6PL2Wq2oD0+TTgw5N/NysByvwDilkfo3LnAYYyd027sUcsXRcMZ4NCz6l7Ec2RFae75sIF8qtZJLYIDxL7rJy50eK69cUmpqglBxbBxGwHz6WhbZmMWPRjz8TucovkJs5YRneq9BoNCJkSSLAMj0hvMKaLYJGmwOYT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098929; c=relaxed/simple;
	bh=wZTWrMIU6jRJMdpNBKii0FZUjYv64X78dk8jDK6uWWU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYRe2i58o7drKY0WsRi1IFG8IQYrSC968mmm7eopsYjUcCqF9nxJjfH2ELSal5jQbkCLetn5rk0zYYpIWMNVIYOT3RCOi3b6xQJUloxD8lar8VSvoAjl04ihWhGE9qPBzi/eIqV/EV5co0kOFWStVoQ8K71+Fqg4lfAnG8kThZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=qoqQlbVR; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="qoqQlbVR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v+db+4SOfu0PgfYFbZx8Wd/SabOOoGgAdetYm8o4Ixs=; b=qoqQlbVRRDX/MurL/i1R0FKR4F
	89n7cxtT0HnZH1kaurwLPb6EsbT0lEzKHLa4RjdM0GlsZGN3RKYaM+9zO5sudjtmBoQEAd9OhDW48
	2B3l9mR9YGzwqGW2nlEAeQiV9bZxh539R9m6nVkG1H86Rjj1AM7fMXIIfdMHdMrpZ+sn0geRDF79C
	Jik+NrIfJig7q9JuqPcOm6fAp3mNWKclCjIrlxZLFornJeBpfaKn28m+y6u9yBEkJTlOzbgVCa40g
	yTn3eOEA6DSB5/bE4zH9cQbktrTEsTt47xYLu+AY54K0zQ17BJlv5w6T4xPMY1987XG7ln6sk/zvw
	NEwhhzSw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-27
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 38/42] service: Send the DNS servers of VPN's transport when VPN is ready
Date: Wed, 13 Aug 2025 18:02:10 +0300
Message-Id: <20250813150214.189282-39-jussi.laakkonen@jolla.com>
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
index 73f777f3..0fddaa20 100644
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
@@ -9401,6 +9425,9 @@ static int service_indicate_state(struct connman_service *service)
 							"WiFi.UseWPS", false);
 		}
 
+		if (service->type == CONNMAN_SERVICE_TYPE_VPN)
+			vpn_transport_dns_changed(service);
+
 		gettimeofday(&service->modified, NULL);
 		service_save(service);
 
-- 
2.39.5


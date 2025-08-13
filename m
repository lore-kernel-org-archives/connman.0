Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DE27AC57
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099615; cv=none; b=D3+wK0b0aXhWhvwIhXEFm8WjE07OzLCP7EyN0Pfh87PE6wwV2/yFtR6ovH4Z6CGRjHMSBt6C9zBCrPxqL9YoKVXs3FsfTc/kuuxrsHq9RTPUDdNv4a3bSt2UyxeiQK71OsQ4v/xACu+drS7uB/fJfsb3cCGMaHoD/dubZ9PtOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099615; c=relaxed/simple;
	bh=ZcO7jwXIsBusVXQjeL7nZX+qY470i2CpbSQ2VMFZI1U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URgtFJhAcdoxg8EH/0c9YsU4hJu719AF+K8nLJ7nK+vmBuTYoQA2PBDdQJCZ81cpzZtBBvhU3//WgFnT8a7h3eOFxlkYKfXrPE/Q7Gubl6uYXHnttlUTxWcKqsb5omwGfSQLXHayX4P08xC44p2NuiICoWp7dq0GlnM04Mbs3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=pzcUyk/M; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="pzcUyk/M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o52TMTzUKkuZ+tKTYU5jGLCeIieeyjxySDAh3hdAMjw=; b=pzcUyk/MUNbkqQZzcucoIralbk
	tWw0k/jlzASzbiz5WyMU6PpnRCHFivr9KDTfStE1vt4L0VnRpxA53Z+iz8qobSYBHCL9gO6Tw77M6
	7NguRIgfjlyVtHuaN8Z/cpkEK9OPJkvINKRDvOMuyiwDFDlPviUIJj7eZDjn2r1OWZa/mM/kouAMK
	U5KYX8xkMvs11925dmvTMh3BA3MIzs1B6nBJ4pRiBBpmh6wMkiPJb+T4CY8ZyKCfGfV1nfN47vRlS
	FNR1F0IDis9uRMF3nZ8XJMzBjs+4F+GIWWmeVjap2Fgjt8kjGU3T2mE423lA68R0ZONweLJBmBIx+
	pqDVxF9A==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-2h
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 42/42] provider: Add the VPN nameserver routes when connected
Date: Wed, 13 Aug 2025 18:02:14 +0300
Message-Id: <20250813150214.189282-43-jussi.laakkonen@jolla.com>
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

Setup the routes to nameservers when VPN has reached ready state, i.e.,
connected.
---
 src/provider.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/provider.c b/src/provider.c
index d677aa12..3553eee8 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -310,6 +310,10 @@ static int set_connected(struct connman_provider *provider,
 			provider->driver->set_routes(provider,
 						CONNMAN_PROVIDER_ROUTE_ALL);
 
+		__connman_service_nameserver_add_routes(provider->vpn_service,
+					provider->driver->get_property(
+						provider, "HostIP"));
+
 	} else {
 		if (ipconfig_ipv4) {
 			provider_indicate_state(provider,
-- 
2.39.5


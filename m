Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CC1EDA05
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302775; cv=none; b=ENyIczpdqAaYoS6HZ0lmOn89kwh6mQdlwpGkqawDGYoIGWX9A9uihDFWy6lElPcYY3vZ024gLyPhMV6YnG6mCwqsyE9nT+1NlBXtwyQZGVCl1W/N4musy1S2anH6bNNiHeDG4cZWQ2kLSuMq5b5rbSLTAd16Gab8r/BD56iLaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302775; c=relaxed/simple;
	bh=2jerOcL3wMET1aAzvdLkweSHu0xm4yYkFEPPBroEpJw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZgL5/l0jvVGtUUs3OXRUd4SvPiP0xJ1O6wS4S8vQyNKDM0xV5USTwOP0bXF4fdi2Nr4YKns1ATjMe9oiXIVLXQI1i/aNCfWYjvrZWKPbH+eZcN0p8F5k0FteV1GTAd3aeoKU/L+TX8QH5sOgG+lpVfEaLuSAQTKb4Hxpr68P6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=m1Vz3dtS; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="m1Vz3dtS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EK1x/apolGK6/c2Pz1ebAZWvJu+G9pBjpign+7UwYwA=; b=m1Vz3dtS8z1ZafKfUxckaCiW5/
	wxAPJdTHMqEDD/pNpU4Z5dDwLGPkRHk+g34ZMTMOSEDMhNAWjic0jcD6dGdjLlf7bkA7jJt1H76J/
	S17DB/McHI7YZLH/gq4COdBBQeN14NdFzNCRk3u0GjX5n2YybXESCVQsmgqEBfmVT6Bg4NoKD3aQW
	UWCTH1LOFuZKRrDWGh0Xm+p+EO4N1PkZXDK4Z/yjhBiFV71mkhhLmAmN+1BIi99zAy3R+z4iPq7Ja
	pBmrP61oEJ6yjLYqmp/bYWlLLE7bkvFmW8Ez3IkSb/5zXXk/ZOy3RkPJreEYwFaIwDi+Ia9/GKpLt
	zj5ShcIw==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-0j
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 7/8] dchpv6: Set err to 0 when client creation succeeds
Date: Thu, 10 Apr 2025 18:58:45 +0300
Message-Id: <20250410155846.252858-8-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:604d:112d:4f8c:3578
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Fix Clang analyzer warning. Value for "err" was not set when the client
creation is successful.
---
 src/dhcpv6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dhcpv6.c b/src/dhcpv6.c
index 8b683599..a9d2aac9 100644
--- a/src/dhcpv6.c
+++ b/src/dhcpv6.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -2064,6 +2065,7 @@ static GDHCPClient *create_pd_client(struct connman_dhcpv6 *dhcp, int *err)

 	g_dhcpv6_client_create_iaid(dhcp_client, index, (unsigned char *)&iaid);
 	g_dhcpv6_client_set_iaid(dhcp_client, iaid);
+	*err = 0;

 	return dhcp_client;
 }
--
2.39.5


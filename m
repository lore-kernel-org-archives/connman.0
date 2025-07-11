Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464392E7658
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244076; cv=none; b=Z+iYx7vK/CWjRyK7BHBgOz9r2+i1ouua0vj4TzRUPVXwQYcJOTOB1/3FtmVUmdFw4b8wTRf4Y/nRTVPiH0RcZAS1xjqtB6p5jZIuIEWFzgK4F7yFH1ozHT0wbbXO4eV0n4MlzBpfmVr0cshJWnED3FmFG/8UlqBJImq6JGjXlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244076; c=relaxed/simple;
	bh=HCaRYGyWtpTHXdekcicgDGs/9NhQOhrcKvR2ZFS8Wtc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuSQu+ymXqT2kBnL24pPZLZddrQOFFKpCirS0AleJSq3qKwzIw7LBOYS6cV+5IegRTX9b7Ndy+UvCmIQnOFjOipvZuHEv4Q8W2R75Q5S0KzsR2Gq7c1LenZKHWX9UJ/lQEDt0uXJy/xeXfF8tPLJaxVD/dmKUD6fLqhBVc/IFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=m//8G4YJ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="m//8G4YJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AEZ1NWNrr2IMbsM8vvI1Q6QB2E2/nPnVBtTsBgpG30g=; b=m//8G4YJFhAvu/IG9l+CQutAUc
	4JwCgRUWpbntc/jR7Gp62WGPEyg3JtNbgSzcuRfkzcx5QhSv9DsHbbsHJF+5kUXS81mYn0bLy/U1L
	4tX8t/tod4/UnN2T6saehJQSQGHGHzv8zAS7VoSW/aM9fHQQIYh6fK5grSCMCt3/xljYRRQI/+vFk
	b0sxrOjk/jtIDMEMU/2LeHQJ4dfsU6S9Iw9SUdCcI2OBl1yIpcCX1rKHhgkYg5CCEpKxQNQm7U1jx
	+zNN5GSGkxSWYWzw+ODTg0JqC3WS239WnBZjz8DOS7iu/lpLWUhrlnh0AxhOXbK+rnxRCLMrBXh4D
	9wwteWrw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-0I
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/45] vpn: Add support for association state, add state getter
Date: Fri, 11 Jul 2025 17:26:58 +0300
Message-Id: <20250711142736.1757060-8-jussi.laakkonen@jolla.com>
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

Support VPN wait user input state as the association state.

Add support for "State" string into the get_property() driver callback.
---
 plugins/vpn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 332d8e83..854b817f 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -156,6 +156,8 @@ static const char *get_string(struct connman_provider *provider,
 		return data->domain;
 	else if (g_str_equal(key, "Transport"))
 		return data->service_ident;
+	else if (g_str_equal(key, "State"))
+		return data->state;
 
 	return g_hash_table_lookup(data->setting_strings, key);
 }
@@ -283,6 +285,8 @@ static void set_provider_state(struct connection_data *data)
 		goto set;
 	} else if (g_str_equal(data->state, "configuration")) {
 		state = CONNMAN_PROVIDER_STATE_CONNECT;
+	} else if (g_str_equal(data->state, "association")) {
+		state = CONNMAN_PROVIDER_STATE_ASSOCIATION;
 	} else if (g_str_equal(data->state, "idle")) {
 		state = CONNMAN_PROVIDER_STATE_IDLE;
 	} else if (g_str_equal(data->state, "disconnect")) {
-- 
2.39.5


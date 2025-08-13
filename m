Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8411CBA
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100738; cv=none; b=NAIo/0sSLxQdJfooCwSfPhuZ94deozzy7E8+OWFNG5rv8pIPGVu8GvaY7wdp+IGcslXPkYOrwAR65MEUtBQ5m+SwfuSQ8MGAujEtWEcigXrQP8FpJmGq6wQYu49ClzvIr78mFXirhsltY1b47rOW35JMlddYrmcS7nWm/DF5SqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100738; c=relaxed/simple;
	bh=HCaRYGyWtpTHXdekcicgDGs/9NhQOhrcKvR2ZFS8Wtc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOPE1Y1AJx5MEF03dFWUf/6iyBh334jXz/DZTUZgXmJiKcO762vQYdszOeLQV9nps2NX3g1dYsDpj6VIZYL8HLX3kRbGhfisW2NbqiRDmpIL1kAA97BoCS1FhH9NxSynnHov4ngtWhRZsOE8yYi94IfLSB9ixaHagtgolKA++VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=N49DYdG+; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="N49DYdG+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AEZ1NWNrr2IMbsM8vvI1Q6QB2E2/nPnVBtTsBgpG30g=; b=N49DYdG+7E4OedaDQgR1F1P/JJ
	r9Xsl84082oK0uTstqLokDVwCnEYHR6LwwvqVj4htMB9A6hNlGv5eWSpv7Fk75Ra6JnEAMwlvaXC6
	yic8Od0EdJbopxamsYmlzjBZOnYg4h3lxRHoJmeGnfdMkZKgTRkRMEbzcHhQrmmezsDD+1zQmHPCb
	N+N4t2uTC75ltGzSfUCKn9MgRKVfFBW6WZYLj6BA1ZfUSGFNgjTRFR8uD6YTTq3h/S/u2Ji4MOQLu
	KIsWOctciVx/fOkfREsyL1kdeydnD0h09kO4eTCCQC2AE7gwut+5fFFsc50LYPbsopmmTcaQqHhTw
	4SXoY48g==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-0k
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 06/42] vpn: Add support for association state, add state getter
Date: Wed, 13 Aug 2025 18:01:38 +0300
Message-Id: <20250813150214.189282-7-jussi.laakkonen@jolla.com>
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


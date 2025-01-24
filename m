Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514B1CCEEC
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745228; cv=none; b=lPZnNc2fHu3uivcOXAx48WHrXQZlvgcoJ/TKKMCQQZJh/MEIvht6lS6g4KwKGems3OEaL/EwYa9TGg9rCDAEYDXnBZbg4wTA7rVm/R7Q3R4JhwvmNQodgDqAz+gEJ8geJ4M6ifKN+V5LUY9YpdyLhIOnXQ+LmbPfjU4TV8Qjv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745228; c=relaxed/simple;
	bh=MRT8+R9+vykFzva1mm1ab322P8AlD8wocobXgvCTeXs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWtbqbuLNKU5Irpw99Q245yuhv0/kN79DTeu1Jha+rhoa1F5cIJDEou5+yeeMZTF9h1UzMnboLrXhcqwM+5DJuDOnq0jhBhu2yoaxenavHerCOWka5rC3LTlPyibeqx15ewgCKyN+MUUC6AA8cDWdMaWFLK2jMQAL+kWd6zvg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=1NI3oy0j; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="1NI3oy0j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5jEUb3mqeN59ircENUXxQLCodnRepV5CRcDFhkiRTys=; b=1NI3oy0jxXk9l9igv8L88eQdBe
	b6MnJ4n2Tr0Nx7+2Tlhs9Wt1CRNzQi24T8Tu8/cdyvZNlp+RiU8Jwyfq0V2JgbYUS6vpxbEtkR9lX
	V2fiN/OcXLuUxNnd6z7y1O7NIc6Lo3C/qQFXHV+3u6SEtVxdiVHeSl/JzkMDceoepGTyGdFf9YrFx
	z2p82H9eqSu+SjVfAZHzq1dS3RqL39Ckcljz2uCfE3Hog2QAQ7mZtBLrKv7sGm6Fi5yUVrkH1oYm6
	6cNEj1EWia7/Y/DjQoYDOkKvDE4XTSyEtWHBUvx1YGzGYXgA4sUtLJoLr+RUKtr2vDzAgqEKzGIDR
	ufbfNRYA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2c
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 07/11] vpn: Add support for association state, add state getter
Date: Fri, 24 Jan 2025 20:58:41 +0200
Message-Id: <20250124185845.1546384-8-jussi.laakkonen@jolla.com>
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

Support VPN wait user input state as the association state.

Add support for "State" string into the get_property() driver callback.
---
 plugins/vpn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 42396d2a..d9a56ae1 100644
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


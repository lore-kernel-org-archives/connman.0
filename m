Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1C4582EB
	for <connman@lists.linux.dev>; Wed,  5 Aug 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932758; cv=none; b=a0CjjGxv9IRai6UWZAhySrNz5AnCW8XaB6WYwYAmf6aNM5EHpOcJaxXOxHzWAhLjC6cZF+heWZ1XBXgeb8BKPPUJn/+90/WU7u4hLyen/bUvSPF4l/FEOy8ewzZ49y4x5AlaYFyAYm3x/H+mLW5iJbeprbhj0OaejvaiKF+eAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932758; c=relaxed/simple;
	bh=0fM0qpw8iRcqIzqQjZu+vqdLDyKhJ/T7GNfU+azQ+B0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KYSgGTYV8yTvMKadmNI6O8zpJnEglqPdFNl2wJtE6/O4BxY81vaoR6+ZzA+7UCHw7zpusDGCwPc1RyiRgdkeMxH48KVuEX00PRsY40tfuuXwQHsBtuzZIiqG0ENLuEpPPO7rgaa90piPnL7u2MkGbIppyBE+tTFs7r0SMfgH3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=EnTKZNTa; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EnTKZNTa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O8EUQ4pmNQp4Bm5yrtd4vOxIBmZKHHuAr3jJP96jN1I=; b=EnTKZNTai4ZRLxIvBrvLEYpMuR
	8jN9wsmbH6xaiFn1oXmzp6iY5BQCaFIxOlsstG6oCBZVu9togcHipzSdGSbm5GKMkB13idaNkFZP3
	/Jcp73hs3VkThCf729FAXhhdyL9JqFKp1Zmgvr91G34EuVov6iSWiNwyvkJiZtYBkdgHlx+5p9yZb
	oOGkpNd4Zv2xWLMfKXzBkvp92v/UDjWPfcBYk4sUbzbTiKdzzopy8EancZ+YD3H+ngaDREFw0SV0G
	5U5RwEkpHnO4Fp++h84iijpa/N5HFLp5ltmayY+J5kWQfvIlvO9QrSvXM7XiBODp0hr+VofQEOeQW
	CjoBsZPg==;
Received: from [2a10:a5c0:37:6500:8996:1c57:dc23:d92f] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wragu-002qb4-0M
	for connman@lists.linux.dev;
	Wed, 05 Aug 2026 15:25:52 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] network: Prevent NULL pointer SIGSEGV in set_autoconnect()
Date: Wed,  5 Aug 2026 15:25:19 +0300
Message-ID: <20260805122540.240407-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260805122540.240407-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

connman_network_set_autoconnect() can be called with NULL network in
some cases when enabling autoconnect. Prevent crash with SIGSEGV by
checking also the network.

Verified and tested by Dragos Cosma (d.cosma@meteocontrol.com) with
ConnMan 1.45. Appeared first in Sailfish OS on upgrade to ConnMan 1.40.
---
 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 416a7e74..9b010971 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2121,7 +2121,7 @@ uint16_t connman_network_get_frequency(struct connman_network *network)
 int connman_network_set_autoconnect(struct connman_network *network,
 				bool autoconnect)
 {
-	if (!network->driver || !network->driver->set_autoconnect)
+	if (!network || !network->driver || !network->driver->set_autoconnect)
 		return 0;
 	return network->driver->set_autoconnect(network, autoconnect);
 }
-- 
2.47.3


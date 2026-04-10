Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78A30E834
	for <connman@lists.linux.dev>; Fri, 10 Apr 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818842; cv=none; b=LNFekdOnhYyMDPUBW9XOR+w0wHZkTAJVezKbqCvJDjhxhgDHDfixUVTLHdUjTfkMcEFogU3x+3nEDHsXtkdUrLg8c9AeBpNTAx00ZM8edRa+w0eq25CCj2t5e5OZaWqPpZNE+gSDTZZvvrJEbdcMZYY2UucwGXLQN+SsTuBYGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818842; c=relaxed/simple;
	bh=Z4OKVHcLh8kPDUnRh+sUA3JI6/0TcjPqpePC7nr5USg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpkbxjyiCpMLZPQR8ASF+kamOZ4dgWzYx+lF68MxIPjo/G7akyexEsyv0mRCgJpNVGJgNFvkSQbrRYXaT3VE8Q+VZPNqp/7SqNOsSutJQal7az1AB49QUEPXA3LdX+WWL9j85PygyOz6l5cm9+SHJl+Jv/E96oy0MOtUqjl+BWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ckWzqfHt; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ckWzqfHt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OL6cjemXOIeSChAAC/NtkQz1orAWUsi6+KfhOOAhC0g=; b=ckWzqfHtbR/jRFBipSBjwAdzv4
	Pcb+cdc4TAjRfg5gex0kEWFpZgGK9FlU4KWoH8Ca3ad42wOL2X5nxZ6CspjnnywVdcnk14dtbhMri
	u60esUSPwCevWtb8b8Dt4X2dpgD6H1slRBob3Ej3mv80YUeeLlubYrkQC78GnIAI+AcWkwbvcY9et
	+dRBois0afkq3mbQNO+DtNjUy5C1mVud/Sv//uzmKXs8+ogwhQ+hmiChaoi7FrifbHlFB1SGv+A0I
	My1s5rw936b+KfjGZB/Oe+dTTnl7Rsb0nZ5xzStwKQPjb+YFSQzMHP6spPOeFVXbaixKIXVISmeJm
	Ppjz7wXQ==;
Received: from [2a10:a5c0:37:6500:bc58:5597:ebe9:bd51] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wB8xx-00FP0z-0Z;
	Fri, 10 Apr 2026 13:19:57 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: f.liepert@meteocontrol.com
Subject: [PATCH] vpn-provider: Compare using lowercase of type value in set_string()
Date: Fri, 10 Apr 2026 13:19:32 +0300
Message-ID: <20260410101949.1519475-1-jussi.laakkonen@jolla.com>
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
 Symbol: NEURAL_HAM(0.00)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: BAYES_HAM(-2.99)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260410101949.1519475-1-jussi.laakkonen@jolla.com

The VPN type value is always converted to lowercase. When the type is
set via set_string() the comparison must be done also with lowercase.
The issue was introduced in commit 3aa13afdf706dee92f657bf6799d6bd97b81da4d

Reported by Frank Liepert <f.liepert@meteocontrol.com>
---
 vpn/vpn-provider.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index dafdaffa..2833d249 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -2754,11 +2754,14 @@ static int set_string(struct vpn_provider *provider,
 		hide_value ? "<not printed>" : value);
 
 	if (g_str_equal(key, "Type")) {
-		if (!g_strcmp0(provider->type, value))
+		char *type = g_ascii_strdown(value, -1);
+		if (!g_strcmp0(provider->type, type)) {
+			g_free(type);
 			return -EALREADY;
+		}
 
 		g_free(provider->type);
-		provider->type = g_ascii_strdown(value, -1);
+		provider->type = type;
 		send_value(provider->path, "Type", provider->type);
 	} else if (g_str_equal(key, "Name")) {
 		if (!g_strcmp0(provider->name, value))
-- 
2.47.3


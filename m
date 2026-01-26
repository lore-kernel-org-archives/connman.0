Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89933A710
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435089; cv=none; b=CTgw3bUd2UDqCsZxIdEOBZODtoN0mYV/jpRXYQn5143qWG8LQVGJn/NzbGh6Fxrh2lCZC/Y/vcX34rKOaR9TEQfrF3JEI0Sny3NFxhNrYVBw9Wf9IhRShhC/aG+1FByoOFBxsta1qJUxRveeeM5KwTD+Irzv/pyTefYxp4ub++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435089; c=relaxed/simple;
	bh=jGafpoQb7PDyiBdszMimi9E7Mg/wRg7jTXcSpj/tpwg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd7Jwv3/io7Jjl6nD5DAwpKJlp5MuKImps1ttrhHiCTVFn3JBkF5m/eIYhFIkqFbLt1wm9m50+1McwDYBwxUphUwymUYVMxdC3iGBec1rhsgHhpwXeGQ3NxAAK4q7kh6kBpY+fzD/7lGLfezleBafPy1V1U4qFJRONFlgffaNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Fg+cSt5I; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Fg+cSt5I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ombdfP6+brPKspc8UACX6a8neaq4YscFTYoiDM6CaB8=; b=Fg+cSt5IfcBTgK2zkW46nvkWpR
	eU45As3ilPRsVlueiYjaSxUmb0Ka7tPPT5h8hY9f74Hra1+TxRfGVLSOCXdtYfhImmXdOny6M8waZ
	sfxgtFaoqRfVmsxSPF/2q3MxMvoEgnc1iNVA4eWskqEkox1NOhIPCodEDo89RpWfxesBWihYwk33e
	GCsJszUUglO6hhXLY8O1rB3bBwRLjgvaTvyh5jtzCQ1V6kCG0TKcmVvIqNrq0z6LzzNYAauntH0vK
	fNjwSsA2yCuVOAk9w0mG/pp3TNDuYDMAvgafDHD3VccbwCF5Kthu1rVMw9fQXwS9LOe2jZ9vN+PbW
	ZeSLN3eQ==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-2r
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 9/9] doc: Update VPN config options for L2TP and PPTP
Date: Mon, 26 Jan 2026 15:43:48 +0200
Message-ID: <20260126134410.55749-10-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

For L2TP
 - L2TP.LocalHostname
 - L2TP.RemoteHostname

For PPTP
 - PPTP.IdleWait
 - PPTP.MaxEchoWait
 - PPTP.Sync
 - PPTP.Nobuffer
---
 doc/vpn-config-format.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/vpn-config-format.txt b/doc/vpn-config-format.txt
index f2adf299..32686c08 100644
--- a/doc/vpn-config-format.txt
+++ b/doc/vpn-config-format.txt
@@ -233,6 +233,10 @@ L2TP VPN supports following options (see xl2tpd.conf(5) and pppd(8) for details)
  L2TP.ListenAddr     listen-addr            Listen address (O)
  L2TP.IPsecSaref     ipsec saref            Use IPSec SA (O)
  L2TP.Port           port                   What UDP port is used (O)
+ L2TP.LocalHostname  -                      l2tp.secrets file our (local)
+                                            hostname, defaults to "*" (O)
+ L2TP.RemoteHostname -                      l2tp.secrets file remote hostname,
+                                            defaults to "*" (O)
 
  Option name         pppd config value      Description
  PPPD.EchoFailure    lcp-echo-failure       Dead peer check count (O)
@@ -260,6 +264,14 @@ PPTP VPN supports following options (see pptp(8) and pppd(8) for details)
                                           if not set here (O)
  PPTP.Password       -                    PPTP password, asked from the user
                                           if not set here (O)
+ PPTP.IdleWait       --idle-wait          Time to wait before sending a control
+                                          connection echo request (O)
+ PPTP.MaxEchoWait    --max-echo-wait      Time to wait for an echo reply before
+                                          closing the control connection (O)
+ PPTP.Sync           --sync               Enable Synchronous HDLC (pppd must
+                                          use it too) (O)
+ PPTP.Nobuffer       --nobuffer           Completely disables buffering and
+                                          reordering of packets (O)
 
  Option name         pppd config value    Description
  PPPD.EchoFailure    lcp-echo-failure     Dead peer check count (O)
-- 
2.47.3


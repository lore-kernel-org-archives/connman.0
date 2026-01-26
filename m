Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7B78F2E
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435088; cv=none; b=k+0pYZ2nKeKQu2loy8XSEwEi5d42o/9R2ye9vNc1iHUGyQkBAJVjj6mhJWF9nIWLEOsaD1SnUsArFEXXOYNndcImNX8mV+lGSqRRlWfew7PS2100BfvWYA8d0YLqgl8IP9XwPwjdhuppUHejzb5f6m3DNJJTRw2vgliBTvyr8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435088; c=relaxed/simple;
	bh=EF6MOf1q4AZ8Q3yFHomamGs3aE0K17iCR/kDAt0EvLA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OH2a5CJab2aBrS7XYKeQP5bNU/x2CDW5/XacdsvNdl6YEZVM03unUX38ppYpDvXkBEaxyigcDLPwefG7kXCFyAKkBOMQyP0AtM0THT/p5PF0SSoAbUSYHVcWmkt846iBk71tI9gWD19SrqjwwaFgxlE6ZAasJpPPN46BENhH8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=rKd7Uu3I; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="rKd7Uu3I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dO+qjG+DLKhPbr/LypjG5em3GqN9JnTOnlj1azOlDTs=; b=rKd7Uu3I+XeI57LYZQQqX+QfeS
	WOWtldd0iz1jY6k86r2DHLpgpr/3XK6N3WdDSzHRMTy+U3Rn1/rOe4n8GbiPcM97wGMagGbBpmMux
	9SwwLJtNwWNFezWgktSUB4MMWvHdytZcPAZcVhx5L0h/QY+I7PwDcUAGFTlqKgM6Y2Vljc73HZ1zu
	A5WOjrGcncwXkWd0Z1mtyoNauJFPHbHTJmFgvALnz4X0u+NVXEo8XBBUCsuTVMWNlDq6g3CaG5SJL
	XXE1MmUc2r5L7r0rbAiptd0V/+Vg4fPbIQSmDxaTwCpKbvRd3cT7kzHHM5rehH7owstcTpeaizHAc
	FkOjAUTA==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-0r
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/9] L2TP and PPTP fixes: credentials, new options, better l2tp.secret support
Date: Mon, 26 Jan 2026 15:43:39 +0200
Message-ID: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
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

This patchset improves the credential handling on both L2TP and PPTP VPN
plugins with connection errors. On PPTP the auth and connection error counts
are used to detect when connection error happens to not to clear credentials.
On L2TP use the VPN agent error for the callback as it is previously parsed.

Add NoBuffer and Sync options for PPTP. Make the logging to be a bit less
verbosive, it seems that a log level 0 is needed for the plugin to function.

Add better shared secret support for L2TP by allowing the user to specify a
custom location for the l2tp.secrets file with existing L2TP.AuthFile option.
When L2TP.Challenge is set the plugin either uses the system file when AuthFile
is omitted, or the user specified AuthFile or the l2tp.secrets file details are
requested from the user via VPN agent. In case of VPN agent all information is
requested once, including the shared secret, local and remote hostnames.

Address potential TOCTOU cases in L2TP file handling. The files saved in
VPN_STATEDIR could overwrite content of a symlinked contend unless the
O_NOFOLLOW is used when open()ing the file.

Documented new L2TP and PPTP options, and added the two missing PPTP options
there as well.

Jussi Laakkonen (9):
  vpn-provider: Change vpn_provider_password_cb_t to use int error
  pptp: Add Sync and Nobuffer as new PPTP only bool options
  pptp: Fix clearing of credentials and use error int in callback
  pptp: Drop loglevel to 0 to reduce logging
  pptp: Do not clear credentials on connection error
  l2tp: Fix clearing of credentials and use error int in callback
  l2tp: Implement shared secret support using file or VPN agent
  l2tp: Fix potential TOCTOU cases with the created/removed files
  doc: Update VPN config options for L2TP and PPTP

 doc/vpn-config-format.txt |  12 +
 vpn/plugins/l2tp.c        | 461 +++++++++++++++++++++++++++++++++-----
 vpn/plugins/pptp.c        | 100 ++++++---
 vpn/vpn-provider.h        |   2 +-
 4 files changed, 485 insertions(+), 90 deletions(-)

-- 
2.47.3


Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B51EF0B1
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302781; cv=none; b=B8J9tRzCw5QhyhHTlwfC2t07GQMRcNYXAvR5/qOM0Tb3kVK+/o1ANqJ//pNE+Hg1bhx8bFeRUd/qhuvpptdctbysgTphX7tV0B1et+v9djtrYKGxXrvxJ3lrhyT4mrU5H6oaH4GJ4jyBKBETyNuUKicTPj1fPag+eHF46/K/QAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302781; c=relaxed/simple;
	bh=qIPKTm3A0Xcri+HAV9ZnLdWYI7M3dbaKnHRprXo/4KY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Oo2RljP3k+pge78uh7NGYOUjmPgV2mhcCnnXaQsZVDdxuFaQ1ZYGTwMZJ28pKSH9sCJlJ3L4w9599yruXMjlWCoAN9au1Psx9ptaGdzAaGmqA9VijrMour72K6GKePclGUOuL/ITHRaERYsVsLEbIBQSvCGNKdwFH/XY7Q5X+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ii6S837t; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ii6S837t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WtNwqwZrVRKtD0F8IxBCSsoVx3C+U7pZsJniUa1XgkU=; b=ii6S837tCTiDf3FBcEY63BkD7/
	VQA5tDszr3knSMX4Dqi/tHC8PQMLDQNs2/nqWRNaYcu5atpbTGgjUlqVgOgitTYksiJFWsO9M0GZe
	KOEZEIqrIL5j6TPP2AGcZZkhtoaFBi4815W59GI2d7HnBPYkPZrmLwkIOFLbmIogDXAKejrfuEv94
	MI7xHdiKyiofE9kVim7ki0oQx4wbk0VBncBKTKi1ej2tdrTkPWTr6CnSek1s1tYE2nFo+iu3H6KMj
	T3WR/EFr8epY7qe2oKm+FrMjNLxX2aGn8pDSxTAKLyoAoYICGqYeeH0AsufZUMwz2bTT1LUBp8mlI
	rilPBCWQ==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIo-004Gb9-2u
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:54 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/8] Fix Clang analyzer warnings
Date: Thu, 10 Apr 2025 18:58:38 +0300
Message-Id: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
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

This set of patches contains fixes to warnings reported by Clang analyzer.

Jussi Laakkonen (8):
  openvpn: Fix use of NULL private data.
  vpn: Check also vpn-driver to avoid NULL ptr dereference.
  vpn: Avoid using uninitialized prefix_len
  vpn: Fix mem leak on nameservers
  ipconfig: Fix Clang garbage value complaints
  gweb: Do not append NULL body to send buffer
  dchpv6: Set err to 0 when client creation succeeds
  vpn: Fix mem leak of gid_list in task setup

 gweb/gweb.c           | 6 +++---
 plugins/vpn.c         | 7 +++++--
 src/dhcpv6.c          | 2 ++
 src/ipconfig.c        | 7 +++++--
 vpn/plugins/openvpn.c | 6 +++++-
 vpn/plugins/vpn.c     | 6 ++++--
 6 files changed, 24 insertions(+), 10 deletions(-)

--
2.39.5


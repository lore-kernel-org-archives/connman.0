Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378A33F59B
	for <connman@lists.linux.dev>; Sat,  9 May 2026 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334516; cv=none; b=ux8b1nmsV20DSrU5i43gZCll9BvlPBD3PQkreBQkDlnMNjDFbdBtOYfTIgLXKoU3gYQHfZ4QCKoRA9CqC3BZUqm7WcBfZRXndL7WKBZxpGzBDwOXx3uivg+c7EF3CyXJp/DShnpLAjUpaitQOFHW1id+QKTbJq2Af9vExBc4Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334516; c=relaxed/simple;
	bh=qpN44g0rkQMbvK5oLhzidhcsmJGVejXdgwJHzeKpI3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EmDbC4heXAtCPo/H4oqwYVd5ZAdrcPtWSQxf6R8gp6blZA783PeeKZL8NpqnqOPAYWIyKiVcAmikLIY3TrZkGTKwDGu2H+JuWKnxhp/3YRm79isAB8X5zzjw5/se51T+osNwSt3tXR5rOzJWokW++YtINt6Pw5Ti3/MOY2yg9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=rWDtvr49; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="rWDtvr49"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uGzJci3msq34ayjKSrttxT0sASLwfniVOlJ/FwIlGQ4=; b=rWDtvr49jOkSGGv/pBiGIl4YiK
	GXjkvhlJiOY0zhuxjFfUvJm1UgKb3xUHKvDpjr66qBhh5+QeXraSwfoYFDBLbKHZ2ExH/lqrI7vgC
	6dTRyS+pcO0sCuYkp3N87IVHXg/beACbkFa89FFXS1XSn7NEfY1XXG2vA3ltt0nVbQ1Iqy89ZC1bR
	BOY7ZlDNun2QHRVddDPvsD9wub3WfAAFDS/dzd9WxcqAGq35FIM6AKpAWcgXnECz6Unwg61gxepG5
	spfelTZafzgNxZjAMUCkJtDkhiPTrnMBfQ7Qd4yFCW/RIFPzcMZy/Iu2mE7DyGOavFqR081tmEhAI
	CtaYdUfA==;
Received: from [2a10:a5c0:37:6500:41d2:24bc:9d82:eda4] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLi2g-00H1Hp-2g
	for connman@lists.linux.dev;
	Sat, 09 May 2026 16:48:31 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 0/5] Split DNS code and fix systemd-resolved tethering
Date: Sat,  9 May 2026 16:47:33 +0300
Message-ID: <20260509134822.343265-1-jussi.laakkonen@jolla.com>
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
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260509134822.343265-1-jussi.laakkonen@jolla.com

This set of patches splits the DNS code into shared/dns.c from dnsproxy.c to be
used also by dns-systemd-resolved.c. Only the caching of dnsproxy.c is kept and
callbacks are utilized to use caching from shared/dns.c. The splitting of the
DNS code is done to avoid code duplication and to make both work in similar
fashion regarding DNS requests for all uses.

The splitting of the DNS code was imperative to make dns-systemd-resolved.c to
work with tethering clients. By design systemd-resolved does not allow the DNS
requests from anywhere else than localhost and requests originating from any
other sources are treated as martians. To solve this dns-systemd-resolved.c 
roxying the DNS requests similarly to what dnsproxy.c is doing. The tethering
interface is listened for DNS requests and they are then proxied to the
systemd-resolved server (using the same code dnsproxy.c did already use to
this) to make the requests look like coming from the local machine.

The changes related to dns-systemd-resolved.c have been use in Sailfish OS for
over a year in internal use and are included in the next, upcoming 5.1 release,
which is now in public beta testing. These changes have been also tested with
ConnMan 2.0 using latest AntiX (for regression testing, as AntiX uses no
systemd) and Debian stable (with and without systemd-resolved) - no new issues
were found and tethering worked on both internal and systemd-resolved DNS.

The work for making these patches available for ConnMan upstream has been
funded by NLnet foundation grant. The changes are also available at
https://github.com/LaakkonenJussi/connman_ng/pull/1

Jussi Laakkonen (5):
  dns: Split generic DNS functionality with cache cb support
  build: Define DNS server addresses in Makefile.
  dns: Use compile time defined DNS for listener
  gresolv: Use compile time defined DNS with lookup + UDP connect
  systemd-resolved: Proxy tethering client DNS requests to resolved

Changes since v2:
 - Use the build-time DNS_BACKEND_V4 in dns-systemd-resolved.c
 - Reorder patches, so sending this as a complete v2

 Makefile.am                 |   27 +-
 gweb/gresolv.c              |   11 +-
 src/dns-systemd-resolved.c  |   29 +-
 src/dnsproxy.c              | 3010 +++--------------------------------
 src/shared/dns.c            | 2570 ++++++++++++++++++++++++++++++
 src/shared/dns.h            |  232 +++
 tools/dnsproxy-standalone.c |    1 +
 7 files changed, 3099 insertions(+), 2781 deletions(-)
 create mode 100644 src/shared/dns.c
 create mode 100644 src/shared/dns.h

-- 
2.47.3


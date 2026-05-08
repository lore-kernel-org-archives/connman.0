Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853773D1CA8
	for <connman@lists.linux.dev>; Fri,  8 May 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256398; cv=none; b=hF5mF7Bwv8rITm8kyDyYh/ScKiv6BMs/R7FlSVRC3axaVu4+c4464eev1JxDvN7yY4iumWaOul6FAvv3z/Mn7MWzn46Oq58mOdTcZ5Rd8lBbUI/neamjqnhjcp/ZB+suEhjmlzsPmNWbbOJj84q1eZssSKV5THAlH2xi/Zl5fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256398; c=relaxed/simple;
	bh=x8GNOJB38xSxs8CJRs0vEFeGjdGW+NOVahkoLlOHqQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RTuxiJzP3g7zNUPCTT51vjU5zRKI7CM4Jso3WFLwPGM5q+2Hdz0ZfJoQA5oeIBihdxmP/uKml08cz4cceNFWhOFgW4MBwjq/tIvtbrMs2+q6wsx5OfA6zm0+agNHYSj5P3xEFw86C2CqtvsZfb8aIA8vVZPcrISxtV6cmAEPfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=w9bVHeaz; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="w9bVHeaz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K43QqJQOtxWpR6za/E2VyVYhurobtuBPbPRBDGFdxOw=; b=w9bVHeazWa/fNmLgr9UHsmqxU8
	xinLyYAFHtRIr1kCwUZmNLe8JUgzcV6nT3RyijmaURji6n3kP0DMGdSgmbDsGkMy+5skZIQelNWEx
	nqbrSgl50EWgFIe6GL9sn+UBOLXeebfCG/HQHuDUQM8wOAgC4+ru7Wt4F+9XFSQ1PuJpalpWuHEc0
	U6HmkpD1kOWtezdhkKFmu22J8bzoLIATpb6K6xWX9mWPPZjNIShsX+M5u4+TqH+cNTRpdAWWwUE5T
	DZ+8lDtOP6BWyF9XJpobXCp2jK+9xD83PQ1W5sNC7QVu2kuCQsfC8cBjYYCJS65K15wSomETj5K6F
	vuITriZQ==;
Received: from [2a10:a5c0:37:6500:11f6:3d14:7c4:afac] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLNid-00CcPv-0K
	for connman@lists.linux.dev;
	Fri, 08 May 2026 19:06:27 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/5] Split DNS code and fix systemd-resolved tethering
Date: Fri,  8 May 2026 19:05:34 +0300
Message-ID: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
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
 Message-ID: 20260508160620.214218-1-jussi.laakkonen@jolla.com

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
  systemd-resolved: Proxy tethering client DNS requests to resolved
  build: Define DNS server addresses in Makefile.
  dns: Use compile time defined DNS for listener
  gresolv: Use compile time defined DNS with lookup + UDP connect

 Makefile.am                 |   27 +-
 gweb/gresolv.c              |   11 +-
 src/dns-systemd-resolved.c  |   32 +-
 src/dnsproxy.c              | 3010 +++--------------------------------
 src/shared/dns.c            | 2570 ++++++++++++++++++++++++++++++
 src/shared/dns.h            |  232 +++
 tools/dnsproxy-standalone.c |    1 +
 7 files changed, 3102 insertions(+), 2781 deletions(-)
 create mode 100644 src/shared/dns.c
 create mode 100644 src/shared/dns.h

-- 
2.47.3


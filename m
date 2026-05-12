Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBD3E1722
	for <connman@lists.linux.dev>; Tue, 12 May 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600208; cv=none; b=eZNkUb+j7Gb3Gf49p7hSHO8x1ZyCrXaJYPAgAApiMKgIdMFwOYrtv1qbTMimxC8BfhDGphGtLn/ln2magMFB1TYiaYYpEK/Gj+RkyFz1+USuOCD8w4LB61untqFf1BppnrcxoN8NX+nISX9e2hgmSYSfsJI2gA8T5qGM8YIC3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600208; c=relaxed/simple;
	bh=kELbF+8dwuyitt+bfpt2n7OlwpVAoujjchJoFzXR+Tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SJiuL2ecIpuh5jr2ikAbY1Na6KoQdnMD8mEnyevc8ERuAVk279J0xhS8qAO4FgCe1OJud3gl4NqDht7EN35UElmLfE8cIV2ww3Xe14iIjaYtf7Us7fQfdL1AqMP8BNkCnoP/uNiJRQuSsBcfLb9RifIbQsZD2H2Usm546HOXINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=BinAhOXo; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="BinAhOXo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3NSYWELNioaCz/EB2ecc9jTf/5OAILCEHru70VyLoc4=; b=BinAhOXoP1nioX5qRAfP9hMnrO
	Mu6sdCdL9+mG0xDg3zHnJN4lje6WOJeCrXarbYr5zHZq3aG6zKVaEVUq47iAyydubmj7OGhaavjH9
	ZBsPp02822KjG9xhG4oF6nesKQ7AAbj66UJ46JVYCNHPkNO5f+ZHrnRpwbrHEIrvZfyEmACZXXGFS
	RcnB2BMeDt0Ram8vmNH7vQRedHgd6gkh5NH3U3c9XcxbQFvQPnTcF0u2txrcoufUxPlp1SdXU+VDh
	PeH86gNqoj78/mHAdF0l2670uka1Ehuxql2rVXbntBUa8nhRcSSPxdCDpNSGsvEdS29SPPyc9KLtq
	OL/omMFQ==;
Received: from [2a10:a5c0:37:6500:9c0c:5ab0:fb2a:7a98] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wMp9x-00EZ9d-2K
	for connman@lists.linux.dev;
	Tue, 12 May 2026 18:36:38 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Allow to specify a type for devices that have no uevent file/info
Date: Tue, 12 May 2026 18:36:21 +0300
Message-ID: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
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
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: NEURAL_SPAM(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260512153627.443352-1-jussi.laakkonen@jolla.com

These patches add "FallbackDeviceTypes" configuration option that can be used
to define a specific ConnMan device type for an interface that has no uevent
file or uevent file is empty. This will help in "black box" development where
the devices are not properly configured in kernel by allowing to use a specific
plugin with the device, for instance.

This FallbackDeviceType addition has been in Sailfish OS production releases
since 2020. No regression was detected when testing with latest AntiX Linux,
with or without any fallback device configuration. Dropping of invalid device
types was added for this patch set.

The work for making these patches available for ConnMan upstream has been
funded by NLnet foundation grant NGI0 Commons Fund:
https://nlnet.nl/commonsfund.

The NLnet project website is available at:
https://nlnet.nl/project/ConnMan/.

The changes are also available at:
https://github.com/LaakkonenJussi/connman_ng/pull/3

Jussi Laakkonen (1):
  device: Add device string to type conversion function

Simo Piiroinen (2):
  config: Add FallbackDeviceTypes configuration option
  rtnl: Use FallbackDeviceTypes configuration option

 doc/connman.conf.5.in |   6 +++
 src/connman.h         |   3 ++
 src/device.c          |  18 +++++++
 src/main.c            |  60 +++++++++++++++++++++
 src/rtnl.c            | 123 ++++++++++++++++++++++++------------------
 5 files changed, 159 insertions(+), 51 deletions(-)

-- 
2.47.3


Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B82216E19
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153420; cv=none; b=npJwcaLwsjultikZiyKATkYP+EszdUjmL90nfSniBoLTcmsfZF//rUcDxVHV5KvnK2/nTnHqg47+nTHCT5XeM0VgS6rRhvsGimHCGWMwggKqXETk9+Nv31syjjWrelHe5L2L9z5cEJ6fAN8SpuRkzlOigWtFC8Z40qFJpN0MHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153420; c=relaxed/simple;
	bh=zztIDEUaDxdxrDPI1lZNuFp+0o/pmr9kfSju4owSk4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VNl8wfd5vccF/4jagngfIVCkAGlhmVZFjcK+inKXRirXj+sVOeFP3aAa8aTrOR0FmSNl2pUSjPDZp1vb+JQunTn98FVj2h8hDg+oQeD908nLCKJZjIozy6A7SaJNdOPvJxEDHS/DHq44hev7eyJrTRwgyvYTDyPYaF01RR2q8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Y2XELn5d; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Y2XELn5d"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 658A21649CB
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:55 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0F47912516C
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:56:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/15 RESEND] Improve PAC URL Mutation and PAC URL and WISPr Proxy Failure Logging
Date: Fri, 21 Feb 2025 07:56:38 -0800
Message-ID: <20250221155653.760046-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=sE3fGElCAjdLw+jzG1zT/E/YwXuWmEJXpiEDxg5+Zf0=; b=Y2XELn5dK6Jrf1DEHfVsrR30UaTFaRQA+lPoSCBn+eHT1FwSPwmA+Zpd7j1Xus0dyDL+O4WsBP0FhHz2w9AiffPSsjeSZ73oZPX5cmYHa4ZtTQTRdlI516GP57BFNa0w0E3LF6mdIZX0L8sr6HBdTQmKAQVlgDKGrJQLtH+NTgqeyGf3hluyllfgTFk2uSwIzx8aE+jIngvdKq/FhgQkCTDM4tnZYF2R+jKlp/3323LYK1YUW/4qGW6UNTflaDzhekrF+wmAcrVCuTwChxIrzpxKUED+tGKDmQGc4II6J7saTMscYoK2iQ0oLE7m7IcCVF+Hl5z8Sr97FUYLKnEm1w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There appear to be a population of premises ISP equipment (some
possibly correlated with Spectrum Communications in Southern
California, United States) in which the ISP equipment sporadically and
incorrectly emits DHCP Option 252 ("Web Proxy Auto-Discovery (WPAD)")
with an invalid proxy auto-configuration (PAC) URL (such as
'http://wpad.lan/wpad.dat'), even when neither the customer nor the
ISP has such an option actively configured on the equipment.

This URL, per the WPAD specification, leads the Connection Manager to
believe that it must use a proxy to reach HTTP- or HTTPS-based
resources, including those specified for WISPr online reachability
checks. Because neither the PAC file ('wpad.dat' in the example above)
nor the host ('wpad.lan' in the example above) associated with the PAC
URL exist, those online reachability checks unconditionally fail
despite such resources being directly reachable, without an
intervening proxy.

Because:

  * PAC configuration (or lack thereof) has not been historically
  * POSIX error codes are themselves limited (for example, there are
    no -ENOPROXY, -EBADPROXY, or -EPROXYLOOKUP codes)
  * POSIX error code usage for WISPr failures is similarly limited
    (for example, -EINVAL)

insight into the actual nature of an online reachability check failure
is, by extension, limited, particularly when proxy failures are
involved. Consequently, log messages generated from these changes
provide crucial insight into triaging and resolving such failures.

Finally, there have been three (3) call sites in the network service
code where the network service proxy auto-configuration (PAC) URL was
set. However, it was never (but now, with these changes, is) set in
'__connman_service_set_proxy_autoconfig', where it is invoked by the
DHCP client code when DHCP option 252 (Web Proxy Auto-Discovery
(WPAD)) is encountered.

Grant Erickson (15):
  service: Add 'service_log_pac' function.
  service: Add 'service_set_pac' function.
  service: Leverage 'service_set_pac' function.
  service: Ensure the PAC URL is set in
    '__connman_service_set_proxy_autoconfig'.
  service: Document 'service_log_pac'.
  service: Document 'service_set_pac'.
  service: Add 'service_set_proxy_method' function.
  service: Leverage 'service_set_proxy_method'.
  service: Leverage 'service_set_proxy_method'.
  service: Document 'service_set_proxy_method'.
  service: Document 'service_set_proxy_method_auto_handler'.
  service: Document '__connman_service_set_proxy_autoconfig'.
  wispr: Add 'wispr_log_proxy_failure' function.
  wispr: Leverage 'wispr_log_proxy_failure'.
  wispr: Document 'wispr_log_proxy_failure'.

 src/service.c | 273 +++++++++++++++++++++++++++++++++++++++++++-------
 src/wispr.c   |  42 +++++++-
 2 files changed, 276 insertions(+), 39 deletions(-)

-- 
2.45.0


Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67430154C05
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981834; cv=none; b=M/oZniqHVVguoQ2wy4krHgQF689vJOh2mE8h3gmkRNvHPcTP1FSz8N6n0mp8+m002zQ2v5AItzEBqsFJR6HUBq4/VkYTOFE+8kCVHpwwA4XaJ2RVfbvMmm1sGB9h8Eag6PxSRuXIqNJ3fYtlQQpdkIRpDfolTlDJ9dayvNn5MXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981834; c=relaxed/simple;
	bh=zztIDEUaDxdxrDPI1lZNuFp+0o/pmr9kfSju4owSk4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HjUQzL8BGz+1VDO/rk5zuRW+3VJijHFfDhD2E4YD0+eIxRq0RRpz0fvT8R1DJoGzqzpoVU+HhFGRkltYGTMaDkZZK43unH+0XJ/ubbZQElymQ6+KLaCPorteTVNft6hgWeq40ddfE8R75/qiOUPniBaWamCbXhxHWyXD3XVN5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=JFvbqYxP; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="JFvbqYxP"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id BF3601649A2
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:18 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6BEE7124FD0
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/15] Improve PAC URL Mutation and PAC URL and WISPr Proxy Failure Logging
Date: Wed, 11 Dec 2024 21:28:02 -0800
Message-ID: <20241212052817.2021264-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=sE3fGElCAjdLw+jzG1zT/E/YwXuWmEJXpiEDxg5+Zf0=; b=JFvbqYxPv3luEAHgUWi7vcV4xNpLIxUwF5s4qCNjE3cJPyGmf1I3wiTeb5SZ6SbKB6NNRfjxYGPG354+o1FHD/BCoQM4g325YvGcyS96ITFpiLY39fQmRqZk/HjLgULbi/tdpaJTxeeYqRaLjNxNQHReSIfCJVw8ZDxYrBBNnEoYJMukmYdIls5hS/ijGF771MwJLSjeHkhecB0t3U4pVfOHEZgEC7cnDkJg9yTHMOwp/iN4QkBu1kBNPrut+2TZSCAK/avdMi8mADx0viyBzJ7P2CIQLBH95AHbb5phlXNAGaoLL7Gh/sPPjoNopUN4RuWAWUhV7CKYy37PEGpjmA==
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


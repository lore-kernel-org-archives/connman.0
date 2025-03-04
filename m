Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3B1F7076
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122191; cv=none; b=nSe4mxbpu8RsUiTfrqLLWuTMzgsFuCGtn9qhEE9Zd4YRo4Dgkfi5mBH3e5EoCzxWHU3+ruj1E1pSzdwgckOyKB/o3TCFINcEMeRr5kYQve5Qees3qsPvYbTS6aSUB1FhJbQRJipYfIBMrxZ6uFjJoQ0wr0QbWkYkykQRVFyvviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122191; c=relaxed/simple;
	bh=yM7DdawfZv5TWwFcmoBcr2U3Dt+xUwxmlIUvsgj3DwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ddaC0tWJ589fc7QHrW33+tfJb9OOXOvlb5TR2TLP8mwc/uzI61FCnFzYG8zXWeJ0/su+ERn8WYYgucmOvcvMIPDUs5uMznIKcuBynCBSF5wlYM/ZAG3ipixOS7MvNDXbKH8RcUnxYfUS90O5WDuwzC6TXd5dpU0/cHjwqODASOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=HbJCOsAz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="HbJCOsAz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CA714164B5B
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:06 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 76E5C126351
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 16:03:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/7] Improve PAC URL Mutation and PAC URL Logging
Date: Tue,  4 Mar 2025 13:02:58 -0800
Message-ID: <cover.1741121901.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=w5qwR401tpuOBlKL8/j9ximmFC47dZhiVrXKco4Rk8U=; b=HbJCOsAzXYGpUlgCLm46vp0MilZPB7ieNCvj3vWAEzWDIBv8x7N7Z8Gi2VYlF/HitSAAEDvxBcgmrRTaWs2Fvo5tkFjlEo9es7Ayu+Mng7W5g4rvtSbMo6o8jPBODZsqnhjqnSJXr2aukx2AEAFedT66zjUVHMEypt2rDIZ2NTrCpGIGT3PwKJrHXmS/IqjotYsx3JwYVQTGNOoXsHZAyw6NHD85yVNhTf3Je8AElaquR1Om4xDFonAtEy3GOSGpn9gzgINXRyolGZ2m6WlZ6e4tm55ZsTCC0VderV8dgbCLwOWwsN9WAOIbgwbpMMljCO1QNcvCEIufFhU9fSADAg==
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
    logged
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

Grant Erickson (7):
  service: Leverage 'service_set_pac' function.
  service: Add 'service_set_proxy_method' function.
  service: Refactor 'connman_service_set_proxy_method'.
  service: Refactor '__connman_service_set_proxy_autoconfig'.
  service: Document 'service_set_proxy_method'.
  service: Document 'service_set_proxy_method_auto_handler'.
  service: Document '__connman_service_set_proxy_autoconfig'.

 src/service.c | 201 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 157 insertions(+), 44 deletions(-)

-- 
2.45.0


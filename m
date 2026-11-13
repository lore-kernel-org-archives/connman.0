Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540909;
	b=TXIS2ccbH8Yxy0Ogn4c77XCS1jxaDJfAIHDEqsZdsRBBSaTCOXa2NRoQOLyB14vUY6BJ
	 v+KWgmRKTRpqiC2McPxvIDv/c3DnW5jbUjgEsp7ShBQqhg8DIljgoXPuuMm0QCyT4nvpz
	 u7ATdpZLFH9V0ysUdFNcmB0Z+DfJRy/r2TB3AyZj+A3IHe0BRXNberUL4CV8QgIeELZ+m
	 nLsyDHGrheT3L0yh4qHfDz+2xWvklEQQQfvdBcnuHRM5kCxNlyQk2HEVCbVmUASxXQAOE
	 o/Hcz2nW6LoDrhm1u/vmQaUJkq5MBui78+juTXXeUPfNq/ISghz88+gzCLkeWlkL1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540909;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=2vUqdrKIaRBN+ZLWQxwv5w1bJh6a8i2CnbDdHCBuIV4=;
	b=sLgs1xR5Oow9MXg1fz4qL1t98XXGVP6+XFIFkCtMHxIQeXQOCICY8u/OSREpLMLyLc88
	 K/ARdR76CHzb2797o7ZIbohiqBRaj0tuK9RjS6Mm3A5SLBugZtKtNJ92qFuxktN+w5syP
	 yMbhf4qRPkOOy2U2lFeIcSFEnOpup3BZ9s5Gh/YAYQJ+YZmTkXkvs4LgMGejjbkEk13lE
	 H10FT/LsMIOpTR95VNGnbIPknVTa1n+/ldxbK0oUfwdvflwB5aU5t80J59iJageIEbl1Z
	 vk3/gfyYs9SDOqbMr1glbg8u8ssp0jtbYSXqPoIi96MvXeOFvNUljSi4u3daGM2DMKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=OFvBLk7O;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D5606A334
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C45D5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=OFvBLk7O
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 42B761602AC;
	Thu, 12 Nov 2026 22:35:08 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DB779124C62;
	Thu, 12 Nov 2026 22:35:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] doc: Describe link-local-only services under PreferredTechnologies
Date: Thu, 12 Nov 2026 19:35:04 -0800
Message-ID: <20261113033504.1828738-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261113033504.1828738-4-gerickson@nuovations.com>
References: <20261113033504.1828738-1-gerickson@nuovations.com>
 <20261113033504.1828738-2-gerickson@nuovations.com>
 <20261113033504.1828738-3-gerickson@nuovations.com>
 <20261113033504.1828738-4-gerickson@nuovations.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=2vUqdrKIaRBN+ZLWQxwv5w1bJh6a8i2CnbDdHCBuIV4=; b=OFvBLk7OANd1STAPRPIxqZyIvb6zdWmmyM3GlCUPPV6GIR5k8L4lXWCiHU2y/phfqyjbe+Vbfey4P+Wnr72Ve/R6I0+EMPQ5vHi0nG9FRs819+j9wr85qXPcahPK3CzJr6g7gRzS4aZc1dl5kzfoVoa/327pEEPmXHCgE5b/oYq7YWCUfQxJJNexiUE8PHKxZ//778/N+uqm50yiE/OrmwUy7ERPkb4AZqKILpmNKazq/1SEP7tpWWxmO7GQhMGKi4z3tw4Q1uPlfVMDMj3QkocLVr2ldqBjHW+nxNLbCXVPyCvMuxk3BCS34lWILcuXzrWOMlLqH4700qImrlBURg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Note in connman.conf(5) that a service connected only by link-local
addressing is not preferred over a connected service that can reach
beyond its link, whatever the PreferredTechnologies list says, and
gets the default route only when no such service is connected.
---
 doc/connman.conf.5.in | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a81ac7bb1e45..33a3c272b678 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -105,7 +105,12 @@ compared to another preferred type further down the list
 with state 'ready' or with a non-preferred type; a service
 of a preferred technology type in state 'online' will get
 the default route when compared to either a non-preferred
-type or a preferred type further down in the list.
+type or a preferred type further down in the list. A
+service connected only by link-local addressing (for
+example, Ethernet with no DHCP server or IPv6 router on
+its link) is not preferred over a connected service that
+can reach beyond its link, whatever its type; it gets the
+default route only when no such service is connected.
 .TP
 .BI NetworkInterfaceBlacklist= interface\fR[,...]
 List of blacklisted network interfaces separated by ",".
-- 
2.52.0


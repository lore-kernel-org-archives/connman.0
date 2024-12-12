Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05A13D52E
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981834; cv=none; b=LUz1vtGR6zzxvnN616O40pcO+WCKsvT6GUU1xCYFPEW+qZXdgYqt/i5PYeH1uKBn6P6Vziu0cUOnfp9VqYslc/uGFmja324eJKtlDyIh60xm++kT+mJjTLcrWeNYHzoVhkEuMD2OgSPpNfPdXNkkW3EBrefXET3S0UApFX9PXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981834; c=relaxed/simple;
	bh=n9zOdnmARl0Ho9Hvo5Za5IE13jQQr2+qPZdZl7Blj2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeVGR21+TJcWqWwmRI3b2pjGSF6ZnvAFOMUoNECVztGMZtCWLtXZ1NIMJz7bCh8WZFFN7p0/410a6fHqIvbCltqgYZ0qH+S6goqk/i2RPK9myvmNm5lktg8zcIUAKoYgc9HK44kaqoQEQ8SY2c4OZLHpClmpBdGkX1fJ1lSvZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=R5eVXM+i; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="R5eVXM+i"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id ADF5A164A22
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:20 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 64EF8125166
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/15] service: Ensure the PAC URL is set in '__connman_service_set_proxy_autoconfig'.
Date: Wed, 11 Dec 2024 21:28:06 -0800
Message-ID: <20241212052817.2021264-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241212052817.2021264-1-gerickson@nuovations.com>
References: <20241212052817.2021264-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=gLy7QA/y/LfnZaxMANYPxvO8+TTA0aR6yLK4PcN0hMc=; b=R5eVXM+iWWw63HIPzTEKWODdFrwD7GckyWjidF+5g/k4DQ3G5RQbCu8nygvEx4jlMBth1yzYr+uTQMZD2jbkyEBK1ZK3fyoBFHngGjHVAis0ttFSjnvdHH9rl4tGdpHjO4fEXazVxU6++cy5jCdUArpqvxcJ1R/LrFAC+Z4cioxhDHmqyh64OitaOvZVxvx/07DSbaHL8SUo/lvg1Aei+fsaizjr5aFYa3k9aFNdkcn1y4Usq2DH/t9tPj1fglh/8OFaJUFko/bNtMn2QaIw0aXqiriPjurI/IqKoBeli4ZZRyrG/Hx2wtxaOslXuwTs6r6YD6mXQv03av5z2aEMBg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Historically, there have been three (3) call sites in the network
service code where the network service proxy auto-configuration (PAC)
URL is set. However, it was never (but now, with this change, is) set
in '__connman_service_set_proxy_autoconfig', where it is invoked by
the DHCP client code when DHCP option 252 (Web Proxy Auto-Discovery
(WPAD)) is encountered.
---
 src/service.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/service.c b/src/service.c
index da851d681bc7..73cf8bca71a2 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5600,9 +5600,13 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
 void __connman_service_set_proxy_autoconfig(struct connman_service *service,
 							const char *url)
 {
+	const bool dochanged = true;
+
 	if (!service || service->hidden)
 		return;
 
+	service_set_pac(service, url, !dochanged);
+
 	service->proxy = CONNMAN_SERVICE_PROXY_METHOD_AUTO;
 
 	if (service->ipconfig_ipv4) {
-- 
2.45.0


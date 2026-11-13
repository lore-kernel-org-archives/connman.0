Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540908;
	b=svHzZIjD8h8mambYYXAUwy+/wEAq7dpUw1wPL0JV5uxKpG68wDdHtlyZShBICKQD1dyq
	 /YKskHdciOK6/b76LS4XX/aV0Nari6grm+T7VzaKKEjcCWQHnj+LWO1yI+iCjEM8BwsnO
	 KtZQS2DW8mpEfqxjkGUG+Z6j3kt/ZZWnQUdZTerCff9CVU1d2jJeWex8daarc4htzy0xO
	 WHyx5/irdrDq2UBCqpsIKISR8xg8vxtzShIS2EkE9ibroiQ0aqXUk8TK5Gw8n51OZoMKP
	 gO8kzz2LByOg8Ylt+p4sQ+qKau0BMSZ7/OPJ92HMgT7czLc+S4IYSWhtBgoh6oHrLcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540908;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=E/Ybfjr/ox+YNf1WBeMehLVlgYZEMHxumIbMfVQ/tbc=;
	b=Qtn/Z2LIEQsTQiYk5omK7xX5KXQT2n8E/nvczMa95/P6U1fGz/2RESroYRWiDvVAiLbr
	 +Bd8lCYRSN1VQVqJClLd64GdfGQ1+wQm7BjpUZuzqLrCXosy3MpNFXyYWXEeDMNIv5iKm
	 4bBp3t9Wng+ev/if4nirYSV1LOaQgtLXmPW9hwui5yRmanFAvG78J7DIqXkjiH5rGtn6B
	 uynyBTNeNq8yM6lIkQgp1ha+PCjxJ7wJqtJTsRDPvuteVvCE9eiObk0jH4Gda60knPmh/
	 uUuQ1OmJ5rt8YkXdtv5MoLpyouAi0J3KQt882GXRZf+xXeYn/47ET2Q1/qh3rU9n0cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=MpWqqcOJ;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D47606A887
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 03:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D47606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=MpWqqcOJ
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 351831602D1;
	Thu, 12 Nov 2026 22:35:07 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CB216124C62;
	Thu, 12 Nov 2026 22:35:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] service: Rank link-local-only services below others when reordering
Date: Thu, 12 Nov 2026 19:35:02 -0800
Message-ID: <20261113033504.1828738-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261113033504.1828738-2-gerickson@nuovations.com>
References: <20261113033504.1828738-1-gerickson@nuovations.com>
 <20261113033504.1828738-2-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=E/Ybfjr/ox+YNf1WBeMehLVlgYZEMHxumIbMfVQ/tbc=; b=MpWqqcOJb5/+k+ILFvEx9OrosTLPW2QnF8WdN/OC0CjrN7J5SmgkEWn1SEYNbWRdKGOHTj092p08ipEg1q23yvVam2vsyigR75/7xFmRortDhNezKPFHidTYXEUv062kRyA2MZOWKlZzLb/nKX13rWzwcEuV9OmF/kw2YoWyVZ/RsSODcrdK8Rtxl1gjH1EbGtyabQe4lNbcJTrdzFCU4LfPCf1dQ9jYBXFw74B06xyCfBH8blPm6soIkt6bZ9Rgqm3iJ+t+gu3JovOVuJYiIPWwJSR6/KqOFY8AfALwYsrbL4OnzP+9EUKzruKa4eL9fpITcDBq/UUfae0AHgtaxQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'service_update_preferred_order' runs when a service becomes "ready"
or "online". It switches the service ahead of the default service,
downgrading an "online" default to "ready", whenever the
PreferredTechnologies list prefers the new service's technology.

So when a link-local-only Ethernet service becomes "ready" next to an
"online" Wi-Fi default, with ethernet listed first, Wi-Fi is demoted to
"ready" at once and Ethernet becomes the default, whatever
'service_compare' later says. In the other direction, when Wi-Fi
becomes "ready" while a link-local-only Ethernet service is the
default, the list prefers Ethernet and Wi-Fi is left behind it.

Decide by 'service_compare_link_local_only' first and fall back to the
PreferredTechnologies list only when it ties. A link-local-only service
then never displaces a default that can reach beyond its link, and is
always displaced by one, consistent with 'service_compare'.
---
 src/service.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 2348b65663af..d566fcaa6019 100644
--- a/src/service.c
+++ b/src/service.c
@@ -9286,8 +9286,9 @@ static void downgrade_connected_services(void)
  *  This attempts to switch the order of the specified services in the
  *  network service list if and only if a) the services are non-null,
  *  b) do not have pointer equivalence, and c) if @a new_service
- *  should sort before @a default_service according to the @a
- *  PreferredTechnologies list.
+ *  should sort before @a default_service, first according to whether
+ *  either is connected only by link-local addressing and then
+ *  according to the @a PreferredTechnologies list.
  *
  *  @param[in,out]  default_service  A pointer to the mutable, default
  *                                   network service to potentially
@@ -9312,6 +9313,8 @@ static int service_update_preferred_order(struct connman_service *default_servic
 		struct connman_service *new_service,
 		enum connman_service_state new_state)
 {
+	gint rval;
+
 	DBG("default_service %p (%s) new_service %p (%s) new_state %d (%s)",
 		default_service, connman_service_get_identifier(default_service),
 		new_service, connman_service_get_identifier(new_service),
@@ -9320,7 +9323,17 @@ static int service_update_preferred_order(struct connman_service *default_servic
 	if (!default_service || default_service == new_service)
 		return 0;
 
-	if (service_compare_preferred(default_service, new_service) > 0) {
+	/*
+	 * A service connected only by link-local addressing never
+	 * displaces a default service that can reach beyond its own
+	 * link, and is always displaced by one, whatever the
+	 * PreferredTechnologies list says.
+	 */
+	rval = service_compare_link_local_only(default_service, new_service);
+	if (!rval)
+		rval = service_compare_preferred(default_service, new_service);
+
+	if (rval > 0) {
 		switch_service_order(default_service,
 				new_service);
 		__connman_gateway_update();
-- 
2.52.0


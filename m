Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457556;
	b=JplHVJns5hOMO0/yw4n7iEjkLJljR9iuCS2F058B3G/JbXz/bBlXhGkeOuIpTI6new+q
	 x9Fh/mkCOSN2wWlyKfntTIRy0GHUi37+zxrTLAyRf8zraA3nmuKLDptYW9JzshQcMRWkY
	 ofHfea/oWJFQvEOubkPs9SFjvs+lA6i4vXLmJgbQnAVOqBS31z8NwkJ+s7tpDy12E7ky7
	 bSOK0MxLCeHHhjXr2kQHzepE5i7qYoRVcKuvSSpx/1dUrcBYuG3bFfyn8p9yZwsdkSbEw
	 ZYTYAif6WO9/m/2Wlq2lS6e17Pu/HsXPrZ73Skn0YxD7PI6NTpO6SDYkiCyYuKtPzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457556;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=SkYPi+YAGh3y+OM9CjcLiYCupfXrxe9L57CN2MLDeaY=;
	b=UJcnzy+821kFqmEM2ZCKrBlU7eKnHqu20ry/f1UCpA/RoZZeh00wu49rJb75a7HS/VtC
	 Zt3pFZitCqCyaMJSWzZix0NOkLEoyDIxhOwTBeXOHdvCqjQiX0w/R67ykUmfZuemODDVv
	 VyWRu4A1nOY4DFIBC05YgwRuT5RsfpzaC7vuV6gigxVqlB5SaWyF65OoTcKQaOWEWTcyY
	 u6FDDcwwOm30GVWBtUrTCfWOW+CbmJoKeb7CSfAyRgZrRddRE3hg+fp6dxuFk9zHIzWmz
	 d+TGeSW3RKuMiMjphDmq60hIC9c0BH8hpRM8BhuQpxEipBf/jdMpFSQcZkKdS7eKv0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=LjxgXhNF;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33186606A32E
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33186606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=LjxgXhNF
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A98F21601FB;
	Wed, 11 Nov 2026 23:25:55 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 418D9124BF7;
	Wed, 11 Nov 2026 23:25:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 5/5] wispr: Bound online check response gaps
Date: Wed, 11 Nov 2026 20:25:51 -0800
Message-ID: <20261112042551.1613107-6-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112042551.1613107-5-gerickson@nuovations.com>
References: <20261112042551.1613107-1-gerickson@nuovations.com>
 <20261112042551.1613107-2-gerickson@nuovations.com>
 <20261112042551.1613107-3-gerickson@nuovations.com>
 <20261112042551.1613107-4-gerickson@nuovations.com>
 <20261112042551.1613107-5-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=SkYPi+YAGh3y+OM9CjcLiYCupfXrxe9L57CN2MLDeaY=; b=LjxgXhNFo3CDjhNT+tocf2kmzOfQp1jEstvwCiTALFLkXSP+E0UZ9ISXMSyLC+At9P6YESTL/WMGzpzdeXXqCAgZWnXfS6s45cGhSOZhhgeP29BrFJp8BeXdVLZe+w6VUDTuUgwDkgsE1B7ob7MNKPxY0PbT/5/oc7UUlxkU4vUYWQZzaJrcDimPjQeletN22zhzVbiD/DsVIBQh62GrHWLdybJ7Pq7VUFly/dlnwjMCYr6S8pnNVPG0lgTVz+FljzRubV5EdBXKJqWqE0RLVtYBjg7LnfIsB/1zm6adJh3Wtf5pmGjjmoaEKOsjvKMugmkUHH4QyoK9F53kcDC6pg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

OnlineCheckConnectTimeout already bounds an online check from the
start of its connection until the first data of the response
arrives; gweb cancels it then. A response that stops after that, for
example one whose headers and part of whose body arrive and then
nothing more, without the connection closing, leaves the check
incomplete indefinitely and, in continuous mode, no further check is
scheduled.

Set the gweb receive inactivity timeout for online checks to the
same OnlineCheckConnectTimeout value, so that each wait for further
response data is bounded the same way as the wait for the first.
Expiry fails the check with "no data from <address> for <timeout>ms",
so it is logged and counted like any other failure.

This extends the meaning of an existing setting rather than adding a
new one: the setting already bounds more than the TCP connection, and
it now bounds every wait for the endpoint rather than only the first.
It bounds each wait rather than the total duration of a check, so a
slow link or endpoint that continues to make progress is not failed,
and there is no new setting whose value could conflict with it.
A value of zero continues to mean "no explicit timeout".

Update connman.conf(5) and the sample main.conf to describe the
extended meaning.
---
 doc/connman.conf.5.in | 16 +++++++++++-----
 src/main.conf         | 16 +++++++++++-----
 src/wispr.c           |  9 +++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a81ac7bb1e45..f81603196b67 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -224,11 +224,17 @@ http://ipv6.connman.net/online/status.html respectively.
 .BI OnlineCheckConnectTimeout= secs[.milliseconds]
 The time, in decimal seconds (for example, 12.3), to wait for a
 successful TCP connection to the host associated with
-\fBOnlineCheckIPv4URL\fR or \fBOnlineCheckIPv6URL\fR (see above). Connections
-that take longer than \fBOnlineCheckConnectTimeout\fR will be aborted. The
-default value is zero ('0') which indicates that no explicit
-connection timeout will be used, leaving the timeout to the underlying
-operating system and network stack.
+\fBOnlineCheckIPv4URL\fR or \fBOnlineCheckIPv6URL\fR (see above) and
+for the first data of its response, and thereafter for each further
+piece of the response. A check that waits longer than
+\fBOnlineCheckConnectTimeout\fR for any of these is aborted and counted
+as a failed check. Because the timeout bounds each wait rather than
+the whole check, a slow endpoint that continues to send its response
+is not failed. The default value is zero ('0') which indicates that
+no explicit timeout will be used, leaving the timeout to the
+underlying operating system and network stack; with zero, an endpoint
+that stops sending part way through its response, without closing
+the connection, leaves the check incomplete indefinitely.
 .TP
 .BI OnlineCheckInitialInterval= interval, OnlineCheckMaxInterval= interval
 Range of intervals between two online check requests.
diff --git a/src/main.conf b/src/main.conf
index da1307d9ed09..e3c96eae3903 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -179,11 +179,17 @@
 
 # The time, in decimal seconds (for example, 12.3), to wait for a
 # successful TCP connection to the host associated with
-# "OnlineCheckIPv4URL" or "OnlineCheckIPv6URL". Connections that take
-# longer than "OnlineCheckConnectTimeout" will be aborted. The default
-# value is zero ('0') which indicates that no explicit connection
-# timeout will be used, leaving the timeout to the underlying operating
-# system and network stack.
+# "OnlineCheckIPv4URL" or "OnlineCheckIPv6URL" and for the first data
+# of its response, and thereafter for each further piece of the
+# response. A check that waits longer than "OnlineCheckConnectTimeout"
+# for any of these is aborted and counted as a failed check. Because
+# the timeout bounds each wait rather than the whole check, a slow
+# endpoint that continues to send its response is not failed. The
+# default value is zero ('0') which indicates that no explicit timeout
+# will be used, leaving the timeout to the underlying operating system
+# and network stack; with zero, an endpoint that stops sending part
+# way through its response, without closing the connection, leaves
+# the check incomplete indefinitely.
 # OnlineCheckConnectTimeout=0
 
 # Range of intervals between two online check requests.
diff --git a/src/wispr.c b/src/wispr.c
index 013afe241054..ce03aec16858 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1556,6 +1556,15 @@ static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 
 	g_web_set_connect_timeout(wp_context->web, connect_timeout_ms);
 
+	/*
+	 * Use the same timeout to bound each gap between receipts of
+	 * response data once the connect timeout has ended with the
+	 * first of them. Otherwise, an endpoint, or a router answering in
+	 * its place, that sends part of a response and then nothing more
+	 * leaves this check incomplete indefinitely.
+	 */
+	g_web_set_inactivity_timeout(wp_context->web, connect_timeout_ms);
+
 	if (wp_context->type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		g_web_set_address_family(wp_context->web, AF_INET);
 		wp_context->status_url = online_check_ipv4_url;
-- 
2.52.0


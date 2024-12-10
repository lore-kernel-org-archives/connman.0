Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2681AAA0F
	for <connman@lists.linux.dev>; Tue, 10 Dec 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871384; cv=none; b=txbiVDzzBanJ3bMjlFZ5eGl1KG41r/dMNvkviCe0ypQmieF/3TO0I37c+/o1pFH6SIcRrCMYC3sokg1bWXrqgem75EII20GW8nTxC8rIVVKzzpYSQeck/7OvNgfLFonMSjZtAkDw9mgAVITF5heIg/6lE2rQ2tljRDLfpZsy7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871384; c=relaxed/simple;
	bh=nhEBEcjZmboqdFzFxS4prGGi2WzLbdWGURn/Sji06IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGs7pcvqjuOtnbk6TRPEje8Uv1UIKxv9D6Co+mm+3GsQXyEti9zoOQZE2G39ksIgcWI+n9Q9yXichEl2NK/T1VPkf4Ay+NJW3IrdgGJIbhu0AYr21n0iDm0hqXP0y36RixF81b20q7xMSLIyt+TnuZq4rcHb0HqIMRUkL1DrljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=NoPNF5O4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="NoPNF5O4"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2414133b3a.1
        for <connman@lists.linux.dev>; Tue, 10 Dec 2024 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1733871381; x=1734476181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWGTnrb5A4RLWc+WrvEwgzb8mQsNWmOa6lvAmloNfnk=;
        b=NoPNF5O4K4OVW/d0g+gVT/ZUyvFClhydy3Sze9SEOlygmCwDz6j05Fzrylnv+fsZYT
         33iYJ37eyOSBcfgDAtr1fwVP9N5VhKDH0rO2ZdWRWCBB5+/gSdc0YT2spzLa2pnwqEqu
         6G7EQycXbZDKTPU4gicUvTlyYz5AA+GsUiRp6d7QT56K+GAzbJikpp548e3Z7bQ1EfJW
         bt4o3ZqmmzeIUblvS+G/MxMNQdjCt6crLUginQU1As7K+f2HQHjh1n97apsygxhygNAo
         92+pZqdwdtua/FKM2d7tJQ6CE39e4k7EXBnMlyGRgdqa2/OhVw/998x2KY+iQQoa16Rw
         AJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733871381; x=1734476181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWGTnrb5A4RLWc+WrvEwgzb8mQsNWmOa6lvAmloNfnk=;
        b=w2rfcg9dDHwFvJOKqtG3ETqGciiXeHpjbmW0ccpd/Qipgj/nu4ILAoPwC8k5qkTWs+
         p+C6vC5epmi7tf8wmTcA6sSljx5Jt/zotm8uD+tGVe8u790/ufCy4BvfJbpXnwMMftZU
         k4NeazRg2u49PlSKONMtQyFp3dIehDGxRZp7L3O471Hmmmf2T+BhabsEr4BHwxvB1nU7
         m9xWZ/8QwlVYmS24TtA7nsQMkKz7e8Qxn5bR8hjscLX1L7OfNxLgsnTDiXByo+pkPPi+
         bImwH9MQevFL1kTEEclWMJLsorn9FWtEbO3BJDML64lmPUaOq59FvmQOfbSr6zlekr29
         mYeA==
X-Gm-Message-State: AOJu0YxAitYU4SuFlz0lIZGrCpMGJKgkcVfhTVyCVq0y+69P66icLDwT
	z/NjaWVeJlaqtL3Z4DBqdPI+58OOnXTMu9AfY4OEBwB/AFJpBeOdH+kAbZp1JU08nCH/GB1JPz/
	+ysvlTaMbBSh0DpVypFECpYkDPh4nngiJpIRYo7cdwL9k3Tq8CRcXRu62p1drGiWUEuMpk+rjD6
	QtlAa1Q9Y9pXZ6TmvotaK89OfeGV1w1jKPP/kjY39uShGjoGcXByFzDg==
X-Gm-Gg: ASbGncs00vandg2C3Oo8x93BwdgM87TmidmUHH0Fs5b/kDkhXWwCeKlPX0ZhcYZWzvo
	sC2ujjT1qiwHWdfqJM2M3nOocP/m/KjEODo53HyoZuf6HgW7X/S137fZARp68akOMP1HvPIIzTW
	AGcU5meb2c2aaNxbe4BOM0PH6tpalGoBka9X6Ajj9+MSraC4LWsaxI0cFmpT7orxLkhVso0OJ/N
	uTKC1wrgOBzRtVG0r6Jej20+IEJpSGobub5Wjyil9ZWV5WEK8R9WrqwBJ16aMx6xJUz1XfZl7un
	yeiHF2M=
X-Google-Smtp-Source: AGHT+IEege8MrowYm2b8jjQEKgxMJUZyJUeulIv3kSn3jyho3wHlWZxa6Dw3SLBl5JFK3lTgjNDItg==
X-Received: by 2002:a05:6a20:72a3:b0:1e1:96d9:a7db with SMTP id adf61e73a8af0-1e1c121c4a6mr1447441637.4.1733871381295;
        Tue, 10 Dec 2024 14:56:21 -0800 (PST)
Received: from BPHKDV2-DT.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7261829be9dsm3516468b3a.89.2024.12.10.14.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:56:20 -0800 (PST)
From: Ram Subramanian <ram.subramanian@getcruise.com>
To: connman@lists.linux.dev
Cc: Ram Subramanian <ram.subramanian@getcruise.com>
Subject: [PATCH] service: check number of connected services before changing rp_filter
Date: Tue, 10 Dec 2024 14:56:13 -0800
Message-ID: <20241210225613.540904-1-ram.subramanian@getcruise.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

service_rp_filter() keeps track of the number of connected services via
a global variable `connected_networks_count` that is incremented when a
service is connected, and decremented when a service is disconnected.
However, it does not ensure that a service was previously connected
before decrementing the counter.

This can cause `connected_networks_count` to go out of sync with the
read number. For example, if a service fails association, it transitions
directly from associating -> disconnected. Though it didn't increment
`connected_networks_count` it does end up decrementing it.
---
 src/service.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/src/service.c b/src/service.c
index 805cfca7..fcdfd78e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -8408,6 +8408,29 @@ static size_t service_get_count(void)
 	return service_list ? g_list_length(service_list) : 0;
 }
 
+/**
+ *  @brief
+ *    Calculates the number of services in 'ready' or 'online' state
+ *
+ *  @returns
+ *    Service count.
+ */
+static size_t num_connected_services(void)
+{
+        size_t result = 0;
+        GList *list;
+        struct connman_service *service;
+
+        for (list = service_list; list; list = list->next) {
+                service = list->data;
+
+                if (is_connected(service->state))
+                        result++;
+        }
+
+        return result;
+}
+
 /**
  *  @brief
  *    Get the route metric/priority for the specified service.
@@ -9314,12 +9337,13 @@ enum connman_service_state __connman_service_ipconfig_get_state(
  * connectivity works ok. This is only done for IPv4 networks as IPv6
  * does not have rp_filter knob.
  */
-static int connected_networks_count;
+static int rp_filter_serviced_at = 0;
 static int original_rp_filter;
 
 static void service_rp_filter(struct connman_service *service,
 				bool connected)
 {
+	int num_connected;
 	enum connman_ipconfig_method method;
 
 	method = __connman_ipconfig_get_method(service->ipconfig_ipv4);
@@ -9335,30 +9359,25 @@ static void service_rp_filter(struct connman_service *service,
 		break;
 	}
 
-	if (connected) {
-		if (connected_networks_count == 1) {
-			int filter_value;
-			filter_value = __connman_ipconfig_set_rp_filter();
-			if (filter_value < 0)
+	num_connected = num_connected_services();
+	if (num_connected != rp_filter_serviced_at) {
+		if (num_connected > 1) {
+			int rc = __connman_ipconfig_set_rp_filter();
+			if (rc < 0)
 				return;
 
-			original_rp_filter = filter_value;
-		}
-		connected_networks_count++;
-
-	} else {
-		if (connected_networks_count == 2)
+			original_rp_filter = rc;
+		} else if (rp_filter_serviced_at > 1) {
 			__connman_ipconfig_unset_rp_filter(original_rp_filter);
+		}
 
-		connected_networks_count--;
-		if (connected_networks_count < 0)
-			connected_networks_count = 0;
+		rp_filter_serviced_at = num_connected;
 	}
 
 	DBG("%s %s ipconfig %p method %d count %d filter %d",
 		connected ? "connected" : "disconnected", service->identifier,
 		service->ipconfig_ipv4, method,
-		connected_networks_count, original_rp_filter);
+		num_connected, original_rp_filter);
 }
 
 int __connman_service_ipconfig_indicate_state(struct connman_service *service,
-- 
2.47.1


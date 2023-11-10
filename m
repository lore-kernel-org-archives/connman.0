Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482BA47
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 967E07317C
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:21:40 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 626EC73203
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 20:21:40 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 2/2] service: Add documentation to 'reschedule_online_check'.
Date: Thu, 9 Nov 2023 17:21:40 -0800
References: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <066A1AD2-8F82-49B6-BF0A-376CBE8243B4@nuovations.com>
Message-Id: <92D9B261-F3C7-4042-BD48-635B62C275AC@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'reschedule_online_check' function.
---
 src/service.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/service.c b/src/service.c
index 9e942e12..81a1bebd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1775,6 +1775,41 @@ static gboolean redo_wispr_ipv6(gpointer user_data)
 	return FALSE;
 }
 
+/**
+ *  @brief
+ *    Reschedule an "online" HTTP-based Internet reachability check
+ *    for the specified network service IP configuration type.
+ *
+ *  This attempts to eschedule an "online" HTTP-based Internet
+ *  reachability check for the specified network service IP
+ *  configuration type with the provided interval and timeout
+ *  identifier.
+ *
+ *  @param[in,out]  service   A pointer to the mutable network service
+ *                            for which to reschedule the "online"
+ *                            reachability check. On success, the
+ *                            service will have a reference retained
+ *                            that must be elsewhere released.
+ *  @param[in]      type      The IP configuration type for which the
+ *                            "online" reachability check is to be
+ *                            rescheduled.
+ *  @param[in,out]  interval  A pointer to the current mutable "online"
+ *                            reachability check sequence interval. On
+ *                            success, this will be incremented by one
+ *                            (1) if it is less than the value of the
+ *                            @a OnlineCheckMaxInterval configuration
+ *                            setting.
+ *  @param[in,out]  timeout   A pointer to the current GLib main loop
+ *                            timer identifier. On success, this will
+ *                            be updated with the GLib main loop timer
+ *                            identifier associated with the
+ *                            rescheduled "online" HTTP-based Internet
+ *                            reachability check request.
+ *
+ *  @sa redo_wispr_ipv4
+ *  @sa redo_wispr_ipv6
+ *
+ */
 static void reschedule_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					unsigned int *interval,
-- 
2.42.0


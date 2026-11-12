Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527588;
	b=PXp5etSGibvDVI6S0sOTb3QNnQk7OTRKFeL679un7V+uuwv46i/W5I0G0HHNyepz+nq4
	 uW1usc5uQxlSgaR9BTOR8HaDs1PT+nYeUT2o+oxDthvIAL7Pn4CHYfyafpLpqRB07zmOP
	 uezZnHQDRyS9gly83a0OwU8/OsEoZs5wzIbXbSqDdOcQa018+aOH7Jgg7zE/zkAvwZx83
	 DMx2BZWAbTVh6Z42WftjhP0BE3klMoW8tVDtZKNrljpKqAt4KXPveiGkTv7HGW0WQNMQz
	 v/R+5xgay6WkjgevryG2AJYQrn9GNofobVep41auDLnc8PUzK3OqE4foWyVqw1oA8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527588;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=MGGJKHOspNJqvuV8zt1VjyhEjeo0brPMY9NzsYf6ybM=;
	b=Z7Xo0d+BMb6lDAj5eYmeJuW+PbQiVs73SdWlev3oAYkWgm2kWQ79kU46U1lBZlgBCRqw
	 ZE2+U3BbJROz/ebWTfDeLewRf2vI6shpOC0P6ayV8dJmJi0dI7mndFmV0tvH6IjXDO+Rw
	 HhcPOin5W7G74QXcuL+QA31lCeLFnyrsBts2mu5wcYRlie0pHzSzAq0tlrtRzdgb3gu0C
	 9Hy1k/9jhJkTPeBu/rFxmFULt8D/26qOA4R5feJivni36pwQWijXb3hPLZjEelaiLfKWl
	 nhUCtlDY+RlkC7kG3GMElOIzZR8vrmeNGRqGiowlhCoNk2GGWtaNi12t2s6/DQP8Dzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=j0Cqe0pd;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E9606A327
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 23:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78E9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=j0Cqe0pd
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1626E160186
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:53:07 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BE296124BEC
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:53:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] openconnect: Fix issue with const return value from strchr
Date: Thu, 12 Nov 2026 15:53:05 -0800
Message-ID: <20261112235305.1627089-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=MGGJKHOspNJqvuV8zt1VjyhEjeo0brPMY9NzsYf6ybM=; b=j0Cqe0pd5Drn1zfYt+CXbepo7WaeyslXrjk0roJiDbO/mmBmpgFbSwKReTMzRsv/4MMskZ1DDK5+u52C4vZMpxaGIk4jtWr3iI3jvyAko1AdTfFaklKLwPtO1S0l9jlOIbO7ULxBaxq6Pa895UhnZP0JwbG1AdEvj0CRhB//D/3Mrs1QzAtnHP3I89yFYm4QMbqdfkRYvB03Fyb6H7T9Nr6vUYK6C8hu9VQovnT/KC6gF5ptPY9bneu2eEozM0B08NnLra4mPw+7Lj9mGLQRhlqv2VshyYLY1pjPcLu+tz0Jt56eBN7WBxOkK4ZeDyJeXZOO7BuZmW7VZCAfU1eQjg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When compiling with recent GCC or clang/LLVM and glibc 2.43 or later,
such as on Ubuntu 26.04 ('Resolute'), the -Wdiscarded-qualifiers
(GCC) or -Wincompatible-pointer-types-discards-qualifiers (clang/LLVM)
warning occurs, and is an error when --enable-maintainer-mode is
asserted, because with ISO C23, the function strchr, which returns a
pointer into its input array, is now defined as a macro that returns
a pointer to a const-qualified type when the input argument is a
pointer to a const-qualified type:

    vpn/plugins/openconnect.c:331:29: error: assignment discards
        'const' qualifier from pointer target type
        [-Werror=discarded-qualifiers]

'sep' is only read through, so it is simply made 'const char *'.
---
 vpn/plugins/openconnect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vpn/plugins/openconnect.c b/vpn/plugins/openconnect.c
index fb63a1a303d0..fcf384c5765c 100644
--- a/vpn/plugins/openconnect.c
+++ b/vpn/plugins/openconnect.c
@@ -325,7 +325,7 @@ static int oc_notify(DBusMessage *msg, struct vpn_provider *provider)
 			netmask = g_strdup(value);
 
 		if (!strcmp(key, "INTERNAL_IP6_NETMASK")) {
-			char *sep;
+			const char *sep;
 
 			/* The netmask contains the address and the prefix */
 			sep = strchr(value, '/');
-- 
2.52.0


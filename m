Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27D12E79
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 681C673150
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 13:58:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:601e:89f:ea32:6713])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 29D48731FC
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 13:58:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] service: Improve Logging and Event Visibility at the Info Level
Date: Sat, 23 Dec 2023 10:58:10 -0800
Message-ID: <20231223185812.2389541-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This improves service logging and event visibility at the info level
by making the following additions and changes:

  1. Make log output of online_check_is_enabled_check consistent,
     resulting in log entries similar to "Online check disabled;
     interface wlan0 [ wifi ] remains in ready state."

  2. Log service default, error, and state changes, resulting in log
     entries similar to:

       Interface eth0 [ ethernet ] is the default
       Interface wlan0 [ wifi ] error "online-check-failed"
       Interface wwan0 [ cellular ] state is online

Grant Erickson (2):
  service: Make log output of 'online_check_is_enabled_check'
    consistent.
  service: Log service default, error, and state changes.

 src/service.c | 69 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 8 deletions(-)

-- 
2.42.0


Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C85FF18
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8F6A873123
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f04b:507e:d663:adf2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 340D673120
	for <connman@lists.linux.dev>; Wed, 13 Dec 2023 15:00:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] connection: Rename 'connection.c' to 'gateway.c'
Date: Wed, 13 Dec 2023 11:59:58 -0800
Message-ID: <20231213200001.1994492-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

While historically, "connection.c" might have been a contextually-apt
name, today it might be better named "gateway.c" since its primary
focus is gateway routes and gateway route management.

Reflective of that, this renames "connection.c" to "gateway.c" and
updates public and private symbol names accordingly.

Grant Erickson (3):
  connection: Rename 'connection.c' to 'gateway.c'.
  gateway: Updated @file comment to reflect recent rename.
  gateway: Rename public and private symbols after file rename.

 Makefile.am                     |  2 +-
 src/connman.h                   | 14 +++----
 src/dnsproxy.c                  |  2 +-
 src/{connection.c => gateway.c} | 65 ++++++++++++++++-----------------
 src/inet.c                      |  2 +-
 src/ipconfig.c                  |  8 ++--
 src/main.c                      |  4 +-
 src/network.c                   |  2 +-
 src/provider.c                  |  4 +-
 src/service.c                   | 22 +++++------
 10 files changed, 62 insertions(+), 63 deletions(-)
 rename src/{connection.c => gateway.c} (98%)

-- 
2.42.0


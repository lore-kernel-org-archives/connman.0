Received: from pisarameressa.linjama.fi (pisarameressa.linjama.fi [207.154.243.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653033C7
	for <connman@lists.linux.dev>; Wed,  6 Apr 2022 18:09:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF9196A9A4;
	Wed,  6 Apr 2022 21:02:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.linjama.com;
	s=dkim; t=1649268166; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8rcoUoMLZse46mqQ3o9iDr2MDcAErAIY+cOxuuxiM/A=;
	b=Iu4eoNIK8he2wYYPYaYKG5P1THqxqGP7qVNOVk+RgQxOYrLlfvZaqrAj+JsK8Vh09JSEcE
	a1TA2XZiwa7QU+RCDeunNzb8Nv9UgiEdRoEmaatuNWOBPAi/Im9ni6QsOjTwJVBWAWjE+p
	lSTm4E6mlAOBlgEsxnHguKD/mg2UXaNf9GW+IXDcjWiY3oKIq2rIt+dt+t4IoYdwNI6D4J
	tzjWLkN7KAXc0BKhalXoFuNkv3DYDjJ+iQUrgQvVQelWduqwvRKq+bfkH4Ze4Ki4Iykzsp
	nh7NhL4pUGpWSuB3G5wqT90+FmUKiiwuw0xjFqA8F6ZtWNwiHKKQFjQgHmxqJA==
From: Daniel Linjama <daniel@dev.linjama.com>
To: connman@lists.linux.dev
Cc: Daniel Linjama <daniel@dev.linjama.com>
Subject: [PATCH 0/2] Replace hardcoded paths with configurable runstatedir
Date: Wed,  6 Apr 2022 21:02:38 +0300
Message-Id: <20220406180240.1191631-1-daniel@dev.linjama.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for configurable $(runstatedir) with RUNSTATEDIR and replace hardcoded /var/run paths

Daniel Linjama (2):
  build: Support configurable run dir with RUNSTATEDIR
  vpn: Replace hardcoded paths with RUNSTATEDIR

 Makefile.am        | 2 ++
 Makefile.plugins   | 1 +
 vpn/plugins/vpnc.c | 2 +-
 vpn/vpn-util.c     | 4 ++--
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.35.1


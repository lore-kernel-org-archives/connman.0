Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548363B2
	for <connman@lists.linux.dev>; Sun, 18 Dec 2022 19:28:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 163D0DADB2;
	Sun, 18 Dec 2022 20:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1671391711; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LQn0XPiEX+rtsa8KR4nOIvsEKIMFw5HiadtG4jbJjjE=;
	b=O0B2JJ426IRBL8Baw1sxbOymMV+GHQiTk0xFaB++5XXf3lSgjTG28URW829q7N4akzXCij
	H6UHW4J4351TUGZoFeTE5r/16t/WXQLgCbrKx/l61BIYqHZNZ5PB1R7P3uGz9SSq8se/M9
	i1FMSac3zB50Jaf3XOq2TxFQmSIPVS9kUMeIq6fvw9OHGt9Op2rU5t7dRPYq8CvmWV84he
	OeY1wLJjkXdjHfJ50Jb0cyXu49LonLGYcf23EKk5o9T4j1enRJAMKtFLKEaPMmM2JVMfMt
	VOy4wzbDA7MSP3XNvpHQFHdrpLe9AGGq/fzjQsg7ddcK82AFH4a5odolO7ZQFg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>,
	"i . Dark_Templar" <darktemplar@dark-templar-archives.net>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 1/2] ipconfig: Do not filter out 0.0.0.0 gateway routes
Date: Sun, 18 Dec 2022 20:28:19 +0100
Message-Id: <20221218192820.22937-2-wagi@monom.org>
In-Reply-To: <20221218192820.22937-1-wagi@monom.org>
References: <20221218192820.22937-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit cb05780d86c3 ("ipconfig: Don't add invalid gateway
routes") as it introduced regressions for IPv4LL setups.

0.0.0.0 is a valid gateway address for IPv4LL setups (see forwarding
rules in RFC3927).

Reported by Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
---
 src/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 9f17f4989ea8..34b1724a22bb 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1172,7 +1172,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 
 	DBG("");
 
-	if (!ipconfig->address || !ipconfig->address->gateway)
+	if (!ipconfig->address)
 		return -EINVAL;
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
-- 
2.39.0


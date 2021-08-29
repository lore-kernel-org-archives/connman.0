Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF629CA
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:32:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8257C61667;
	Sun, 29 Aug 2021 21:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630265568; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=MUqCwr6dTl9ES11MBiYqhpnOo/OOK3itelWLtOIleLM=;
	b=WWpsTjz2IZn9G8+rpe2oaHLfnynrY45/qjh+jv4AuZ5Jsnw2BADO95dpeKq9u0STAHhZoQ
	K5ea0I4i+j9pYQ8au4G6KBSyou4Y+3/FE2Ur388bTMk7fqecsIVzLCrQ+X7kFuI4Quvem0
	YjQ1xo5jBWC7XXxJgJv9rN1yxMkIVOyNEZGej7+RsXDX+KV74W2rzEnWlGuXCcupwFg0p8
	1hfadtrwA3CasyeCG0hzy2luYl9mSeqyODDSiMqhedFp3ULDEutmL5o1c0uUjplXs4RMcB
	1Jvh2v3P+h7fVzl5D97qg9PCy9l+21Hdc0mNyfPaMzWzWqjCFXcdk9vg17Uw3w==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Athimoolam Rajkumar <Rajkumar.A2@in.bosch.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] network: Do not disconnect decice on network connect
Date: Sun, 29 Aug 2021 21:32:40 +0200
Message-Id: <20210829193240.19095-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Initially, commit 3b6dd9aa9030 ("Add support for disconnecting
networks first") introduce the __connman_device_disconnect() in
__connman_network_connect(). It was there to allow autoconnect to
work. The initial code was checking if only one device should be
connected:

    mode = connman_device_get_mode(network->device);
    if (mode == CONNMAN_DEVICE_MODE_NETWORK_SINGLE)
            __connman_device_disconnect(network->device);

The service state machine has evolved over the time and this
check is now part of the main service state machine. Though
the code snippet in __connman_network_connect() was updated
(the mode bits got removed) the disconnect was not removed.

For 1:1 mapping between device and network this is no issues. But in
the case of oFono we can have several APN/networks per device. Due to
this disconnect call it's not possible to have several networks per
device. Let's remove it.

Reported by Athimoolam Rajkumar.
---
 src/network.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index b12bbc091b0c..1cbdf9cfed95 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1797,8 +1797,6 @@ int __connman_network_connect(struct connman_network *network)
 	if (!network->device)
 		return -ENODEV;
 
-	__connman_device_disconnect(network->device);
-
 	network->connecting = true;
 
 	err = network->driver->connect(network);
-- 
2.32.0


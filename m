Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E3250BF8
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403580; cv=none; b=OTsUFROf0Ngo8gMf/wn6r6gD+F/KS6Kuw8GJEXYoSJ/ISYbknzy1ftvCG14CAEAhh0ei7UXfG5/82rw0L+Sij3bXfX0KciQjWHgtOypQ2lFGCRiSfpqJ+8831QWs84VzY8Z5vw4X3dbGWrfjkIGDL/VBCJtr7c2piqGj9saq4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403580; c=relaxed/simple;
	bh=Wtdzq7pkKnhfBumWG3bd5kwMWCLLql+ev2qg+SPBYm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg/JdGxWrlDniBLdoJ6h2jn+UNLyMfil8aczl2SHaYtI4kah893ZK+DqRcXiqHVAXyEcjrm3PdUbF7plLLgJ4sZxjLr/YzuVq26rXpVgcThKVVhlorvLlOvTUBlH/Vh25fUhrVaKLmEP9RmqFscAlM5ZPLto6KnH2oRhGn8pG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=iTnKzf8I; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="iTnKzf8I"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5C68F164A4D
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:37 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 123F3124F28
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/4] ofono: Provide a secondary opportunity to get CM props and contexts.
Date: Wed, 12 Feb 2025 15:39:33 -0800
Message-ID: <5f8c2021153277ed01fe100f733f935c5cf6b9db.1739403363.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739403363.git.gerickson@nuovations.com>
References: <cover.1739403363.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=USCUU5mWf2TXm+xDRYSfc8TNuCSA8RxS/S5f1et4J9I=; b=iTnKzf8I1qqfJ2vT5oNH7eIitoeCuubTLEdXueXAhBnzWmjJBTZMkEjIVTAPCj5/WwlMe9X6iF+OsoYEzl9CsNQ7JzE6flwptFZYct/gQoIy7Vu9d7gNI7b23JhSQt8A7t1jBQXTIalFMLAOtji8LMnPZIjt2KfZi+X+MiBgwCM1CN7MIznx2OtJVLFRBSw0KJE9HjOLEPzCNwJgeXhJJ64gfSVgRh0JMaLS1L+bp+NKK/59QoeZyLlQ1yvrmd5FcQDYWa+HWRoXE5gnY9jf/MJkfj4uP6hLjctwuXiv8PtMsrUfV4g3DaPEwf+61RxG6X+/0Ts8OUaXjbk5ljkRvw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Provides a secondary opportunity to send D-Bus request to get
Connection Manager interface properties and contexts at the successful
closure of 'try_create_device' since the primary opportunity in
'modem_update_interfaces' is missed in the following test case:

    # connmanctl disable cellular
    # /etc/init.d/connman stop
    # /etc/init.d/ofono stop
    # rm -rf /var/lib/ofono/*
    # rm -rf /var/lib/connman/cellular*
    # /etc/init.d/ofono start
    # /etc/init.d/connman start
    # connmanctl enable cellular

At this point, ofonod will create a fully-provisioned and -functional
Cellular service, with both IPv4 and IPv6 Cellular network
contexts. However, connmand has no network and no service associated
with it so, so any Connection Manager client observing the Cellular
service state will observe it failing, on timeout.

In this use case, the ordering of the oFono 'lte' (Long-term
Evolution) and 'cm' (Connection Manager) modem interfaces shared
between ofonod and connmand is different from what they normally are
in the case where a Cellular connection has already been
established. Consequently, when the 'cm' interface state change
notification addition arrives, the connman device has not yet been
created because in 'modem_update_interfaces' executing
'cm_get_properties' and 'cm_get_contexts' is dependent on the presence
of 'modem->device':

	if (api_added(old_ifaces, new_ifaces, OFONO_API_CM)) {
		if (modem->device) {
			cm_get_properties(modem);
			cm_get_contexts(modem);
		}
	}

Unfortunately, that does not and cannot happen until the 'lte' modem
interface is added because 'try_create_device' has these conditionals:

	if ((modem->capabilities & LTE_CAPABLE) &&
			!has_interface(modem->interfaces, OFONO_API_LTE))
		return false;

and the 'lte' interface is added only moments later (rather than
moments earlier as is normal outside this use case), but too late
nonetheless. So, the ofono plugin will never get 'cm' interface
properties or Cellular network contexts.

With this change, each call to 'try_create_device' now has an
opportunity to check if the 'cm' interface has been added and, if it
has, to request 'cm' properties and contexts.
---
 plugins/ofono.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 820299765c67..f5248e57488b 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -167,6 +167,9 @@ struct modem_data {
 	DBusPendingCall *call_get_contexts;
 };
 
+static int cm_get_contexts(struct modem_data *modem);
+static int cm_get_properties(struct modem_data *modem);
+
 static const char *api2string(enum ofono_api api)
 {
 	switch (api) {
@@ -1038,6 +1041,27 @@ static bool try_create_device(struct modem_data *modem)
 	modem->device = device;
 	connman_device_set_powered(modem->device, modem->online);
 
+	/*
+	 * The order in which the LTE and Connection Manager interfaces
+	 * arrive may not always be the same.
+	 *
+	 * If the latter arrived before the former and a modem device was
+	 * successfully created, this represents a secondary opportunity
+	 * to get Connection Manager properties and contexts, both
+	 * essential to successfully creating a Connection Manager
+	 * Cellular network and service.
+	 *
+	 * The primary opportunity would have been with api_added in
+	 * modem_update_interfaces; however, that would have been skipped
+	 * since the LTE interface did not yet exist in such a scenario
+	 * and this call would exit early due to the LTE_CAPABLE and
+	 * OFONO_API_LTE conditional checks above.
+	 */
+	if (has_interface(modem->interfaces, OFONO_API_CM)) {
+		cm_get_properties(modem);
+		cm_get_contexts(modem);
+	}
+
 	return true;
 }
 
-- 
2.45.0


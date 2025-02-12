Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C11209F55
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403579; cv=none; b=rPBHTM3uXmCerAUggCM3GnR9zoEg2J28j+kmbpMs8VCoeMzZWCx/WfxCIpfy8KM8PCsgl4LT4TE6Kkb/VoZNRz71F10y7GFga8D0WfKYub318ChqZF5C0i3yyPwFjFJjL1HcGkM7F3OsWDc4E6bItYz6a0LnHq2kTIEnggr3JLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403579; c=relaxed/simple;
	bh=49dKVdZ4vzpMlLWVw9cTPZpqrqz5YURr6BOfwqRebMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CMPtO8EhpkDG7/2ti+OhJd8GY0JS2ZT8FSZj0hgQnQjaHUKL1IUh8jIZ3BbOClhasncz2wZb0OQLSf1dPoiP7VWjRG/ByFlSNLe1cvelBkjLf3eBRzjgzJ2jZhSxPA5eNcXhL29XA7Gg/r1j6IAo200OTUzSFB/G9zFlWcqSDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=PjwLianm; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="PjwLianm"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9ACEB1648AC
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:35 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4CAC2124F0C
	for <connman@lists.linux.dev>; Wed, 12 Feb 2025 18:39:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] ofono: Make the oFono Plugin Modem Interface Order Tolerant
Date: Wed, 12 Feb 2025 15:39:29 -0800
Message-ID: <cover.1739403363.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=MB3035TE/WwrIwZ8THp5tWYXnM7lrt875zKEpSdAgqc=; b=PjwLianmy4wjlZdXJabezLsRYYBvByha2CjPYaKQJrf+QZvDuZvXAWyg93Qq+0YuzxekMD24p+3IYzYx4itYL13mX8/msUAMM9AF6WKjnqeUOH+KAERg5mBB8QjNjT3oMdGQzxxb1UFDjPk1QDR3+gnzzvJl8zGjv75B6A5H/gp3isTikRZP30JpC/FnfQTObqpovVK8Rp8wF3Z36LToxXZF5N/1JVp51Xz6uyaOlibDqChGLed/XCqEn3hglyQ71N3rSPjOj0fndFPR8H4EY92xJfe2ZlV2eDjJ8j6R/omgRZftoNyrWpHMqSDSi/SsjUSAjK3j0Lp6xjdU0QUsvg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This addresses and closes #135 by providing a secondary opportunity to
send D-Bus request to get Connection Manager interface properties and
contexts at the successful closure of 'try_create_device' since the
primary opportunity in 'modem_update_interfaces' is missed in the
following test case:

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
between 'ofonod' and 'connmand' is different from what they normally
are in the case where a Cellular connection has already been
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

Grant Erickson (4):
  ofono: Add additional 'DBG' statements.
  ofono: Use goto error-handling semantics in 'add_cm_context'.
  ofono: Documentation: Add comment about entry condition for
    'context_changed'.
  ofono: Provide a secondary opportunity to get CM props and contexts.

 plugins/ofono.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 7 deletions(-)

-- 
2.45.0


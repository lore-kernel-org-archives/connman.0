Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8222DFA7
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742425; cv=none; b=hy52ROD8adCAoZh8uo8vXiOZfTZ9jOPUhNSysMrGPdbCqTYaSGdWy3qpjcApqU06/FLbPm9OS6Lsf2o5CQ4YCq3BCmUnAo8Iofhqhm3IJq3rijb54dyPnlXYTVQxQVFoVrxiew079dHNJTlwZeTdXBmrpF2dvTJTrAcWJHv9n2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742425; c=relaxed/simple;
	bh=TKP6pRrphvzN5WkSiB2qlymFykkAYTABCxg/z9smybQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XtAgUNEF4HgOLEIE29xlTMQ8AIR5SVpaHPdjUd9gl5lx3LLwJUUkU+buvZouTZ/WPycIwBHw7YX1XLDWc8WTYsJ6pqjCDe+bUv1C37ooMxod2lbjmLhvZwWV4qJnwdsRmOm1+YaVgendmY76zEeOA7+9Z2g6QwgDYSbbtn+2Ulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ouzfooI4; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ouzfooI4"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D6BF0164A8A
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:18 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8BADC124E6D
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 18:32:18 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] Generalize Default Enabled Technologies
Date: Mon, 28 Jul 2025 15:32:14 -0700
Message-ID: <20250728223217.3991877-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=26vKdVM9uGaQps8OoX+FPaUIIBvhIbWdrY/P3tvwT08=; b=ouzfooI4dbDXeUUFiT/kqqZqSydbqOjNNDbKGDzYMEVt4zRrEeIy/2lbFPayFFd++ol3eKwDG0OneWPUH2nyMJ6ezpq9Zjg3YU6z2qfjZJv3cWfeE9F1E1AnQZpDOJZF0s70otgeQ59sMMdJZ9kWkDSSpNKZ3Ipkn80ZV71Vnn2lHNNkLMQ3r/TSr8xP2NdfEuAJbSiNKdvL0Y/sis25poliHRPdxBZzQ6RT4UE1h5W6dju7F5VJzvDsMBVIFyD5CzLiW4JmuVoXyPBYJa9KlzDlXA+DrXvXszL6ntrfCIQUJbg8T+ThZTHYTuiaX6KmzVBB/dxrSocJrH9PJSGsXw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Since nearly the beginning of connman, it has behaved such that the
Ethernet technology is enabled (that is, powered) by
default. Currently, this is hard-coded behavior into
src/technology.c:technology_load.

However, if a different or additional technology is desired, there has
historically been no way to achieve this via configuration.

The 'DefaultEnabledTechnologies' key/value pair introduced by this
patch set is a list of technologies that are marked enabled (that is,
powered) by default, separated by commas (","). The default value for
this entry when empty is 'ethernet', matching the legacy behavior prior
to the introduction of this setting.

Grant Erickson (3):
  main: Introduce 'DefaultEnabledTechnologies' setting.
  technology: Leverage 'DefaultEnabledTechnologies' setting.
  doc: Document the 'DefaultEnabledTechnologies' setting.

 doc/connman.conf.5.in |  5 +++++
 src/main.c            | 32 ++++++++++++++++++++++++++++++++
 src/main.conf         |  5 +++++
 src/technology.c      | 25 +++++++++++++++----------
 4 files changed, 57 insertions(+), 10 deletions(-)

-- 
2.45.0


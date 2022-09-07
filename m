Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78120EB
	for <connman@lists.linux.dev>; Wed,  7 Sep 2022 18:52:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DAAA5E050;
	Wed,  7 Sep 2022 20:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662576745; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Gj+LqD35RXXF6QrcFv/isrAXkoAWDEbvIFojlr5QqKc=;
	b=q5QBnPUdOZW/zsKhqNf8EBUMHIAEUR709EvOpxKAHV/gEDmeVt00cgo7lqkgK5p1StDPZy
	tOi4d3WXe+nLHSYZRKMEmYsxM5tK4aWfBik0iKkSfXEM/7Yj457lHCzg5kn2AAKIanssn8
	miR+26pOVA2dr4z+k0tWMfj486aPaZXK5c3eJSC0Q6fJtldkYsO0ScGEq6iQv/T2TeoiDg
	tHQc1EFTl+wm/a7bXNJJA3in6Vg4hjFx4ecjDaKIR9SQ51ZggZ8sFyvYBMqmmn0ddJoafO
	H9nXTOwKzWcgtLM/HLb4FPDuQwItvn+/9/nI3rvzmwBIkfDV1jwWrQ7R6TYExw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 0/3] Fixes wispr refcount and cleanups
Date: Wed,  7 Sep 2022 20:52:18 +0200
Message-Id: <20220907185221.2981-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fixes and cleanups from the introduction of the wispr refcounting.

Daniel Wagner (3):
  service: Track online check for IPv4 and IPv6 separately
  wispr: Fix context refcounting in wispr_portal_request_portal()
  wispr: Simplify the IP version check

 src/service.c | 39 +++++++++++++++++++++++++++------------
 src/wispr.c   | 16 ++++++----------
 2 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.37.2


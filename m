Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34103FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:53:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 457DF60F99;
	Sun, 29 Aug 2021 21:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630266806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EpFAbylEpjKS6gJHWHzQDAgaOzsbf+fxB1MdK6K7MW0=;
	b=igDg+V6Qie9M4ALc2vBjtbCHg5QaQijKaXz00XeIlRP1inV/H7DI7TOXb7Q7AXR8OuCjrq
	Tm9AOhCukjRN1NTBbBfKwq0fdwKFsFFEPnboixB+Jr68LkJAdC7rgrWMRCMjDViWh1oy11
	3UtPzMGAGjsf2ghFeLry2UBcTqGv0g6y4pWZXRquRrWj6EL7Yiv2IiatPcDSAalT6AC6UI
	PcpVlKpO+yERrdp/RcxVXw8TrpM5rRS2z4gDnhJ92f2W4SodsCPn8zU9+4/ZUW0/Nxz7cw
	gveLhSDDl5JHHovp/fOSU3o4DSgIpk5lxfcCnEJZ7mnsoAwQ4hjEEAq4fOzlYQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>,
	=?UTF-8?q?=D0=A1=D1=82=D1=80=D0=B0=D1=85=D0=B8=D1=9A=D0=B0=20=D0=A0=D0=B0=D0=B4=D0=B8=D1=9B?= <contact@strahinja.org>
Subject: [PATCH v1 0/2] Disable online check for real
Date: Sun, 29 Aug 2021 21:53:19 +0200
Message-Id: <20210829195321.23396-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Страхиња reported we still do some online checks even though
EnableOnlineCheck is set to false. Let's move the
__connman_service_wispr_start() code to helper and add a check there.

Cc: Страхиња Радић <contact@strahinja.org>

Daniel Wagner (2):
  service: Move wispr start code into helper
  service: Do not trigger wispr start when EnableOnlineCheck is disabled

 src/service.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.32.0


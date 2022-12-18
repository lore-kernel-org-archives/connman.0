Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90232CAB
	for <connman@lists.linux.dev>; Sun, 18 Dec 2022 19:28:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF84CDADAF;
	Sun, 18 Dec 2022 20:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1671391710; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KbWxis0sYfAVwALxAXt5NuAf0TSQp1Xnea5FDGooOF8=;
	b=EQrhKFTY1bQ9zAcBN32u9IY2HoRQJsnC5DmaYSogmssgSGVjFWl9qNhP/dHNxl8X7cyw08
	XLgts2Xb33zwP+h2TIWbLrZuK64fJLsxFN1yLsQ4q0khdfBgTVVYAtZC3hM5XV+u9sZx2S
	s5xMF/e+m4r9r97ir4dQJ4eq7OKS/bPGrMT2YBXc635//HEkl4KdhoDPi0ET7VDFo5l1Z3
	nJ/6tuqgpf4ylRL0/CKsxfAwITF6+5oIQ/Zx0h4qLuYcj9juWT55scQ+ZHu9hoK7rjzRa1
	r6BrSovNCQsB5ScTG4YJ7sZ39SlYhFE2LhQ1jAa3xHdjjYoxnW+GaZojN/+rmg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>,
	"i . Dark_Templar" <darktemplar@dark-templar-archives.net>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 0/2] Fix a couple of regression
Date: Sun, 18 Dec 2022 20:28:18 +0100
Message-Id: <20221218192820.22937-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

A bunch of fixes for the recentently reported regressions:

 - https://lore.kernel.org/connman/66993511-8b3c-bf48-beaf-9ff9e6ee446b@gmail.com/T/#u
 - https://lore.kernel.org/connman/b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net/

Daniel Wagner (2):
  ipconfig: Do not filter out 0.0.0.0 gateway routes
  main: Add Hamachi interface to ignore list

 src/ipconfig.c | 2 +-
 src/main.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.39.0


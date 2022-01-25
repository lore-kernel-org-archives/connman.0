Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F666173
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 521455CF3B;
	Tue, 25 Jan 2022 10:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101229; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ry6EsCb3zFz90GodvKDWzINfU0RV9vKvD3m1FZtt/X0=;
	b=RW9BmyKY//usTo+PNWHkwLv0KKNZbe/DWoZX1P5pb5i+1wYZJIy2SLzg3rVfKyxSeAzkRD
	3/eLFzEnpDtvxV3DFZqr90NPU82zkmwR0hFR9N5LAS7TM3jjf74Ih5WApmhvNUuCtDUD4B
	c77k1IUgGdGhPw5EO3y2p+ldf5u6riwovr9m53+aZQ1aXjGRZj+VGICd9g4fLRh8jIyiE+
	kUXokxZpkwwFP34gBd0Wvh1Y5dzbhMT93GqtX4PTqsjc+I1Vv0WC3GxlferIGQIoYs4x/V
	UQBTnY1qJ364y+Ugueosciktk25lMR1Y11MISjFkMAEIMS+YwEtxt4mAxWL8LA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 0/5] dnsproxy: Add input validation checks
Date: Tue, 25 Jan 2022 10:00:21 +0100
Message-Id: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Matthias Gerstner was busy testing the dnsproxy code and found a bunch
of bugs. With a lot of input and help from him we came up with the
following patches.

dnsproxy.c is in a pretty bad shape and needs a complete rewrite with
proper tests added. This will take time and brave soul to do so.
Though things aren't that bad as there is the option to use
systemd-resolved as DNS proxy. I haven't looked at the code of it but
I am pretty sure it is way better than dnsproxy.c :)

Anyway, I'd like to thank Matthias for his excellent support and
contributions fixing up these bugs.

Thanks,
Daniel

Daniel Wagner (2):
  main: Use g_strdup for online_check_ipv{4,6}_url config
  dnsproxy: Validate input data before using them

Matthias Gerstner (3):
  dnsproxy: Update TCP length header
  dnsproxy: Avoid 100 % busy loop in TCP server case
  dnsproxy: Keep timeout in TCP case even after connection is
    established

 src/dnsproxy.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
 src/main.c     | 11 +++++++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.34.1


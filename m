Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441828;
	b=CHBRlFAU2fwD8MwQFJ53oIT0GH3EqHxeI86krwNok3Z0yTh/v3gZo38I2vPsbnhH2evb
	 Ny4GKuCiI1JQImTw5jHUb6z815ab3Fqfcewmv3NDeNM6vas/auFsEUcfnc/1jYRNtuHVk
	 44k33iGjfoO1AEaJ1DKziIqaMgpjAEpaERgDDr9SoRwu7kVSSGQcueUr3aKEIq4mEuM71
	 /+yoU1aTWB0q0+m5k9IUb5uEfcbAs1ix3GWSN4HcWmzbaWWqSaz+6sTHzXlrwVDtFJwfc
	 zBvcMUHRkvSXOD2eIFIGBmJCI4qfFG+ihXNZvgNF8yi7rupKLgl5il/a24yQJjg7t/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441828;
	h=DMARC-Filter:Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:To:
	 X-Mailer:DKIM-Signature:X-Scanned-By;
	bh=EabVJCnnIxDv4eFSWqKchsg8FWR0Nt8QB/IIie5RFAY=;
	b=SzFB4Vx5d41IcTKKL9pq29ecR9DVjls4MIxuSJ6QQjJYE/qN6OsI2Gka8OmckTmyCdZK
	 CsfskT74Jz4K0g3dTkFF+/8JGOoXzd0raEW0iNouANt7T4vv3y52F3hmHAi+O2sOC6QMy
	 uk1DJI+y1Gc9bAX42CTWMCoa85PxMpq/Ki2Y3pOfrkn4VwNNJUuNcHZQV8yC+lbo3czyM
	 BJ1k+sajGqLsTQc9tXc1t0QDckPPPUuOAAYPvOwagvH2WSELRUIQeUWiQaNPYJPgtK+ZX
	 ERF9twKKZ2e84aHDwu6bJqgA+x7xhBUFzU0kzWTIyxiGvhg52AaKQITtvBdLVLwjnXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=eE+kW1qd;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB70606A324
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 00:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB70606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=eE+kW1qd
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4C70116024F
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 19:03:47 -0500 (EST)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 113AF124C15
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 19:03:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.4\))
Subject: gateway: Fix Lost Default Gateway Demotions 
Message-Id: <F35C804E-0CF5-46B6-BD5B-D8371C680A48@nuovations.com>
Date: Wed, 11 Nov 2026 16:03:36 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3864.700.51.1.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=EabVJCnnIxDv4eFSWqKchsg8FWR0Nt8QB/IIie5RFAY=; b=eE+kW1qddFvIVsxEf7rfUecJSx0S7dE0SKGFmz94LueLDAzCpTUIJwgdgih+WZQszQOmKqu3UFhzvY/qLRqdSCLFECAKluob6u7KRW3HFaIK0bPFONf/UgpcTmC5pgUFLO0sEJvIeRnqdQLYfVuLxXKr/NeBMPBgmCVyJKCCylCBUt2+G6xJ8/t0l91IGvauaKfAlbgq4plrtbzsECdlRma1jBCepJncFSmJQkKhExqNm8Lw/a+bQ8OsISCsBBwRw9KZuPsSblTv0qnoUzCqyH4zFVRtYsjMn9aHsVp1WBOfybI8x4S+gtOfx8BcwlKQuCpkKKr+s1uSbLv9CaVRYQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Team Connman:

    https://github.com/Nuovations/connman/issues/151

Patch forthcoming.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


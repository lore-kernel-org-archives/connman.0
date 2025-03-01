Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C28F7D
	for <connman@lists.linux.dev>; Sat,  1 Mar 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853521; cv=none; b=SxaiBKrM5k+yjTTE7jPSMiK5dhZtjzsn5SNcPVwdeehXSeFiD/fwnuxHwyhB01yNUnlOSM1LggECyUGgz6Y8biUTBIkRZf0ttRgn+mu/N0mcHDXnRyJtb8xMkCc+pUsF7NV+apRtPeYuiJvqd4bFsor+yd3mrmMDTKlzjR10hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853521; c=relaxed/simple;
	bh=zGRaKVlKynO0TwLu2FgQPCS9KcdNFkMt66zmGWdX7pA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=g3kRv4A5Vbw44XTrknQO0GQde8bMS7r4jAEu0GHr/++MCjdVJ6Wtrg1VDOBiI+BI1Ja5p8BNhEqlzDaSRw7hdyORVuRQgWb7WlqsTP3buYD7R75+zmkSHJOT536AHW9s3vKq8ypRCSmHlDO7lfV+4pRofsSiNMMXslhgBG7clAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=UVIj36E3; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="UVIj36E3"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8342A164948
	for <connman@lists.linux.dev>; Sat,  1 Mar 2025 13:19:30 -0500 (EST)
Received: from smtpclient.apple (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 420AB125164
	for <connman@lists.linux.dev>; Sat,  1 Mar 2025 13:19:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: 11-hour ISP Outage Did Not Result in Two Systems Failing over from
 Ethernet to Cellular
Message-Id: <632749AE-211C-484D-8235-F03D49007EE5@nuovations.com>
Date: Sat, 1 Mar 2025 10:19:15 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=MwTyteMGpuYMYEHJ8b/0Jj6RfcG1ZXh9xwCxplXb+mw=; b=UVIj36E3D8+k8boWuDX6XH366XesthMiLNInWOO3nXyxLBlcykC4PmMkksxVof9+bll1EQJD0w90d6soICpD4fa3E/EKkr7ykTiT75+/c+iw0myA4EW+tQTf7tVNwhvumLgv+f9gozEiJ3P7lutRu3P2LTjgS/BJoiegaxGv4ylpRLGEPjhWQr5R6Hw9eeCZyNe62cnGahPb2rT17MT28yZqyynIaanO9n4Ma5VP8KjxJFQqIAu5DX3WDu1b3CFzox1dHI/Asrjor8klcPleO3WtFHJ63zNFVE39I1ZrZ00s5V0GhBVaXagVxbEmw08AmvGDeFOX1a7WS69fZV9aig==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

FYI, for those interested in following or tracking:

https://github.com/Nuovations/connman/issues/140

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


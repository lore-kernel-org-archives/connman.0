Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443694;
	b=mH2++u3i05ZCkaLiAgy5ngLBPRbV9VUknbpiVmFFHusfhgp0JG/XeIwvv2Rk0sMLdmRa
	 zrmyp6ezOGhRQojFOYLq32sQ6ul4lNbqCWCMZIypUn1Gu9pcmfDgMv+cpho1PC7FgMotY
	 DcArqgqbxGw/8tcYeRpl+gDpFty3eLXK0aAl+hsvCG6HEZoUDLCo62rFxJejiv0vk2y9I
	 E3hVpD6aerIRVELO2Sl6If5Bo2Mc8K0GdPSsFcmPeN0FJNJYXHpPb7sVC5JeVnuGofQuO
	 vC2FygRWbd6IwSfqok2GvarEXfyG7zCsBY/03pq9DW0qcgEVg9a8/l/iDA1+JDoWvHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443694;
	h=DMARC-Filter:Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:To:
	 X-Mailer:DKIM-Signature:X-Scanned-By;
	bh=7I4MC5mC1Ku87FAqhRvWtouywWPa35CAJ0AkH6q2K0c=;
	b=jwPOs3JPYynf/aFeaCVynx8qhKVW5x+HLiitnBXK252cyqwmp0aN9MYyJ8l378Il/lm3
	 IbHlK5Ipj/1P9lRuggyXyJ0LIux6N9AT7BqvD0ywYXZ/v5I+e5HbLmf2Gd18O6NnfSXVh
	 Q4uvL9ZnKHHWCsi/UBwVzZjRF/TwCkAcQ6cn2suoYEaA32UQ1uu1bKKwZJZqWBSVSJxnW
	 3wMCA+emv/DH150p5H4b3AbwlUq8ySubcKH3HEjxQ7o7Wi6HQpYcuDWI/4ulSB6MkeLG0
	 S6k9ubr6JPRpKlvKTRmacSQoQT8M7ckiMLKDcVManfg0sQbnG6yJatdHRTbOAEVzL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=h6V91Upd;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF29606A31C
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 00:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF29606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=h6V91Upd
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CB5F81600D1
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 19:34:52 -0500 (EST)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8FD27124C7C
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 19:34:52 -0500 (EST)
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
Subject: gweb/wispr: Online Check Still Has "Holes"
Message-Id: <E612FCE3-87AB-485D-A667-932223AAA38F@nuovations.com>
Date: Wed, 11 Nov 2026 16:34:41 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3864.700.51.1.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=7I4MC5mC1Ku87FAqhRvWtouywWPa35CAJ0AkH6q2K0c=; b=h6V91UpdtD/mt5DVKVPdY64DZHKoe1rwMwgIsWi2PnBAnkvYzE7Q6BoIuC/vC6wgUmY7TbbmJELnI4fR3eroOz1C+ApX1utaDLYn/OqRh4fzI7sQjPn9x8vbyh8oQRFslbED2xiXVqNsdfqsce+zAK33wtGtB/UdmBHAgBsU5XWvXBoUrah+htxKot3DAsiAw+ohTXRlE4iKdNXcim12fezb5eJH/VSOyele4QkrF8Ogd/WTZUFEYltKErTke+WJ8RiP0C2f6nGCye3FKGmChfGxwM4hByual2t5M15TVgy8MvG5xbgj2FLLSJq6BSbcVUdLPN7VLfYgxvbuGwdHzQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Team Connman:

    https://github.com/Nuovations/connman/issues/153

Patches forthcoming.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


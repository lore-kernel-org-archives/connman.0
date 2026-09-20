Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5772765E2
	for <connman@lists.linux.dev>; Sun, 20 Sep 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908414; cv=none; b=h+g74W8qO0sY/9IjIAMqCiiHCFJVTI0Jz7jk81g/btjWs2oYLqfpVjhqzG5Ty+N/ki/5fvW5fTdO3a7tC8AKXeZaVKMgGqE6dopmYq8yVrB/lizKZEpvZkhRsbZB65QiQsa525GbKcwXhE+6LuXo+aOUQWWgGVG2kb3g88bJApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908414; c=relaxed/simple;
	bh=8kps1qxZiXQnDRXF96drd19SzisYUsufLJygBkLHmGI=;
	h=Date:Message-ID:To:Subject:In-Reply-To:References:From; b=szpwLhOJ4YjuWUV0vo4uned8wHwUlbk0xUO5iKFPOj/+92MoXxJBxAxaGfq7+1z+2JImKRUn1ixY0qpoH0++2LOd2q6htDjwFdSxQp54h4XH07OScWrSD1VSwqatFAh2+zB9LUpfou7UEIxxyBgv0IHwtcKI8og1KwSIrKkOaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=pgprkTbN; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="pgprkTbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1789907945; bh=8kps1qxZiXQnDRXF96drd19SzisYUsufLJygBkLHmGI=;
	h=Date:To:Subject:In-Reply-To:References:From:From;
	b=pgprkTbNp13cM2MAxW5vUQdixCniQcKta4ckCseI9D0A3hK3Q36rE2YmMWsr/uCZF
	 gMLVYKnqlkBHdfl2Piv9OKKv1DkQLM119jelF/PZm5V+nER3BiA4lhMeSvOj5qVGbq
	 60hJpzNnhMtZ9IFL/uEK50U8niL3w7Rd49Ynzj5g=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with UTF8SMTPS id 4hnmBd5rwpzDrYj
	for <connman@lists.linux.dev>; Sun, 20 Sep 2026 12:39:05 +0000 (UTC)
X-Riseup-User-ID: 857C00F0CDAFBE9E56616FB3687D6CBA49DE3563C4D7B94B46E26BB6D0A11D07
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with UTF8SMTPSA id 4hnmBd0yxxz1xmQ
	for <connman@lists.linux.dev>; Sun, 20 Sep 2026 12:39:04 +0000 (UTC)
Date: Sun, 20 Sep 2026 14:38:52 +0200
Message-ID: <280925b2dab33ece9a5237165be0a8fa@riseup.net>
To: connman@lists.linux.dev
Subject: Re: [PATCH v6] plugins/wifi: Fix GSupplicantInterface socket leak during teardown
In-Reply-To: <20260830133850.1423-1-kasuta@riseup.net>
References: <20260830133850.1423-1-kasuta@riseup.net>
From: Doemela <kasuta@riseup.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>

Friendly ping on this series. The fd leak is reproducible on embedded
systems (LibreELEC) with kernel-space WireGuard, eventually hitting the
1024 fd limit and crashing ConnMan. Happy to rework anything that's in
the way of merging.

--
Doemela

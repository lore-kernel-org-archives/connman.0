Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7F8C1F
	for <connman@lists.linux.dev>; Fri, 13 Feb 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016773; cv=none; b=NgrkRYmx0ZcoGw0EA/l4kuOTjJI2mVYC/3U76rQ2mhw4To5QVEStMJcnavpT4ejCN3nBQFTh0vS1BM2n05L2OfY7m3Ec5hq8mzsI1gHLO/haygY6lJdnLsPDZA2ptgUA+JOIku7PEXqiM3J+p1TtVyEuIuKXJ56YjlOv2n97Aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016773; c=relaxed/simple;
	bh=zwdqUd/3trHS3t3au+Voc+4kWmtFsxr6z54a/vB4dag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rzujWLExPaR3Mu+Cbhp0HRrck42mgxaIGabKfQg6CMAvCvZ5hzCmR9RUkllANpq5dufitJfKpxtCLn9xnSGtjZslcfPZPhQpggBrOErKm5hCV8m/t8fkiy+QNkoUtc1p1cr+wCA7+QRlohDEHDj61AXcVh6CbKIxu9NWLG8y6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f6bd.dip0.t-ipconnect.de [79.249.246.189])
	by mail.holtmann.org (Postfix) with ESMTPSA id D5895CECBE;
	Fri, 13 Feb 2026 22:06:09 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/5] connman: Fix issue with const return value from
 strrchr and memchr
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <aY3Uu_Zd2b3v26ON@01676446e9f4>
Date: Fri, 13 Feb 2026 22:05:59 +0100
Cc: connman@lists.linux.dev,
 rudi@heitbauum.com
Content-Transfer-Encoding: 7bit
Message-Id: <BE01B073-F9F6-4A11-9768-65C9163D53D9@holtmann.org>
References: <aY3Uu_Zd2b3v26ON@01676446e9f4>
To: Rudi Heitbaum <rudi@heitbaum.com>
X-Mailer: Apple Mail (2.3864.400.21)

Hi Rudi,

> When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
> warning occurs because with ISO C23, the functions strrrchr qnd memchr
> return pointers into their input arrays now have definitions as macros
> that return a pointer to a const-qualified type when the input argument
> is a pointer to a const-qualified type.
> 
> Rudi Heitbaum (5):
>  vpn: Fix issue with const return value from strrchr
>  vpn-provider: Fix issue with const return value from strrchr
>  gweb: Fix issue with const return value from memchr
>  dundee: Fix issue with const return value from strrchr
>  ofono: Fix issue with const return value from strrchr
> 
> gweb/gweb.c        | 4 ++--
> plugins/dundee.c   | 4 ++--
> plugins/ofono.c    | 4 ++--
> plugins/vpn.c      | 8 ++++----
> vpn/vpn-provider.c | 6 +++---
> 5 files changed, 13 insertions(+), 13 deletions(-)

all 5 patches have been applied.

Regards

Marcel


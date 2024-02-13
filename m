Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6D1B273
	for <connman@lists.linux.dev>; Tue, 13 Feb 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813792; cv=none; b=t4856pQv0Ilb43jAdoDmf/9DbMUsM4U4K5tJSdqI0zLyWtvQbK9GOBkJQ9uviLFMhVeMih9KuxmER0QKeZC4Pn+O+oZBhN+aPdW+vtISvJOQfnPjWft/kCp17Bx1FYGfLUlC759Dm3qCjP4dQpwNtq4rT/axFnfurTiKnDwk4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813792; c=relaxed/simple;
	bh=VTo2Zs0NerZG++0M0F3a6f7lmEVZznz6OlEV38s2b9g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kv643/kZnU5z6h0fquy96bqcO36MqZA9zaCkpLL0wMbHL2oo+pSVB49DwHrEK2QzAoeVC9jJ+lPNgCopEuYXEybuTe3pdCCGMTdk8iaECwHsFCVd1/Qtz1IXqXJbvRQ5FV9ckGTbdDzjASYGPWwGL0+63KV4V6ceD6CCyXWG4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fff9.dip0.t-ipconnect.de [79.249.255.249])
	by mail.holtmann.org (Postfix) with ESMTPSA id D6D9BCECBE;
	Tue, 13 Feb 2024 09:43:02 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] dnsproxy: fix signedness warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240209180148.19443-1-bfukano@gmail.com>
Date: Tue, 13 Feb 2024 09:42:52 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <57DFD430-B169-43C5-B394-44CBA7A3FAEC@holtmann.org>
References: <20240209180148.19443-1-bfukano@gmail.com>
To: Brian Fukano <bfukano@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Brian,

> This fixes the signdness warnings in dnsproxy.c
> ---
> src/dnsproxy.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index d4242560..72e77f96 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -436,7 +436,7 @@ static void update_cached_ttl(unsigned char *ptr, =
int len, int new_ttl)
> ptr +=3D DNS_HEADER_SIZE;
> len -=3D DNS_HEADER_SIZE;
>=20
> - if (len < DNS_QUESTION_SIZE + 1)
> + if (len < 0 || (unsigned int)len < DNS_QUESTION_SIZE + 1)
> return;

I love that you are trying to address these warnings. However just =
casting the issue away is not really helpful. Lets us proper types for =
the variables and have the checks make sense.

Background is that I want the compiler to keep warning us about these. =
Once you cast, the warning is gone forever.

Regards

Marcel


Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D33186E27
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265937; cv=none; b=cM3ZsgRVNQbkavEaYTNJz4iQXHTzYRfRxiWjgAt0UXBQWiHu/e8pFt3jzkR1ghthuTAE2b7t4bxEHkMjnyTtmTIP0SWIpi2/iU9h4FIcbdFkqtb29vU/LL7dJKbXvlpObmxLq+tCt+uiOKbi9u4BOU3iUfGFFSAf9viW8B8Aupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265937; c=relaxed/simple;
	bh=yzsnRRJlNSGhw7GXpKKXY9suyaXYQSQYYtwMu4AEwZg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YBz3bEs3vctOS+9ODgxqJkXI+uPSQIYrVXrZdb8vanI0j+w24Rsg6qZuVmXhmyxPSfCw09L2FGGzY0TTiEV3SUjI43abnqd6SzLfLatdnMDDUYQjOzIKYGqbQraRkPSicUjBKTqzx6vYI386Qjvb+1kK9Wjkmf/XwLsk8sQUj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f372.dip0.t-ipconnect.de [79.249.243.114])
	by mail.holtmann.org (Postfix) with ESMTPSA id E6B50CECDC;
	Mon,  2 Sep 2024 10:32:14 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2] dnsproxy: fix signedness warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240327191229.248942-1-bfukano@gmail.com>
Date: Mon, 2 Sep 2024 10:32:04 +0200
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADBCDD43-141F-4ABD-B516-2C8EF47E2C10@holtmann.org>
References: <20240327191229.248942-1-bfukano@gmail.com>
To: Brian Fukano <bfukano@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Brian,

> This fixes the signdness warnings in dnsproxy.c
> ---
> src/dnsproxy.c | 50 ++++++++++++++++++++++++++++++--------------------
> 1 file changed, 30 insertions(+), 20 deletions(-)
>=20
> diff --git a/src/dnsproxy.c b/src/dnsproxy.c
> index d4242560..a25fde35 100644
> --- a/src/dnsproxy.c
> +++ b/src/dnsproxy.c
> @@ -417,30 +417,30 @@ static void refresh_dns_entry(struct cache_entry =
*entry, char *name)
> entry->hits =3D 0;
> }
>=20
> -static size_t dns_name_length(const unsigned char *buf)
> +static size_t dns_name_length(const unsigned char *buf, size_t len)
> {
> if ((buf[0] & NS_CMPRSFLGS) =3D=3D NS_CMPRSFLGS) /* compressed name */
> return 2;
> - return strlen((const char *)buf) + 1;
> + return strnlen((const char *)buf, len) + 1;
> }

<snip>

this patch does no longer apply. Is it still needed?

Regards

Marcel


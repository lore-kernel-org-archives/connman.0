Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C921369B4
	for <connman@lists.linux.dev>; Wed, 22 Jan 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565283; cv=none; b=c0Kd7Am4dh1aLwZuOcNHFcRWbQp+yIpPKJPyOa/wukp3xS0hJh5sXpNWd8ZlCKO5C+zkwcBiBHr0T7Tj4AEOU91flN/NTxywnXayWxWvK5PzzVS9J79vG6oBRdKYhw/Lgh6bLC2K8eORglixxfDFeSZlRRjY8A94hAp9qujR8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565283; c=relaxed/simple;
	bh=XlF50UXGDjXpoqeVKvaB8IsJGbK7cFPuQZO3zPqvYt0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aD+OjsJb+QaoEjyRdrm71yYuxOq5TagedoJFyK+Z0R6J3tEEadluKuaIYWcKWdRsIio6fNOKA+5gfsyr4lYwBe6aZgHqYm8ixR1U49TA6VB7OGDZgf8d94YGBxgS9KNaGkOT0HAjVNMriuAGf8SMnkFtIrtL+ULvDLr0Wc4cP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=mU2FW0V0; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="mU2FW0V0"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4CB84164A42;
	Wed, 22 Jan 2025 11:51:51 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EB1CB124EDE;
	Wed, 22 Jan 2025 11:51:50 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 08:51:40 -0800
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
To: Gabriel Sanches <gabriel.sanches@prevas.dk>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=92IxzRVCMi0JsYrhXyS6hrsAk9jbDzHpeHSoOkUBqlo=; b=mU2FW0V0E1G1eDZhKgiMRbmmxxZ+riE02rI5asMSn1V1+70u3vP4X0XW6EtkWnWlWGixSwq6WaeZ26JHpoHsQMVaL6e38PbF55UlaaiBW9awWIatTXxHh+Y8Merm6FxAIkeLQejRXViYS9aXdz+hKJcl8kHQkk61PSiHw35Nx2c7XhiZ/87toTr/o2t/r7CVlTJtV3k5vHuJIK3QlNI6HqAc62rhT20CkaCAsBpWMAIteIneL/3zCzO8ESsJrGkry65FJaeocSSVt5ERpCseNBq9/4eCHD4mqQf/dtyg2J2BKHuOuhUOiTa9lF2EiMnhYDQg6mWc8xV9Upfgx+KRgA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
> I was testing connman's wireguard plugin and got a segmentation fault.
>=20
> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>=20
> I simply changed them to ipv6 and got it working.
>=20
> not related to the patch:
> I had to manually add ip route so the other devices could be pinged
> The plugin adds routes for the WireGuard.DNS configuration setting
> # ip route
> 1.1.1.1 dev wg0 scope link=20
> 8.8.8.8 dev wg0 scope link=20
> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83=20
> 10.42.0.1 dev end1 scope link=20
> <vpn host ip> via 10.42.0.1 dev end1
>=20
> the missing route added manually:
> ip route add 10.33.0.0/16 dev wg0 scope link
>=20
> an equivalent wireguard file adds it properly (using wg-quick)
>=20
> Is the plugin lacking some implementation?
>=20
> ---
> src/gateway.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/gateway.c b/src/gateway.c
> index 16c87f83..b2c211e2 100644
> --- a/src/gateway.c
> +++ b/src/gateway.c
> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
> 					is_gateway_config_vpn(
> 						=
new_gateway->ipv4_config);
>=20
> -		is_vpn6 =3D do_ipv4 &&
> -					new_gateway->ipv4_config &&
> +		is_vpn6 =3D do_ipv6 &&
> +					new_gateway->ipv6_config &&
> 					is_gateway_config_vpn(
> -						=
new_gateway->ipv4_config);
> +						=
new_gateway->ipv6_config);
>=20
> 	} else {
> 		if (do_ipv4 && new_gateway->ipv4_config)
> --=20
> 2.43.0

Gabriel,

Great catch on this copy-and-paste typo; thank you!

Best,

Grant


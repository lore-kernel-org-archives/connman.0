Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262116C854
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975294; cv=none; b=juq2crVlzwwu/mk6YE/NiyydXC6R2F1qWhHNwXMoN0bHE73kTEcc2uEutKOFNDnrIkDpDUtXKP+zWZknuwJwh7J+MZtGCSDIArJI8bi1QJXoX+6T37bcSA18TWCJqlAzZbFLRHFzqirUx+2Hiu/TfuNF3cVM34ZYrMTw9U7zRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975294; c=relaxed/simple;
	bh=hOCzQAx4TMttUkot5b1x82j04moI2oe6Hqwr36opqG0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PWcfUqK4cbbJVoMt5hyrsG3CrqpUuA0xjXwQymk1yD0b7Otq1gA/uKBuwF+0+hEEPq+4O66Kff1wTyUef1i9+U8fgFVwX8GEojXJasfWPHybiVPnEKyGHBPh4mFtCcBjRv1RSdpWp8TrwLWt+lXNXy7PxpA+PLWrVbLPfeKzh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=H4q6xZEF; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="H4q6xZEF"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 78DC21649C5;
	Wed, 24 Apr 2024 12:14:50 -0400 (EDT)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E9E39124C10;
	Wed, 24 Apr 2024 12:14:49 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: connman-vpn does'nt work with wireguard
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <5D35F841-0063-422D-B6E6-F2FFBAFFF332@gmail.com>
Date: Wed, 24 Apr 2024 09:14:38 -0700
Cc: daniel antoine <univac55@gmail.com>,
 connman@lists.linux.dev,
 =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E0CE3E4-BE47-4C6E-B102-570F8DB593E2@nuovations.com>
References: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
 <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com>
 <5D35F841-0063-422D-B6E6-F2FFBAFFF332@gmail.com>
To: Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=8GRIA6E19ZS1C5z3SC4dnxE2YL9bl7J4vjtsYhb8pIk=; b=H4q6xZEFYYHK2DqFUk8lfyDkuq2a4vj/8tiCJ7rIfQWpkmVQ0LTcxI3amF26/hUGoDObwUYPVO1/A6/hyPCS/SvAJtejLNIUDYMevF71WPkLozzBjA9UXa9tclsZnrHYf7LhxSD7O91JgDU7UYkqhDLbfIQ/A7CuaF/JfaHeogq7iXo/6HFTzL+S8wtXggJpqrVgIJVUYzEuyNPWj9paHoySTLF6OOVbKTNhDsBFIwKccY9B4ce3IR+WoHwqVtdi5d+/dylI/2tzFZT+1Xl9IW4n7WY88GX4p45SGINXkqBOXWvYQrQx9XjlwtwKaeFywWJf6gdc33KVipZz8X1hOQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

+Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

On Apr 24, 2024, at 7:50=E2=80=AFAM, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>> On 24 Apr 2024, at 6:06=E2=80=AFPM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>> On Apr 23, 2024, at 11:05=E2=80=AFPM, daniel antoine =
<univac55@gmail.com> wrote:
>>> I have installed wireguards-tools on my system and I am able to
>>> connect to a VPN server friend with the command wg-quick up 'name of
>>> the interface' . The configuration file in /etc/wiregard has a host
>>> with a FQDN as blabla.com  . It also works if I replace the host by =
an
>>> IP address (IPv4 or IPv6).
>>>=20
>>> I have adapted the configuration file in /var/lib/connman-plugin =
like vpn.config
>>>=20
>>> [provider_wireguard]
>>> Type =3D WireGuard
>>> Name =3D vpn
>>> Host =3D balabla.com
>>> WireGuard.Address =3D 10.0.6.5 /24
>>> WireGuard.PrivateKey =3D xxxx
>>> WireGuard.PublicKey =3D zzzz
>>> WireGuard.AllowedIPs =3D 10.0.6.0/24
>>> WireGuard.EndpointPort =3D 51822
>>> WireGuard.PersistentKeepalive =3D 25
>>>=20
>>> My display environment is enlightenment. I see the connection "vpn" =
in
>>> the connection window. When I click on it , wg show vpn displays the
>>> connection to the server, a ip a command shows an interface wg0  but
>>> it drops after some seconds. I can ping the server 10.0.6.1 until it
>>> drops.
>>>=20
>>> If I replace the FQDN by an IP address in this file , for an IPv4
>>> address it makes the wifi connection shutdown and returns. My laptop
>>> is connected by wifi to my livebox. If I put an IPv6 address it does
>>> nothing, no interface wg0 is created.
>>>=20
>>> connmanctl shows the vpn service with the command services and the =
vpn
>>> connection is present in vpnconnection
>>>=20
>>> My first question is why connman does not accept an IP address IPv4 =
or
>>> IPv6 . I have compiled wiregard-tools with WITH_BASHCOMPLETION=3Dyes
>>> and WITH_WGQUICK=3Dyes
>>>=20
>>> After why the connection drops
>>=20
>> Daniel:
>>=20
>> I wonder if you are running into the same issue as Christian Hewitt =
<christianshewitt@gmail.com> in the thread "RFC: There Are No Routes for =
Non-default Services
>> =E2=80=9C: =
https://lore.kernel.org/connman/FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail=
.com/
>=20
> The distro I work on (LibreELEC) is bundling this patch to revert the =
change:=20
>=20
> =
https://github.com/LibreELEC/LibreELEC.tv/commit/998f2bcfd5849e3eecda6f753=
ff5bab68a847aea
>=20
> This unfortunately means we=E2=80=99re unable to bump ConnMan until =
things are resolved/adapted upstream.

Adding Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>, the =
original patch submitter of 9eb1772d31b6 for visibility.

Best,

Grant=

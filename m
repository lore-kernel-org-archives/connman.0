Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085C1607BA
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972026; cv=none; b=tZb2zGqtig+244DtdlGxQL4jm0EtqkL9vurolP99G8P7aMfG7R+ZI7pLklU9Zn8VlN5qAOEx7MTTqT16bXzGaZucl7V4ZL7WjTFjWco42SmERGxbG/4I+gqPZXrQjjVJPsKdecZc7Lqn0mSNPUuLJg6uYXbc1OBTIsO4ccnHwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972026; c=relaxed/simple;
	bh=0aI0GunFVEXmMVPu9iE8y5YllWQCVaoh46qz3TgoSfs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VBOTaB4B400dS15bD9eS6mrZkIqSE88v1oV48Kk8bD7jzUbWIX3x4uhYyheF6MQ6KPbzG6g2llwEF125hU4qwOSKmzZ+Syhb245wUufnPb2cldCMb6/iuNXaPCyVHHiuIXLof52laod3fJHBBduFxspqye+S80Z50jC6tU6GXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=riZbDRoD; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="riZbDRoD"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B895B1649C5;
	Wed, 24 Apr 2024 11:20:23 -0400 (EDT)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 469C5124E36;
	Wed, 24 Apr 2024 11:20:23 -0400 (EDT)
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
Date: Wed, 24 Apr 2024 08:20:12 -0700
Cc: daniel antoine <univac55@gmail.com>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD0C33D1-C11B-4879-A1D6-BFEAAC36F65A@nuovations.com>
References: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
 <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com>
 <5D35F841-0063-422D-B6E6-F2FFBAFFF332@gmail.com>
To: Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=3G5feVa/pNbERoxJgjIRyQgSNtQhFueoIK0O5aFsxzw=; b=riZbDRoDB6Jv5rGN2ZGpqU+sLNftNa98TuZrSAPogb4tWmZhHSNIjcfWno/cJ777k+ROmsT8EoePW8iLxEB6nOKa4VgV8FKcXo3eccK3EUf1rdxFaDkKr/PI2Y4g4EIrJ6/terHRh5qRztILJZJir5TFacSPoRJL0gI9Ye68ziYtVKnb16iyIsNIeNgG3z04xLDwqDGZjx9WvCiNwR3FuptnI23ohNhIjTBPFN8XJwTkCdmzuHSQ8bAogvobKJnYLMET8CRkFYYOEgn8Dux5b/fApWWHRCxSnnHBQy6IkOKdiquKitvIsJMPzQEnp41Z2Hqd/Gbwphh6iGn4uv22dw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Apr 24, 2024, at 7:50=E2=80=AFAM, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
>>=20
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
>=20
> Grant, did you ever get access to the WireGuard server that I shared =
working?

Christian,

I=E2=80=99d sent a note toward that end on 2023-12-19 and just now =
refreshed that thread to you privately.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


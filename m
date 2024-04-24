Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59615E213
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968121; cv=none; b=M/ohpkjfkeii8zMb7Bke/4b1aXh2lqOU5kCsWwHVklGELs+8f0bp61h2Xk4ByHNQwSxHCUxc7ctIoRIMw6O+v1g0MCHQnHBVmRufLEllBC1rlqNGQHdmwZoLvt/FwLUgp1ZxZXQ7jDYUwyu+HNmkKr9RwhOH2aOUp80xYaW+fFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968121; c=relaxed/simple;
	bh=gi4AbOZYpHPRHv4YMoaDx6ICvf4DvFE2VNMxD/KT1G0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mnnr1KMxZeGXoiz5to2a2lwwTYBVKsLIT+MJ+586DGDBU3Wg8HLADLjlSB8PVaUb/kye+owRaxYvz1+OPHTIbUBNDezylvY0L1D8rTfGABRZ+ohydOeajZUjPaPqv0dXFuHNu06FueAkzAdvpeQZWk1q0v4NHEeJwEXInB8X1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=agk/wfQi; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="agk/wfQi"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0A9CC1649CF;
	Wed, 24 Apr 2024 10:06:55 -0400 (EDT)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 90C98124F8C;
	Wed, 24 Apr 2024 10:06:54 -0400 (EDT)
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
In-Reply-To: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
Date: Wed, 24 Apr 2024 07:06:43 -0700
Cc: connman@lists.linux.dev,
 Christian Hewitt <christianshewitt@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com>
References: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
To: daniel antoine <univac55@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=pSSW8a6rKpSJ5+FOPPGB51KMBg5hvb6wmu5Cbxhfp+8=; b=agk/wfQinUTOM4zZdL82ffbO1HRReUdAk1MAq0Bg+tUYc+m146tAHrNhCkBSnIiMWrgD88Dow3VH25uEnQ8t04sIRpmQFBDwis/ThViy2mcazWOAUXbaLsgwAiIpYoauwB2OpWxksNkrFbeLgF+isegsJ8DPrkTafnUXqzCJ0/FQH+ltJjZ7D1jTDS7hlB4q5mWrJc1yYR+DjrZTGhp5f/3m/WofJrBYuJBi3PN2/YQXWT1HMI5COP4kwYx3Ar0cnk2X5bswFSFDhv55bLHJadgs0pAz+IKwuXU1Vd8TCYKuYba6oT9xU6y1O6jQ7J8OZHEaw/tXa0bb/XXQHsyZQA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Apr 23, 2024, at 11:05=E2=80=AFPM, daniel antoine =
<univac55@gmail.com> wrote:
> I have installed wireguards-tools on my system and I am able to
> connect to a VPN server friend with the command wg-quick up 'name of
> the interface' . The configuration file in /etc/wiregard has a host
> with a FQDN as blabla.com  . It also works if I replace the host by an
> IP address (IPv4 or IPv6).
>=20
> I have adapted the configuration file in /var/lib/connman-plugin like =
vpn.config
>=20
> [provider_wireguard]
> Type =3D WireGuard
> Name =3D vpn
> Host =3D balabla.com
> WireGuard.Address =3D 10.0.6.5 /24
> WireGuard.PrivateKey =3D xxxx
> WireGuard.PublicKey =3D zzzz
> WireGuard.AllowedIPs =3D 10.0.6.0/24
> WireGuard.EndpointPort =3D 51822
> WireGuard.PersistentKeepalive =3D 25
>=20
> My display environment is enlightenment. I see the connection "vpn" in
> the connection window. When I click on it , wg show vpn displays the
> connection to the server, a ip a command shows an interface wg0  but
> it drops after some seconds. I can ping the server 10.0.6.1 until it
> drops.
>=20
> If I replace the FQDN by an IP address in this file , for an IPv4
> address it makes the wifi connection shutdown and returns. My laptop
> is connected by wifi to my livebox. If I put an IPv6 address it does
> nothing, no interface wg0 is created.
>=20
> connmanctl shows the vpn service with the command services and the vpn
> connection is present in vpnconnection
>=20
> My first question is why connman does not accept an IP address IPv4 or
> IPv6 . I have compiled wiregard-tools with WITH_BASHCOMPLETION=3Dyes
> and WITH_WGQUICK=3Dyes
>=20
> After why the connection drops

Daniel:

I wonder if you are running into the same issue as Christian Hewitt =
<christianshewitt@gmail.com> in the thread "RFC: There Are No Routes for =
Non-default Services
":

    =
https://lore.kernel.org/connman/FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail=
.com/

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


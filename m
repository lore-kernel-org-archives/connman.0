Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383F15B99E
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970236; cv=none; b=CzNq5+LpGar7M0IA/wXhpFMqmx2RGI1uPSbEBpnyABDXNIIcUnBOk4HqDsTpxAzvA/XVWNmjLowbYu1IdUh++YGcBWYn5NFPct9329a5ang79CS9si8pt7AoYpZSoLgHUjnrjggzLzzolUrx/yzNJ+YA0QHDMVEKMxAoRmc0S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970236; c=relaxed/simple;
	bh=g5viy80ekHoTlK8lum4/+X6rHrPLpddro8eaZaNG3Ec=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rQpdbKRAvZo51gYTkC9QfRxemWa/CU6v9Vfj0xPdhfS1l/xC/KJad4ntTNtYsbu1PBvEB3gD53ssnU53lc4LjAE9kIvaKqkrf7tsg1mX6t2DHZQ5IAtw4FFUZz0jYXcnCQI8VO+bg4s6BYr133JND9Iv0Y4PKELgXDcw5g5Vchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeZFVJQw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeZFVJQw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b243c20a2so2026435e9.2
        for <connman@lists.linux.dev>; Wed, 24 Apr 2024 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713970233; x=1714575033; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boJHf7KwWcS35X8G6MY5ksc84vdPUlOwmy75jVmqYTg=;
        b=YeZFVJQwEWpJzqOWEVGTp5qm+7Nx0ITNuR0DwvWnvv0c2s7OKFRwQmY0g0YakgIPbd
         WAolkibICa9Qfif1z4CSwxn0DpFGh7p/3KKiUgAdmDiLe5d1xSI3JE5EOWYqpXyCp+5p
         4jqOS4zwkt7Zm4sS8TQBZeWxf2OjRhgt6PUXLUnuibHBfdLvNP21kv6rJUdjwQoDUv6e
         yjxGs5h0RSt1OkBxyscweOjt8tO3yF/8vqnVI2WvDTG8kp6fw1APyLIAkLS02YclWPp3
         0+z/ZiVx0X5i5lZ1PBYBXc1NWmmpKClICeRc2nOxUGlg40xyER0ECiI367ysk87Y5uPj
         nvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970233; x=1714575033;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boJHf7KwWcS35X8G6MY5ksc84vdPUlOwmy75jVmqYTg=;
        b=JWbNakgFtJvzDpNGdQ7PIeWZHQvytwUoRsbFkpVF/mXXkw3oCPaqnGQVkLNZb4kIWd
         iOX3QEAH6LRe1Fm512i93ykm+szL+Mse3bP+xRzVKMlNYEweN8d4jw458j28V+nHR5xn
         LQ7jIf9fU+BZBA+RiCY0vB4vnxnyeWBqBGdAjImk8r1Z6iyScjB81eXQABpCuuZQS/mq
         9nEQjYWxY2odsLkVvGNGn8oGE3JDtQTD70p/r36j+jE7Mf7W4uigFxlXaH3wZlfoAOK/
         Zy/9LiRBrkAPX20jFW2aOx621oab2rflZSwCKEKN1ftFWv8DvYBLzZ3J1cgbjkFBI7SB
         vR6w==
X-Forwarded-Encrypted: i=1; AJvYcCWAXCTOWymykHQ75Endl9RB7l/NW6U/q6tZtV9Hfb2j0Cf12IvdH+vgNHkCpGJL5NLP1m8sJE+AAE723KkEZ9RdspMoglsFWQ==
X-Gm-Message-State: AOJu0YyQSN4Fh7WJCVuEE3dLMmQGydMC6JtzVymVckRjX2bWHR0YY4p9
	gT+6noMKfB+iTwoCywQDSQLYl6aSChKDVf1flL0WUUyr3Sj1cRYE
X-Google-Smtp-Source: AGHT+IFZfMK0TbiMlSgvh4Z1MxbLl4Z+8/Ats+Pt/VMxa5ersYymnk9384HmKXWUakL2HFsw8Xt6dQ==
X-Received: by 2002:a05:600c:35d1:b0:418:e88b:92c3 with SMTP id r17-20020a05600c35d100b00418e88b92c3mr1911835wmq.2.1713970233113;
        Wed, 24 Apr 2024 07:50:33 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b0034658db39d7sm17521962wrq.8.2024.04.24.07.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:50:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: connman-vpn does'nt work with wireguard
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com>
Date: Wed, 24 Apr 2024 18:50:19 +0400
Cc: daniel antoine <univac55@gmail.com>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D35F841-0063-422D-B6E6-F2FFBAFFF332@gmail.com>
References: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
 <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

> On 24 Apr 2024, at 6:06=E2=80=AFPM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>=20
> On Apr 23, 2024, at 11:05=E2=80=AFPM, daniel antoine =
<univac55@gmail.com> wrote:
>> I have installed wireguards-tools on my system and I am able to
>> connect to a VPN server friend with the command wg-quick up 'name of
>> the interface' . The configuration file in /etc/wiregard has a host
>> with a FQDN as blabla.com  . It also works if I replace the host by =
an
>> IP address (IPv4 or IPv6).
>>=20
>> I have adapted the configuration file in /var/lib/connman-plugin like =
vpn.config
>>=20
>> [provider_wireguard]
>> Type =3D WireGuard
>> Name =3D vpn
>> Host =3D balabla.com
>> WireGuard.Address =3D 10.0.6.5 /24
>> WireGuard.PrivateKey =3D xxxx
>> WireGuard.PublicKey =3D zzzz
>> WireGuard.AllowedIPs =3D 10.0.6.0/24
>> WireGuard.EndpointPort =3D 51822
>> WireGuard.PersistentKeepalive =3D 25
>>=20
>> My display environment is enlightenment. I see the connection "vpn" =
in
>> the connection window. When I click on it , wg show vpn displays the
>> connection to the server, a ip a command shows an interface wg0  but
>> it drops after some seconds. I can ping the server 10.0.6.1 until it
>> drops.
>>=20
>> If I replace the FQDN by an IP address in this file , for an IPv4
>> address it makes the wifi connection shutdown and returns. My laptop
>> is connected by wifi to my livebox. If I put an IPv6 address it does
>> nothing, no interface wg0 is created.
>>=20
>> connmanctl shows the vpn service with the command services and the =
vpn
>> connection is present in vpnconnection
>>=20
>> My first question is why connman does not accept an IP address IPv4 =
or
>> IPv6 . I have compiled wiregard-tools with WITH_BASHCOMPLETION=3Dyes
>> and WITH_WGQUICK=3Dyes
>>=20
>> After why the connection drops
>=20
> Daniel:
>=20
> I wonder if you are running into the same issue as Christian Hewitt =
<christianshewitt@gmail.com> in the thread "RFC: There Are No Routes for =
Non-default Services
> =E2=80=9C: =
https://lore.kernel.org/connman/FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail=
.com/

The distro I work on (LibreELEC) is bundling this patch to revert the =
change:=20

=
https://github.com/LibreELEC/LibreELEC.tv/commit/998f2bcfd5849e3eecda6f753=
ff5bab68a847aea

This unfortunately means we=E2=80=99re unable to bump ConnMan until =
things are resolved/adapted upstream.

Grant, did you ever get access to the WireGuard server that I shared =
working?

Christian


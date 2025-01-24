Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8735942
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724864; cv=none; b=spwrYhu0AgFOWNyxRzkS3k7ziQcpKsFwmPqtOg/qzzOOtHSiAW7pyZ96E1Ufy2qCXARkG/DuGamxQtWFhol5nj7Nd8Yt/Z5+wtVBpvK2H48t+wb8LR/9Raw9TEXEpzZd6ybLSB1BxZLmAGN5llUN2ZwDMT31BAHg5Rin4+nYQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724864; c=relaxed/simple;
	bh=Jj8iDUMRaoIXbBewJwwce1CTBgh3zygtGhUsKZzrW3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8t/eC+wjweF9kDihHYT4ofd+1guYcRrto9507w4CFKXrg7cwD+vrfXjXP/C31bS4GyxRl4KNgXM5HbSl2ojdh8T2D18BqidRzYH5vuCz5YEb/S+dKfeqPLdaI56zrwOnumzigh0O7t8V9FKZ6FUYJ5jj3548ZEbSaXJWGO0Kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK5WBpEd; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK5WBpEd"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso670372e0c.2
        for <connman@lists.linux.dev>; Fri, 24 Jan 2025 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737724862; x=1738329662; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7TWjYrXH5LVSsUZlgqOD45o5CeRAqMd3XiZlotq2DE=;
        b=EK5WBpEdNf84tIsqya3mT6rNku3J+FMCAyF3amznRm9pfbklH4ULc4gyLG1yCQPpwn
         g6jIpPhyK3chulHOvbtKLxAyN3V7na/7LEuVCVqe9sYTcGxAW4ePxC5/VJT80oH1hhqx
         qe4/xhIMIh/2cO87xMr5Lt0MEHvu0pxSwDghr1PUs/+BVfzHEAdYv+IS8yItVxWK6luh
         /ax+UzMUsYqaolAyWF6gMI3W6isSscH8f9SHaDt1p4XXkvLnNVO78kgpyhev+LbvsACk
         blg9XqF4H/hwApe8ex69HtJwMdyec5jBFNmnDNhZZYuEAAgExw43KYlnRks2rme71ktm
         plKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737724862; x=1738329662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7TWjYrXH5LVSsUZlgqOD45o5CeRAqMd3XiZlotq2DE=;
        b=bEgTyQiMl1zrdZA4eBe62dW6LvHUOtlPGNGL631Ru2qf9vBJIUfxI9N3GND+9fqIaa
         9mQpirlaNW+y3PODVQPM+LBQxClFexguy3hDwcFEO9Hxb7wAOlPSl4kv74dc5XAlwx58
         9xBpXiSutt27xI1sgmr0Aso0/HguOiiq18Gb8gZ+Q+WU+qOPZzupwDZSfYqMQaHUuwom
         n1Al8UBBlLFdQW3eof80ZoWIBUYTPfPBR6gN1B+0MrS7rEB0td211+zdK9vL/Wel+VwN
         kYipwPrV521/2Rqz5Dzeo+UpFU3V5Q7DMHwOD1egEiTXqMhIFeWoyU5j6l5yullcMAvG
         jYlQ==
X-Gm-Message-State: AOJu0YxIsmBlgJLDT/RFQ8u80EG2Q2cfV0wFJPO+fqp0uQNUsj8riLO2
	MOGqSP/K9t6iHttlJWF3qJ+alO7x3Ja0ucsh+zDaYBLP4vAZ1IsJWwWTvsShdrIUOJNhAGrhEBW
	Je/Pf/+rTccBSGsAPrV5dCALDvhXS8vQSeSU=
X-Gm-Gg: ASbGncs/X+cnV3roXqLKcTYP8XscP2CKpLBdEYMbjWu+m/Hq9yPCsi4gDNFrjIf0YcI
	jZaQ6NBjTx5ct/jO6n6HTwFRkb0pmeFmI2vZdRxOCWwo3cSQs9Qa4R0EPdDrMYYWJnLU/BeLLrX
	UA+hVYxK0mW0dlbWUOAaY=
X-Google-Smtp-Source: AGHT+IEgrAommakCl/clNmqUGEv82vxrveLlGMgG94Fon7cyOvQhQz4CZD1YYoj67tF0FnCowvHxzCCIFcxKZc2qg28=
X-Received: by 2002:a05:6122:2501:b0:515:daa7:ed07 with SMTP id
 71dfb90a1353d-51d4c6586f4mr22836095e0c.0.1737724861722; Fri, 24 Jan 2025
 05:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
From: daniel antoine <univac55@gmail.com>
Date: Fri, 24 Jan 2025 14:20:51 +0100
X-Gm-Features: AWEUYZlHdRuezk0apxvtnkm1B5wbSp0B1dON8G2dlIUs0nk1240uPWHqUUXMRdk
Message-ID: <CA+iibzCNbo26XnW4_2fR3WvnPpe1g4sV_Qrr6GH--2xwgQ180g@mail.gmail.com>
Subject: Re: [PATCH] gateway: fix calculation of is_vpn6
To: Gabriel Sanches <gabriel.sanches@prevas.dk>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have installed the patch but I am not sure about the config file in
/usr/lib/connman-vpn

does it look like this
[provider_wireguard]
Type =3D WireGuard
Name =3D Wireguard VPN Tunnel
Host =3D 3.2.5.6
Domain =3D my.home.network
WireGuard.Address =3D 10.2.0.2/24
WireGuard.ListenPort =3D 47824
WireGuard.DNS =3D 10.2.0.1
WireGuard.PrivateKey =3D qKIj010hDdWSjQQyVCnEgthLXusBgm3I6HWrJUaJymc=3D
WireGuard.PublicKey =3D zzqUfWGIil6QxrAGz77HE5BGUEdD2PgHYnCg3CDKagE=3D
WireGuard.AllowedIPs =3D 0.0.0.0/0, ::/0
WireGuard.EndpointPort =3D 51820

I am not sure if the options Domain WireGuard.DNS and
WireGuard.ListenPort are mandatory. The host must be an Ip address or
a name like mysite.fr ?

Best regards

Daniel

Le jeu. 23 janv. 2025 =C3=A0 12:38, Gabriel Sanches
<gabriel.sanches@prevas.dk> a =C3=A9crit :
>
> Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
> the WireGuard plugin from faulting on startup.
>
> Fixes: commit 823d5a2a8cc4 ("connection: Refactor =E2=80=98__connman_conn=
ection_gateway_add=E2=80=99=E2=80=9D)=E2=80=9D
>
> Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>
> ---
>  src/gateway.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/gateway.c b/src/gateway.c
> index 16c87f83..b2c211e2 100644
> --- a/src/gateway.c
> +++ b/src/gateway.c
> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service =
*service,
>                                          is_gateway_config_vpn(
>                                                  new_gateway->ipv4_config=
);
>
> -               is_vpn6 =3D do_ipv4 &&
> -                                       new_gateway->ipv4_config &&
> +               is_vpn6 =3D do_ipv6 &&
> +                                       new_gateway->ipv6_config &&
>                                          is_gateway_config_vpn(
> -                                               new_gateway->ipv4_config)=
;
> +                                               new_gateway->ipv6_config)=
;
>
>          } else {
>                  if (do_ipv4 && new_gateway->ipv4_config)
> --
> 2.43.0

Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECA17E
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514836; cv=none; b=atie12iaS3JENaEfx/BwupEYt3BaFSDkSNTC4S377t9CJNivlYchuHdu5CcHgKx6t4AHPjztc11UceL2q9hamJQ1SyrLpsaVDDo9JKVGDy+27YJys3ldJE0mvUXUQQzH0rkZJShqcW8sbExWS33irvz76LS1SK4KJTpzaMbbx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514836; c=relaxed/simple;
	bh=ztBktUJdGIKhl7zsMSextd1HDWpun2vPMUCbv9CpiZ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CI09d9s8KVK2Ol5S3ItzsE+zGdJonFJogzJIVUlIPkTGg6e0SRS1A60sWnoOTBtVE3GPzF6gkbxCXd4lpb+jPTUHH5rI1g8kPdSr43weEzaAl+RqR3vsuZxBMFvRxkMiySpEEc/RE7hMdQG7TmEo0H9hMJPCsyz6k5zBLkts1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hetlIMdm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hetlIMdm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948021a45so17498765e9.1
        for <connman@lists.linux.dev>; Thu, 13 Feb 2025 22:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514833; x=1740119633; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ierDPYWNz0TY2VF4LHCPJFmSDRUnogd7cUsbJp2QI8=;
        b=hetlIMdmToAuKHaXmDtmLBT1xp7TTkSpeN/BMNG+ajM6N1u60k0RNjq7uvIEupz3+F
         07IQ0TdKVIj63EdQLnKwzI1txfjf5NvKcwzLMi/Yq1YK2RFdWi97yMUQaDlc6f0vlQTa
         uk6nL4TP7bpHyupbbVqaGrv5DY1RfDrjDhd5njPTv3QvWGTEgNzGBuqRk2ZuRnFI4TCV
         hygLNEuufSD+bmSyPOnpvvFbxhJuXNT6T+FZKwpsuzuOGGFBYD6c3h8pLlfZb0hpUh/V
         J9S1TxOX7PrDqSkhNwLeZCVBIFcuKMOp+ivh8Gb0vFtXwoOJQ07iccdk4jUzEU16eVN4
         id4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514833; x=1740119633;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ierDPYWNz0TY2VF4LHCPJFmSDRUnogd7cUsbJp2QI8=;
        b=VXex1KvOBRQjVOH7lzxrLj0VrG9Je/T4DaoJtHQTQBIKDlMB3WqncBSFGu+dNc3aEU
         4s8zaCctW0p1AlfJKAu2z2DOM3a9mnyS+Pq9zi5KqMCrtuVmdkYhYhIUasHUogqBf8Pa
         k6OrB2RAKJYAECcCIQDtF/Jkj4uqO1NaynXpRfIAuwJQgGpBaDpDJro2liJq1T4BUcgr
         VA4WFyHAw7kGo8fq43QCu/QSE74TyltReT27mqElCIfhmUeEad1marr4KPr3xc6BtKSc
         UbsQ87hgyz2BvDOr2WSFOtt1udN9s4FAbzcUttLTpvoRXtsBgB3IzGfnoMHgOPy57sYO
         naOQ==
X-Gm-Message-State: AOJu0YyeK4zxrXzOHeSO4dKGx/Tu48UEBwk8W4QPLb226PALcWNc5GeA
	Yz0n3G+2kBOubBZ5LGQqEhHnDQbsqLhA19G6weNIBVcPWCDV87HE
X-Gm-Gg: ASbGncuZg7rKftGBHdWdjzCOOkTUh2gMz+eeC80/MNb1phWLj08q7ZFOcghFUlKM6Il
	QKNmZg4B9xEdCJQZJI2IaUw3L+Xf29MUydX0mMkGna0jwQt8nrWgNsTIaXhdWJSkDEYBcIB40JV
	IgblrZ6eetxRDkSTyuewSLZIGuJQnwBoiseutSxkCOV1b1Dpd6CbyKe+67i05o7qnfs7ZLT7wYc
	piupe9qcftayMPtaaHbHUIdQZBUvO4VaZ4VlFMLZOu5QLQrmzQ0OMHV8SmwVU0o9FGcStFStQS1
	zfQRysNfq8D17EpOrYXlIEz5Ojv+jFQorJ7zWg==
X-Google-Smtp-Source: AGHT+IFAnB9I/f+Lw3K6jdP5+XqBM804yl1UnOcLTtbW3Zq1SlJQe7SszwyDRDoK73k+9W+aqwxD8Q==
X-Received: by 2002:a05:600c:34c1:b0:439:44eb:2d81 with SMTP id 5b1f17b1804b1-439581768c7mr118423775e9.15.1739514832527;
        Thu, 13 Feb 2025 22:33:52 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396713feccsm11942205e9.39.2025.02.13.22.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:33:52 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] gateway: fix calculation of is_vpn6
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Date: Fri, 14 Feb 2025 10:33:39 +0400
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFB720D7-E13D-44B8-A683-1467F9FCC187@gmail.com>
References: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
To: Gabriel Sanches <gabriel.sanches@prevas.dk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

> On 23 Jan 2025, at 3:38=E2=80=AFpm, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>=20
> Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
> the WireGuard plugin from faulting on startup.
>=20
> Fixes: commit 823d5a2a8cc4 ("connection: Refactor =
=E2=80=98__connman_connection_gateway_add=E2=80=99=E2=80=9D)=E2=80=9D
>=20
> Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
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
>                                         is_gateway_config_vpn(
>                                                 =
new_gateway->ipv4_config);
>=20
> -               is_vpn6 =3D do_ipv4 &&
> -                                       new_gateway->ipv4_config &&
> +               is_vpn6 =3D do_ipv6 &&
> +                                       new_gateway->ipv6_config &&
>                                         is_gateway_config_vpn(
> -                                               =
new_gateway->ipv4_config);
> +                                               =
new_gateway->ipv6_config);
>=20
>         } else {
>                 if (do_ipv4 && new_gateway->ipv4_config)
> --=20
> 2.43.0

This fixes a complete breakage of the ConnMan plugin:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>=

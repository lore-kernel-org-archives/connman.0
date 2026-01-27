Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A127FD4A
	for <connman@lists.linux.dev>; Tue, 27 Jan 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522195; cv=none; b=lm+HqUVv6GJUBZyAz4BJA/lxGKHt0jESnjbTvL1miYZEShpmAhs3c19TmPWxDRN7xKI1+rjLQer2OMTHHjDdB21fu9Bc1MWIGcpcb3Z8S4a65fFeiDA7uiKMJdbEMg2rSctiXPmjLAiRHjhoINcjCkuMNvfP/XNxI2kpdY4zWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522195; c=relaxed/simple;
	bh=YAcb2TU/c/0fNkgdHRXbZC4OmDD5dRMVYzDrTKmcfUM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KAv6MWS8ixpR7tDDgvHJgzc2q8n3YpovpDInTt1M4uUOZqHtlbaBZfT+wbc4cN/2B9jy9It5q3/TqLMAz3bsbv9EkNCRewSHQ0LOYy49ik92QQC3ILSSCbFCmRLXca1WQJG94XpzxayTtPSjkUs+lXYTPf/hqa0b6NrogUMP99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpMSoueo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpMSoueo"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359108fd24so3411499f8f.2
        for <connman@lists.linux.dev>; Tue, 27 Jan 2026 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769522193; x=1770126993; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBxTyb6JhcLKEOZwK1IdMBPQw+ztlNNrTuyzmr9WSVk=;
        b=dpMSoueoelwjP/rakwIOGxlqogMZkPEtV0d30SePEC/f0TR94evcVJr4vTqDRI7bq1
         WUOcYpfpi6428C2KwRmaqxVf4hlZxPf2tWgsg2zL7EwzJUXWm56Dqh7T7Sc+KRABNY+u
         lBOgp0pfllavqSejx9V4uLvhqm/i/dxMr3Sndevs5Vj3zhyV2ooF1KTQ1llCI38J5LsG
         z80fTBF+RciKXz79OYhd1bPTQHLRbpqpN4Z0BBuFMSkLZ3W87hklABHSC1vfPdeOXlo3
         z5VHMd5YOJDBPjvXkZ6Vrjzcr92QptqoZ6L9HiEkgO6n2KyhUZYT47j5K6r0yoRk6qG8
         s0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769522193; x=1770126993;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBxTyb6JhcLKEOZwK1IdMBPQw+ztlNNrTuyzmr9WSVk=;
        b=sBqC0+K6xsctZJo9E6GgupbfgyDHDgaH88mU0xSOpnWXFR2oEAdJ4ByTRMtOVUfi6f
         15cLPlWpTe5X7dMBtYFT1lIjZspMwqOeAnNkJwjjgZCjc8gkV0sQxN7Z/DpmXbUNUAAX
         t5oiNW11TrlMuH2sNZLQNiUjd8YhKYsaPxgTZD1hlg1RY6CarSTgOlun66XIc/MHJtXT
         RE4G/Xzs3djRu0SlTsz1+1sxBAmfhQqC3Gchrr5Tuc1DEX5ch29MoxHjo+N/um+I5oAX
         2doktDHt6BQtocT4V5+a1vp379rhHBJkKDlF52F+6pqQ2MdS2s88q0SrK4MQQUa5uUEd
         9LqQ==
X-Gm-Message-State: AOJu0YzdZP5cx5VtfjMNnuNjvhW56Zj0Xoy8K09EIYdtB5AgxBJ6S4lR
	/zKEkDicI8uCPRQsPHdd2/0MOaOnFr2hw9ZeIcmEPBUKY7LS8Q5AtUYbB/WvLo7e
X-Gm-Gg: AZuq6aJXUQivDJ1QkQg2H2hnXnZWwU9DULt/ynwszR2f2VB99a8CahEO4KhhKQjeIgS
	kyKCE/CEN8d3ullflR/v0niBZ3Kj3mTRkpjQlBxQWtlmC1exfHGuGaSCNCeow4/S5KM4qX5OGoi
	iDqH0FhBrZ0pgGAosWi9AyLwyWQYsqaSQGwAvUmENNuDtZqbqzGY+WJytbmmqafcI6zjma+60sE
	83cIYip1m0K74rVwQl4q4sb7oMDrG3sf9cRw1a/8p/AHcpgat6y+60K2/sOuN323w6A3D+THGww
	cKdeGvMJjApzVP106d9WRo+E7ngji8PuJYsOM8Ki/9dInV+ZVxZzGP+IIP9GLJZg6fsKMS9BeGe
	NK+vbeHUVwsqp6oN220iIREpxcQX5ff2YJ0M+tekJzsA164cZpyScg5p/WdkfJ1luAA6LKo4cky
	OWMl9dZNltvdG+usUQCCQipltynyBy0Py6fC+dcGQ8SwVUcT9GS3elCIrEkV6rrx+KTCAlMw1Bi
	p7BJtVrmP3G/IQ=
X-Received: by 2002:a05:6000:4021:b0:435:b6ab:6c1a with SMTP id ffacd0b85a97d-435dd0b2bacmr2667540f8f.49.1769522192489;
        Tue, 27 Jan 2026 05:56:32 -0800 (PST)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm37026948f8f.38.2026.01.27.05.56.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:56:31 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] wifi: Detect invalid key with auth challenge failed
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20251215100431.1867291-1-chao.yan2@bosch.com>
Date: Tue, 27 Jan 2026 17:56:19 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4211481E-C2E9-4EF6-81D9-040AADE0B6EF@gmail.com>
References: <20251215100431.1867291-1-chao.yan2@bosch.com>
To: "YAN Chao (BCSC/EPA2, Smart Home)" <chao.yan2@bosch.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

> On 15 Dec 2025, at 2:04=E2=80=AFpm, YAN Chao (BCSC/EPA2, Smart Home) =
<chao.yan2@bosch.com> wrote:
>=20
> Signed-off-by: YAN Chao (BCSC/EPA2, Smart Home) <chao.yan2@bosch.com>

Hello Yan Chao,

Can you please provide a description of the problem that this patch
solves? - I=E2=80=99m wondering if it is the same =E2=80=98invalid-key=E2=80=
=99 error that
users of the distro I help maintain (LibreELEC) have been reporting
for a couple of years. In our distro it shows when using connman and
iwd, but not with connman and wpa_supplicant. We have never managed
to pinpoint/find the root cause.

Christian

> ---
> plugins/wifi.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 12389fa..551a5fc 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -74,6 +74,7 @@
> #define P2P_LISTEN_PERIOD 500
> #define P2P_LISTEN_INTERVAL 2000
>=20
> +#define ASSOC_STATUS_AUTH_CHALLENGE_FAILED 15
> #define ASSOC_STATUS_AUTH_TIMEOUT 16
> #define ASSOC_STATUS_NO_CLIENT 17
> #define LOAD_SHAPING_MAX_RETRIES 3
> @@ -2505,7 +2506,8 @@ static bool =
handle_4way_handshake_failure(GSupplicantInterface *interface,
>=20
> if ((wifi->state !=3D G_SUPPLICANT_STATE_4WAY_HANDSHAKE) &&
> !((wifi->state =3D=3D G_SUPPLICANT_STATE_ASSOCIATING) &&
> - (wifi->assoc_code =3D=3D ASSOC_STATUS_AUTH_TIMEOUT)))
> + (wifi->assoc_code =3D=3D ASSOC_STATUS_AUTH_TIMEOUT ||=20
> +     wifi->assoc_code =3D=3D ASSOC_STATUS_AUTH_CHALLENGE_FAILED)))
> return false;
>=20
> if (wifi->connected)


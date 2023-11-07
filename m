Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA31FA6
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7R+1+ds"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so9354678a12.2
        for <connman@lists.linux.dev>; Tue, 07 Nov 2023 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699357614; x=1699962414; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Aq0+B6kyjIw3Ec6Np9whIMlVcwrwOlLz0HBYcqDntU=;
        b=i7R+1+ds75pUBzEKonoplX/aEhjBoyaXKWRsjDXcDrWZ2RP46DCeP7ZKUBKUtfHkfB
         6hqg8PcCNcFV3+QV6McDNpDBMHG6mqU3Odo9Cfhl/mqZ1yqkfNymMERP0f/YoM6jkW03
         m9fT/KS5nXbxuuPvacdFja1+QbtxakaNhn13sts+cbU5z+gojvXSJo0ere3fnURzZh+R
         w21UlYvhClAkGfUdGaCNgcJFdJYaPj/80JCBWHfmcCUBTbLeQW/orOc1xFM+q0cM8iEG
         M7ljSI6PpVopFuw9EFYzuEzqR4/snSd8/sgjX5LAGCO5MYCcMrY/NA32y9zL7DuvSudg
         PJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699357614; x=1699962414;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Aq0+B6kyjIw3Ec6Np9whIMlVcwrwOlLz0HBYcqDntU=;
        b=sQArffGOXCHSLUig9v+JH5wXPPoxTEAaYmYKsn5prVYkYCjlKHf3vjbv9ZtbtHTp8s
         I8iijJAp9A7Mqo37GrVD5hC/PJJ9+v0Hw/to65VzglHWuAXNQ88fLyxNOSa/dzN9jmWM
         FYiYFgEbT8Oi/V8DejAkdAXS9iGlRjg/8YeNC70glf6eKEKaB1TE7MxGmscBLT4Fb12s
         mlyRaJeN4VsB0w6BGoWihcVrfLY+nQlDH/dWVcodAMS8b4ccqyZLW12jWQP6QOHO7F3U
         Y+VcPtiVtveaQvjoUnh+qSwf2T0dUHw6X74HTGEk2k7KKwiw4zhB9jF+6kFCu1QJW/Jg
         ljnQ==
X-Gm-Message-State: AOJu0YynaejUgyRO1humX7dNvRk9fnyd2XT9t5Tn4SdQBE4UTvV5Z5H3
	Pf4qBF/IrIuiHA19+lfyUub412AoKco=
X-Google-Smtp-Source: AGHT+IFobSUNr9eq0TTS8X6X9zXznrLrh3bd5aPkJSAI7qaEd5gkFeCy4MgVFwdM4t3HgdIV1VRgOQ==
X-Received: by 2002:a50:cc8e:0:b0:542:e844:5c9b with SMTP id q14-20020a50cc8e000000b00542e8445c9bmr23864372edi.13.1699357614274;
        Tue, 07 Nov 2023 03:46:54 -0800 (PST)
Received: from [192.168.2.2] (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id n16-20020a509350000000b0054026e95beesm5463746eda.76.2023.11.07.03.46.53
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 03:46:53 -0800 (PST)
Message-ID: <676d2284-58f1-4ff1-b4b2-ddb102e847d0@gmail.com>
Date: Tue, 7 Nov 2023 12:46:53 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Don't add route for invalid dst and gateway address
 combinations
Content-Language: en-US
To: connman@lists.linux.dev
References: <20230828111846.2170668-1-zboszor@gmail.com>
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <20230828111846.2170668-1-zboszor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping.

2023. 08. 28. 13:18 keltezéssel, Zoltán Böszörményi írta:
> Don't add route for link-local or unspecified destination address
> coupled with unspecified gateway address.
>
> When the machine has multiple interfaces, it may occur that some
> of them don't have a DHCP server behind them, and there is no
> fixed address assigned to them either.
>
> Such interfaces get a link-local address assigned by Connman and
> routes are added to them with 0.0.0.0 gateway address on IPv4.
>
> Adding such routes breaks networking because these routes behave
> exactly like the default route but they take precedence over the
> default and are the equivalent of /dev/null for network packets.
>
> Observed with virtual veth* interfaces created by docker where
> only the bridge interface has a DHCP assigned address.
> ---
>   src/inet.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/src/inet.c b/src/inet.c
> index 4039a73c..3465d50c 100644
> --- a/src/inet.c
> +++ b/src/inet.c
> @@ -611,6 +611,16 @@ int connman_inet_add_network_route(int index, const char *host,
>   	addr.sin_addr.s_addr = inet_addr(host);
>   	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
>   
> +	/*
> +	 * Don't add a routes for link-local or unspecified
> +	 * destination address coupled with unspecified gateway.
> +	 */
> +	if ((!host || is_addr_ll(AF_INET, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET))
> +			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET))) {
> +		close(sk);
> +		return -EINVAL;
> +	}
> +
>   	memset(&addr, 0, sizeof(addr));
>   	addr.sin_family = AF_INET;
>   	if (gateway)
> @@ -745,6 +755,7 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
>   					const char *gateway,
>   					unsigned char prefix_len)
>   {
> +	struct sockaddr_in6 addr;
>   	struct in6_rtmsg rt;
>   	int sk, err = 0;
>   
> @@ -753,6 +764,19 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
>   	if (!host)
>   		return -EINVAL;
>   
> +	if (inet_pton(AF_INET6, host, &addr.sin6_addr) != 1) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Don't add a route for link-local or unspecified
> +	 * destination address coupled with unspecified gateway.
> +	 */
> +	if ((!host || is_addr_ll(AF_INET6, (struct sockaddr *)&addr) || __connman_inet_is_any_addr(host, AF_INET6))
> +			&& (!gateway || __connman_inet_is_any_addr(gateway, AF_INET6)))
> +		return -EINVAL;
> +
>   	memset(&rt, 0, sizeof(rt));
>   
>   	rt.rtmsg_dst_len = prefix_len;


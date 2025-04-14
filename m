Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA727587A
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645123; cv=none; b=Rtf2Th13893Fc/lUJpdYi84ytEq6YWaV8/anFU2xSqck/yLO7OdVhMAGtAxFrFZ9oRST1Cljb3h4QpEBZq5DMB0V/trIr1HrLDkbQBCWgp3auvLDoKSi7kbyYOTM0vGs2eCu/ladQglwwVcnBZfvblnoh06VlEOuQK2GBr8cAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645123; c=relaxed/simple;
	bh=zHmX6hRqFCeZFHbRUs/+/Qv6bl6Of1y+DEVrcQmluag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W/G/5/5qisfiYzfLKFF5YjrqVsTEV6NTuEgsoKAC8HmSJvawLe/+dfl6nqKq9A8BkyY/V/JhWyLm5DD5NZfrTHpSU0XzLbImUnjqDB6VS5P4GIVrlEXivSpux0vBo0GLGRws/CsKiBDYWD7f5m7GJtoGD5VYpkv6OnhSlfeU1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBOD+M3W; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBOD+M3W"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c769da02b0so3006215fac.3
        for <connman@lists.linux.dev>; Mon, 14 Apr 2025 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645120; x=1745249920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHK+mL7yrFdHha20wGvbkKrqZ8BvG/EJvRTJubH9Kr8=;
        b=EBOD+M3WqdfBhQ2NUKjQ9KmGDjSfkog3wsxtbbau3Uu0WtDBeQUibH624hi4iOLhAL
         wa8W6Yn1Tm9958y1QT7sQ0oRlJGmrfPrdZXOi8/ahW8egr7VEKcA2QT8gFWzTb2Aj91+
         g1SIpuEUp9kQ1uzeurLxLfSh64BMIzbHQaCP1txEa0fFL7NGEOma0th99fH2NAPO2E8u
         o6kN3+ZrTvMl7GGCuHwQFX5a/o1Yu4GsksX1N77+LZpxALbZMV0iwsv9zYA3jJ/76KKF
         JvGtUNE+DDqAa/LEBSzjqMDyYuJ1no+Ig6dEpwZlY+PaiNKZGUIQ9+iOoOreejnurwQg
         8+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645120; x=1745249920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHK+mL7yrFdHha20wGvbkKrqZ8BvG/EJvRTJubH9Kr8=;
        b=v0rdVCA4y9GBY8HfH12TvqqxGfZkrdAn5wUbpPNhZq9B7LesCBfJFZ8ZTotH4bFjDw
         Rn1AVstv6mGd7tU3xskdu3xbmqpnY3a/UlkFvd5LmurvTCWeXJQEWUzRDPrtXYbk6GWs
         uiYTeZMfSYenXdLCifXfABtDEWzjlxcebOwbkkmRg8J5W7yLQXwyCy0UJ0wOk4AC3Ue3
         1CKB0DTGw4E5ooHdXOiB6VBceCsbYmy3HKAo+xFPybMpxggO8FLRyA+i/O0NffBLLaef
         F+J+7q7sXI+qNDpriEkGdaqEl6a5cbDRSQqzNcMnhJnpLvUhIuGjHFpvu39SjsbBCOUh
         b2cg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ye+o7NLD0x2SMuel7HCR1gUgjJyxZaVTU1GLaB7uU4lHvR82JNW4zZYUYhgWS9vZZMKsTpHB@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Cz8YGkn9FByrlhs9UxHQgFehcfszh/HPp1U4IWGli2dVdgfS
	KINmRYJplVJuBdrhmYlnyIHZIE1PcTfcX7Ylno31EDHM/QKX5XunrZNlWw==
X-Gm-Gg: ASbGncs2P6MSn9dggTEPqeujPqeq+sWlIIWiMzaQqKXSTX+PNIk2sH/EJV/V6jSI4zY
	GbgszU96JYlBDjt10b//MJiy/MmHt2fAzEt7KO4LlEMM7bZHKfJQROMq6VrOu5eGTEpfdda64+C
	aW737QLuocuJQWo/gz94R/3aZ8YEyzCg2/Shd28JOeO3YOZkFPaLu+1k31t+n1PwXZsNWFUs9yr
	42Gwm2tkalzmoKaALcvNBl4GARH0YwP2n2Ib81R23/H1pf3SojKVjBuqntDd8192A49ut56U2Rw
	zFjqtdNvTpjFo9kK6tkRVwbVBkc0sQuwM2zdF6x4PsTCKekUsL1iuCuX5YbKJcgLDFSbPazx9FO
	E0NPxjw==
X-Google-Smtp-Source: AGHT+IFHjcaH9wgZpkYnb8rt0vca9T7sLOJ+cuICsxmnPk+au+ii9VeaWaErI8WI6Jvec4SratJ15Q==
X-Received: by 2002:a05:6871:a989:b0:2cc:3523:9ccb with SMTP id 586e51a60fabf-2d0d5f335bemr6818186fac.25.1744645119522;
        Mon, 14 Apr 2025 08:38:39 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2d096961127sm2369880fac.20.2025.04.14.08.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:38:39 -0700 (PDT)
Message-ID: <45488d9e-325b-425a-841b-599aef0a5a80@gmail.com>
Date: Mon, 14 Apr 2025 10:38:38 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] vpn: Fix mem leak on nameservers
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
 <20250410155846.252858-5-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250410155846.252858-5-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 4/10/25 10:58 AM, Jussi Laakkonen wrote:
> Fix Clang analyzer complaint about mem leak on nameservers.
> ---
>   plugins/vpn.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/vpn.c b/plugins/vpn.c
> index 9664c82f..9e6e26bf 100644
> --- a/plugins/vpn.c
> +++ b/plugins/vpn.c
> @@ -472,8 +472,10 @@ static int extract_nameservers(DBusMessageIter *array,
>   		DBG("[%d] %s", i, nameserver);
> 
>   		nameservers[i] = g_strdup(nameserver);
> -		if (!nameservers[i])
> +		if (!nameservers[i]) {

g_strdup() doesn't fail (it aborts).  So I'm not sure what this is trying to fix?

> +			g_strfreev(nameservers);
>   			return -ENOMEM;
> +		}
> 
>   		nameservers[++i] = NULL;
> 
> --
> 2.39.5
> 
> 

Regards,
-Denis

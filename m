Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3311713
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318278; cv=none; b=tEXeswp2DSk8Ibnctj2LSc6JDrFczF3nRnGWUJW5OdTnM81v+Xv0idCEB+Sy5rBiOhQA18PRyadRRV8w7+gdz/yXX2h7g62wRnQqcjHQtEZMpgICWOVWKI6yvLvxPRH9cww5xPjf07n0zWQzXUhAHaEHLvy+ew6YRh9E03GbaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318278; c=relaxed/simple;
	bh=fJFPvutF7LZr+KvaAgYKorLgo50ivYzktRVdAJu1nIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iuc1dYPa/XAUkGNcmisikxBUJvYLV9zTxWa0W0FuLBJ7PTnlAiyWhF/4yzjLotEPLOAORSV5JGia8jVf3W5GJT+Z/nEkavNm8qx7TbZGFbzGeZMi6d7wu99W0SW41moX45TGELDckDi24E2RjJqDEeLE5/Woi8nBd8vcwxuNkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKgG8kXp; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKgG8kXp"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-433f36eb840so531367b6e.3
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318276; x=1754923076; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkKB1sY/nnwzONS2uTpb9fY1xGsTQ+EvB3GK6X6Rmv4=;
        b=IKgG8kXpApYbcBdpUUnLnV0qACZDMmuM3ABCJI7WT7owRHs8rK6JV+aSG2O6v4yDRu
         ICSdMrqT5nmPvsnqplJwy5kY993Zr6pXmRvT/sW1Y91bTNHBjcDcqf+7MM7kjsYdMzGV
         PcpCfmCYKoI3ZhFhJIMXOOZnCAyxII1SmBXvCNZ3OPP/qFM0/mBuh1VRprCj+3EJqeJe
         A3okRqnehQiIa0D1y7NOcmZ0sPf8TZiXNFMLz6TN0kq3bFmbbEvrv1I8lFw+sb2mFFBH
         KypILBYLsEUMPuobRFwI0Vbqdg360erH4hYkBywGvqvAM/Xm7LbJObGRB39lmxbHMhax
         7J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318276; x=1754923076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkKB1sY/nnwzONS2uTpb9fY1xGsTQ+EvB3GK6X6Rmv4=;
        b=Vd2xoIT1yVcEvPvGM7OZghHnU95Bg2bfZovUEndkk43gL/O74SKX/OnaJdpL7rlVpw
         n8hHmjemqudfb+i0O7GpQMWs5qgSmGX/x9FaVqB5LUq8RIFB7TElOWJt+NKrocN3e8vp
         8kvv/CNwG+qldoO5qW6aW5nCei3wDRMXF7/E2HtjF8TCdKljO4wPVm0QN4Sir5T2EI8/
         17jlK8/Sn8Qyh5uJOtgXv2I2XTsx7SqgoujIZZOtFlz9rFknEQ4laeowhOumFyWREhAS
         o3wLTHux+CP7KOA4vx9Q0Mg/gjL8wN8JP3wKe59yCUVM0iO5FQzbI7OF6jyY6LN04WkR
         i6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcWbZCjnr7EqCC5ohx2rPtCYmWQzFQHk3K5Ny595EiQu+917UPa3vFlO4lm5Z83bthD/BbXfzw@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+29WNXQXIoUXAFLh0V6ge25EutJFYQHuIcJHgBVOkudWU5KGU
	LMS3jipg8DPsW50DRtsJmjTnCE4EaQe5tOKKEqzQz6MZasA84lwdHb1qLBKQnA==
X-Gm-Gg: ASbGnctZ1ijqhR56V4VEsk2gt4xR+bh7zhApO9QJwEkWo0iRbQS2J/xeV9IyBua48z9
	OnB1IvF7hJrM4JWrXIB3vWMwVeptnnxSNoxN5zQRVefRgT6KYuZ9gD7cv4phaCWwi/rc/rBKd2L
	WrKdu+rtPznuVh0O/fNgVEU8Aj2LAqQ6uC1JawzTV+y0gnK/rjk2cwniGDEr8ivT+hWa/5HgKjZ
	Ynrlm/3sQEDW8XRSF7JD+ALuknt7Ri6DN8t34r5qBDTI1ZA/2Obh2uY3XfkwWoSvLn+5WR/iRX3
	4Kjq03g+vHb1yK1RApY2LtGzYUPWKhVEbhaIs7wGmpbaobH2VgF5RCtVcuON8vEldxAOMJTWhv+
	fOzJH8hVkIGioi/FBEBwI5BkY+wuuCA0WMIx32/fN9bPg07PILQROnKDjxzgUsATGLLwQIibFbf
	dPctx5+4fBwQ==
X-Google-Smtp-Source: AGHT+IFeCaM3/tOSdkdYyuKgNYJCvHBXnXgNH7NBgc8OBnoMutG6Ozuu2nfjSKefN0+gqm74LvSF3w==
X-Received: by 2002:a05:6808:8817:b0:433:fa6d:9104 with SMTP id 5614622812f47-433fa6da581mr3245143b6e.24.1754318275648;
        Mon, 04 Aug 2025 07:37:55 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-433ffe7bb91sm932408b6e.2.2025.08.04.07.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:37:55 -0700 (PDT)
Message-ID: <98baf14c-069b-465f-9532-44f48b12e888@gmail.com>
Date: Mon, 4 Aug 2025 09:37:54 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/45] gresolv: Add generic error for GResolv struct with
 getter
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-17-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-17-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:27 AM, Jussi Laakkonen wrote:
> Add a error for the struct to be used with hostname lookup. The function
> should return either 0 in case of error or the source id, this fixes the
> wrong returns when error happens and makes it possible to retrieve the
> error afterwards.
> ---
>   gweb/gresolv.c | 15 +++++++++++++--
>   gweb/gresolv.h |  2 ++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
> index 8101d718..1f1db474 100644
> --- a/gweb/gresolv.c
> +++ b/gweb/gresolv.c
> @@ -116,6 +116,7 @@ struct _GResolv {
>   
>   	GResolvDebugFunc debug_func;
>   	gpointer debug_data;
> +	int err;

These errors are really local to g_resolv_lookup_hostname, so not sure this 
warrants a member.

>   };
>   
>   #define debug(resolv, format, arg...)				\
> @@ -1060,7 +1061,8 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
>   	if (resolv->result_family != AF_INET6) {
>   		if (add_query(lookup, hostname, ns_t_a)) {
>   			g_free(lookup);
> -			return -EIO;
> +			resolv->err = -EIO;
> +			return 0;

Since this is a glib library, have you considered returning 0 and setting GError 
in/out parameter instead?

>   		}
>   	}
>   

Regards,
-Denis

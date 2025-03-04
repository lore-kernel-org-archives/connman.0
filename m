Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2F255255
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108341; cv=none; b=baPzAq8YCnhyzEwS1IcR/KhAMY8okVJlSI1ktai74hJKfaDmor6ruyxM7w/wK4hBoNTorQKx2lXmVVaKfKz71Rn63N7QV82fc4T1P9E8NMtsT7nJydG+thte2wzDJrcOZ6E4vdzSNpqQbf/255feiKqvXClldAHinQ+AzvgpIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108341; c=relaxed/simple;
	bh=4TgBEql6L+cIWeQm3j/N+rctFpGpg+QvjhbJnMyQVYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LcRsgC/eqtbKQh/EnbalGqTJOJXEPkX+MPv4Mds76+wQ+e8nkc3yakjBjTA8JMSWIfaju5U8KtJpgn6Oxb2lsenRmK105p79AgRugT5aG0SlLhGCcRLwEu1zvJZYw+QyxGqE87ciUth6sreo7r3FrPMMQ4SjVvv2iy4L6ZrmMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkRtVSl8; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkRtVSl8"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so5138037fac.1
        for <connman@lists.linux.dev>; Tue, 04 Mar 2025 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108339; x=1741713139; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOtl4BxM2MPRaR9jxojeN73MYDu8Ck7MEIwq2C11P/8=;
        b=QkRtVSl8uJd5T/WDlt3QNjPbYj38mqwbEJXdZ6qVmCCpE5rbBSTsTk7+cAQu5fG3Pf
         evKOUo4YFUqqM+0ty15W7NdcXo2PvmQSx7pb/SAjFCTULtwUsv6wN2EhTgH8zCUDclSc
         g/oD8OQGvOqd7Tv1idHj7TTCRdMAqEIvuucwOJhrE6SGlqQB47VYvdfpmNL5IyMBEDpC
         JZ0IymeNB+5fScWQx6JPgV7VpmzwE6Lf7n4b0sIty8V9+8YuxVZD+k/33ep67Gqz4TXu
         3a3r9beQGSx6Y0MvJKbd/hZg7GrKwcHk/MsMUe2/PzyBC7CW82f4klEkgkoKBX9vuLag
         YNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108339; x=1741713139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOtl4BxM2MPRaR9jxojeN73MYDu8Ck7MEIwq2C11P/8=;
        b=HI+P0LKKujTH3MpishFOT4yDgbaOMmZaia/bFNSBFrXI+ddE7OCuOr2573iTehze7x
         zQj8iuYmoTJFFVP1QWCwlc28t6690s0eyXBTRI2ZE0lPtOhx8tq2nF02ARFRBgfT64iS
         /vSf8irJBlRMZ7E1r2bbiEUHnbK6Jvf2jripfRQ8Kg4t2PR74qZV5L0Wa+aPaNWGvI3A
         TV034lCzt9sxWqDaUDvnSiNftc2lJQwdKujsEVsvglMdLV/ikhptwWLhg66sol5hQ676
         vWUP9bLlU124ssEFnh1tN3ve9F/JVKpcSy22odH1KdMTsdl7+3hJESWZmzCDfGlDFwhJ
         K5XA==
X-Forwarded-Encrypted: i=1; AJvYcCWrSDLyu6t51zA6jCEDjPtsij4L1Zhwe3MwPWF4dPjW51eM88MLp87HsqshImwpo6t7sm0Q48Ms@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3cFAIRjI4M0ktBedv7sgvbm+vmWj2yMrl7GhY5TgPvZBXNfrL
	D9Mr2LmXzgH9C/5lKCF7ausJdP6/sz5Kc1we7KJIQU41ZhJf5oPtath4zg==
X-Gm-Gg: ASbGncs6pzhkx7YzEjqhyYJ9oerfV1vs/e9SAoO3gyBVI/M0grDMR3p7GPWXfV+WOa4
	t3VL71GshdyZyMyGDHcYwqtpL0qQZGTS4JVd2daKCSbowW5+4OCBpfYIs1rcn4mQRIANLG5CC1L
	maJbkMTarHI1i+w443TpxRVzC0ilRJUWt5yOX+QJS1W07oMAuUKl1VAsN46e1lcMig3oVybwk2j
	yDwWMwZCXdvpdZ2AZHizYDRxLsc+FhBQ5kyO9yMn3954fMIueOmIsWGUqH5hU+6T988hI/DaSrt
	WzOmyrNVxYudbLlfymKSSXAKD3v3mxsDRphO3drv8iw7kCMvjwv9fla4RnUcX3JVBDch4XT4pBP
	LahgnDVXlNQ==
X-Google-Smtp-Source: AGHT+IH5Q5d3KFd859liWXbKrnIrHIbqYP4fFwbOKY8hdDq9N/niRrmy+kfuCWLIwj3/KFz+h99b9g==
X-Received: by 2002:a05:6870:fba2:b0:2c1:5fcd:acc5 with SMTP id 586e51a60fabf-2c178365ee1mr11551261fac.10.1741108338566;
        Tue, 04 Mar 2025 09:12:18 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c1c581833esm983888fac.5.2025.03.04.09.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:12:18 -0800 (PST)
Message-ID: <86712602-45e0-420e-80ce-cfb904702448@gmail.com>
Date: Tue, 4 Mar 2025 11:12:16 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] service: Leverage 'service_set_proxy_method'.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-10-gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250221155653.760046-10-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/21/25 9:56 AM, Grant Erickson wrote:
> Leverage 'service_set_proxy_method' for
> '__connman_service_set_proxy_autoconfig', the second of two call
> sites.
> ---
>   src/service.c | 49 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 5c94c2962de8..d2d8e7cea065 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -5662,32 +5662,47 @@ const char *connman_service_get_proxy_url(const struct connman_service *service)
>   	return service->pac;
>   }
>   
> -void __connman_service_set_proxy_autoconfig(struct connman_service *service,
> -							const char *url)
> +static bool service_set_proxy_method_auto_handler(
> +				struct connman_service *service,
> +				enum connman_service_proxy_method method,
> +				const void *context)
>   {
> -	const bool dochanged = true;
> -
> -	if (!service || service->hidden)
> -		return;
> -
> -	service_set_pac(service, url, !dochanged);
> -
> -	service->proxy = CONNMAN_SERVICE_PROXY_METHOD_AUTO;
> +	const char * const url = context;
>   
>   	if (service->ipconfig_ipv4) {
>   		if (__connman_ipconfig_set_proxy_autoconfig(
> -			    service->ipconfig_ipv4, url) < 0)
> -			return;
> +				service->ipconfig_ipv4, url) < 0)
> +			return false;
>   	} else if (service->ipconfig_ipv6) {
>   		if (__connman_ipconfig_set_proxy_autoconfig(
> -			    service->ipconfig_ipv6, url) < 0)
> -			return;
> +				service->ipconfig_ipv6, url) < 0)
> +			return false;
>   	} else
> -		return;
> +		return false;
>   
> -	proxy_changed(service);
> +	return true;
> +}
> +
> +void __connman_service_set_proxy_autoconfig(struct connman_service *service,
> +							const char *url)
> +{
> +	const bool dochanged = true;
> +	const bool donotifier = true;
> +	const void *context = url;

Why are these needed?

>   
> -	__connman_notifier_proxy_changed(service);
> +	DBG("service %p (%s) url %p (%s)",
> +		service,
> +		connman_service_get_identifier(service),
> +		url,
> +		url ? url : "<null>");
> +
> +	service_set_pac(service, url, !dochanged);
> +
> +	service_set_proxy_method(service,
> +		CONNMAN_SERVICE_PROXY_METHOD_AUTO,
> +		donotifier,
> +		service_set_proxy_method_auto_handler,
> +		context);

Conversion from any pointer type to void * is automatic in C; using 'url' would 
be just fine here?

>   }
>   
>   const char *connman_service_get_proxy_autoconfig(struct connman_service *service)

Regards,
-Denis

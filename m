Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B3C2C9
	for <connman@lists.linux.dev>; Fri,  1 Aug 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076854; cv=none; b=TqBCqWA0yFgNJsDD+EnK5fVSlqqMJ29A/NbeHq7924+z94W96vyFXvpb4+DYh1EhNpmsIB2Wobt2tGbE1E/oi6y7RN1sCSuMyi3hwXQVeezLxIXMyCV7fw5KmavShNU2jaLLyKEpVXwXlT9ODl57ePMGi1qWHqfizg5eWQ8OY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076854; c=relaxed/simple;
	bh=2kazlXonTPwktERdiKfFGsiTsA3sPnEfRNoM7fPecPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ICpPcSlWluJCOtEPqr40vdWv5mECQ/QhQHysFgqmmYw+amLbbjuyFGQgClS+RZzldsp3BOGz3RwyDTpPsJL6WGTLmF7LLbqB/X9PQsVFb99W31+pHz3obXbllDkjVRz0sPYEWw1hBq8hJz2JEJ78YXIf1PA/Si75e9b70Jvsers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+3c+ztY; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+3c+ztY"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ff9b45aec2so1270422fac.2
        for <connman@lists.linux.dev>; Fri, 01 Aug 2025 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754076852; x=1754681652; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3fY67XDGRpH2Uo3fbR7YHG2crELmM0Y4sVNc3XBwLc=;
        b=Y+3c+ztYGKlHKdZSYDueO2eqKf8d9hhgowoMcdMjPzMypcqu8bRJPRRjIJX3sfy1JH
         dDTLufn82EIlqxuy5yGX1fiDUc2+xT1Wqnm1e8/I0WEGJ+8FY2Es1m2K78cAYoci8GBE
         aI8h47kjjZ+lH6xGp5bQW7JEbSW1V86Hr4fdnfvVfiUSfkENedKOX57D4RgmS2V3Rhov
         Knko3Iwsnh8JxaAbIyYlz+BOnSR8rh2lA9MHgwlttBy0z6AjgCJ//LUaVPDIqe/jxwt8
         D+kxSGdroMHYqSfUOTdkSVSmbUND1lJ8ZQSadJAEi7tWd+oN+7blv1oRkl0730vGHqWL
         Bw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076852; x=1754681652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3fY67XDGRpH2Uo3fbR7YHG2crELmM0Y4sVNc3XBwLc=;
        b=xPR1zHbN88FP/glwsGEQctcVtYqVktbFM5Yr/Ry6DG1DogzQAw56ykojqCML7vxf/9
         NWXwW+TWSUr/93tUP7FaykEU4RLBHvEAKFsN3vJgFUw7jYoi4ISbBZY8uxXzkcIpCEBx
         MoM9zXeoBwohd8ced/aczFSmiTFHo7vPXXgdU0KMETuuiWJH1Yeosmuoix+MPiCOYg1V
         P7mSdT9UuDS1gPiYHLQqJ4uC0oH1wEFuZ0lRWba4AGocrMmvwce78XELgPnUb6xWacrI
         2ktOZY3ADBTh+MYmtouWclImiX8wBrEsPRAqLecSlulNpOIfxKnis1ZQYSySiRvelqtu
         5f9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDKhVgYY4AUxockBcSwVk7gNL0GPKkJ4l/BIiz+bIqBGHlS/8WqsQx+EE5HjPbniEmzjZQ+8gZ@lists.linux.dev
X-Gm-Message-State: AOJu0YwkiDAcZgVgPT3YH8TwKYYHr86NppR9UZOtpnm7/VCefxXPTEpB
	Wo/ZFPnh1OYrpv3PvRXIbwUZ4e70GDWJG4Ik4UqYRoyDW5dypOCiEK7k
X-Gm-Gg: ASbGncurvJUml/F4wyP2ZWzLB9Fs7f7v9p1ZYi4h2DMLg3ezbDhj8+GAjJTzFOwvNMJ
	H580QXNZKRirn3QQwyZO/6QV/+9NVkG2luY4ZrV7JuiRog5T5qLClB3QzLrfQOZCbSmx3Fb/6Tq
	Ook9BMg6jPPI2s1BPRQEcWI6tYPZQO/U5FR8Pfh+nQO5W+afRXdX/uyiDJgUU1U63pDEF9CyO3w
	rjmiv8e/ggyEqpRzn7T8N72mi9evZHX4RL7Ps24aefoj8KRb05CqkTtGeOJlG9G1Dd1WjJzhqTj
	eVYmbPqmeB/kPnyzfS0uWukDbN6vP0UEti2x7VWWGnXqoEO1Xy9je0/vVRRMNDC90IBWKzQGHis
	VKcXUww0mpldCy9HVJ16WMf85oxaWTFnVX/95tF1PxQhXejrJjrPdy4574Kf80OhUTrWc3yMaYu
	phFfX5MpuohQ==
X-Google-Smtp-Source: AGHT+IFZoEgsmhZ+5dAwtV3F3VopvidNWf/C1ysTaNefEiV2D1mdlakPh6wVi+543fCxaA3iq9lSbA==
X-Received: by 2002:a05:6870:3516:b0:2e9:9e9:d94b with SMTP id 586e51a60fabf-30b67cbad99mr540017fac.39.1754076851826;
        Fri, 01 Aug 2025 12:34:11 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-307a71236b3sm1081122fac.4.2025.08.01.12.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 12:34:11 -0700 (PDT)
Message-ID: <e82d52a3-aa88-46c0-af63-53aacb565772@gmail.com>
Date: Fri, 1 Aug 2025 14:34:10 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/45] provider: Handle VPN configuration and association
 states
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-7-jussi.laakkonen@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250711142736.1757060-7-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

On 7/11/25 9:26 AM, Jussi Laakkonen wrote:
> Set the association state when VPN is waiting for user input as an
> initial state after connecting the provider. Set the configuration
> state (as it is declaced to be the string to connect state in VPN)
> accordingly as well. Start VPN connect timeout in configuration
> state with restart option to ensure that the timeout begins from the
> last known configuration (connect) state.
> ---
>   include/provider.h |  9 +++++----
>   src/provider.c     | 22 +++++++++++++++++++++-
>   2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/include/provider.h b/include/provider.h
> index 3f2e36ad..aac47527 100644
> --- a/include/provider.h
> +++ b/include/provider.h
> @@ -44,10 +44,11 @@ enum connman_provider_type {
>   enum connman_provider_state {
>   	CONNMAN_PROVIDER_STATE_UNKNOWN       = 0,
>   	CONNMAN_PROVIDER_STATE_IDLE          = 1,
> -	CONNMAN_PROVIDER_STATE_CONNECT       = 2,
> -	CONNMAN_PROVIDER_STATE_READY         = 3,
> -	CONNMAN_PROVIDER_STATE_DISCONNECT    = 4,
> -	CONNMAN_PROVIDER_STATE_FAILURE       = 5,
> +	CONNMAN_PROVIDER_STATE_ASSOCIATION   = 2,
> +	CONNMAN_PROVIDER_STATE_CONNECT       = 3,
> +	CONNMAN_PROVIDER_STATE_READY         = 4,
> +	CONNMAN_PROVIDER_STATE_DISCONNECT    = 5,
> +	CONNMAN_PROVIDER_STATE_FAILURE       = 6,
>   };
>   
>   enum connman_provider_error {
> diff --git a/src/provider.c b/src/provider.c
> index 1f0ce10d..ab4aeafb 100644
> --- a/src/provider.c
> +++ b/src/provider.c
> @@ -126,6 +126,22 @@ static int provider_indicate_state(struct connman_provider *provider,
>   {
>   	DBG("state %d", state);
>   
> +	switch (state) {
> +	case CONNMAN_SERVICE_STATE_UNKNOWN:
> +	case CONNMAN_SERVICE_STATE_IDLE:
> +	case CONNMAN_SERVICE_STATE_ASSOCIATION:
> +		break;
> +	case CONNMAN_SERVICE_STATE_CONFIGURATION:
> +		__connman_service_start_connect_timeout(provider->vpn_service,
> +								true);

Possibly handle this inside service.c?

> +		break;
> +	case CONNMAN_SERVICE_STATE_READY:
> +	case CONNMAN_SERVICE_STATE_ONLINE:
> +	case CONNMAN_SERVICE_STATE_DISCONNECT:
> +	case CONNMAN_SERVICE_STATE_FAILURE:
> +		break;
> +	}
> +
>   	__connman_service_ipconfig_indicate_state(provider->vpn_service, state,
>   					CONNMAN_IPCONFIG_TYPE_IPV4);
>   

Regards,
-Denis

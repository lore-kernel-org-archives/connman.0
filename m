Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C721D3D4
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332067; cv=none; b=uTjGI+ZBV/vlowUrkeYh+izEPBFzPft6wpiixNTMjUXdwpm/NSXuYFK/Vz+MI+wpsvY62z4+WBNT1JK0HJ9upLPzMLTCLSxwkGSiSiGGF0cKHzC9FTbWmR44ydS/B+yDpCUDns8cLmTfA4zNqb22ufeonfEQKkz2oJxhgk7zIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332067; c=relaxed/simple;
	bh=siFzLIQFUUHUGyaicDhrOumMFC4dd7M/T5aO4BMJNQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oJeJDZpRiCOS0u26QRsW8JwXq18Gbl3qQ8RG3tzvaecWllF0ISleGo07bwnxkKCWgOm/Ndk9wzYHOvkv3CpUBMwmeLVNM8vLb6LiUrZuzTWdKMH/MIc4cz6DtLvyDXQrZ0PuEsl2AeIry1n6u4gWicrNMfK8c9iinvBw6sz6I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8yd4DA7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8yd4DA7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4338d05972cso679520b6e.1
        for <connman@lists.linux.dev>; Mon, 04 Aug 2025 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754332065; x=1754936865; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNbGZe2oLmIQ0qKEbpIIPoR08VdVwUtc5yCbIDzS52U=;
        b=G8yd4DA7d6+FW12lLPDPcTU2z5jwlcIP0nXZ4g14mP9Q1infeCrUpkJOmpjKI/ysSO
         YHXIBwYUeCKUjaGSquqCFwMa1d+fRIKTUKRo9k3rke+xH3Zqn15qP2CSwAtvXuOplpJJ
         FQuwES6PA/enOP3ic+4yObMim30NWDdtbEQYhiwdPTioDraVv2vQHe8EpSSdudoHzn0E
         zGAGxpcpL+EFIUORjcdVjiRMp1A7WXz4pjrHhRB8K91JCOmHXzGeXeyALTl09mJpFgKp
         6QTw6omz7p1ylweLsMDquHQSzjmITXbjNzEL5SDUETafFs25RgaaUugyqG94guqUWg5e
         m1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754332065; x=1754936865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNbGZe2oLmIQ0qKEbpIIPoR08VdVwUtc5yCbIDzS52U=;
        b=X6cLgo4um5snF8ZVREbGx31T+YddUJLbbBblEPTPh35hIXOXA8RvYxLUx5XHrVN2L1
         gnPyoAIqpnYSoWlVII9g08PHTdLHoBGXUM/pqEG+tzW4QP5NtRr68qD1FIDOBYqEUuNZ
         HdcvahNoSCSTEn/AWTctcOvbuPL0GNYmCMPm0+a2lWPji3Y4fYzPJFNeG/Trm3UoPxU/
         jF71TuUfFKQyIoSXAL4zVG/mveRxr1V77A18y2eSXdZkdjlJyQBDXy2il69pOmdWxMLi
         wvHXZxOKXAidjt9xqqnFPtIqr0Z5VHhIMSoyXWEfg9OEUk4xvDwDiD9mZvDka3gTTdNS
         Wg5g==
X-Forwarded-Encrypted: i=1; AJvYcCUKbKQ+1xvweqmvwLQ27+0ZMBYIBrS31ZwkaaTKPE14hUbxLczW41xrFYHnz32BNjoxIpa0G+YW@lists.linux.dev
X-Gm-Message-State: AOJu0YzncZ4xsOfTKqs3e9DaWaIMD/UJy5eySpEIssURKjhUrbD8Y4jj
	CzyipLtVQpJM2kPddqPFznvW3jn5EQ+xjL40n7AgcyprBJI5px/pn/wh
X-Gm-Gg: ASbGnctkgJW1NTU1geVQD7DdS+o940eejZZGeVVMukyCx8uKKvoWYAKm/CY4cC7DChV
	VpSCKcxP1F7g0Blyw17rEzBpQUJQBVlV+OxaV0eXZGg8W/B7iu++9vIEPL4ZN3h98Wrc25/e2o7
	rQ0rxBXxlh3EqKN0zsLFZge311tvQMm5KD7MeiTA8X/oBkMEkG/zvS7ZicjRBSjh4WuSbk4Y3Mz
	ow+ahX6bcep9Nnm7FLpyGo72a6rcK4FTi07lQHPjD6pA6RWFpfC/pMq472qDdxRVg5geNd8aYlG
	O7/mxg9bLFKnNA6qxIGmsJgTWpgx38drH46sp7C/uQ9Tt1ozE90OwFX1hTOUcWkFx50GsM6OWyJ
	WERhgA0Kv7chWD5D6Gw4k01F6+sb4E2rwEKjBBuGP4hRnlfV7rMwzeN1weLMTrVynfxKM7zfg5h
	I=
X-Google-Smtp-Source: AGHT+IEKThbTP/7oYkkV+qOlFJ/ALlPVuq3MZcxGTvDOZxZJIQ1zznY+03RSruw6lw3yd1YQ4auTog==
X-Received: by 2002:a05:6808:508e:b0:433:ed9b:fcfd with SMTP id 5614622812f47-433f0336901mr6350025b6e.19.1754332064919;
        Mon, 04 Aug 2025 11:27:44 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-43358d8687asm2252838b6e.26.2025.08.04.11.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:27:44 -0700 (PDT)
Message-ID: <34d2345c-58a0-4e1c-9943-549863b7b060@gmail.com>
Date: Mon, 4 Aug 2025 13:27:43 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] technology: Leverage 'DefaultEnabledTechnologies'
 setting.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20250728223217.3991877-1-gerickson@nuovations.com>
 <20250728223217.3991877-3-gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250728223217.3991877-3-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 7/28/25 5:32 PM, Grant Erickson wrote:
> This leverages the new 'DefaultEnabledTechnologies' configuration
> setting.
> ---
>   src/technology.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 

<snip>

> @@ -429,19 +429,27 @@ static void technology_load(struct connman_technology *technology)
>   	GKeyFile *keyfile;
>   	gchar *identifier;
>   	GError *error = NULL;
> -	bool enable, need_saving = false;
> +	bool enable, need_saving = false, enable_persistent = false;
>   	char *enc;
> +	int i;
> +	unsigned int *enabled_types;
>   
>   	DBG("technology %p", technology);
>   
> +	/* Determine which technology types are enabled by default */
> +
> +	enabled_types = connman_setting_get_uint_list("DefaultEnabledTechnologies");

I amended this patch slightly to avoid > 80 character line.  I moved this 
initializer to the variable declaration block.

Perhaps instead of duplicating these strings everywhere, the CONF_* defines 
should move somewhere as public API?

> +	for (i = 0; enabled_types && enabled_types[i] != 0; i++) {
> +		if (technology->type == enabled_types[i]) {
> +			enable_persistent = true;
> +			break;
> +		}
> +	}
> +

Regards,
-Denis

Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609AF28E1D
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0epGvgf"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7f2c72846so86653839f.2
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703269389; x=1703874189; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgFhxk+WeDeO25l8MgxEUetKhGgHBv72MeS8xUULMrY=;
        b=K0epGvgfk+W0UJegO9GcxjeBGchvE3zNK7Sji/IX4KyioUWoxdxkZr1bjPCd7YhKWX
         r8pma5j8sRDu6+mNBQebqIZw17N6hxlri6O/AMII9Ffo0Q+xVp+bFvVsW49xodF2GcjT
         /lY55VD523v1enEGzZ7E854XwtrOkep3wDVK47cRwf7zzP43YlZA3g50PjyKidB55Bzc
         yh3AruIb/8I7yYWbpksOdU27FLtXABFZdhXiT2u/IDEZTwly0cI4IVhmwSTiHbm6I5fx
         8Yse6MPafUsrMnDxvqGkA/VPvogdOKASDbnltUaz6vW/opnS/L/nIJtV+no3yzq50jt1
         3Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703269389; x=1703874189;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgFhxk+WeDeO25l8MgxEUetKhGgHBv72MeS8xUULMrY=;
        b=pjb+/PKeqRuCycyGRta4LYaog3gBqVbkjqm9juF8o7mLXTkXCnVFIcfQnvv92xyer4
         aBCidZKYyG4TDEA9K0qU+49PDary5yECjUMnk4Lxj1w5JcUbdJqWwe66mDmo4L4OJDPP
         2rkYLD+fARY8pwTHuk3mrpzfqSrjJF90BueB+vLyGzQbujMy6zlkDJvukyzBU+IwPoMp
         H1gMSIlTeLlAtTWytNuT/ym7bS2+zim/V7swDSl7hRXh2ezIEWxFfhQu4BUXQY7KZUEl
         Gm5zvK9MurijsoK44RjKghF6yfBtfJzfUTgyvI+7NiXYff9H7PQ5pK7MShjFixSWyqzf
         /zIg==
X-Gm-Message-State: AOJu0YxXTnV+KedVcuCEoXkle+mSWhq121pA3y6C8Eh1FSXdYOIOqxs5
	5MC8wF4wAjnpAd7TsouJ12Wdg5WWM/M=
X-Google-Smtp-Source: AGHT+IGE+Q7+nQ1zgpP9QQWSCRJJToc+X+fkydVsMxD1SjapOIR/8PEXag3aZs7NUPIidUvQ+uKoFQ==
X-Received: by 2002:a05:6e02:1a8b:b0:35f:89f1:a871 with SMTP id k11-20020a056e021a8b00b0035f89f1a871mr2403096ilv.38.1703269389535;
        Fri, 22 Dec 2023 10:23:09 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056e021b0700b0035fce97d25bsm1252222ilv.71.2023.12.22.10.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 10:23:09 -0800 (PST)
Message-ID: <22f2e328-ee23-4086-bc78-d2ce6c52303c@gmail.com>
Date: Fri, 22 Dec 2023 12:23:08 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] service: Make log output of
 'online_check_is_enabled_check' consistent.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <20231221073307.2361429-1-gerickson@nuovations.com>
 <20231221073307.2361429-2-gerickson@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231221073307.2361429-2-gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

> @@ -2195,9 +2195,17 @@ static void cancel_online_check(struct connman_service *service,
>   static bool online_check_is_enabled_check(
>   		const struct connman_service *service)
>   {
> +	g_autofree char *interface = NULL;
> +
>   	if (!__connman_service_is_online_check_enabled()) {
> -		connman_info("Online check disabled. "
> -			"Default service remains in READY state.");
> +		interface = connman_service_get_interface(service);
> +
> +		connman_info("Online check disabled; "
> +			"interface %s [ %s ] remains in %s state.",
> +			interface,
> +			__connman_service_type2string(service->type),
> +			state2string(CONNMAN_SERVICE_STATE_READY));
> +

Does it make sense to add a specific method for such informational prints that 
will enforce the desired formatting pattern instead of relying on human 
intervention?

Regards,
-Denis

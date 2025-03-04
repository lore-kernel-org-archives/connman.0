Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239701F5826
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117919; cv=none; b=Hv5DjUWyeMyub2PyjhFQIJ7LtYhZZyMa2Cq562EAgGBkSuyxjBTZTZ2GXrMqok6nl0MtE/boUFU8pFkLMwO1tS2ZEAsdkHdWWW3m8FQlA5ALsS2PWQ1z2ajZ4sXGjXspqgVHUvJFpIKsFOy97spUQ28cPzhUL5x6T6lWa1CuHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117919; c=relaxed/simple;
	bh=QnQoRtBMGRCks59mi4UbfyOQpSHzFKfIpVjgT9e0Vjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqny5GSmJF3RW8DhRQrUqq0Ue0++yY684MVME41KyfyRqVR/EokMT8hU/j2jBH2VxGhGN5Vg1XBaDFjTTQhfKegGvp5CXrOpz2MOT1fNfEMSx+G8cEDZPy79fF/535VAZNFeSzRzYjc5xYTOKpXnM7M4dwJtAapvm9oSsLU6Wj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeTKzz+R; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeTKzz+R"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7272cc739f7so69729a34.1
        for <connman@lists.linux.dev>; Tue, 04 Mar 2025 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117917; x=1741722717; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYr+YBm73xQ8R1ST1sJMFnRufpoxaNGxlnC10uDrBwA=;
        b=PeTKzz+RB+Mxbhks4I0dCNkgEN9zTQePc1dfXLtmq3J8zkZFjNxvRE5veZZEuZLTqM
         UXcd9s8dWu4E8Y1GxUzfYi/zOFWHAsCn1VY2DJQB8qk1a4a+6BQA9DDIJH4m0qVfc92j
         041zl70/w3oRETpJS8c+oNJe7g9T6AYENvcpMZN00glC0E2x1tEJDZgwfoN7tjItJSxJ
         VM97jO6V30KXeEmzVsqbRY6uqIjXJ5EA3amPywWaPcTna230qjGJadi/zxuvtQN7r/kp
         kdihT5KeiTmk2qx6zWC0G+xPsMuG8YdCRanzD8fZxAtXcdh5IsFydFoPp1dUmTchZODT
         3GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117917; x=1741722717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYr+YBm73xQ8R1ST1sJMFnRufpoxaNGxlnC10uDrBwA=;
        b=BVBoiWXsU3q0WIUyo4twGSv0n2yl2nraP/QFQzyF/zF2NgKVz9TTOg9rbEPn2CiUBl
         Ln1DelfZ/Zu9m8lv/hSIDb8n3Og1QsU0N/lqPB90bSykp8PgzfoWxaIPZj0y9l0qTS8R
         kLnMpyD6WRCkCErzG4F0O7octsgm+ziZFcCBagBYYhYl6dEY6BjxytOyxy1nBvaIJa30
         WOLl5C1Z+VDVmDluddX+qzM9ew7ULRGH0Bxi9C/zolHwV7GWg/iT67Fv9uy+qouhMoC4
         0VpEIOsaiM6zvZXj+WpEy4KtQa+2WXWlBSQhXxMH7ZNoNTA6zq+uWXXo+VsFOg3aa0Q7
         xYPg==
X-Gm-Message-State: AOJu0YyDNn41S96t6FOfCCnpf52rZSQE/TBAr18//s6VrJnGMfXcRGos
	SkY3yGmmQlEEeJ8aP2s6Wls7F/FGi5++KqE23uxTrVDLb0k0idEI5M5Kdg==
X-Gm-Gg: ASbGncvDTJYpxlSrUtJhofiDJIIZpkZK2kmsjdQmiTV/oDjddHIf/jrczg3FWZ0xZh3
	yvMWfuwJgLkxyMZ6pXh/GKj5AMBMP0d5enPgpKLvq+J9patRN3u2lzJob82dOpJBoLl5qZm3WjM
	a1eXW1nGzHWRimYEMwhSR19ODQdXQwoblTGalt49dEUtKfgn6bb7G69opR5UbE9lJip1dOG3bWB
	3/SuqnU8ptEDn/+QPryAGRtdtwJ21P5l3uPqXsctDVikX+mpKoeNkpnu5gxVfu14AHMYAzumEuk
	mvvBVgLsjbNs8gQw6lQFJx2utCOJGkFe9aMLCQNnosu1wJqcKyNGuRUV8Sxq/CbuV/nwdNECJnR
	6kyTOHpMorg==
X-Google-Smtp-Source: AGHT+IH2ATpcsCqHV1NCgRTGM3oKRINhP11y+HpYiyBRsWt61deOrXleGNwcr0UdKbS+lQD2qd/nag==
X-Received: by 2002:a54:4e81:0:b0:3f4:11b3:206b with SMTP id 5614622812f47-3f678f93043mr2244986b6e.17.1741117916914;
        Tue, 04 Mar 2025 11:51:56 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f5506a0b92sm2319720b6e.6.2025.03.04.11.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:51:56 -0800 (PST)
Message-ID: <1cc9904d-74a1-410e-a184-48eea13c0ccc@gmail.com>
Date: Tue, 4 Mar 2025 13:51:55 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] service: Leverage 'service_set_pac' function.
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-4-gerickson@nuovations.com>
 <f11d323b-a1f6-41c2-af92-bc08ee08ec49@gmail.com>
 <683EB080-8A98-4446-875C-1EE92845AA30@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <683EB080-8A98-4446-875C-1EE92845AA30@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

<snip>

 >>> @@ -770,8 +770,7 @@ static int service_load(struct connman_service *service)
>>>    str = g_key_file_get_string(keyfile,
>>>    service->identifier, "Proxy.URL", NULL);
>>>    if (str) {
>>> - g_free(service->pac);
>>> - service->pac = str;
>>> + service_set_pac(service, str, false);
>>
>> Does this leak str?
> 
> I do not believe so, no. service_set_pac now handles the same:
> 
>      g_free(service->pac);
> 
>      if (pac && strlen(pac) > 0)
>          service->pac = g_strstrip(g_strdup(pac));
>      else
>          service->pac = NULL;
> 
> except now instead of being individually duplicated and scattered around to several call sites, it is all handled in one with service_set_pac.

service_set_pac receives a const char *.  But g_key_file_get_string() returns a 
newly allocated char *, which is assigned to 'str'.  What frees it?

[1] 
https://www.manpagez.com/html/glib/glib-2.42.0/glib-Key-value-file-parser.php#g-key-file-get-string

Regards,
-Denis

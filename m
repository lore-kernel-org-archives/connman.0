Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CE280305
	for <connman@lists.linux.dev>; Fri,  8 Aug 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669320; cv=none; b=j3lFi9Fef65UeIegYxypmNj4UBeEBCEefT3Pr0iZFqT9o+D4/H68bDd56M/W1x67ufPzuKyAmo3xIwDtnwsfYYuiU7fl15FhA67Xb9xicv8ApB+D9bosiqEE7/PAkJdcRNe2IV39JH5MX2CFGPeTFwp/mpptIYu6EhJx5rfXeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669320; c=relaxed/simple;
	bh=F7t+dvzG1+6mtTyGMGKOsTlKzUuizFCku/aLhT2OQmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tP9VWW1ae8m+g2OqsDyawlWVQ2oZ3obKnZp6dOh01v2e+9nTu8bYIJKo+1wJJTI/GUtwTAvYacMsC0dVqAJ28y0c6vQ3ngvhBtfIkBuxJZETce/a9c8xJRzchEj2LY38Jtrj/bsFKuL5p3Bcs1dMgM12oeC3EmB5JA/Tu2YqbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNBrwnz1; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNBrwnz1"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-619ae418553so763666eaf.1
        for <connman@lists.linux.dev>; Fri, 08 Aug 2025 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754669317; x=1755274117; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2BX4M3eQMmhRLm9qhC28L0lIRTc1GUiN9/xTpQ+j9I=;
        b=nNBrwnz1g1jOxDYWE7L71DCVFUI2yzYpIRsIP+wpyyaM4g6Z1myp5bQ7abRz1GOEff
         s7BHmeCxNu35OV3kQ/8pEs6x6TrYApWK+OaXQ4Sx4do+mO3iLRTAp1zPniIxGuxk1e01
         OcsZvIGNA80EwJDMmUdsTBbkmhVMg4QGXPI4e8DrWiuBGMgbA4NRhijCNvkaeSyU0Pnk
         2z/83PKCiNz6wTJQFMfgxR715rXjxcpzdR8D1moJdyaCZ/PDyRsiePq6rRkq/zywDVSg
         CK13Yi2VyID2V56Qy/8bq6d4iWi2LcZYItG+ea1yrRQGzd5RF47lEccZj/WGeQBPTlrq
         OdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754669317; x=1755274117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2BX4M3eQMmhRLm9qhC28L0lIRTc1GUiN9/xTpQ+j9I=;
        b=c9l4SXalecx08cpdIUjQSFOewI14hHCsNi/7sqxkydklm5BHDbhEwtebttK9c2L6dM
         vmn9ydbo4/jPRU/z+n2fizKJmRKfaI7vZx60ec/vbYe6C+4SC/ycV/GSz507Y5VTECO1
         51ckauF/xyDW5jDRsOWNnU0+ZbokkAj1aFOqjV+9mpW5hailUQc/G201RSd2We+bTWpX
         lS6mZopKJUex+TqtBdhjqbLvlXBpR1CbwgUD661ESyHbbZ0c8MSJ0iPK2GZx6tCqm1+N
         KSAP/YpuxpDShz8fjNjew0jdJ+mp+ZTTEiInymLVFVlTNbVoUDi+dOzBYvKZORRYHnUm
         ZYRg==
X-Forwarded-Encrypted: i=1; AJvYcCX7UWUnIM0UTjtvrhSFcCSYhDSOhlBIxdU/TaLUGYbPokO1FJ3JUXfKt8COD0OXN2ljwLOqI4Ym@lists.linux.dev
X-Gm-Message-State: AOJu0YyEk3Ip2Saw5DhCfwAZbwrIhgcavTPxbHEZdZQcFAi9zMDnifl5
	0b7SchgccIq7VIJH4/6fv7srPUT8H7SpYtX1PCjYEWynQTCDooUWrlsWnh+q1A==
X-Gm-Gg: ASbGncuXLTHGNq6F1M4fVaMzwajxJNt4LBZFOV4VIQ5DybPPp8lLl+TvSzO3D8Gs2BU
	nCcsYdZ9lb7TIm8IrZ/RMYcKAGMO/98jQMNyJbI3JqnW5esLUQa+ZKnMp+jnoz5hUsD04J++akT
	BjrCzu03vrb7PD1G/z1Wp3wYogMHhFoR60Q8hbnsp39MW45+lpxdsnDolOvRfnOvuBMd6Zk4ZMc
	n1abvxr8AyWZeh9NPj3TUZNJu9o2N09FlQj5iBm6BnXIdB1dWFV+BswzTV2rcYqb52dtk38GjnU
	fNQD81wsHIZz9r2Lmtlp7FeXDFiC4k4vJ2QPkRi7iqWhiC7djERnALhGMyvN86U5o0FExDv+g0I
	/0xMdCDBB4QSz/7Pk4NIwGDyIcy0ZPfflvI4Gr2C77Qa1nfuwR/u7FWe8JW+hBcLgcZyTSnPSLF
	c=
X-Google-Smtp-Source: AGHT+IF4clD1spITeMfWM8ie03p5geieQFrNpduVxaJi1+7JwWKZM0iRyH6Bc2jDOZqkqWtxF1AM4g==
X-Received: by 2002:a05:6820:538d:b0:61b:7e35:bb41 with SMTP id 006d021491bc7-61b7e35bc6fmr992677eaf.6.1754669317210;
        Fri, 08 Aug 2025 09:08:37 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-61b7c865cd1sm273480eaf.1.2025.08.08.09.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 09:08:36 -0700 (PDT)
Message-ID: <42c25386-1dc7-4ef1-aa0f-b36b5d29dabe@gmail.com>
Date: Fri, 8 Aug 2025 11:08:35 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/45] service: Explicit VPN connect timeout, ignore in
 VPN agent wait
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
 <06df3300-c462-4294-85f6-b90315ef012b@gmail.com>
 <463ce86f-be52-47af-891f-745402387c29@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <463ce86f-be52-47af-891f-745402387c29@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jussi,

 >>> @@ -7322,8 +7322,27 @@ static gboolean connect_timeout(gpointer user_data)
>>>       if (service->network)
>>>           __connman_network_disconnect(service->network);
>>> -    else if (service->provider)
>>> +    else if (service->provider) {
>>> +        /*
>>> +         * Remove timeout when the VPN is waiting for user input in
>>> +         * association state. By default the VPN agent timeout is
>>> +         * 300s whereas default connection timeout is 120s. Provider
>>> +         * will start connect timeout for the service when it enters
>>> +         * configuration state.
>>> +         */
>>> +        const char *statestr = connman_provider_get_string(
>>> +                    service->provider, "State");
>>> +        if (!g_strcmp0(statestr, "association")) {
>>> +            DBG("VPN provider %p is waiting for VPN agent, "
>>> +                        "stop connect timeout",
>>> +                        service->provider);
>>> +            return G_SOURCE_REMOVE;
>>> +        }
>>> +
>>
>> I'm a bit confused why this entire block is needed?  If the service is a VPN, 
>> then the timeout isn't even started, and thus connect_timeout() shouldn't even 
>> be called?
> 
> Yes and the point of this was to extend that the provider.c can initiate the 
> timeout for the VPNs as well to behave similarly to other services. So In 
> ASSOCIATION state there is the 300 timeout for inputting credentials etc. which 
> is then followed by the 120 timeout for connecting in CONFIGURATION state.

Yeah, but right now you're introducing something that is essentially dead code? 
How is this a good idea?  Introduce it in a patch where this is actually needed?

 > > I think this was done because the agent needed a bit longer timeout than the
> connection timeout is for the user to input the credentials and it seemed to 
> obey the 120 timeout instead, so the aim was to make VPNs to have same states as 
> any other service, to synchronize the behavior.
> 

Why would the core have a timeout for this at all?  NoReply timeouts are purely 
a libdbus-1 construct.  You could have a dialog sitting there forever asking 
user to input username/password prior to initiating a connection.  The driver 
should really figure out whether a timeout is needed or not.

Regards,
-Denis

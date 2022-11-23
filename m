Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575554699
	for <connman@lists.linux.dev>; Wed, 23 Nov 2022 18:27:53 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id g12so30666997wrs.10
        for <connman@lists.linux.dev>; Wed, 23 Nov 2022 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KG+2oLzHXtCWFRH2K39uJhfQidUkTXUNRvDT0BTXodU=;
        b=V3WtyJ/kJOhI/7XHH68ooU8M1BaT1s8wMbNS4zF5t50YijgYx/21eef6UyImQkqJZK
         ME8nMacDGAIMbfsSwEg96MU54J/wMI6ypdMfnNaBcIvV7THCTcirH3DFxfctLD0jHVVd
         YXrepEmPHsGzWwZxLGTCtfZC/jKfPcY+bXVPtmSqhW6PClVAZNadNpYcoqBlKYFd4gdy
         KfF5B/yjbXbmGm2LNoDo/8aVjPLBfKhJBUjlfc2YJ0Z+pfTGZsPRxAeRT5aStRQVupEx
         xJw3hLoiXv761i8Q0b57CdJih+uOufrrMWLrERAkto5BUu0LMiIxpH+vnCQAGcO1r/kV
         DIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+2oLzHXtCWFRH2K39uJhfQidUkTXUNRvDT0BTXodU=;
        b=xLG726CHozjhdVrOgAFLH97z/heY8CPTmAi/+Di+jqc2RwTuawh8R8gbqmXFAuU+2O
         L/slJpgkY8pJy345jBt7ufJI9D3uZAZjuCbUb7edAv9KIzH3OV51YHWMr+K46hMeuNPL
         k560rTPFF/58S2ZvVJFlu5iiTwuFY/Hzz7S2kHx226yqkkC/L80Zq2AOJHOe/FOgqyJy
         6wjPzXLVUUiBqanLqt/o/V/zOIvbi7iinVS7htTrk/J10AQGf0z0Wdd/V38kgr9c5zjt
         6q5piTpedJGP/YMVslldpTdquVXb6qdc0lqQBWSAWggVBshWpAyXt5WWGChPNK7fH/nI
         N/LA==
X-Gm-Message-State: ANoB5plt7DOZHPKqH/HqIwV90j84v/n4cKbUQWWGIqsvrmGycGhCLzZ8
	ZMYBs9OQcufK+bekNBv7BRk=
X-Google-Smtp-Source: AA0mqf55Ao/NF+YCD7sefPJ6ReLp2G2YU+r5Yw6AvUJ53GCLZFsTp5wcNVVRlGoPZLH2TpbzADeDKQ==
X-Received: by 2002:a5d:4b49:0:b0:241:b6d0:cf61 with SMTP id w9-20020a5d4b49000000b00241b6d0cf61mr18099857wrs.195.1669228071496;
        Wed, 23 Nov 2022 10:27:51 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:30bc:b8e3:267c:6e67? (ptr-gh3gmp946np8o3sk86f.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:30bc:b8e3:267c:6e67])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003b47b80cec3sm3660169wms.42.2022.11.23.10.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 10:27:50 -0800 (PST)
Message-ID: <ef0bc60e-2833-9e72-c4ff-5d7fa3838ce0@gmail.com>
Date: Wed, 23 Nov 2022 19:27:49 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: autoip address set/reset loop
Content-Language: en-US
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, john@metanate.com
References: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
 <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
In-Reply-To: <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

I did watch your commit earlier, but because you say "It's propably a safe bet to say NULL is never a valid GW, so let's filter it out for all callers", that for me seems to be guessing it could have been a bug and it just didn't seem to fix much or anything you saw at runtime. It would have been better to see what runtime issues you fixed with it, because there is nothing for me to hold.

Regarding assigning the invalid /non-routable 0.0.0.0 gateway IP: it basically means there is none, so I don't see the issue. See https://unix.stackexchange.com/questions/94018/what-is-the-meaning-of-0-0-0-0-as-a-gateway#:~:text=on%20this%20post.-,0.0.,there%20is%20no%20intermediate%20hop.

On 23/11/2022 18:36, Daniel Wagner wrote:
>
>
> On 23.11.22 18:12, Geoffrey Van Landeghem wrote:
>> Subject: Re: autoip address set/reset loop
>>
>>
>> Hi Daniel,
>>
>>
>> Well, as said it autoip (APIPA) was not working because of this because it seems to not have assigned any gateway at this stage. This get's assigned in the __connman_connection_gateway_add() function which is called after this DBG(...):
>
> My patch fixes a bug but introduced a regression. If you want to fix the regression you need to figure out how to address the original problem: cb05780d86c3 ("ipconfig: Don't add invalid gateway routes")
>
> Just reverting is not okay.

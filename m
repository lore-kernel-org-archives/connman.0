Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7828EC
	for <connman@lists.linux.dev>; Thu, 24 Nov 2022 16:34:13 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id ud5so5245571ejc.4
        for <connman@lists.linux.dev>; Thu, 24 Nov 2022 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbEluOOevtgkR1Uo7kJQc6ShafpGHRaztaiOmV5i/TA=;
        b=YhYcJ3BP2v9TXJ5n/daDNZPOpgu8wUYbJZ5o1RxUmYaH/gEZC8du24y87oUwTRUl+2
         bG/5LTgIDO5QgKFxR5CBNWPiLRBBN4I8V+uzz1oPkFqJwNgzeegSeKkNe00QeXG43GWO
         igrprVJfWESm9pepkOQTwvAQOtEnfUV587Uc/M+lut4ISCHeSwEuEmEA1/mJ6NvhEeDm
         hEWOf8mty9mHpazO6Bi+7jUExJf+OOEqrfeDqjeEHo+a/vETL81V0K+ga4upjWbJbtSE
         QFoEThIqPqMZyCHjiH5/LZywu4yqQruuW394ZIi5V6nlgtOFSRk486vykajK0r3kM0p1
         uGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbEluOOevtgkR1Uo7kJQc6ShafpGHRaztaiOmV5i/TA=;
        b=EH3/SZ+8dVwPcWLfoPocs0/nQdpJs1FO4qU/hLJqGk2/JfJB3IPG9RtC9F8HsJA2IY
         Hmj+dvOc0hYwvlM+1cLvAJYvnQrBT40Pq6Bx94AjWAbdtSqM07P40d4bOgEJ38ux6pEZ
         eVN4unQMa8CMj7K2oyRgHUUl9lWlhtsEQ6yBntPulYsuAO3FperVtbIzkKfCGSvF1Il9
         n6c1VbVlbvOR2Z1k/Kj21NFEOzk9IA/rrG0MM3G6YqlJsExIYMuhV5tvUIO7tTMjRwJ2
         zAeoxt8GuPU5yceM/WQG2X1OFVq1pWhHnmcW5eqJuIiiUWJ+RHCii/u2d5TYREiif3uT
         8rsw==
X-Gm-Message-State: ANoB5pn8VWpmxAErz/98dmm/IEHS18Ga6ttbvJSZFMb9WsEmwGglnqTP
	mdsBtnKw9Fp1j+3n7KlM2iEgRC25CpelVw==
X-Google-Smtp-Source: AA0mqf6zbsN8cJcJo5QDIo+vRW0wxjVUfkPK+MJlRJmRx4Nazdk+C2vdKFnpgLaai1qnVJ8BXb+HhA==
X-Received: by 2002:a17:906:5fd5:b0:7ac:2e16:a8d3 with SMTP id k21-20020a1709065fd500b007ac2e16a8d3mr14077479ejv.667.1669307651449;
        Thu, 24 Nov 2022 08:34:11 -0800 (PST)
Received: from [192.168.0.198] (84-199-78-189.ifiber.telenet-ops.be. [84.199.78.189])
        by smtp.gmail.com with ESMTPSA id f5-20020a056402150500b0045723aa48ccsm677665edw.93.2022.11.24.08.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 08:34:10 -0800 (PST)
Message-ID: <431721b6-ac4e-dacb-d739-760e7c6e0bbd@gmail.com>
Date: Thu, 24 Nov 2022 17:34:09 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: autoip address set/reset loop
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, john@metanate.com
References: <152f062c-7c16-c6cb-c8e8-c6f82902e40b@gmail.com>
 <39363d0c-2928-b5a1-d108-1213149fa7ea@monom.org>
 <ef0bc60e-2833-9e72-c4ff-5d7fa3838ce0@gmail.com>
 <20221124114529.w33mrgo26s5b7qgw@carbon>
Content-Language: en-US
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
In-Reply-To: <20221124114529.w33mrgo26s5b7qgw@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ah! That was the mandatory info I was looking for!

When you say that such gateway address is a bug, then do you mean in general? Because I'd think that in case of IPv4LL at least you need some default route. The RFC also speaks about using 0.0.0.0 for forwarding rules: https://datatracker.ietf.org/doc/rfc3927/

And the current codebase also accepts it:

    /*
     * If gateway is NULL, it's a point to point link and the default
     * gateway for ipv4 is 0.0.0.0 and for ipv6 is ::, meaning the
     * interface
     */
    if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV4)
        gateway = "0.0.0.0";

    if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV6)
        gateway = "::";

Note sure how to proceed next, do you mean we should add an extra check if our IPv4 is LL? Something like this function found in acd.c:

#define LINKLOCAL_ADDR 0xa9fe0000
static bool is_link_local(uint32_t ip)
{
    return (ip & LINKLOCAL_ADDR) == LINKLOCAL_ADDR;
}

On 24/11/2022 12:45, Daniel Wagner wrote:
> On Wed, Nov 23, 2022 at 07:27:49PM +0100, Geoffrey Van Landeghem wrote:
> Again, 0.0.0.0 as gateway address is a bug:
>
> https://lore.kernel.org/connman/b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net/

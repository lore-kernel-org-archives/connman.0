Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AA3222
	for <connman@lists.linux.dev>; Tue, 22 Nov 2022 18:35:45 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so6332758wma.3
        for <connman@lists.linux.dev>; Tue, 22 Nov 2022 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A02oN4zVzjI0H361SKXarFuh+S3C8eVxLVkXoe14YP8=;
        b=TfwrHpvEmtwNvpSNOCfe+kaVEezEbI13FkShMuP7+yOtb7StyYR6ZG/KVxQ26CWc2w
         sPKaaLUYcB2PVJUNFFViPVdpcKMj28Uorw/mh8aJwEj557taDl576tU4xdWsaCkmWgPF
         5r/nH7WYyOTovtrdB+3v7q80hzM70FZzGpZgHMe490cUqnkv5DPYXwi/tS6ZBks58Nft
         UPkanLdFFV2TNf9v65NbQDJV99cypqhyp0IZ5DTnGqem4XcoWeu2dgpmf7Ia8vlMYgyH
         +BVWcL9MdftVy5KF+QR5FHG/C9jZAECEfERV0bSv/IfuWr//wAvmB2qJ+THXrQWjd5gC
         rszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A02oN4zVzjI0H361SKXarFuh+S3C8eVxLVkXoe14YP8=;
        b=RvViuNJKgoJmvCh9rBgBCt/fjQU9d5rW17kuhpVboarXv/ziJOFhUDDLd5D77nz9k7
         xPRqX3NircIOtH4RhZqazh0aSwLEQVXIJhpHhckZh9vfM2+NDZZMoyIydn+2K5mjbask
         +nM/ClfrniAul3/+YmyEq7M0tR3Pp7HWzJc2sBLDRBWKDFaGltLLmDkKXo4NI88T7KZx
         goOcZ8frToXl3IyvcAj2seuZfjj7yny2mvcuw60Dqip9FzUpgs/h0rwpBsyNg8cokKKN
         /1dpN+9OPtxiDBeGXeTIWyio+LucXpGMbmoufX1sv4shLNWhaMVuHJL+L6SR8INtG11J
         2gqg==
X-Gm-Message-State: ANoB5plgtzzSkPvQk5Qz8MKc/O7HtIWi5BdWzpGgcBFG8y2ICsTyorTL
	h46KMv51EAYpEM/ACGSovFzAysAl1q0m4w==
X-Google-Smtp-Source: AA0mqf5iApkXaarrl8YhMxmA21Z2eO4jz8+lkBxaa1JdFyPGvexhYBIFo8C2/lR7RirV35U+70CISg==
X-Received: by 2002:a05:600c:4d0a:b0:3c6:a7a1:eebd with SMTP id u10-20020a05600c4d0a00b003c6a7a1eebdmr17053509wmp.176.1669142143716;
        Tue, 22 Nov 2022 10:35:43 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:5d81:6a68:de38:2188? (ptr-gh3gmp9soz6sk1obfyg.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:5d81:6a68:de38:2188])
        by smtp.gmail.com with ESMTPSA id e15-20020adffc4f000000b00241dec4ad16sm3546086wrs.96.2022.11.22.10.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 10:35:43 -0800 (PST)
Message-ID: <2ec046cc-aefc-2a6a-3f1c-5a08c447fd76@gmail.com>
Date: Tue, 22 Nov 2022 19:35:42 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: autoip address set/reset loop
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
To: geoffrey.vl@gmail.com
References: <dda7ee12-1176-6eaf-4f84-a599bfbadee8@gmail.com>
Content-Language: en-US
Cc: connman@lists.linux.dev, wagi@monom.org
In-Reply-To: <dda7ee12-1176-6eaf-4f84-a599bfbadee8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Subject: Re: autoip address set/reset loop


After adding some extra logs I could trace that the issue is due to an error in __connman_ipconfig_gateway_add:

network.c:dhcp_success() lease acquired for ipconfig 0x1a300b0
inet.c:connman_inet_set_address() index 3 address 169.254.5.120 prefix_len 16
inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 3 family 2 address 169.254.5.120 peer (null) prefixlen 16 broadcast (null) p2p false
ipconfig.c:__connman_ipconfig_gateway_add()
ipconfig.c:__connman_ipconfig_gateway_add() ipconfig->address->gateway NULL
network.c:connman_network_set_error() network 0x1a26080 error 2

There was an extra check introduced there recently which is blocking the function from returning successfully and therefor results in that __connman_connection_gateway_add() is not called either (which should add the '0.0.0.0' gateway).

@Daniel, should your patch be reverted (and maybe accompanied with an extra comment explaining why there is no NULL check for the gateway), or do we somehow assign the 0.0.0.0 somewhere earlier in the process?


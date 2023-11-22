Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056CA5786B
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgQGQvYW"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso9793426a12.0
        for <connman@lists.linux.dev>; Wed, 22 Nov 2023 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700669259; x=1701274059; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yxpF86COCRlvN7nkFR8N4un6tWgu0bUbXBL9Lci2eg=;
        b=XgQGQvYWt8r2z478YJS3EZMq1xTzLnuktT9Qy8aQ8E/wy3YvCcPOKt44UA3aOlUfgg
         YBJidg5Ojlb8cPBXTG3TDR1n0Np7LOPoEm1/A1c3aqzWEU2Pjq3TTpOy16/t6SWU+ttg
         lwieiezYJZNG5sCVz94PdTalKFAO86bVx66iGSlsqqVxzaK1UllvtyPcwgfGQjbXfhTp
         YWu7a0a4ucTKzXXWNbaDgM6PjUeUm2d8unDcIHKh3epfDdSwSGAufR1FlZISgXuPldAI
         4jOg8TmKkGbWSsg34mG/giGUIe4L6wp0TLepivN2QrBT42x5cjxTJvR6+oI3KYWuePML
         EbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669259; x=1701274059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yxpF86COCRlvN7nkFR8N4un6tWgu0bUbXBL9Lci2eg=;
        b=DbC3ZJJ8aqyVLqtNDfbIT+y2uv68acekh4TVP/P4Y5X+6nGSjEJEbPSoRdGbV9xvAl
         DaS5r/1m+HMDvAlFbe/XblR/SXngjNCT+NXrmiQydCPwJR0upHgY7/FZX/4fEPRH9uRH
         /0vNqsHcHjGpKgOxKQZSdQE5m5ZTd2qnmRiGkVGZNj1wA4qBmEANqJO/d7leIz5fxNxp
         LQwF3EHOFdA6f7+vA63HfDR0Fuw5Yb2gaXY3/YPGwQkhxxO7wfRvwEjUvEPkzQzpDJ2B
         rzXYg/DztYczW0rKV1jM8kudJ22Fu/TZxq4gFxi/0N1axxd9QFu0+xyV+W10+Wffx30d
         kRYA==
X-Gm-Message-State: AOJu0Yzp/iWPVurPQ2eI+gMXWBjtJHtrprtbEA70ugsjZjSHEC3EFRUe
	y75pCwrkfBKWlYM1tUBW+UyzzIT8794=
X-Google-Smtp-Source: AGHT+IFvg66i+XFbsIZX1obtP1/ujBiqNUQcfgWkabaBheZX9Ba7uVrVQ6J826PxBoJRvbmomVBlWQ==
X-Received: by 2002:a05:6402:484:b0:544:a27c:f7b6 with SMTP id k4-20020a056402048400b00544a27cf7b6mr628610edv.8.1700669258863;
        Wed, 22 Nov 2023 08:07:38 -0800 (PST)
Received: from [192.168.2.2] (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id m24-20020a50ef18000000b00548699fa102sm5338177eds.83.2023.11.22.08.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:07:38 -0800 (PST)
Message-ID: <83d7e315-a25c-4c2c-9ddc-9abde56ebeff@gmail.com>
Date: Wed, 22 Nov 2023 17:07:37 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Regression_caused_by_=22Don=27t_add_route_for_inval?=
 =?UTF-8?Q?id_dst_and_gateway_address_combinations=E2=80=9D?=
To: Christian Hewitt <christianshewitt@gmail.com>, connman@lists.linux.dev
References: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Someone with a bigger hammer should look into this.

I guess there is a difference between
* intentional default gw with all-zero network and netmask bits for VPN
* dhcp not responding on an interface and then adding a route with all-zero gateway and 
netmask values

2023. 11. 22. 15:53 keltezéssel, Christian Hewitt írta:
> Commit 9eb1772d31b6 ("Don't add route for invalid dst and gateway address combinations”) causes a regression in WireGuard support through the connman-vpn agent. I presume the wg0 interface matches the definition of "unspecified destination address coupled with unspecified gateway” added.
>
> This is my routing table with the WireGuard interface (wg0) active:
>
> RPi5:~ # route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
> default         172.16.50.1     0.0.0.0         UG    0      0        0 eth0
> 1.1.1.1         *               255.255.255.255 UH    0      0        0 wg0
> 8.8.8.8         *               255.255.255.255 UH    0      0        0 wg0
> 10.127.0.0      *               255.255.255.0   U     0      0        0 wg0
> 65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
> 167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
> 172.16.50.0     *               255.255.255.0   U     0      0        0 eth0
> 172.16.50.1     *               255.255.255.255 UH    0      0        0 eth0
>
> As wg0 does not have the default route “all-traffic" is not routed down the VPN tunnel as defined in the connman-vpn WireGuard configuration:
>
> WireGuard.AllowedIPs = 0.0.0.0/0
>
> This is the routing table after reverting 9eb1772d31n6:
>
> RPi5:~ # route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
> default         *               0.0.0.0         U     0      0        0 wg0
> 1.1.1.1         *               255.255.255.255 UH    0      0        0 wg0
> 8.8.8.8         *               255.255.255.255 UH    0      0        0 wg0
> 10.127.0.0      *               255.255.255.0   U     0      0        0 wg0
> 65.109.130.17   172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
> 167.299.200.14  172.16.50.1     255.255.255.255 UGH   0      0        0 eth0
> 172.16.50.0     *               255.255.255.0   U     0      0        0 eth0
> 172.16.50.1     *               255.255.255.255 UH    0      0        0 eth0
>
> And “all-traffic” is routing through the tunnel again.
>
> I don’t code so can’t figure out how to fix this myself. I’ll happily test any patches you share though, and can provide remote access to test devices if needed.
>
> Christian


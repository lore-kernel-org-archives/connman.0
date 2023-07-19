Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50D1BB27
	for <connman@lists.linux.dev>; Wed, 19 Jul 2023 22:58:55 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-565a8d74daeso161500eaf.1
        for <connman@lists.linux.dev>; Wed, 19 Jul 2023 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689807535; x=1690412335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BgDKrshvojsIjSrrqVMTqpDjLflOySFrRkyOxowJlA=;
        b=S/+6YL4e3GMTl6pWq1W0cI0Sp6zr7cwh0dWUtG2Hu8DJbYxpp4SSWXfunadZJ1b33n
         yebLrvhhfJDcNZKrIHVmPw4b7uQcl0ncIJKCgR8kGohulJrhNHmsNQ/FkJPHjdVJyFDT
         f39njAbu5vYKjh8ywAqugnOvnxp5GTeHELNrPykOdgbwcubT9Yhf7uK4inwzK030kWpp
         jBkT1Aye5o54OWbSSbPuhWqW0d5rWym9qRMD0agmVgrtxa2OT2+DVhG0lcHHsUe5189K
         +dPsmVR+X5Qu8R8FORyWOZGF6JJMTz+7gRJGafZNz+2bYh8DqxqdR3/gTPpSQtKNVjJ6
         wpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689807535; x=1690412335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BgDKrshvojsIjSrrqVMTqpDjLflOySFrRkyOxowJlA=;
        b=EwSj+brIkXjRKHACZOjhq3aEGvVgDmYtbrS8AfegBgPzrfWd0Yna9zxdoDnOAE9TZR
         vn47vftZjUvxuOKHBk1pGOxtZgWyUxSaWNVxRIJIeILQiClBmSN0M9wXR7MnZjMJLYrx
         v63jXd5lMUgOl1erzm3ZGm/RAfgfxuz9vmS/0zPmzTNUTPJOqco/8eNr9aO8fewxPjYx
         HyFBeTxNTNceLCP98kq1HiNZT81GksSiYxUlSkI8f063algO+HJ6pGNafWIEza143MAG
         q8cJF5iIEc0Q4RlIH8bM+TxzFc3A247PNHPhLymJNv3nLa0bNo0iWKQSkYP2aSxHSkYU
         KHlA==
X-Gm-Message-State: ABy/qLZ+zMb2tgBWOvQyUTRqpTspFVBMwTy9uFXMjgA71O4RtSkVYIAW
	UPbMBoaHJWVDm6xnerZm2p4H/x8ztvIdZg==
X-Google-Smtp-Source: APBJJlFLtOyNjPiYXGXNWBzxqXmbkh+fyJ9G/dvpJUQ1++/wf7lZfey8FErtExKC1e8c7J7avtdYkA==
X-Received: by 2002:a05:6820:34c:b0:560:b9f0:b9fc with SMTP id m12-20020a056820034c00b00560b9f0b9fcmr968260ooe.0.1689807534962;
        Wed, 19 Jul 2023 15:58:54 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z138-20020a4a4990000000b00567829a4991sm736772ooa.36.2023.07.19.15.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 15:58:54 -0700 (PDT)
Message-ID: <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
Date: Wed, 19 Jul 2023 17:58:51 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: A Few Minor Complications on connman + connman-vpn +
 wpa_supplicant + ofono Bringup
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

On 7/19/23 11:57, Grant Erickson wrote:
> It’s great to be re-engaged with the connman community after some time away, noting a community and mailing list migration in the intervening time.
> 
> I am currently working on modernizing an IP-based communications stack for a Digi i.MX6-based SBC with Ethernet, Wi-Fi, and Cellular (using a Quectel-based “Nimblelink”) connectivity. The infrastructure has migrated from ifupdown/ifplugd/wpa_supplicant/ppp/chat to connmand (1.41) + connman-vpnd + ofono (2.1) + wpa_supplicant (2.10). All in all, standing up a prototype for this more modern stack was very straightforward and simple relative to when I first engaged on this front in late 2010. Ethernet + Wi-Fi + Cellular worked, mostly, straight away with little-to-no configuration and setup on my part. Congratulations to the community on all the progress in the intervening 13 years!

You should check out iwd ;)

> 
> I suspect an issue with the routing setup:

<snip>

> 	# ip -4 route show
> 	default via 192.168.2.1 dev eth0
> 	100.87.218.180/30 dev wwan0 proto kernel scope link src 100.87.218.182
> 	100.87.218.181 dev wwan0 scope link
> 	192.168.2.0/24 dev wlan0 proto kernel scope link src 192.168.2.46
> 	192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69
> 	192.168.2.1 dev eth0 scope link
> 	192.168.2.1 dev wlan0 scope link
> 	198.224.173.135 via 100.87.218.181 dev wwan0
> 	198.224.174.135 via 100.87.218.181 dev wwan0
>

Correct.  IPv4 routing is missing any gateway information for wlan and wwan 
links.  Hence the packets cannot be routed.  iwd uses a default route with a 
metric set with the assumption that the metric for ethernet devices would be 
higher priority.

You can also try doing something like:

ip route add defult dev wlan0 table 1234

> 	# ip -6 route show
> 	2601:647:5a83:8c52::/64 dev wlan0 proto kernel metric 256 expires 2591856sec pref medium
> 	2601:647:5a83:8c52::/64 dev eth0 proto kernel metric 256 expires 2591856sec pref medium
> 	fe80::/64 dev wlan0 proto kernel metric 256 pref medium
> 	fe80::/64 dev eth0 proto kernel metric 256 pref medium
> 	ff00::/8 dev wlan0 metric 256 pref medium
> 	ff00::/8 dev eth0 metric 256 pref medium
> 	default via fe80::f29f:c2ff:fe10:271e dev wlan0 proto ra metric 1024 expires 1656sec hoplimit 64 pref medium
> 	default via fe80::f29f:c2ff:fe10:271e dev eth0 proto ra metric 1024 expires 1656sec hoplimit 64 pref medium
>

ConnMan (or is ConnMan using the kernel to setup IPv6 routes? I don't remember) 
is setting up default routes for eth0 and wlan0, so things work in this case.

Regards,
-Denis

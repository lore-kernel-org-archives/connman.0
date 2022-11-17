Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA68C03
	for <connman@lists.linux.dev>; Thu, 17 Nov 2022 19:36:33 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id ft34so7597378ejc.12
        for <connman@lists.linux.dev>; Thu, 17 Nov 2022 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhWpMemWiR6939wBlNKO2JM7aJTcPP02+7OuWBZcdsY=;
        b=p4elNXlQ68HYiEC0vBz1gNqyNd/SxN/zONys3AHHVgZfdEzrxPvLvW2hBlOnT7Hulk
         AXkHrvv3DYOD87NtV8uCr/ulCkXO6GjaTiObDr2+CZ2ZhKq/eJVPsRnnN0+gzWQbgvTI
         /WDOYB2JCKTOGqLegeTcvGJWKnp/YJ/EfvplZRYoxXuzCa6dfOQHe4QlOZEqIPGhsV7c
         GgSgxyFBDcWopBY7ChmJ0kWxiGBnE/E/3WTKpvxlVLTjeSg6+neNOWzU/nS27KNcuMcM
         rVVsRJkIwZhlp//VXbpj8F3FDpsOhYvCha5uYwOhDCYh0bhQFFk4OAuVIlREMDG1l+j3
         wjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhWpMemWiR6939wBlNKO2JM7aJTcPP02+7OuWBZcdsY=;
        b=RJ3U+FqqkmOQnFkdlUqXXytH1g7Vnr4SsQ1gKPo4zj6HCzIAyQONXjXZHy3Y+XgPE1
         84Ek4k4CYHkMYz8JaRPW2QYTpe5xIhSGGo5W2wmRgTnGjlRZoqUTbSxQmcbaUiLkW5cw
         eU0QT5yjhTyqD//cOGhRrpOLFr20/+klp0FKgabbwac3iGN/ODbpp9ihZtbUj7ASAvhd
         7l9FMn7ZHUmJuCJmbZQm5AsIF2JKI4FNAQ9Fe+lqYFnFLI18sv9NB1fCXv5PNOSirlY1
         vMrIHSH3/znkhlb2CZVpLLH1OyNHI3X7fs6tIcHSDjSxL9aony9E9EDGIbY7pPCQeAZr
         23IA==
X-Gm-Message-State: ANoB5pldwK4ecUlnnt9Aox2ysQn2PZ+G2asPxVa7PQzdJQ8gDVEki30M
	Ot5pJPsofiCukWAwGsLfgmxjDDKpkb/i+Q==
X-Google-Smtp-Source: AA0mqf5ck8PTCuSsDRPtsbkgeOPblDTq0omN2gvYFEI22+/l48Zv5TViy53GaB/4URgT+4Cq5f59mA==
X-Received: by 2002:a17:906:805:b0:78d:8267:3379 with SMTP id e5-20020a170906080500b0078d82673379mr3280253ejd.415.1668713791963;
        Thu, 17 Nov 2022 11:36:31 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:554f:c9af:49f1:9b40? (ptr-gh3gmp9o7hkwznwdfeo.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:554f:c9af:49f1:9b40])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906394900b007add62dafbasm734917eje.157.2022.11.17.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 11:36:31 -0800 (PST)
Message-ID: <2f32ea1c-6fa6-998a-5d2a-7991b7b8b7c6@gmail.com>
Date: Thu, 17 Nov 2022 20:36:30 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: geoffrey.vl@gmail.com
Cc: connman@lists.linux.dev
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: Re: service: 'ready' Status ProprtyChanged not sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

What was missing earlier were some logs. Below is the output of connmanctl monitor:

Technology   ethernet             Connected = True
Manager                           State = ready
Manager      ServicesChanged      = {
*AR Wired                ethernet_xxxxxxxxxxxx_p13_cable
}, {
}
Service      ethernet_xxxxxxxxxxxx_p13_cable IPv4 = [ Method=dhcp, Address=192.168.0.101, Netmask=255.255.255.0, Gateway=192.168.0.1 ]
Service      ethernet_xxxxxxxxxxxx_p13_cable Nameservers = [ 192.168.0.1 ]

As you can see the 'State' PropertyChanged on the Service is missing.
After reading the service api docs I'm confident that this is a regression.
I dug a bit further and found that it's actually due to the allow_property_changed that is blocking any PropertyChanged for a while.
Example:

Nov 17 14:00:30.957 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:service_schedule_added() service 0x21146b8
...
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:__connman_service_ipconfig_indicate_state() service 0x21146b8 (ethernet_xxxxxxxxxxxx_p13_cable) old state 1 (idle) new state 3 (configuration) type 1 (IPv4)
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:service_indicate_state() service 0x21146b8 old idle - new configuration/idle => configuration
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/session.c:service_state_changed() service 0x21146b8 state 3
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/notifier.c:notify_idle_state() idle 0
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/manager.c:idle_state() idle 0
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:state_changed() service 0x21146b8 /net/connman/service/ethernet_xxxxxxxxxxxx_p13_cable state_changed = configuration
Nov 17 14:00:30.966 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:allow_property_changed() service 0x21146b8 /net/connman/service/ethernet_xxxxxxxxxxxx_p13_cable allow_property_changed = false
...
Nov 17 14:00:31.295 hostname connmand[8343]: ../../../../../../workspace/sources/connman/src/service.c:service_send_changed()

I haven't added the full log here, just an example of the State property.
It boils down to the fact that every PropertyChanged in between 'service_schedule_added' and 'service_send_changed' is not allowed to propagate.
And I noticed in the full log that it's not only about the 'state' property but in fact a handful of PropertyChanged events.

So it seems the delay was added there on purpose, so I'm wondering why it was implemented that way. Any clues here?


Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07133631
	for <connman@lists.linux.dev>; Thu, 20 Jul 2023 01:41:59 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b9f46ec07aso226745a34.1
        for <connman@lists.linux.dev>; Wed, 19 Jul 2023 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689817319; x=1690422119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzrJJoq1pYe43aMstnROE+8+QWWum/AhKxurfZvvxAQ=;
        b=FusCHjTfCByoVqo1H3ENnP08pgGxMnmABxEhhJFvjW4D+qtx9Vi0rB7EJUK/nxZNAw
         YNKKNnHMP/Tf2BYy5jCIUtcPPg58JFDynERcsD74slZZTY819sMzZwdqDCogkvgGlWYd
         rAkleT9fMzrWqN0a0Wa5z3/E1WxZ5shGpI2+kZ7Rga6Y3jbM9LWNJUBrPKn0maGyM7VX
         CWAWtJ03xv8tw9vI0HcGWzMKzbW0MAG3VOpjD/u1ifpbLmuWQUHLFHa8jCxaum/NY4FR
         8zmPyB3+pqPm9vsgDqeKASVCr44IdnxGfFQ9JEOr6uP1eb439rKD5otGaHEYGDW+09jq
         wKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689817319; x=1690422119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzrJJoq1pYe43aMstnROE+8+QWWum/AhKxurfZvvxAQ=;
        b=j2K8Y/LZYhiFMsCvHpOWtqyfkx56BO+RDUN/0CKJhICp+rny2UV3Nie8Lu/VyxidbJ
         t5O35SuF8YbKSxPeTKdtFXXwxH2TkUe4m1ADf59x0NiAH96SpIOSVqWXRHkMh0ojzqr9
         VfYe6avbnfVGK9TnZPWLxpFG8JUHIOSqWb9dSxqVe8aXMjJr+zvG28yRlmdZ6/CmbZMc
         w6xVmTL/2yRD7/GV7SkLwoYvWjyUoslFvtGm9rox7D4ML2dEXwiZyFYjygmmsoJQAZPv
         ML6a6Af+intftPLXxzKhbJQko0whO1QFQiXhoVCKdlLa9h6HLcxqwjecn4HHv7z/tVlo
         lgTA==
X-Gm-Message-State: ABy/qLa5JPayc4nfnkMbJwBEE3DEXW6QsvoaS+2VgWd3fr95UwuPQ2mI
	ZZ3f6gWHQKtkF9M62N+aZSCIVj5uQrfiQg==
X-Google-Smtp-Source: APBJJlFGI8XTgG2g11lSNM/YzJCmCf7MVuuU2OEN9kFbsUVtMZUmr6IFO0eiLjznM8flgs1OW4Ik6g==
X-Received: by 2002:a05:6830:1d5c:b0:6ba:864e:c5de with SMTP id p28-20020a0568301d5c00b006ba864ec5demr834838oth.8.1689817318736;
        Wed, 19 Jul 2023 18:41:58 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l1-20020a05683004a100b006b95392cf09sm21902otd.33.2023.07.19.18.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 18:41:58 -0700 (PDT)
Message-ID: <f6f0a90e-28d6-3a23-9a78-ef5082d9186e@gmail.com>
Date: Wed, 19 Jul 2023 20:41:56 -0500
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
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
 <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
 <AD3159CB-7D79-4188-B56A-7EB65C6581DB@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <AD3159CB-7D79-4188-B56A-7EB65C6581DB@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

> Absent iwd doing this, shouldn’t connman be adding such a route for wlan0 as it did / seems to have for eth0 IPv4/IPv6 and wwan0 IPv4? My understand is connman is the maintainer of routing from a link redundancy perspective. Is that not accurate?

I'm not sure what the reasoning is?  Perhaps there was an attempt to stop any 
flows to the non-default interface?  Or maybe just an oversight.  Maybe one of 
the maintainers knows.  But I would tend to agree that the behavior you describe 
would be desirable.

> 
>> You can also try doing something like:
>>
>> ip route add default dev wlan0 table 1234
> 
> That didn’t quite work; however, this did:

Ah I think the table id is limited to a uint8, so maybe try a smaller id?

> 
> ip route add default dev wlan0 via 192.168.2.1 metric 1024
> 
> where 192.168.2.1 is the next hop gateway.
> 
>> ConnMan (or is ConnMan using the kernel to setup IPv6 routes? I don't remember) is setting up default routes for eth0 and wlan0, so things work in this case.
> 
> Precisely, it seems like the IPv4 route for wlan0 is a “hole” in routing coverage where it did set IPv{4,6} routes for eth0, an IPv4 route for wwan0 (no IPv6 on that interface), and an IPv6 route for wlan0 but missed the IPv4 route.
> 
> My gut says this is a “bug” rather than “as-designed”. Thoughts?
> 

Sort of.  From what I recall, ConnMan handles IPv4 routes completely internally 
via its own mechanisms.  For IPv6, it lets the kernel logic act on some of the 
information.  Maybe the prefix info from Router Advertisements?  This is why you 
see two default routes with the same metric in your setup.  The routes are being 
setup by the kernel and not ConnMan.  It has been a while since I looked into 
this.  Either way, as you point out, there is an asymmetry between IPv4 and IPv6 
that should be fixed.

By the way, we do have a full DHCPv4/DHCPv6/SLAAC implementation inside ell now. 
  Maybe someone feels brave enough to start using it in ConnMan?  That's one of 
the reasons we made it.

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/netconfig.c

Regards,
-Denis

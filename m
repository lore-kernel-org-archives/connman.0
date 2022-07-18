Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34A7F5
	for <connman@lists.linux.dev>; Mon, 18 Jul 2022 02:31:46 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10d4691a687so5346384fac.10
        for <connman@lists.linux.dev>; Sun, 17 Jul 2022 19:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApE6zdyI5rF8Flyin9qF7qLpLbPEJfaL6rIxGNi47sw=;
        b=e1JUFSJiMKioHcU8e7uBHoHl8MhznRYThbzED23MsV8oditALfEcswWhjWIpbaoaCP
         aI+YJbGdcbCYl2NkLElic7399WpubaLrlKYS4L7oRcWRsIq+bm24ocmXBMWUTDasZGP2
         1xKctOYnNsEuqMvDyvgUVnHEAvWx0x4t7ee5Rdnb8LlasUYze8GyDCoEiM/q6fyn+dRD
         2aTcakOV6j2E6+T1UNe9aTV6FBFhnLIIbKYGV8iaLiIpZ3+JkHDrWhRrfGWbpLrB52Jz
         toANRJQPxz9qegnFMR7uvtpYhwD4E1N0KRTWcvvZVX8mQMcR3muriG89A0HtNAtgMNHN
         o+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApE6zdyI5rF8Flyin9qF7qLpLbPEJfaL6rIxGNi47sw=;
        b=Qj5Ttz9pBpyZfRQ2CNZhZPbkXUVufmEg4ltT0p0/9JAHslkhjHQy/gGuI533S+nW2X
         SAv9OVH/iAsK0ft8eEmShWg2kLF5i1sVVMMZN8KnXH9FSNTpJCCa94oTCgN8C919oxl0
         6ZPHXoIkysbURwTWeQ7hzF0TB4O7zrK1sbgN359kV3ezlDRCv3ZhhnC1Sm3bXNPuzELV
         BjkM088ZuN45zaHjgBxQT91X5aYBTBmQv9wSGctWlaMgHVTE4Eba3ZvG9JeEpO6wxVtc
         hvzJCyJK+p1w9S13KMoUb50sTYyJ8VBnzzKhc2wjZnX7zBNFYeOBCoYFANhXHRTnhqlw
         lbbg==
X-Gm-Message-State: AJIora9CZQzaKiVvEa+xHIGQTG8GRMzAtBLUG88iNXs5halZGoRT5qED
	o0wIFlITCjGTHkSDDZdmcgSU1MmDDxIN7pNDoZM=
X-Google-Smtp-Source: AGRyM1tNSks9zITo1SCKhjUkmmB3I+hBmNFkk0Tt/o+Wj8OoslfoDj+FGyxnEiuNM0Shihrg3jD/W8onTDPUWWnAxMk=
X-Received: by 2002:a05:6808:f8d:b0:339:e7f6:12e with SMTP id
 o13-20020a0568080f8d00b00339e7f6012emr14955832oiw.78.1658111505275; Sun, 17
 Jul 2022 19:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWTmGCSQFEMABzUU742ZE-2LJNR38+B55Kzr3HrLjcOO-g@mail.gmail.com>
 <3dc4f487-0833-19d9-d4b7-8c6319d32411@gmail.com> <CAA=hcWT6xaJKWxmstpRznb+hY7PcwDSagm_n6udZ8VjMXw_p6A@mail.gmail.com>
 <02550a47-5d45-d165-4572-0542f5772532@gmail.com> <CAA=hcWRSKCUEcO+EnRgrk9D+dUxAubYjQAHEQjfgWTE0FaKNug@mail.gmail.com>
 <20220704092248.2qjehvz7f3f3dsii@beryllium.lan>
In-Reply-To: <20220704092248.2qjehvz7f3f3dsii@beryllium.lan>
From: Jupiter <jupiter.hce@gmail.com>
Date: Mon, 18 Jul 2022 12:31:09 +1000
Message-ID: <CAA=hcWRsNbm36yLt00bD7xuTEVkD=ApYt3JNYd66H7bw1JiSeQ@mail.gmail.com>
Subject: Re: iwd + connman
To: Daniel Wagner <wagi@monom.org>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd <iwd@lists.01.org>, 
	connman <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

>> But I don't think that is the cause of connman failing wifi detection,
>> how is iwd and connman communicated on
>> EnableNetworkConfiguration=false, I assume through dbus, right?
>
> No, this is not a D-Bus API. ConnMan will not set this.

Could you please elaborate how the ConnMan could figure out WiFi
connection based on there being no direct connection and communication
between the ConnMan and iwd?

> The DHCP code in ConnMan doesn't really care about this detail. ConnMan
> operates on interface index.

I set up /etc/connman/main.conf:

PreferredTechnologies = wifi,cellular
SingleConnectedTechnology = true

The ConnMan was able to switch between the WiFi and cellular
connection when I used wpa_supplicant, it is now incapable of
switching WiFi and cellular connection in iwd. If it is based on
interface index, here is my interfaces both mlan0 and wwan0 are
connected, ConnMan is not able to turn off cellular when WiFi is
connected, how does the SingleConnectedTechnology=true work with iwd?

mlan0     Link encap:Ethernet  HWaddr D4:CA:6E:A4:E8:E0
          inet addr:192.168.0.101  Bcast:0.0.0.0  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:161 errors:0 dropped:0 overruns:0 frame:0
          TX packets:75 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:12561 (12.2 KiB)  TX bytes:39957 (39.0 KiB)

wwan0     Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-0
          inet addr:10.116.236.149  P-t-P:10.116.236.149  Mask:255.255.255.252
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:350 errors:0 dropped:0 overruns:0 frame:0
          TX packets:387 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:61823 (60.3 KiB)  TX bytes:72540 (70.8 KiB)

> Currently, you can't use EnableNetworkConfiguration=true together with
> ConnMan. This will not work.

That was the question I have asked for months about how to make
EnableNetworkConfiguration=false work with ConnMan. Sadly if I set up
EnableNetworkConfiguration=false, ConnMan was not able to set up WiFi
network, if you believe the ConnMan is able to work with iwd
EnableNetworkConfiguration=false, could you please elaborate how to
debug it, I'll try to figure it out?

Thank you very much.

Kind regards,

Jupiter

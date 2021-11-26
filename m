Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073CE68
	for <connman@lists.linux.dev>; Fri, 26 Nov 2021 21:50:22 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id n6so21195133uak.1
        for <connman@lists.linux.dev>; Fri, 26 Nov 2021 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NfPQ3jZlvCZvJaXjxEsr1pXTDIIXVHrR5Cz90s/Xos=;
        b=SnQGdGC252tq9FWs0vQQo0YKxZnx7s4SbDFTqSPy0uvonWnH8EKjzyDiU1lw2FK8dT
         SDWLHGJ3RoXL5v4JZ+QIqF2WpvyRAN+qOW5l6CP1ipXb3zCMXPxMKKZvw/b0wmG3DwBR
         2/XrY/7jYymgizvggE8r08mHkRaqUa77v+FTc9vPiZgCwPTRSXU2imdGeC8e0A0myahp
         /VVVmQOEQeOi0R7o+GpYtUjjPs3RGtxG6kw1RaB42WpeNTqM5NT1eLpDdG4qr/QyYhD/
         68bRnD8Z9ezr6c2PnbLIVsOetP3wiLWtXfny6zcC5y2HNqxAxTntLfHzX0AdDNa6Leqf
         Gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NfPQ3jZlvCZvJaXjxEsr1pXTDIIXVHrR5Cz90s/Xos=;
        b=fgdpwSwvTdDjF7qr01CB11u1mnXDcXccZAH0keEPvrtFpHN8YO3bVRMsDvIno2TJDE
         opDilbs1V+a5aVhqq3iPjgHcFdfVkoXn6HwIlQOK5v2AY0oWx1gUXS4L+q13yYtAVzYG
         DQkQJdqhXLpLEKe5xdkL3RRiQG8MiAU4XNMp6SlRHR9tGL9ewY/n7Iu59aTx/UCyuCEg
         N9eHD02lW3WYL+XR6sYymLy9th4ChDICSfyq/IRWEG/KC30qiQ2AoO8NsuZ8dBCIOEjo
         zP0k2oNu1xAXVy1m0el59uQdQF9K5TEoIemTdVDzH4o2k+xlYfBQBOpZj6CMJS8zNHci
         1gsw==
X-Gm-Message-State: AOAM532TyZMkw3zJeXMMW4AyyQudHmichnYoIVeyvl5lCBI/pArXzw2W
	MZfl6sDZowd3gO5inKVOHXzyXUA+JPmIa1c5o9/fhGQf
X-Google-Smtp-Source: ABdhPJy7811syDY/Wf2ST96MViud15k6bVlNIPKqZdBTnBnluPq8Mg9wMr+ti1jaiGTUPlcOOZqvUAt/1xILPdhUIjQ=
X-Received: by 2002:a05:6102:a46:: with SMTP id i6mr19974767vss.19.1637963421842;
 Fri, 26 Nov 2021 13:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon>
In-Reply-To: <20211126163040.ai2euhv6yf4esnhn@carbon>
From: Jupiter <jupiter.hce@gmail.com>
Date: Sat, 27 Nov 2021 08:49:45 +1100
Message-ID: <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
Subject: Re: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
To: Daniel Wagner <wagi@monom.org>
Cc: comman <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Greatly appreciate your kind response, please see my comments and
clarifications:

> Indeed, I recommend to use iwd instead of wpa_supplicant. There is no
> active development happening in ConnMan on the wpa_supplicant
> plugin. That means the wpa_supplicant plugin might work perfectly fine
> for your use case and there is no need to use iwd. But don't expect any
> big help if there are problems with wpa_supplicant.

Yes, I indeed have issues with 1.40 after upgrading to OE Honister,
the WiFi connection is broken, the connman 1.40 assigned a
169.154.0.0/16 range IP address, no DHCP message received:

connmand[9988]: DHCP index 3: switch listening mode (0 ==> 1)
connmand[9988]: DHCP index 3: sending DHCP discover request
connmand[9988]: DHCP index 3: sending DHCP discover request
connmand[9988]: DHCP index 3: sending DHCP discover request

No DHCP packet response received.

Please correct me, but I believe dhcp server is managed by connmand as
I found dhcp.c in the connman source, the dhcp issue is not related to
wpa-supplicant, right?

I am running CONNMAN_DHCP_DEBUG=1 connmand -n -d
src/dhcp.c:src/network.c, please let me know if you need more debug
messages.

> Hard to answer as there is not definition of 'stable enough'. The best
> advice is to test your use cases and figure out if it fits your
> requirements.

That is fine, I can see clearly the connman direction, I'll move to
using iwd for testing, I am still learning connman, not in the
position to contribute in development, but at least I can contribute
for testing and debugging :-).

> ./configure --disble-wifi --enable-iwd

I'll try it in Yocto build.

> There is no change in ConnMan's D-Bus APIs. Depending on your use cases
> you might be able to remove the ConnMan from your design and only use
> iwd. This is the case when you are only interested in WiFi networks. I
> know some project went this way as it makes their system simpler and
> more robust.

My IoT device is running both WiFi and 4G LTE network interfaces, I
definitely need connman to manage network switching between 4G LTE and
WiFi .

Thank you very much Daniel.

Kind regards,

- jupiter

Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF92C81
	for <connman@lists.linux.dev>; Mon, 29 Nov 2021 06:52:43 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id j1so10355168vkr.1
        for <connman@lists.linux.dev>; Sun, 28 Nov 2021 22:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr67qqo2EUa43+5HWa7M8b77MIs2OpiibDYwwVPVNQM=;
        b=msItRb4NZa5YDAUijuo7PQJSWp0RJJEcp03epVhIvt9e7QUOWcwmF9tYDfmuYf8CXB
         jOqn4JGNRpkB67rzRfcmbYxyRp5RqQdMSkKEFetnESD2BrmiF5r7kGQyWlPIs0SZfEPc
         G4QJr/PBpNif1bm8lWHDWGRPpD2m0wUVgB16ye+o9F/+MAWyaa1UYGgE+9zbTX5ciuEo
         mho/eN7zLsOyI9aucLi7Nuo9ET1N9uVJtrZSuGAKF9TIwDQfFOLl7pTJeMuFjExnAzll
         Es7oop6WM5NbFbIs0Ute+bhpBFnYRyxOQJX5odigJCcH8w53coPmkV/oIB3t7+httJkL
         vvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr67qqo2EUa43+5HWa7M8b77MIs2OpiibDYwwVPVNQM=;
        b=2UVryILz2KYsqyFjrTzFKh4y3dTV6AVMW18TNwDs0JiPPz/E4mVt6hVeG39dfaj4ub
         MKF2QVANI814O7z4MjgoiFuUFxbdj1OPULbwR69um5739PS3txCH7Gs23uNUAlF58OLE
         jt52AMeWOcm/pvKPftN4wm4wcDtBDWIXJESvE6esmPg/JFRhZ5ixXhXy/E7D7+XnKmoB
         0po+NZbhm0UeQH+VYbayFfrHIw+bLO2ApsEOcnPl1CCABbaPbvJLoVjOA5TBr7XmLZI0
         7eaNUXimaP9z3tlKU0Y9QI1xMrbevp9hvg94guyLi39sGqNkKH7hib8zKnFYVWSdcGI4
         qEBQ==
X-Gm-Message-State: AOAM530GYhwC/GbsBd7E+7kKPOLcmPSXu94a8+DelHB05/IMPqb8wOa3
	IAjxPjWb/s41SNKPWiUCJyHHj8w7V/Jrimx5nqMs644THTk=
X-Google-Smtp-Source: ABdhPJzkL4BtGKvzCmed6WHkavbaUsqfPOpVYUZhxmRqf7vOQ78CkwXS9JiQwj6yPxKYDzNRQFWWs1N/cONyCaxZpac=
X-Received: by 2002:a05:6122:218b:: with SMTP id j11mr34397204vkd.11.1638168762142;
 Sun, 28 Nov 2021 22:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon> <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
In-Reply-To: <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
From: Jupiter <jupiter.hce@gmail.com>
Date: Mon, 29 Nov 2021 17:52:06 +1100
Message-ID: <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
Subject: Re: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
To: Daniel Wagner <wagi@monom.org>
Cc: comman <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

I finally built and managed to run connman 1.40 with iwd, the
wpa_supplicant is disabled, but there is no WiFi IP address, who is
running DHCP, connman or iwd? Running  CONNMAN_DHCP_DEBUG=1 connmand
-n -d src/dhcp.c:src/network.c, it did not send DHCP discover
requests, something is broken or not configured properly.

Thank you.

- jupiter



On 11/27/21, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi Daniel,
>
> Greatly appreciate your kind response, please see my comments and
> clarifications:
>
>> Indeed, I recommend to use iwd instead of wpa_supplicant. There is no
>> active development happening in ConnMan on the wpa_supplicant
>> plugin. That means the wpa_supplicant plugin might work perfectly fine
>> for your use case and there is no need to use iwd. But don't expect any
>> big help if there are problems with wpa_supplicant.
>
> Yes, I indeed have issues with 1.40 after upgrading to OE Honister,
> the WiFi connection is broken, the connman 1.40 assigned a
> 169.154.0.0/16 range IP address, no DHCP message received:
>
> connmand[9988]: DHCP index 3: switch listening mode (0 ==> 1)
> connmand[9988]: DHCP index 3: sending DHCP discover request
> connmand[9988]: DHCP index 3: sending DHCP discover request
> connmand[9988]: DHCP index 3: sending DHCP discover request
>
> No DHCP packet response received.
>
> Please correct me, but I believe dhcp server is managed by connmand as
> I found dhcp.c in the connman source, the dhcp issue is not related to
> wpa-supplicant, right?
>
> I am running CONNMAN_DHCP_DEBUG=1 connmand -n -d
> src/dhcp.c:src/network.c, please let me know if you need more debug
> messages.
>
>> Hard to answer as there is not definition of 'stable enough'. The best
>> advice is to test your use cases and figure out if it fits your
>> requirements.
>
> That is fine, I can see clearly the connman direction, I'll move to
> using iwd for testing, I am still learning connman, not in the
> position to contribute in development, but at least I can contribute
> for testing and debugging :-).
>
>> ./configure --disble-wifi --enable-iwd
>
> I'll try it in Yocto build.
>
>> There is no change in ConnMan's D-Bus APIs. Depending on your use cases
>> you might be able to remove the ConnMan from your design and only use
>> iwd. This is the case when you are only interested in WiFi networks. I
>> know some project went this way as it makes their system simpler and
>> more robust.
>
> My IoT device is running both WiFi and 4G LTE network interfaces, I
> definitely need connman to manage network switching between 4G LTE and
> WiFi .
>
> Thank you very much Daniel.
>
> Kind regards,
>
> - jupiter
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs

Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080C184
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 01:08:30 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id d126so5140011vsd.13
        for <connman@lists.linux.dev>; Sat, 27 Aug 2022 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Tk8zMurTIilIa2TAay2MXafNNyCwXM497ai9BXP9mG4=;
        b=NWGunVXmLfGN7stnzH2EThrzNeI1fgcwCQcOxx6C3MTMZneoH5Qt+rjwCwXk/G92PS
         TFVb5IgHl0KxyvSU0OH5yc3SY76gMPts+g4pmE1IkB9xyUDb5djFPN3q+R0B+K8SPt6D
         lYHUQb1sdXNbNBiWkkfp1Vj7Ge2g1q5nSkvPLYGyoujMs2HYqRaBA6bAVCWe8bSowk4q
         OyaJSsxgWxOLdXK0eXAEa/9sKEIT17x/+jj+wfsCFJUky1uRv8ZreYuhJC2NouYEEsHI
         eivVr+b62YdSHx1xLNegxEJc6427OAAoj8/C4j5CJyQC1wSzNcYKBk3dPLvpKRukrawR
         WD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Tk8zMurTIilIa2TAay2MXafNNyCwXM497ai9BXP9mG4=;
        b=M8+13RoFPqg259MBVzHMUfDMReYkp5ekBAPpixGKlrmyi4fVeNQOwXfCdhaSug7Pvs
         FnqG6hxWOdG4lOHop9TLvBkeL15GAlb2o0T8VhMyZN1btZUYyZhAfiO17zLXQIdK5ui4
         e3J4SJHl5hoAnF4hz8rFDTonekJiNVZzzZ2uDUVL3T5Lo1CdUelfJOyyCpOQknPoDybP
         fQQf13FZBCDEDBF+tEaxRkMOqjadtGbcy7AVszv32MDt7ezAKWNAv5sB8Tz0WXcYXfOR
         GZbbbAQkeqfXznKODDkYV1faeKHptb1ES8XoxQSm1tfkuViITVl4bpWTkRYFTBSMuHIF
         kGZw==
X-Gm-Message-State: ACgBeo0YO1ZUKKNy0Gh0RJ81gmI5SC2qkt2xrS80FVdGUF3XFM4mdrqh
	HNsL0wvWUhaqLoryBxBoYtX2i3HHQPBAOhEsbxnh4pRMTK5z2w==
X-Google-Smtp-Source: AA6agR6ktM1B6eL1mEoBT2mroUz7z4+hNxqNtnseuC0Yxb3wEU/J1rKcURpo/gpPh50dwAsvysEWqDZfOBQ7anB4vM4=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr797896vsi.85.1661648909824; Sat, 27 Aug
 2022 18:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Quen Jankosky <quen.jankosky@gmail.com>
Date: Sun, 28 Aug 2022 01:08:19 +0000
Message-ID: <CAFT6v_b-nE0TkTRDNcEPgb6wDue0NAwWPBEDevVfA=VBDD-rqg@mail.gmail.com>
Subject: Default Routing Issues, And Potential Solution
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greetings.

I'll preface this by saying that I'm not entirely knowledgeable in
networking, low level routing rules in linux by using `ip` or other
utilities of that nature, and I may be completely wrong about all of
this. However, connman is one of my favorite pieces of software and I
would like to help improve it.

I also know that connman is designed for embedded devices and is meant
to be simple, and possibly only handle about one connection to a
service at a time. However, connman obviously supports multiple
connections to multiple services and this should be addressed.

* * * The Problem * * *

To begin my main issue here, I've discovered that what `default` route
gets set in the `ip route` table by connman is mostly arbitrary.
Whether there is some sort of setting for this, I have not been able
to find, and have only seen a single post relating to this same issue.
This has resulted me in having a lot of headaches trying to use more
than two services at once and having a valid internet connection. Let
me show you two different routing tables, each on both of my two
devices connected directly using an ethernet cable with manual network
parameters, and each separately connected to one WiFi network using
DHCP. It should be obvious which subnet each interface is on, but the
two subnets I'm showing here are `10.0.0.0/24` and `192.168.0.0/24`,
one for the non-routed ethernet connection and the other for the
internet routed WiFi connection respectively:

Foo:
-----
0.0.0.0 dev enp4s0 scope link
default dev enp4s0 scope link
10.0.0.0/24 dev enp4s0 proto kernel scope link src 10.0.0.2
192.168.0.0/24 dev wlp5s0 proto kernel scope link src 192.168.0.127
192.168.0.1 dev wlp5s0 scope link
-----

Bar:
-----
0.0.0.0 dev eth0 scope link
default via 192.168.0.1 dev wlan0
10.0.0.0/24 dev eth0 proto kernel scope link src 10.0.0.1
192.168.0.0/24 dev wlan0 proto kernel scope link src 192.168.0.129
192.168.0.1 dev wlan0 scope link
-----

... As you can see, on Bar, I have no trouble accessing the internet
being which is being routed on `192.168.0.1`. However, on Foo, I am
unable to access the internet from my WiFi network despite both of
these devices using connman and similar configuration settings; it's
arbitrary. This is extremely frustrating, since it forces me to need
to disconnect my direct copper connection between my two devices in
order to have any access to the internet on Foo, or disable the
connmand service altogether and manually configure my network (not
ideal for portable devices!). Even if I manually change the default
route to the correct one, connman changes it back after a few seconds.
I feel this is problematic and needs some kind of solution.

* * * What I Propose * * *

I'm not exactly great at this kind of thing, but I feel like the
following idea is sensible and backward compatible with other
configurations.

There will be an additional configuration value for IP services, let's
call it `DefaultRoutePrec`. This value is meant to have an integer
number from 0 to 255, and defaults to 255 internally within connman
when not set in a configuration block for a service. When connecting
to a service or an existing value gets changed, connman will compare
this value to other services that are connected (if others are
connected at all). Connman will choose which of these services will
have the default route (for their respective interface) by using the
service with the smallest `DefaultRoutePrec` value, 0 being most
preferred and 255 being least preferred. If the `DefaultRoutePrec`
value is the same as the currently preferred service, it's disregarded
and it does not change the default routing rule and sends a warning
message in the logs about it. In order to modify it in `connmanctl`,
there could be another `config` argument called `defrouteprec`, and a
valid command would look something like: `config service_name
defrouteprec value`.

This is most likely not a great solution, but here's some reasons why
I think this wouldn't be a terrible thing to implement:

1. Other software has precedence and preference rules similar to this,
like the `getaddrinfo` call.

2. You can have multiple layers of precedence rules by provisioning
the preference values for any applicable services, specifically it
would be useful for portable devices with WiFi or devices that have
their interfaces hotplugged or flapped often. 256 values should be
granular enough for this, but this obviously can be any maximum value
that would be fit for this purpose.

3. This is a fairly simple thing to implement since it's effectively
just checking a number versus some other numbers, instead of doing
something like having a global array of the order of precedence for
the services that has to be changed and updated. The latter would
offer more flexibility and pretty much no upper bound to precedence,
but the solution I'm suggesting is probably more optimal for embedded
devices.

4. Existing configurations would be compatible via the defaulting
value of `DefaultRoutePref`, and it wouldn't behave much differently
than how connman does now.

* * * Conclusion * * *

I think by implementing this or any kind of precedence methodology for
the default route, it would make connman a lot more functional and
allow it to be used in more cases versus other network management
daemons. I love connman a lot and I want to see it as functional as
possible, its my favorite network management daemon to work with and I
want it to have fewer problems.

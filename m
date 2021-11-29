Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2868
	for <connman@lists.linux.dev>; Mon, 29 Nov 2021 21:07:06 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id l24so37026738uak.2
        for <connman@lists.linux.dev>; Mon, 29 Nov 2021 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfwaNIS5GFQvIeStJuVKvTTAmqD4TCZxvQ5PXWEZJD4=;
        b=mgY151cLpc5EjL8D8FIxhxmlDHmFxkPKHYwXJF6EoAJtNVYQWEYSqbM47FwYgyArY0
         QPbf8bdaxkbxzLe8T1OPK30HjYwE9bXXITm5v0sIWjftvhxF4y42YYY3/IKbdNKG7Chr
         HAShYNlRn6LTWngPXfa44uG0ofjJHgo27v2cAHTLnhem6wR/sXb7xAjKN+IQxhx0gIvc
         ruxQaFmZ+NbqDSZa81AS0qzkW2WJTTdQ+9PRcXJ03AatNuMrQPxntClpHNu8MQYIw/G2
         ewy+REdxh4bnzan0Kd99Xj56yftaKsBdC+QizFqPe1qFEbIIk8F5zjbZP6ovxdrm0r9S
         sw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfwaNIS5GFQvIeStJuVKvTTAmqD4TCZxvQ5PXWEZJD4=;
        b=mP25xBIOYc5UWbQE5OYfoEN+rmOLKGjfEcX1t000uENcYnBZvfu3OJjZ21CMv/2668
         u3054LIxDAXMEfH0rRc1WZwh4yH4KrL34zMb+u/XUZW71tUvnbrScUnm10V1Fsb0mtPz
         l/CbzihGcPQJX2T5omg21muBlRPRRxP8dr2I58BK8oCXXvcRCiu6dk1e9fEeqdmcBAsT
         43toWoRewO/NZAZwqCsaDHbo4Jt1rj97IIDTL22fUfRQaTXw54U9C7KSOAobgaaz553M
         iC8bnUT7YJ4OIRwQji8dHgCbo/96UXgjmyUV1t/7QtSr2w+lzV8iNMuDSAW4DqfmRAFT
         GN5g==
X-Gm-Message-State: AOAM533pMjSt2dq5kZVY6TzbW9BWi0HBFM55MDwFzXt5RB02iahUqOp7
	Yu8DSnxK1p5s3GmkOwlV12uw3rUpNiXeVXs9+SQMu38GWjE=
X-Google-Smtp-Source: ABdhPJxz7B92rZEqggZBLak95mt52IlgdKTsSzFwYDnyUgW44TttlmaKgU7idXfnopCCjMfzIq+xHqe8337LooJvQoc=
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr36861693vst.37.1638220025065;
 Mon, 29 Nov 2021 13:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon> <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com> <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Jupiter <jupiter.hce@gmail.com>
Date: Tue, 30 Nov 2021 08:06:29 +1100
Message-ID: <CAA=hcWS5eXKLMUrTC=MTKUOERiR7eT_J+WdeJL=k8y=i-T40CA@mail.gmail.com>
Subject: Re: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: comman <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Emmanuel,

Thanks for your advice.

> Have you checked that your IP configuration method is hdcp?

When I built connman 1.37 with wpa_supplicant on Zeus, it managed both
WiFi and 4G LTE network interfaces well. I did not configure anything
for DHCP, I did not even find DHCP package and running dhcpd service,
I thought that wpa_supplicant managed DHCP server and connman managed
DHCP client, is it correct? I only had DHCP issues when I upgraded to
Honister connman 1.40.

Could you please elaborate how the DHCP works in connman with iwd and
how to configure DHCP?

> Maybe checking the services list will give a clue:
> dbus-send --system --print-reply --dest=net.connman /
> net.connman.Manager.GetServices

The dbus is indeed broken, any clues how to debug it further?

# dbus-send --system --print-reply --dest=net.connman / net.connman.
Manager.GetServices
method return time=1628090207.390874 sender=:1.3 -> destination=:1.39 serial=522
   array [
   ]

> I have started the migration to iwd, which required some fixes, and I have
> still
> not reached the same behavior as with wpa_supplicant (but I am close).
> Unfortunately, I had no more time to spend on this activity, but I hope
> giving
> a new try before Christmas.
>
> To integrate iwd on yocto (hardknott), in connman recipe, we are using this
> line:
> PACKAGECONFIG[iwd] = "--enable-iwd --enable-wifi, --disable-iwd, iwd, iwd"
> And to activate it via the local.conf
> PACKAGECONFIG_remove_pn-connman = "wifi"
> PACKAGECONFIG_append_pn-connman = " iwd"

Thanks for tips, I added those and rebuilt them, but it does not make
any difference. here are more debug logs:

# systemctl status connman -l
* connman.service - Connection service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/connman.service/lib/systemd/system/connman.service8;;;
enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-08-04 15:11:21 UTC; 7min ago
   Main PID: 203 (connmand)
     CGroup: /system.slice/connman.service
             `-203 /usr/sbin/connmand -n

Aug 04 15:11:31 solar connmand[203]: wwan0 {create} index 5 type 1 <ETHER>
Aug 04 15:11:31 solar connmand[203]: wwan0 {update} flags 4098 <DOWN>
Aug 04 15:11:31 solar connmand[203]: wwan0 {newlink} index 5 address
52:20:05:11:99:CB mtu 1500
Aug 04 15:11:31 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>
Aug 04 15:11:31 solar connmand[203]: Adding interface wwan0 [ cellular ]
Aug 04 15:11:33 solar connmand[203]: wwan0 {newlink} index 5 address
5E:9C:83:62:CB:D4 mtu 1500
Aug 04 15:11:33 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>
Aug 04 15:11:37 solar connmand[203]: wwan0 {update} flags 4240 <DOWN>
Aug 04 15:11:37 solar connmand[203]: wwan0 {newlink} index 5 address
00:00:00:00:00:00 mtu 1500
Aug 04 15:11:37 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>

# systemctl status iwd -l
* iwd.service - Wireless service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/iwd.service/lib/systemd/system/iwd.service8;;;
enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-08-04 15:11:22 UTC; 7min ago
   Main PID: 206 (iwd)
     CGroup: /system.slice/iwd.service
             `-206 /usr/libexec/iwd

Aug 04 15:11:24 solar iwd[206]:                         48.0 Mbps
Aug 04 15:11:24 solar iwd[206]:                         54.0 Mbps
Aug 04 15:11:24 solar iwd[206]:                 HT Capabilities:
Aug 04 15:11:24 solar iwd[206]:                         HT20
Aug 04 15:11:24 solar iwd[206]:                         Short GI for 20Mhz
Aug 04 15:11:24 solar iwd[206]:                 HT RX MCS indexes:
Aug 04 15:11:24 solar iwd[206]:                         0-7
Aug 04 15:11:24 solar iwd[206]:                         32
Aug 04 15:11:24 solar iwd[206]:         Ciphers: CCMP TKIP BIP
Aug 04 15:11:24 solar iwd[206]:         Supported iftypes: station ap
p2p-client p2p-go

#  CONNMAN_DHCP_DEBUG=1 connmand -n -d src/dhcp.c:src/network.c
connmand[3865]: Connection Manager version 1.40
connmand[3865]: Adding configuration wifi
connmand[3865]: Adding configuration cellular
connmand[3865]: Ignore group named 'global' because prefix is not 'service_'
connmand[3865]: Adding service configuration cellular
connmand[3865]: Checking loopback interface settings
connmand[3865]: System hostname is solar
connmand[3865]: lo {newlink} index 1 address 00:00:00:00:00:00 mtu 65536
connmand[3865]: lo {newlink} index 1 operstate 0 <UNKNOWN>
connmand[3865]: sit0 {newlink} index 2 address 00:00:00:00:08:00 mtu 1480
connmand[3865]: sit0 {newlink} index 2 operstate 2 <DOWN>
connmand[3865]: wlan0 {create} index 4 type 1 <ETHER>
connmand[3865]: wlan0 {update} flags 4099 <UP>
connmand[3865]: wlan0 {newlink} index 4 address D4:CA:6E:A4:E8:B4 mtu 1500
connmand[3865]: wlan0 {newlink} index 4 operstate 2 <DOWN>
connmand[3865]: Adding interface wlan0 [ wifi ]
connmand[3865]: wwan0 {create} index 5 type 65534 <NONE>
connmand[3865]: wwan0 {update} flags 4240 <DOWN>
connmand[3865]: wwan0 {newlink} index 5 address 00:00:00:00:00:00 mtu 1500
connmand[3865]: wwan0 {newlink} index 5 operstate 2 <DOWN>

# journalctl -xeu connman.service
-- Journal begins at Wed 2021-08-04 15:10:56 UTC, ends at Wed
2021-08-04 15:30:41 UTC. --
Aug 04 15:11:18 solar systemd[1]: Starting Connection service...
Aug 04 15:11:21 solar systemd[1]: Started Connection service.
Aug 04 15:11:21 solar connmand[203]: Connection Manager version 1.40
Aug 04 15:11:22 solar connmand[203]: Adding configuration wifi
Aug 04 15:11:22 solar connmand[203]: Adding configuration cellular
Aug 04 15:11:22 solar connmand[203]: Ignore group named 'global'
because prefix is not 'service_'
Aug 04 15:11:22 solar connmand[203]: Adding service configuration cellular
Aug 04 15:11:22 solar connmand[203]: Checking loopback interface settings
Aug 04 15:11:22 solar connmand[203]: System hostname is solar
Aug 04 15:11:23 solar connmand[203]: lo {newlink} index 1 address
00:00:00:00:00:00 mtu 65536
Aug 04 15:11:23 solar connmand[203]: lo {newlink} index 1 operstate 0 <UNKNOWN>
Aug 04 15:11:23 solar connmand[203]: sit0 {newlink} index 2 address
00:00:00:00:08:00 mtu 1480
Aug 04 15:11:23 solar connmand[203]: sit0 {newlink} index 2 operstate 2 <DOWN>
Aug 04 15:11:23 solar connmand[203]: mlan0 {create} index 3 type 1 <ETHER>
Aug 04 15:11:23 solar connmand[203]: mlan0 {update} flags 4098 <DOWN>
Aug 04 15:11:23 solar connmand[203]: mlan0 {newlink} index 3 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:11:23 solar connmand[203]: mlan0 {newlink} index 3 operstate 2 <DOWN>
Aug 04 15:11:23 solar connmand[203]: Adding interface mlan0 [ wifi ]
Aug 04 15:11:24 solar connmand[203]: mlan0 {dellink} index 3 operstate 2 <DOWN>
Aug 04 15:11:24 solar connmand[203]: (null) {remove} index 3
Aug 04 15:11:24 solar connmand[203]: Remove interface (null) [ wifi ]
Aug 04 15:11:25 solar connmand[203]: wlan0 {create} index 4 type 1 <ETHER>
Aug 04 15:11:25 solar connmand[203]: wlan0 {update} flags 4098 <DOWN>
Aug 04 15:11:25 solar connmand[203]: wlan0 {newlink} index 4 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:11:25 solar connmand[203]: wlan0 {newlink} index 4 operstate 2 <DOWN>
Aug 04 15:11:25 solar connmand[203]: Adding interface wlan0 [ wifi ]
Aug 04 15:11:25 solar connmand[203]: wlan0 {update} flags 4163 <UP,RUNNING>
Aug 04 15:11:25 solar connmand[203]: wlan0 {newlink} index 4 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:11:25 solar connmand[203]: wlan0 {newlink} index 4 operstate
0 <UNKNOWN>
Aug 04 15:11:26 solar connmand[203]: wlan0 {newlink} index 4 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:11:26 solar connmand[203]: wlan0 {newlink} index 4 operstate
0 <UNKNOWN>
Aug 04 15:11:26 solar connmand[203]: wlan0 {update} flags 4099 <UP>
Aug 04 15:11:26 solar connmand[203]: wlan0 {newlink} index 4 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:11:26 solar connmand[203]: wlan0 {newlink} index 4 operstate 2 <DOWN>
Aug 04 15:11:31 solar connmand[203]: wwan0 {create} index 5 type 1 <ETHER>
Aug 04 15:11:31 solar connmand[203]: wwan0 {update} flags 4098 <DOWN>
Aug 04 15:11:31 solar connmand[203]: wwan0 {newlink} index 5 address
52:20:05:11:99:CB mtu 1500
Aug 04 15:11:31 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>
Aug 04 15:11:31 solar connmand[203]: Adding interface wwan0 [ cellular ]
Aug 04 15:11:33 solar connmand[203]: wwan0 {newlink} index 5 address
5E:9C:83:62:CB:D4 mtu 1500
Aug 04 15:11:33 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>
Aug 04 15:11:37 solar connmand[203]: wwan0 {update} flags 4240 <DOWN>
Aug 04 15:11:37 solar connmand[203]: wwan0 {newlink} index 5 address
00:00:00:00:00:00 mtu 1500
Aug 04 15:11:37 solar connmand[203]: wwan0 {newlink} index 5 operstate 2 <DOWN>
Aug 04 15:24:07 solar connmand[203]: Terminating
Aug 04 15:24:07 solar systemd[1]: Stopping Connection service...
Aug 04 15:24:07 solar connmand[203]: Remove interface wlan0 [ wifi ]
Aug 04 15:24:07 solar connmand[203]: Remove interface wwan0 [ cellular ]
Aug 04 15:24:07 solar connmand[203]: Removing configuration wifi
Aug 04 15:24:07 solar connmand[203]: Removing configuration cellular
Aug 04 15:24:07 solar connmand[203]: wlan0 {remove} index 4
Aug 04 15:24:07 solar connmand[203]: wwan0 {remove} index 5
Aug 04 15:24:07 solar connmand[203]: Exit
Aug 04 15:24:07 solar systemd[1]: connman.service: Deactivated successfully.
Aug 04 15:24:07 solar systemd[1]: Stopped Connection service.
Aug 04 15:30:39 solar systemd[1]: Starting Connection service...
Aug 04 15:30:39 solar systemd[1]: Started Connection service.
Aug 04 15:30:39 solar connmand[4713]: Connection Manager version 1.40
Aug 04 15:30:39 solar connmand[4713]: Adding configuration wifi
Aug 04 15:30:39 solar connmand[4713]: Adding configuration cellular
Aug 04 15:30:39 solar connmand[4713]: Ignore group named 'global'
because prefix is not 'service_'
Aug 04 15:30:39 solar connmand[4713]: Adding service configuration cellular
Aug 04 15:30:39 solar connmand[4713]: Checking loopback interface settings
Aug 04 15:30:39 solar connmand[4713]: System hostname is solar
Aug 04 15:30:39 solar connmand[4713]: lo {newlink} index 1 address
00:00:00:00:00:00 mtu 65536
Aug 04 15:30:40 solar connmand[4713]: lo {newlink} index 1 operstate 0 <UNKNOWN>
Aug 04 15:30:40 solar connmand[4713]: sit0 {newlink} index 2 address
00:00:00:00:08:00 mtu 1480
Aug 04 15:30:40 solar connmand[4713]: sit0 {newlink} index 2 operstate 2 <DOWN>
Aug 04 15:30:40 solar connmand[4713]: wlan0 {create} index 4 type 1 <ETHER>
Aug 04 15:30:40 solar connmand[4713]: wlan0 {update} flags 4099 <UP>
Aug 04 15:30:40 solar connmand[4713]: wlan0 {newlink} index 4 address
D4:CA:6E:A4:E8:B4 mtu 1500
Aug 04 15:30:40 solar connmand[4713]: wlan0 {newlink} index 4 operstate 2 <DOWN>
Aug 04 15:30:40 solar connmand[4713]: Adding interface wlan0 [ wifi ]
Aug 04 15:30:40 solar connmand[4713]: wwan0 {create} index 5 type 65534 <NONE>
Aug 04 15:30:40 solar connmand[4713]: wwan0 {update} flags 4240 <DOWN>
Aug 04 15:30:40 solar connmand[4713]: wwan0 {newlink} index 5 address
00:00:00:00:00:00 mtu 1500
Aug 04 15:30:40 solar connmand[4713]: wwan0 {newlink} index 5 operstate 2 <DOWN>


connman should send dhcp requests repeatedly, that seems another issue.

~# ip route show

# ifconfig
wlan0     Link encap:Ethernet  HWaddr D4:CA:6E:A4:E8:B4
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)


Thank you very much Emmanuel.

Kind regards,

- jupiter

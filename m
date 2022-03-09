Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECF7B
	for <connman@lists.linux.dev>; Wed,  9 Mar 2022 15:39:51 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso2013666otp.4
        for <connman@lists.linux.dev>; Wed, 09 Mar 2022 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hdw9z73iDchQZlGnhUIBh+D1tKiK4b8HUtIU4AcJwV4=;
        b=Qv6s3OiJax5TqJhgA4Oi6xeM5Org+O1s85RXyaExWuziBfm37TnbstYBGh0RV8F89x
         jTCL25OPVN+Kcwo/R23Gx2oIo9quPMtyUWx/tTUYjflwWadNeDk7alP8BELB+BOATQMT
         CZvrA+IcXLnfnbcj1GOtqKLpq6LW68WTEyO8MS24RgEWyVVgQF4Mwb6VPLnYsvmeXpPX
         fpnrFkYv0jc1ixxLoQCY8gMfEuBydNTckkXIdT7h7ded0BPC9atjEo4DM8UAsUGDu58H
         1tstV8LSFWNTkqkkBo0tKiw8VdHs8UXFhc9QTlttcM/zPA9KwC9OBwQqfw52bVIQked1
         ElpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hdw9z73iDchQZlGnhUIBh+D1tKiK4b8HUtIU4AcJwV4=;
        b=o5Tagez1MCooH1wwIDDFWhV26utTOs9N75rmOLvxD75MG40fqIOGu+n0kj8fss1wZe
         O1yx2aI1zqPi/hBbcnqJAOR6jPvrBAXyZU+s79wAUkJJBjrSec0o1th+gtT8PSM1kFwX
         FHqYCgzva4J1QMrI7dYLBz+GvAgL76cYNb3ssa/+Z8rsp0rL4IkPPf17jhbQ2EN6IG9/
         QCMT0B/Het0qSHBo8/ER+9yFzb3W09GRvbmwwB5u1rONXSbe3qWciTdws1pCUplO5pJw
         iz76XC1IzXaGnSeQcVyZTSbUnHG6bDhBR2Q9ir1FfGrxGXGzD8PVZV6fikmQMDryr+ML
         b2Vw==
X-Gm-Message-State: AOAM531sHxEGkJo4nlgux2kdNdpWwxO6sLvKTS12METiVwsSAt6i6q7y
	gnABOR/jnnZ9j0yoWjO244fv2jJbhbXP5hadEWgLNlpCTgk=
X-Google-Smtp-Source: ABdhPJzpV0yYM8dtqDm+OEr0tKCWAxFbcDxhlvjbinDkAGoJkkYHJQWWcfkitGspkVHKX8vtvJaEFzz3w/Wm2mo+Nzc=
X-Received: by 2002:a05:6830:1f49:b0:5b2:5c16:3dd1 with SMTP id
 u9-20020a0568301f4900b005b25c163dd1mr151051oth.207.1646840390636; Wed, 09 Mar
 2022 07:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220307090321.27204-1-wagi@monom.org> <CAG17S_MqNzp1n8qHmWkLS918uSUYdEqWS-CHrHMg6uC0Xr-auw@mail.gmail.com>
 <20220309074838.jbshxixcues4bqxx@carbon.lan> <CAG17S_NonoANXzrvAcgUpPbUKx4qXwFb2m3Dx2T3=_8_V1En_A@mail.gmail.com>
 <20220309124408.clmtdktitls52wcp@carbon.lan>
In-Reply-To: <20220309124408.clmtdktitls52wcp@carbon.lan>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 9 Mar 2022 09:39:39 -0600
Message-ID: <CAG17S_MyFW=BCBiVxj-oX85R8tGWgRPNq5_JhMa=1vpx_j9BBg@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add scan support in access point mode
To: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Daniel,

I tried it again but with the plugin logging and get the same result.
iwctl will scan and show the networks but connmanctl does not. When I
tell connmanctl to scan, it takes a long time to return the prompt.

This is the log
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
org.freedesktop.DBus.ObjectManager /
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.Daemon /net/connman/iwd
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.AgentManager /net/connman/iwd
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.p2p.ServiceManager /net/connman/iwd
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.Adapter /net/connman/iwd/0
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:create_adapter()
/net/connman/iwd/0 vendor 'Broadcom Corp.' model 'BCM43438 combo WLAN
and Bluetooth Low Energy (BLE)' powered 1 ad-hoc 1 station 1 ap 1
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.Device /net/connman/iwd/0/3
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:create_device()
adapter /net/connman/iwd/0 name wlan0 address b8:27:eb:xx:xx:xx
powered 1 mode station
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.Station /net/connman/iwd/0/3
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:create_station()
state 'disconnected' connected_network (null) scanning 0
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.SimpleConfiguration /net/connman/iwd/0/3
Mar 09 09:01:18 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.DeviceProvisioning /net/connman/iwd/0/3
Mar 09 09:01:18 rune64 connmand[417]: wlan0 {update} flags 4099 <UP>
Mar 09 09:01:18 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:XX:XX:XX mtu 1500
Mar 09 09:01:18 rune64 connmand[417]: wlan0 {newlink} index 3 operstate 2 <DOWN>
Mar 09 09:01:18 rune64 connmand[417]:
plugins/iwd.c:station_property_change() /net/connman/iwd/0/3 scanning
1
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {update} flags 4098 <DOWN>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:XX:XX:XX mtu 1500
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 operstate 2 <DOWN>
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:object_removed()
net.connman.iwd.Station /net/connman/iwd/0/3
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:object_removed()
net.connman.iwd.SimpleConfiguration /net/connman/iwd/0/3
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:object_removed()
net.connman.iwd.DeviceProvisioning /net/connman/iwd/0/3
Mar 09 09:01:19 rune64 connmand[417]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 0
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.AccessPoint /net/connman/iwd/0/3
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:create_ap() started 0
Mar 09 09:01:19 rune64 connmand[417]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 1
Mar 09 09:01:19 rune64 connmand[417]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 mode ap
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {update} flags 4099 <UP>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:XX:XX:XX mtu 1500
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 operstate 2 <DOWN>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {add} address
192.168.5.1/24 label wlan0 family 2
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {add} route 192.168.5.0 gw
0.0.0.0 scope 253 <LINK>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {update} flags 69635 <UP,LOWER_UP>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:52:CC:D0 mtu 1500
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3
operstate 5 <DORMANT>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {RX} 0 packets 0 bytes
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {TX} 1 packets 66 bytes
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {update} flags 69699
<UP,RUNNING,LOWER_UP>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:XX:XX:XX mtu 1500
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 operstate 6 <UP>
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {RX} 0 packets 0 bytes
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {TX} 1 packets 66 bytes
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 address
B8:27:EB:XX:XX:XX mtu 1500
Mar 09 09:01:19 rune64 connmand[417]: wlan0 {newlink} index 3 operstate 6 <UP>
Mar 09 09:01:19 rune64 connmand[417]: plugins/iwd.c:object_added()
net.connman.iwd.AccessPointDiagnostic /net/connman/iwd/0/3
Mar 09 09:01:19 rune64 connmand[417]:
plugins/iwd.c:ap_property_change() /net/connman/iwd/0/3 started 1

The dbus config is the one that is part of the connman package from Arch Linux.

# cat /etc/dbus-1/system.d/connman-dbus.conf
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
    <policy user="root">
        <allow own="net.connman"/>
        <allow send_destination="net.connman"/>
        <allow send_interface="net.connman.Agent"/>
        <allow send_interface="net.connman.Counter"/>
        <allow send_interface="net.connman.Notification"/>
    </policy>
    <policy at_console="true">
        <allow send_destination="net.connman"/>
    </policy>
    <policy context="default">
        <deny send_destination="net.connman"/>
    </policy>
</busconfig>
# connmanctl scan wifi
Error /net/connman/technology/wifi: Did not receive a reply. Possible
causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.
# connmanctl services
*AO Wired                ethernet_b827eb079985_cable
# connmanctl technologies
/net/connman/technology/ethernet
  Name = Wired
  Type = ethernet
  Powered = True
  Connected = True
  Tethering = False
  TetheringFreq = 2412
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 2412

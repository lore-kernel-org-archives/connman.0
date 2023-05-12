Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3F39D
	for <connman@lists.linux.dev>; Fri, 12 May 2023 00:35:13 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5304d0d1eddso1921983a12.2
        for <connman@lists.linux.dev>; Thu, 11 May 2023 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683851712; x=1686443712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fTC/OehLmNzBg6bRyvp3SjRKw7h0jnvKxwfKxgDd1Y=;
        b=j4tEcFTFrqK9N/PaUbyBdPnWegOj1WcBh2S9Ni0ICykEIgvow8AW2TiF4i7ackQFEX
         dFLkBqdBNkjjm81aN6hc7vvRQlRsPrRT5sc9lXAU3TZHq/5gJKJsp462fpQlmPp8pF8O
         YZh7ogTFrHsB86deVS9B8c/ZWcYarpEdfUtSdbpmNd37Cru8c7+LVXuPCmZMRwIX5A1B
         gZf5mqMLsYeLlWb88RWztce8tBrbW/FPIsRn0JONVgq7URVVKLcO9j2rkXFk0Nfa33cG
         qVOu3VtPSuTPtLR6JNATUFIkOsF+dJRoA5R9i22Xcy4WGryrfVq6Mggesi+J22VjbUMF
         dnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683851712; x=1686443712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fTC/OehLmNzBg6bRyvp3SjRKw7h0jnvKxwfKxgDd1Y=;
        b=HlR347gHiQaJHFLnzh2XmY428tZzBxB3SdasxPiDR6B2uW6++Su0fgf6bz+XE2HiGU
         gg7gSS6wLDjkWOVsW4/Gnr5NpiHPUzuUtpZSFCHW8xxh14t5g83GEDZNIAQdbEIhYEco
         dwmx0bIp9UqQZX0sK2mor4G7bMZk+tJOR54dhu0/tAhnp7sZmFTpNIihtj8xCiXVwcX4
         rPEKMIrRguIOIAlf/vE2wL6libw8wP0l2RgQSmXLTdX3bJgNcke5jThysUYHEa7kr3w6
         t05gKMXV344cjTj45KqnTsPcQuREji6DpD2bvnXCHPMO1fpdwYhCJ7ONPkmUeNftYmws
         fY/w==
X-Gm-Message-State: AC+VfDyGRlRVsvE77TV7EE6t2aUnY25hLjci9V5jiGFZ5m1IG2WEGhx/
	mL6P6v204qaWINLTuY7Vqm/xI5ZQfbqgQVI3NBS1V7HpvSEnNA==
X-Google-Smtp-Source: ACHHUZ6gor6pGqlRrkpIm7RrMnkzmu6WNBKYu5N7L6w5AOKbGFL9YOP0NKUgxb0Fd37OPzyfVe0Z3khlPCw5vSbUN08=
X-Received: by 2002:a05:6a20:429c:b0:102:4597:de69 with SMTP id
 o28-20020a056a20429c00b001024597de69mr10344184pzj.30.1683851712574; Thu, 11
 May 2023 17:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230116081624.12618-1-wagi@monom.org> <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
 <CAG17S_NzXYUOPkF1h0e056=jCBQaP3nUh2t0y0n9R5nzhe9yYA@mail.gmail.com> <20230227074314.pys65eppvaus2wbs@carbon.lan>
In-Reply-To: <20230227074314.pys65eppvaus2wbs@carbon.lan>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 11 May 2023 19:35:01 -0500
Message-ID: <CAG17S_OFx6vU9ubpyDO06N49jBMQVqb20L+tzx0gNs7eWaLv2g@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add support to Scan in AP mode
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 1:43=E2=80=AFAM Daniel Wagner <wagi@monom.org> wrot=
e:
>
> Hi KeithG
>
> On Tue, Feb 14, 2023 at 12:55:37PM -0600, KeithG wrote:
>  > ~# iwctl device list
> > >                                     Devices
> > > ---------------------------------------------------------------------=
-----------
> > >   Name                  Address               Powered     Adapter    =
 Mode
> > > ---------------------------------------------------------------------=
-----------
> > >   wlan0                 b8:27:eb:a4:6e:0f     on          phy0       =
 ap
> > >
> > > ~# iwctl ap wlan0 scan
> > > ~# iwctl ap wlan0 get-networks
> > >                                     Networks
> > > ---------------------------------------------------------------------=
-----------
> > >             Property              Value
> > > ---------------------------------------------------------------------=
-----------
> > >             Name                  spg4
> > >             SignalStrength        -4400
> > >             Type                  psk
> > >
> > >             Name                  ATTcVY9ZWa
> > >             SignalStrength        -5100
> > >             Type                  psk
> > >
> > >             Name                  ATT3zFM5gH
> > >             SignalStrength        -5900
> > >             Type                  psk
> > >
> > >             Name                  2WIRE811
> > >             SignalStrength        -6900
> > >             Type                  psk
> > >
> > >             Name                  ATTU8Z3d7i
> > >             SignalStrength        -8400
> > >             Type                  psk
> > >
> > > So I am in AP mode and I am connected via WiFi to it.
> > >
> > > In connman, though, I do not get any wifi SSIDS:
> > >
> > > ~# connmanctl services
> > > *AO Wired                ethernet_b827ebf13b5a_cable
> > > ~# connmanctl enable wifi
> > > wifi is already enabled
> > > ~# connmanctl scan wifi
> > > Error /net/connman/technology/wifi: Did not receive a reply. Possible
> > > causes include: the remote application did not send a reply, the
> > > message bus security policy blocked the reply, the reply timeout
> > > expired, or the network connection was broken.
>
> This means the connmanctl tool didnt' receive any response. Do you have t=
he logs
> from the iwd plugins by any chance (connmand -d plugins/iwd.c).
>
> > > Is this how it might work? This is how we do it when we use hostapd t=
o
> > > connect instead of iwd.
>
> It looks like the plugin is still using the wrong API and either iwd does=
n't
> respond or the iwd plugin doesn't handle the error case correctly.
>
> > Is this still something that could be done? I can build and test any
> > patches pretty quickly (except for next week).
>
> I am not that fast sorry :)
>
Daniel,

I am finally back at this again. I appreciate your help with this.
I have applied your patch to connman and am running iwd 2.4. I enabled
the logging of the iwd plugin:
connmand -n -d plugins/iwd.c
I get the same response as before. I am connected to the Pi with iwd
in AP mode (only, no ethernet)\

# connmanctl scan wifi
Error /net/connman/technology/wifi: Did not receive a reply. Possible
causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.

when I submit this command, it takes a long time to return and nothing
extra appears in the log. Is connman sending a command like 'iwctl
station scan' as opposed to 'iwctl ap scan' and 'iwctl ap
get-networks'?

It is happily connected and iwd can scan for networks while it is
connected in AP mode.

# iwctl ap wlan0 scan
# iwctl ap wlan0 get-networks
                                    Networks
---------------------------------------------------------------------------=
-----
            Property              Value
---------------------------------------------------------------------------=
-----
            Name                  spg4
            SignalStrength        -3000
            Type                  psk
...

the log in the journal is this:
May 11 13:16:40 runeaudio connmand[362]: wlan0 {update} flags 4098 <DOWN>
May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 2 <DOWN>
May 11 13:16:40 runeaudio connmand[362]:
plugins/iwd.c:object_removed() net.connman.iwd.Station
/net/connman/iwd/0/3
May 11 13:16:40 runeaudio connmand[362]:
plugins/iwd.c:object_removed() net.connman.iwd.SimpleConfiguration
/net/connman/iwd/0/3
May 11 13:16:40 runeaudio connmand[362]:
plugins/iwd.c:object_removed() net.connman.iwd.DeviceProvisioning
/net/connman/iwd/0/3
May 11 13:16:40 runeaudio connmand[362]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 0
May 11 13:16:40 runeaudio connmand[362]: wlan0 {update} flags 4099 <UP>
May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 2 <DOWN>
May 11 13:16:40 runeaudio connmand[362]: plugins/iwd.c:object_added()
net.connman.iwd.AccessPoint /net/connman/iwd/0/3
May 11 13:16:41 runeaudio connmand[362]: plugins/iwd.c:create_ap() started =
0
May 11 13:16:41 runeaudio connmand[362]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 1
May 11 13:16:41 runeaudio connmand[362]:
plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 mode ap
May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} address
192.168.5.1/24 label wlan0 family 2
May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} route 192.168.5.0
gw 0.0.0.0 scope 253 <LINK>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {update} flags 69635
<UP,LOWER_UP>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 5 <DORMANT>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} route fe80:: gw
:: scope 0 <UNIVERSE>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {RX} 0 packets 0 bytes
May 11 13:16:41 runeaudio connmand[362]: wlan0 {TX} 1 packets 42 bytes
May 11 13:16:41 runeaudio connmand[362]: wlan0 {update} flags 69699
<UP,RUNNING,LOWER_UP>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 6 <UP>
May 11 13:16:41 runeaudio connmand[362]: wlan0 {RX} 0 packets 0 bytes
May 11 13:16:41 runeaudio connmand[362]: wlan0 {TX} 1 packets 42 bytes
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 6 <UP>
May 11 13:16:41 runeaudio connmand[362]: plugins/iwd.c:object_added()
net.connman.iwd.AccessPointDiagnostic /net/connman/iwd/0/3
May 11 13:16:41 runeaudio connmand[362]:
plugins/iwd.c:ap_property_change() /net/connman/iwd/0/3 started 1
May 11 13:18:28 runeaudio connmand[362]: wlan0 {RX} 124 packets 12220 bytes
May 11 13:18:28 runeaudio connmand[362]: wlan0 {TX} 93 packets 15083 bytes
May 11 13:18:28 runeaudio connmand[362]: wlan0 {newlink} index 3
address B8:27:EB:52:CC:D0 mtu 1500
May 11 13:18:28 runeaudio connmand[362]: wlan0 {newlink} index 3
operstate 6 <UP>

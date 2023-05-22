Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0914266
	for <connman@lists.linux.dev>; Mon, 22 May 2023 14:23:59 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso2908849b3a.0
        for <connman@lists.linux.dev>; Mon, 22 May 2023 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684765438; x=1687357438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/3AQEomYj/ImGE76upjoGyes+10MKYSXMWwvK+7j4c=;
        b=Gb76QpGyFjFkvfJf90puoc8Yyy6H8AX94Aouez0KVFZImYDzHRJuUfUuGEukaVjzSP
         gUBzBGYvdaQjtzVB0NhaMmOKIoCN5YZ+0O6L7QhFMP5YOclNCRSZwUnxDsRrvv2VpbxF
         ecNv67MFRBSY8idjnk/exA6clpO+r6A6CmLjNBhsVe287/FsQU4b1+nRC1M53OZX0xIT
         oCpI7fabVIeaLhmE6Wu76ToDKH0OOhDJRYGHi5fcQvsCjOYuEtgklUPsOpe5qsA047N5
         ADwtnt6nhq9pV3XH5S/j1sOuQlZpcJO2wmrR/fldQL7ZSGMMELxyDx1RCcIIOJRNph9o
         eOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684765438; x=1687357438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/3AQEomYj/ImGE76upjoGyes+10MKYSXMWwvK+7j4c=;
        b=QWc7QRNflLx11b4Kl8T9qws1p9DApGPZ6ujrNRQdwW4nB3cut0632Q8Vryy52RmYsy
         MZ3LLbPQfekJsxD2Uky6nEqfRXBPCP3oc+LqdOCwfRmc5AG5JexdkvgvQPkZaeuSArQu
         E/lqGG7B9DL/B3qhSjuGkubeU1GwuwZNni3+XM1S0IGNZ4IL4iH20PCkBMmHQIK7rL7a
         vAZvivnYE5BSLHxXS/jww7kVaJuq1xBzy2Ta4/lm7usnPHa8MecMANFteUU0iPgpVuDt
         7eViJlz8WwKQOfbHQR09yuFxHHn7ip2uYiFxzqILxovwFkuHFbXV586NARNHNIUSgWdd
         FiRw==
X-Gm-Message-State: AC+VfDygaPjStB8YjfNsa8boN3SobSVWt4uHR8tnzIJ2nfKjjqhidI73
	hCIFSHK5NU4VgA3CXCYUn1zKQPeBti/eN8hgqGtXqkMID8I=
X-Google-Smtp-Source: ACHHUZ4G/DxqjMYYdh5iqXakgrogNJIIDuLJG6+DS46G7Y2pyY15SHEM6zFr5LrIoUoK6iP9eBYWiLAsEh0OQOjLAhE=
X-Received: by 2002:a17:902:c944:b0:1a6:46f2:4365 with SMTP id
 i4-20020a170902c94400b001a646f24365mr13446815pla.30.1684765438122; Mon, 22
 May 2023 07:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230116081624.12618-1-wagi@monom.org> <CAG17S_PHpxpWnkJrM-NC1J+MDqXzN0zeV-TZ97Euxhfgcj_mMg@mail.gmail.com>
 <CAG17S_NzXYUOPkF1h0e056=jCBQaP3nUh2t0y0n9R5nzhe9yYA@mail.gmail.com>
 <20230227074314.pys65eppvaus2wbs@carbon.lan> <CAG17S_OFx6vU9ubpyDO06N49jBMQVqb20L+tzx0gNs7eWaLv2g@mail.gmail.com>
In-Reply-To: <CAG17S_OFx6vU9ubpyDO06N49jBMQVqb20L+tzx0gNs7eWaLv2g@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 22 May 2023 09:23:47 -0500
Message-ID: <CAG17S_MkyEqj497spiejQBUMdPiOkCr3ao9tjwaJZnUs_4rHpA@mail.gmail.com>
Subject: Re: [PATCH] iwd: Add support to Scan in AP mode
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> > On Tue, Feb 14, 2023 at 12:55:37PM -0600, KeithG wrote:
> >  > ~# iwctl device list
> > > >                                     Devices
> > > > --------------------------------------------------------------------------------
> > > >   Name                  Address               Powered     Adapter     Mode
> > > > --------------------------------------------------------------------------------
> > > >   wlan0                 b8:27:eb:a4:6e:0f     on          phy0        ap
> > > >
> > > > ~# iwctl ap wlan0 scan
> > > > ~# iwctl ap wlan0 get-networks
> > > >                                     Networks
> > > > --------------------------------------------------------------------------------
> > > >             Property              Value
> > > > --------------------------------------------------------------------------------
> > > >             Name                  spg4
> > > >             SignalStrength        -4400
> > > >             Type                  psk
> > > >
> > > >             Name                  ATTcVY9ZWa
> > > >             SignalStrength        -5100
> > > >             Type                  psk
> > > >
> > > >             Name                  ATT3zFM5gH
> > > >             SignalStrength        -5900
> > > >             Type                  psk
> > > >
> > > >             Name                  2WIRE811
> > > >             SignalStrength        -6900
> > > >             Type                  psk
> > > >
> > > >             Name                  ATTU8Z3d7i
> > > >             SignalStrength        -8400
> > > >             Type                  psk
> > > >
> > > > So I am in AP mode and I am connected via WiFi to it.
> > > >
> > > > In connman, though, I do not get any wifi SSIDS:
> > > >
> > > > ~# connmanctl services
> > > > *AO Wired                ethernet_b827ebf13b5a_cable
> > > > ~# connmanctl enable wifi
> > > > wifi is already enabled
> > > > ~# connmanctl scan wifi
> > > > Error /net/connman/technology/wifi: Did not receive a reply. Possible
> > > > causes include: the remote application did not send a reply, the
> > > > message bus security policy blocked the reply, the reply timeout
> > > > expired, or the network connection was broken.
> >
> > This means the connmanctl tool didnt' receive any response. Do you have the logs
> > from the iwd plugins by any chance (connmand -d plugins/iwd.c).
> >
> > > > Is this how it might work? This is how we do it when we use hostapd to
> > > > connect instead of iwd.
> >
> > It looks like the plugin is still using the wrong API and either iwd doesn't
> > respond or the iwd plugin doesn't handle the error case correctly.
> >
> > > Is this still something that could be done? I can build and test any
> > > patches pretty quickly (except for next week).
> >
> > I am not that fast sorry :)
> >
> Daniel,
>
> I am finally back at this again. I appreciate your help with this.
> I have applied your patch to connman and am running iwd 2.4. I enabled
> the logging of the iwd plugin:
> connmand -n -d plugins/iwd.c
> I get the same response as before. I am connected to the Pi with iwd
> in AP mode (only, no ethernet)\
>
> # connmanctl scan wifi
> Error /net/connman/technology/wifi: Did not receive a reply. Possible
> causes include: the remote application did not send a reply, the
> message bus security policy blocked the reply, the reply timeout
> expired, or the network connection was broken.
>
> when I submit this command, it takes a long time to return and nothing
> extra appears in the log. Is connman sending a command like 'iwctl
> station scan' as opposed to 'iwctl ap scan' and 'iwctl ap
> get-networks'?
>
> It is happily connected and iwd can scan for networks while it is
> connected in AP mode.
>
> # iwctl ap wlan0 scan
> # iwctl ap wlan0 get-networks
>                                     Networks
> --------------------------------------------------------------------------------
>             Property              Value
> --------------------------------------------------------------------------------
>             Name                  spg4
>             SignalStrength        -3000
>             Type                  psk
> ...
>
> the log in the journal is this:
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {update} flags 4098 <DOWN>
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 2 <DOWN>
> May 11 13:16:40 runeaudio connmand[362]:
> plugins/iwd.c:object_removed() net.connman.iwd.Station
> /net/connman/iwd/0/3
> May 11 13:16:40 runeaudio connmand[362]:
> plugins/iwd.c:object_removed() net.connman.iwd.SimpleConfiguration
> /net/connman/iwd/0/3
> May 11 13:16:40 runeaudio connmand[362]:
> plugins/iwd.c:object_removed() net.connman.iwd.DeviceProvisioning
> /net/connman/iwd/0/3
> May 11 13:16:40 runeaudio connmand[362]:
> plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 0
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {update} flags 4099 <UP>
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:16:40 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 2 <DOWN>
> May 11 13:16:40 runeaudio connmand[362]: plugins/iwd.c:object_added()
> net.connman.iwd.AccessPoint /net/connman/iwd/0/3
> May 11 13:16:41 runeaudio connmand[362]: plugins/iwd.c:create_ap() started 0
> May 11 13:16:41 runeaudio connmand[362]:
> plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 powered 1
> May 11 13:16:41 runeaudio connmand[362]:
> plugins/iwd.c:device_property_change() /net/connman/iwd/0/3 mode ap
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} address
> 192.168.5.1/24 label wlan0 family 2
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} route 192.168.5.0
> gw 0.0.0.0 scope 253 <LINK>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {update} flags 69635
> <UP,LOWER_UP>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 5 <DORMANT>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {add} route fe80:: gw
> :: scope 0 <UNIVERSE>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {RX} 0 packets 0 bytes
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {TX} 1 packets 42 bytes
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {update} flags 69699
> <UP,RUNNING,LOWER_UP>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 6 <UP>
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {RX} 0 packets 0 bytes
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {TX} 1 packets 42 bytes
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:16:41 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 6 <UP>
> May 11 13:16:41 runeaudio connmand[362]: plugins/iwd.c:object_added()
> net.connman.iwd.AccessPointDiagnostic /net/connman/iwd/0/3
> May 11 13:16:41 runeaudio connmand[362]:
> plugins/iwd.c:ap_property_change() /net/connman/iwd/0/3 started 1
> May 11 13:18:28 runeaudio connmand[362]: wlan0 {RX} 124 packets 12220 bytes
> May 11 13:18:28 runeaudio connmand[362]: wlan0 {TX} 93 packets 15083 bytes
> May 11 13:18:28 runeaudio connmand[362]: wlan0 {newlink} index 3
> address B8:27:EB:52:CC:D0 mtu 1500
> May 11 13:18:28 runeaudio connmand[362]: wlan0 {newlink} index 3
> operstate 6 <UP>

I neglected to say which version of connman I am using. I am running
connman 1.41
with the patch earlier in this thread applied.

Keith

Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81962C9D
	for <connman@lists.linux.dev>; Tue, 30 Nov 2021 11:00:12 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id w23so40457641uao.5
        for <connman@lists.linux.dev>; Tue, 30 Nov 2021 03:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1jqx/WzksMUyAvna6GALAx/zZf2S0SPGUFGEsudUGw=;
        b=FbbfzKKhoiHlC+Liv+PqtyddMrq7Jm+1itQkEKwj0MeC0fhfxVoN0OWcb9N1S1C/p+
         OyxdbUNVwT2I0sdc2crW/mvv6TZssWQkJOlu/EgalINdTcbdSxSeJJwgIcH9DrDMug9/
         bRYQeb9N5V3xI//EmbnLDx+Kwg9HustauEBtC7BwFKt7NogFFhJoHqfON7Hs67z4aAqw
         zxlu8I225rWPFY6n6rIMw0BMvffdYNPtlQDlCysgAaGRJ/2x9w61XsnsLvgOlA95iX3O
         UdpkTaNuv4y6Kk6sACxymu5E0iYoTvRueeCA+PTK6YR7/SLpokno5U6uq/Ret4x3FJVe
         ulfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1jqx/WzksMUyAvna6GALAx/zZf2S0SPGUFGEsudUGw=;
        b=PSNSadT23kxqk/66D6aGZ0+KBcjwys3N6VrreKW95UPY7qBH+RiinIqTJO4Rqo2AZf
         CKqFBVJMREi1I7bUG1syVSFqtLlJoh5aLMyiWwVX8g2gHDAtXuiuDbHD3J2Dj12NPKXG
         AiXzv2Zm5No6/qtsGNd02xIRmQLU49Q02ceWfT7uApKmVBZLQnrSalv2ikWv24fxX7Yu
         mxZFKGDmL+Alr18RgOeAL/0PfQzAJOGWy7gripHqHePuI2pTxYLs6kCEvv6abxHB3Kah
         egwLh1nZ54lszhj09TjE4RYvzG+vORuS6jiqGDweYnydXvRkjYIuKULVYLYnRmNh0ECM
         NjFg==
X-Gm-Message-State: AOAM533J1nLUcAJQ7XdaOPTnOEbJBeO9Zu5soKblwyHhQ0RcNe3YidCo
	WizuXrBMVySiFMQQH2AQAI7/svO7HUgjzTx0ZP3nD5iP
X-Google-Smtp-Source: ABdhPJwmvszPDe5Kfk2gImv8vhwwL1/Km6DNEt9d1PHkb+dOeg/Fz9JnqbkPZpLHh1QdUQEhDLNUNv4uPI3eL5JVcnY=
X-Received: by 2002:a05:6102:d94:: with SMTP id d20mr39687609vst.12.1638270011677;
 Tue, 30 Nov 2021 03:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWSCzvpeqPWMjuTo9kCrE3cS14F7_+_XW-=PU5omTUKvEw@mail.gmail.com>
 <20211126163040.ai2euhv6yf4esnhn@carbon> <CAA=hcWQMThadP0TQDhqEoREroP8TNx1yQkFHC3a0=TNv9FR3DQ@mail.gmail.com>
 <CAA=hcWQB7t8GK8h0kQ1gW8iF-eO_Df2G6C354d2jh4jAxJcfSQ@mail.gmail.com>
 <MRZP264MB154446BAABD22138868B793A93669@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <CAA=hcWS5eXKLMUrTC=MTKUOERiR7eT_J+WdeJL=k8y=i-T40CA@mail.gmail.com> <MRZP264MB15442653D8E656E75EC9D94393679@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB15442653D8E656E75EC9D94393679@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
From: Jupiter <jupiter.hce@gmail.com>
Date: Tue, 30 Nov 2021 21:59:35 +1100
Message-ID: <CAA=hcWRC5J4dDtOfy-43nL3j9EyfYNvePp9RyKeGzipLt_Z8bA@mail.gmail.com>
Subject: Re: How to create connman_1.40.bbappend to enable and to build
 connman with iwd?
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: comman <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Emmanuel,

> Pretty strange... Can you confirm it worked with your former configuration
> on 1.37?

Yes it worked on 1.37 with wpa_supplicant built by Zeus if you would
like to see the result, sorry very lengthy :-):

root@solar:~#  dbus-send --system --print-reply --dest=net.connman /
net.connman.Manager.GetServices
method return time=1638267429.462818 sender=:1.4 -> destination=:1.22
serial=128 reply_serial=2
   array [
      struct {
         object path "/net/connman/service/cellular_505016005871803_context1"
         array [
            dict entry(
               string "Type"
               variant                   string "cellular"
            )
            dict entry(
               string "Security"
               variant                   array [
                  ]
            )
            dict entry(
               string "State"
               variant                   string "ready"
            )
            dict entry(
               string "Strength"
               variant                   byte 80
            )
            dict entry(
               string "Favorite"
               variant                   boolean true
            )
            dict entry(
               string "Immutable"
               variant                   boolean false
            )
            dict entry(
               string "AutoConnect"
               variant                   boolean true
            )
            dict entry(
               string "Name"
               variant                   string "Telstra"
            )
            dict entry(
               string "Roaming"
               variant                   boolean false
            )
            dict entry(
               string "Ethernet"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Interface"
                        variant                            string "wwan0"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"72:DD:6D:D2:FD:91"
                     )
                     dict entry(
                        string "MTU"
                        variant                            uint16 1500
                     )
                  ]
            )
            dict entry(
               string "IPv4"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "fixed"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"10.114.35.221"
                     )
                     dict entry(
                        string "Netmask"
                        variant                            string
"255.255.255.252"
                     )
                     dict entry(
                        string "Gateway"
                        variant                            string
"10.114.35.222"
                     )
                  ]
            )
            dict entry(
               string "IPv4.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "fixed"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"10.114.35.221"
                     )
                     dict entry(
                        string "Netmask"
                        variant                            string
"255.255.255.252"
                     )
                     dict entry(
                        string "Gateway"
                        variant                            string
"10.114.35.222"
                     )
                  ]
            )
            dict entry(
               string "IPv6"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "off"
                     )
                  ]
            )
            dict entry(
               string "Nameservers"
               variant                   array [
                     string "10.4.130.164"
                     string "10.4.58.204"
                  ]
            )
            dict entry(
               string "Nameservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "direct"
                     )
                  ]
            )
            dict entry(
               string "Proxy.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "mDNS"
               variant                   boolean false
            )
            dict entry(
               string "mDNS.Configuration"
               variant                   boolean false
            )
            dict entry(
               string "Provider"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path
"/net/connman/service/wifi_d4ca6ea4e988_4a757069746572496f54_managed_psk"
         array [
            dict entry(
               string "Type"
               variant                   string "wifi"
            )
            dict entry(
               string "Security"
               variant                   array [
                     string "psk"
                  ]
            )
            dict entry(
               string "State"
               variant                   string "idle"
            )
            dict entry(
               string "Strength"
               variant                   byte 73
            )
            dict entry(
               string "Favorite"
               variant                   boolean false
            )
            dict entry(
               string "Immutable"
               variant                   boolean false
            )
            dict entry(
               string "AutoConnect"
               variant                   boolean false
            )
            dict entry(
               string "Name"
               variant                   string "JupiterIoT"
            )
            dict entry(
               string "Ethernet"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Interface"
                        variant                            string "mlan0"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"D4:CA:6E:A4:E9:88"
                     )
                     dict entry(
                        string "MTU"
                        variant                            uint16 1500
                     )
                  ]
            )
            dict entry(
               string "IPv4"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv4.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "dhcp"
                     )
                  ]
            )
            dict entry(
               string "IPv6"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Privacy"
                        variant                            string "disabled"
                     )
                  ]
            )
            dict entry(
               string "Nameservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Nameservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "mDNS"
               variant                   boolean false
            )
            dict entry(
               string "mDNS.Configuration"
               variant                   boolean false
            )
            dict entry(
               string "Provider"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path
"/net/connman/service/wifi_d4ca6ea4e988_43656e74617572323447526f757465723230_managed_psk"
         array [
            dict entry(
               string "Type"
               variant                   string "wifi"
            )
            dict entry(
               string "Security"
               variant                   array [
                     string "psk"
                     string "wps"
                  ]
            )
            dict entry(
               string "State"
               variant                   string "idle"
            )
            dict entry(
               string "Strength"
               variant                   byte 47
            )
            dict entry(
               string "Favorite"
               variant                   boolean false
            )
            dict entry(
               string "Immutable"
               variant                   boolean false
            )
            dict entry(
               string "AutoConnect"
               variant                   boolean false
            )
            dict entry(
               string "Name"
               variant                   string "Centaur24GRouter20"
            )
            dict entry(
               string "Ethernet"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Interface"
                        variant                            string "mlan0"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"D4:CA:6E:A4:E9:88"
                     )
                     dict entry(
                        string "MTU"
                        variant                            uint16 1500
                     )
                  ]
            )
            dict entry(
               string "IPv4"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv4.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "dhcp"
                     )
                  ]
            )
            dict entry(
               string "IPv6"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Privacy"
                        variant                            string "disabled"
                     )
                  ]
            )
            dict entry(
               string "Nameservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Nameservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "mDNS"
               variant                   boolean false
            )
            dict entry(
               string "mDNS.Configuration"
               variant                   boolean false
            )
            dict entry(
               string "Provider"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path
"/net/connman/service/wifi_d4ca6ea4e988_576946692d463236335f4578742032_managed_psk"
         array [
            dict entry(
               string "Type"
               variant                   string "wifi"
            )
            dict entry(
               string "Security"
               variant                   array [
                     string "psk"
                     string "wps"
                  ]
            )
            dict entry(
               string "State"
               variant                   string "idle"
            )
            dict entry(
               string "Strength"
               variant                   byte 40
            )
            dict entry(
               string "Favorite"
               variant                   boolean false
            )
            dict entry(
               string "Immutable"
               variant                   boolean false
            )
            dict entry(
               string "AutoConnect"
               variant                   boolean false
            )
            dict entry(
               string "Name"
               variant                   string "WiFi-F263_Ext 2"
            )
            dict entry(
               string "Ethernet"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Interface"
                        variant                            string "mlan0"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"D4:CA:6E:A4:E9:88"
                     )
                     dict entry(
                        string "MTU"
                        variant                            uint16 1500
                     )
                  ]
            )
            dict entry(
               string "IPv4"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv4.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "dhcp"
                     )
                  ]
            )
            dict entry(
               string "IPv6"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Privacy"
                        variant                            string "disabled"
                     )
                  ]
            )
            dict entry(
               string "Nameservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Nameservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "mDNS"
               variant                   boolean false
            )
            dict entry(
               string "mDNS.Configuration"
               variant                   boolean false
            )
            dict entry(
               string "Provider"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path
"/net/connman/service/wifi_d4ca6ea4e988_4a757069746572496f74546563686e6f6c6f6779323447_managed_psk"
         array [
            dict entry(
               string "Type"
               variant                   string "wifi"
            )
            dict entry(
               string "Security"
               variant                   array [
                     string "psk"
                  ]
            )
            dict entry(
               string "State"
               variant                   string "idle"
            )
            dict entry(
               string "Strength"
               variant                   byte 33
            )
            dict entry(
               string "Favorite"
               variant                   boolean false
            )
            dict entry(
               string "Immutable"
               variant                   boolean false
            )
            dict entry(
               string "AutoConnect"
               variant                   boolean false
            )
            dict entry(
               string "Name"
               variant                   string "JupiterIotTechnology24G"
            )
            dict entry(
               string "Ethernet"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Interface"
                        variant                            string "mlan0"
                     )
                     dict entry(
                        string "Address"
                        variant                            string
"D4:CA:6E:A4:E9:88"
                     )
                     dict entry(
                        string "MTU"
                        variant                            uint16 1500
                     )
                  ]
            )
            dict entry(
               string "IPv4"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv4.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "dhcp"
                     )
                  ]
            )
            dict entry(
               string "IPv6"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Configuration"
               variant                   array [
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                     dict entry(
                        string "Privacy"
                        variant                            string "disabled"
                     )
                  ]
            )
            dict entry(
               string "Nameservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Nameservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers"
               variant                   array [
                  ]
            )
            dict entry(
               string "Timeservers.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains"
               variant                   array [
                  ]
            )
            dict entry(
               string "Domains.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy"
               variant                   array [
                  ]
            )
            dict entry(
               string "Proxy.Configuration"
               variant                   array [
                  ]
            )
            dict entry(
               string "mDNS"
               variant                   boolean false
            )
            dict entry(
               string "mDNS.Configuration"
               variant                   boolean false
            )
            dict entry(
               string "Provider"
               variant                   array [
                  ]
            )
         ]
      }
   ]

> To keep moving, I propose you to test the following configurations,
> and check if you get back a coherent service list:
> 1. PreferredTechnologies=wifi in main.conf,
> 2. ConnMan HEAD on Honister
> SRCREV = "0ef47336dc92b101c6d87ed3a9fff4db36096007"
> 3. ConnMan 1.37 (from Zeus ?) on Honister
> 4. ConnMan 1.39 on Hardknott

I don't think it is a connman issue, it seems to me my Yocto build
problem, something wrong with the libraries, dbus, wpa_supplicant, and
other network things, as per Daniel's advice, it is better to move to
use iwd, but I have the same problem for both connman with
wpa_supplicant and connman with iwd, both broken dbus and could not
get WiFi IP address, I think that dbus failure could be related to the
failure of IP address, I'll keep digging.

> By our side we will migrate to Honister next weeks / months, but I hardly
> doubt your problem is related to Yocto integration.

Are you using connman with wpa_supplicant or iwd when you built
Hardknott? If your connman works on Hardknott, it should also work on
Honister, just be careful the syntax has been changed to use : not _,
for example do_install::append, FILES:${PN}, it took me a while to
lean the new syntax.

Thank you.

- jupiter

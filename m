Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA2137E
	for <connman@lists.linux.dev>; Wed, 28 Dec 2022 13:16:15 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id e205so14782469oif.11
        for <connman@lists.linux.dev>; Wed, 28 Dec 2022 05:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAcN0f5Z+4MTcHm7sMjals1HWBQnAlcfCCoXukJqDPU=;
        b=dXv1xHjqDw4tsnseFrmgdw+ocY1hd+dQe9NEaBhg8MBYHKYwnOOK7RtvpCGMFlGB0e
         lilkJzjzoB1BsDPkPAdwcFCRJLuRieO5LirazQLF30slAyXQzbW+kD4W2prtsVX76usy
         OUUDwe7MkAbWToxK5PmQxu6kGgWlHjWisth2tSZz2AI87LsMqzCbUDFIlDSv96IRP3lb
         30Qt2PfmZ+FyoaDP4kPGmx8Z+3l1vXAqLUC4qc3HRo9vy+S2gYbRHP+SzEqWXL9aPYgZ
         uTvoTkA/fLYVdZC6+flvrwSfhBTWl23sNVbjaH3EbHFhFXrA9ltWMkdfgnVcRpa2uXRC
         /Ykg==
X-Gm-Message-State: AFqh2kpPZpiDbum/XFohkbJ7u1ubk0tI1tQjKwh97PzUCiDIQgkrKS26
	ISSt1KOISW5gUtCrKORKpxEtV8REISU6VeKy7zik/N+as5+M+qN8YuDzBQ==
X-Google-Smtp-Source: AMrXdXvBHCznpfl+ky+ao2WCUj5rBxPWzHowlzZJIc22bVj5JZzzYNLt8D0QPUIJTsZTS9Z4PmqA/FyPzlUKVLLjyVM=
X-Received: by 2002:aca:1b01:0:b0:350:4f8f:6ddf with SMTP id
 b1-20020aca1b01000000b003504f8f6ddfmr1340287oib.235.1672233374362; Wed, 28
 Dec 2022 05:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jade Lovelace <lists@jade.fyi>
Date: Wed, 28 Dec 2022 14:16:03 +0100
Message-ID: <CAFA9we_ArzwtDidQkEQTL-vEPC2GGnRTqZB7jbx=UZ-R1MkzoA@mail.gmail.com>
Subject: bug: 802.1x configuration is not turned into an iwd KnownNetwork
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I just set up an 802.1x configuration with Connman and iwd and it
seems that Connman is not telling iwd about its network configuration
files and turning them into iwd KnownNetworks.

When I create a config file for a network in /var/lib/connman for an
802.1x network, then try to connect to it, it will get stuck in
"association":

connmanctl> services wifi_9cb6d0f7daaf_7075626c6963726f616d_managed_ieee8021x
/net/connman/service/wifi_9cb6d0f7daaf_7075626c6963726f616d_managed_ieee8021x
  Type = wifi
  Security = [ ieee8021x ]
  State = association
  Strength = 56
  Favorite = True
  Immutable = True
  AutoConnect = True
  Name = publicroam

I had a think about this and concluded it was probably that connman
didn't create the known network on the iwd side, which I confirmed by
manually creating /var/lib/iwd/publicroam.8021x with the correct
configuration, solving the issue. I suspect that if I was using some
UI for connman that creates networks via D-Bus rather than via
configuration files, it might work, but the fact that the connman
config files don't apply to iwd is inconsistent with the behaviour
under wpa_supplicant.

I am using connman-1.41 on NixOS.

Here is my config "publicroam.config":

[service_publicroam]
Type=wifi
Name=publicroam
EAP=peap
Phase2=MSCHAPV2
Identity=<REDACTED>
Passphrase=<REDACTED>

Here is the relevant connman log (with iwd debug logging on):

Dec 28 13:24:34 snowflake connmand[266352]:
plugins/iwd.c:object_added() net.connman.iwd.Network
/net/connman/iwd/0/5/7075626c6963726f616d_8021x
Dec 28 13:24:34 snowflake connmand[266352]:
plugins/iwd.c:create_network() device /net/connman/iwd/0/5 name
'publicroam' type 8021x connected 0 known_network (null)
Dec 28 13:24:34 snowflake connmand[266352]:
plugins/iwd.c:station_property_change() /net/connman/iwd/0/5 scanning
0
Dec 28 13:24:34 snowflake connmand[266352]:
plugins/iwd.c:station_property_change() /net/connman/iwd/0/5 scanning
1
Dec 28 13:24:34 snowflake connmand[266352]: plugins/iwd.c:ordered_networks_cb()
<<< REDACTED >>>
Dec 28 13:24:55 snowflake connmand[266352]: EAP type has not been
found. Most likely ConnMan is not able to find a configuration for
given 8021X network. Check SSID or Name match with the network name.

^^^^^^^ ------ This was when I tried to ask it to connect prior to
configuring it

<<< REDACTED >>>
Dec 28 13:27:04 snowflake connmand[266352]: Adding configuration publicroam
Dec 28 13:27:04 snowflake connmand[266352]: Adding service
configuration publicroam

^^^^^^^ ------ Then I added a configuration here

Dec 28 13:27:04 snowflake connmand[266352]:
plugins/iwd.c:cm_network_connect_cb()
/net/connman/iwd/0/5/7075626c6963726f616d_8021x connect failed:
net.connman.iwd.NotConfigured

^^^^^^^ ------ But connecting fails

Jade

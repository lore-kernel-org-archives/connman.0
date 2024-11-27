Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FA1FF602
	for <connman@lists.linux.dev>; Wed, 27 Nov 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717299; cv=none; b=lpZxLjJtqMLS+H1Kb8VNYBmA7D4m/cM70shkP4RADHYDVLUj5txZ72VTiaqSVQTQzNZ88KcbuZb7DyzUtt7eTMSqGvVfSVzd61JrQnaoFhF5tbpYpD57BvB9lJdNqn1cYlIrtPE331rpaL/PK/XweXl0FEoLXvUfnTtx9kavpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717299; c=relaxed/simple;
	bh=f6ThRhfr1E8vQzEWZ6WZg1szhVKxRyixT12aiagezKA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VCOaRLoeBuVrSiMq5uhBRiakfQQ1XwvSG8ps5Q64WmT5AZqexSXqGUMWOFFzPXBZojYaZ2+MLsr3720vC2MBU0dz7hm7zmGOxat6iCy2BaiUsw/P7ZEBzY2uZzFiWq6IjI3ViOVA07Kws0MBaDzlSwFp/qHdn8t2HJxYsChLWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viessmann.com; spf=pass smtp.mailfrom=viessmann.com; dkim=pass (1024-bit key) header.d=viessmann.com header.i=@viessmann.com header.b=JOikWli/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viessmann.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viessmann.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viessmann.com header.i=@viessmann.com header.b="JOikWli/"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfa9979cd1so1546956a12.1
        for <connman@lists.linux.dev>; Wed, 27 Nov 2024 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=viessmann.com; s=google; t=1732717295; x=1733322095; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GRceAuEdG+1xgEeS0wJXUEbuEDbJGU0w/olG7dZVk5o=;
        b=JOikWli/x4WEngCu6uEzEva2lCuH6dv39Q+7T63LabQ7hiPub0KL3C8lrr42VghiiG
         UfWybVqsrzL+h1yk0xvN+tyPDiB4XkL+75fitUVhlKcrjLJz+n7lONQzy4MQp+ZbiINs
         ATC6JOQNP0SWWqnGq8OMcHcvHP0XEXP35dld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732717295; x=1733322095;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRceAuEdG+1xgEeS0wJXUEbuEDbJGU0w/olG7dZVk5o=;
        b=KiI4y6Rg0SUM5KYAmkKIcKUe0cdake/cQ6GJTVgXYNF5w5bmt/GjVUvDl0efgaClRn
         6MrKQa6IRdw4Fkb8+YF2oSpz5UXVNw6yXBZooC/l65ua+WMzChydnz75U0lAKHqE5+GQ
         QcoYss2g6MW0zJN875x9W5l5sYDwUAybBIM4AMBGODVskKiwM9sf6pu09J75R+09q3Yl
         sdZ3fuVkNB+NXJq8GYyoLqZJO+wa9urhfg0j24yCJvxVfb0FpTLDha/mHVPQuc6gMDoX
         DAFCy73fn+4Wtdpur83/xNG1iSWpdOkEwgXOVTRqWvnsQnRRvqKKD2wpl1C9tjF2IioJ
         /9nQ==
X-Gm-Message-State: AOJu0Yw54kFrPtGcgkkfYKtjTLg+Ya9nU4hgirTeUlonj+EbIPU5eynI
	DxHe/eScjrP6h2UUf+P7d8ItooISfIWjpygH17CWd7BjV5JJNIMX+QpmlNF397Ur7MoHDAVgd/s
	cYixlW1dd7auwfmEP+goBIEzLL9TUYwcHucIf0BtPI6Yky+kAurE=
X-Gm-Gg: ASbGncsBpkeyfrWY+i4IW5hSMp5dhG3OHdg6VcCO67sDIaJ+w8I86B+bgIA5PjHOC5i
	Hbq6STFqKoifF6CuLW5sjA68YB7QY
X-Google-Smtp-Source: AGHT+IE5xw8hS39Ko3ZgUk/4mudLG4bp+X2txsKv3XGp6jtJR+kV4NLgp4zdsn/ImJuicWVNsk+22g8KTA0hgyA/xNA=
X-Received: by 2002:a05:6402:b0f:b0:5d0:8106:aafe with SMTP id
 4fb4d7f45d1cf-5d08106ae9cmr2497667a12.13.1732717295100; Wed, 27 Nov 2024
 06:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Szymon Szymczak <szcs@viessmann.com>
Date: Wed, 27 Nov 2024 15:21:24 +0100
Message-ID: <CAP+seRmXcvfY-1fuFb2nr2foAPqQkWQ5BBkaKQV+A2egiNHgxw@mail.gmail.com>
Subject: SEGV in network when requested to connect while still disconnecting
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'd like to report a problem I have discovered while running version
1.43 in an embedded device based off yocto scarthgap 5.0.4. I've
bumped connman to 1.43 while keeping patches from
https://github.com/yoctoproject/poky/tree/scarthgap/meta/recipes-connectivity/connman,
commit 2034fc3, the reason for an update was a SIGABRT due to
use-after-free fixed in connman in commit
f1f6db78a40344e68c29841c0b4061d15aef4f39 wifi: Fix use-after-free when
tethering is disabled.

The issue does not reproduce in 1.41.

For reference, the device is configured to connect to WLAN networks on
a wlan0 interface (via wpa_supplicant) or open an access point on a
tether interface, both using the same phy. The issue reproduces on an
automated test line and I was not able to reproduce the problem
manually in my setup.

Steps to reproduce the problem:
- Configure wlan0 to connect to a network
- Disconnect from the network
- Enable tethering on the tether interface
- Shortly thereafter, while the device is still disconnecting from the
WLAN, configure connman to connect back to it, this time with manual
IP address settings (I am not sure if the manual IP configuration
plays any role in here besides causing the exactly right timing to get
this issue reproduced)

Expected result:
- connman configures the interfaces to connect to the requested AP
with manual settings applied

Actual result:
- A segmentation fault occurs in set_connected_manual in src/network.c:505:
#0  __connman_ipconfig_get_local (ipconfig=0x0) at
/usr/src/debug/connman/1.43/src/ipconfig.c:1269
#1  0x0044ab6c in set_connected_manual (network=0x22adfa8) at
/usr/src/debug/connman/1.43/src/network.c:505
#2  __connman_network_enable_ipconfig (network=0x22adfa8,
ipconfig=<optimized out>) at
/usr/src/debug/connman/1.43/src/network.c:1980
#3  0x0045f280 in set_property (conn=<optimized out>, msg=0x22aa390,
user_data=0x22a1998) at /usr/src/debug/connman/1.43/src/service.c:6466
#4  0x004c11cc in process_message (connection=0x2298b80,
message=0x22aa390, method=0x4f1750 <service_methods+24>,
iface_user_data=<optimized out>) at
/usr/src/debug/connman/1.43/gdbus/object.c:259
#5  0x77a79e04 in _dbus_object_tree_dispatch_and_unlock
(tree=0x2298eb0, message=0x22aa390, found_object=<optimized out>) at
/usr/src/debug/dbus/1.14.10/dbus/dbus-object-tree.c:1021
#6  0x77a65a68 in dbus_connection_dispatch (connection=0x2298b80) at
/usr/src/debug/dbus/1.14.10/dbus/dbus-connection.c:4758
#7  dbus_connection_dispatch (connection=0x2298b80) at
/usr/src/debug/dbus/1.14.10/dbus/dbus-connection.c:4586
#8  0x004bc84c in message_dispatch (data=0x2298b80) at
/usr/src/debug/connman/1.43/gdbus/mainloop.c:72
#9  0x77b20320 in g_main_dispatch (context=0x2298148) at
/usr/src/debug/glib-2.0/2.78.6/glib/gmain.c:3476
#10 0x77b24af4 in g_main_context_dispatch_unlocked (context=0x2298148)
at /usr/src/debug/glib-2.0/2.78.6/glib/gmain.c:4284
#11 g_main_context_iterate_unlocked (context=0x2298148,
block=<optimized out>, dispatch=1, self=<optimized out>) at
/usr/src/debug/glib-2.0/2.78.6/glib/gmain.c:4349
#12 0x77b259c0 in g_main_loop_run (loop=0x2297698) at
/usr/src/debug/glib-2.0/2.78.6/glib/gmain.c:4551
#13 0x0041530c in main (argc=<optimized out>, argv=<optimized out>) at
/usr/src/debug/connman/1.43/src/main.c:1272
Code:
501             service = connman_service_lookup_from_network(network);
502             ipconfig = __connman_service_get_ip4config(service);
503             __connman_ipconfig_enable(ipconfig);
504
505             if (!__connman_ipconfig_get_local(ipconfig))
506                     __connman_service_read_ip4config(service);
507
508             if (connman_setting_get_bool("AddressConflictDetection")) {
509                     err = start_acd(network);
A core dump shows that apparently `service` was set to NULL in line
501 due to `network->device` being NULL.

Logs indicate that connman attempted to apply ipconfig on a network
that was still in the process of being destructed and disconnected.
The abovementioned `network->device` field was probably cleared during
the disconnection phase in:
Mar  9 13:34:16.065 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/device.c:connman_device_remove_network()
device 0x22a0cb8 network 0x22adfa8
Mar  9 13:34:16.066 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/device.c:free_network() network
0x22adfa8
Mar  9 13:34:16.067 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:network_remove() network
0x22adfa8 name <SSID CENSORED>

Later connman proceeded to wait until the network is disconnected
while also starting dhcpv6 PD due to the request to reconnect to the
network:
Mar  9 13:34:29.802 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:34:36.572 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:34:38.298 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:connman_network_ref_debug()
0x22adfa8 name RDW-TEST-WEP 4 ref 2 by
/usr/src/debug/connman/1.43/src/dhcpv6.c:2612:__connman_dhcpv6_start_pd()
Mar  9 13:34:38.299 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/dhcpv6.c:__connman_dhcpv6_start_pd()
replace network 0x22adfa8 dhcp 0x22bcf10
Mar  9 13:34:38.454 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:34:38.668 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:34:39.700 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:35:08.517 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_disconnect()
network 0x22adfa8
Mar  9 13:35:21.847 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/dhcpv6.c:__connman_dhcpv6_start_pd_release()
network 0x22adfa8 dhcp 0x22bcf10 client (nil)

And finally, with the same instance (0x22adfa8), the crash occurs:
Mar  9 13:35:52.182 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:set_property() service
0x22a1998
Mar  9 13:35:52.183 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:set_property()
IPv4.Configuration
Mar  9 13:35:52.183 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_create()
ipconfig 0x22a3dd0 index 3
Mar  9 13:35:52.183 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_set_config()
method 3 address 10.77.21.66 netmask 255.255.255.224 gateway 10.
77.21.88 prefix_length 0 privacy (null)
Mar  9 13:35:52.184 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_unref_debug()
0x22b8fe8 ref 1 by /usr/src/debug/connman/1.43/src/service.c:
6133:__connman_service_reset_ipconfig()
Mar  9 13:35:52.184 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_enable()
ipconfig 0x22a3dd0
Mar  9 13:35:52.184 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_unref_debug()
0x22b8fe8 ref 0 by /usr/src/debug/connman/1.43/src/ipconfig.c:
1924:__connman_ipconfig_enable()
Mar  9 13:35:52.184 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_disable()
ipconfig 0x22b8fe8
Mar  9 13:35:52.185 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_unref_debug()
0x22b8fe8 ref -1 by /usr/src/debug/connman/1.43/src/ipconfig.c:
2001:__connman_ipconfig_disable()
Mar  9 13:35:52.185 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_ref_debug()
0x22a3dd0 ref 2 by /usr/src/debug/connman/1.43/src/ipconfig.c:1944:
__connman_ipconfig_enable()
Mar  9 13:35:52.186 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:service_up() wlan0 up
Mar  9 13:35:52.188 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:service_lower_up() wlan0
lower up
Mar  9 13:35:52.188 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:stats_start() service
0x22a1998
Mar  9 13:35:52.189 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/service.c:__connman_service_reset_ipconfig()
err 0 ipconfig 0x22a3dd0 type 1 method 3 state (null)
Mar  9 13:35:52.191 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:set_configuration() network
0x22adfa8
Mar  9 13:35:52.191 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:__connman_network_enable_ipconfig()
ipv4 ipconfig method 3
Mar  9 13:35:52.191 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/network.c:set_connected_manual()
network 0x22adfa8
Mar  9 13:35:52.192 daemon.debug connmand[404]:
/usr/src/debug/connman/1.43/src/ipconfig.c:__connman_ipconfig_enable()
ipconfig (nil)
Mar  9 13:35:52.193 kern.info kernel: [ 3669.875591] do_page_fault():
sending SIGSEGV to connmand for invalid read access from 00000018
Mar  9 13:35:52.193 kern.info kernel: [ 3669.875610] epc = 00473410 in
connmand[400000+e4000]
Mar  9 13:35:52.193 kern.info kernel: [ 3669.875653] ra  = 0044ab6c in
connmand[400000+e4000]

Full connman logs from the test procedure, although a tad bit
censored: https://pastebin.com/ngajZfMK

I am open to try out any fixes and provide feedback if needed. Let me
know if you need more details about this one.

Kind regards,
Szymon

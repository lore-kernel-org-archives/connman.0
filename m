Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5429A1
	for <connman@lists.linux.dev>; Fri, 18 Nov 2022 10:55:53 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id n20so12260380ejh.0
        for <connman@lists.linux.dev>; Fri, 18 Nov 2022 02:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7c2H1utNxXKX+I10cUaN6TFL0+n3+cpS0D7FN0Gjp4=;
        b=X7X2whzQFKi0xrJM5B11mIYW+Rkg0hzqAwfNnD0Z76gu7iJBWHCIoufjSDxjIm8FSc
         CC7qTlVy4ZNpTTddDOz/Qw7aB9hXFs9FdoxuUJkX1asOfDAvX2ja+UHpiLtoANrArRBp
         g7OKn0oJMx4UnB/zzmEFPJMfLt6hHpIsFqWyCYGhx9JnV4/lauy1yKL0gY78KpPzZ28A
         Bn2BhOJpEHTDB5wOJFaDfJVIjYpBY5EjTNMn5P4OPz9t63WwWPOs44rEdeWZV+yMoMsL
         NHMzDSep9YmUwQYqNx4yEKX3EC9j5geBrlaPw8vwGfyuqbIadnjSkEy+qSy2t9m97IVx
         zi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e7c2H1utNxXKX+I10cUaN6TFL0+n3+cpS0D7FN0Gjp4=;
        b=BSX6MrBwcCviRFxoZJchPZjf4F4QdgZG+SFk1jNimvhehJj6b9TWo6lEPM7pNJXUYP
         3yGUvrSesZY4M65Lv1bhcRXVO3f0gl1rte2Tn2qwaTRZ/u6Uo72jpm41bWTA+wP2rx/O
         SAif1Vm437LtCuLTRg8e5R5BlGSjKnVJ8wpUpykhc73med7LZul4osZAqDW+ygoU7b4w
         4joLssh2yLl51DvxNDzrnBJzLhRrRn9FgpdDLjGjxNlCNlsBDeOTXNlmellGHDrVr1Vd
         4XfeFYSArSniPFWkk1thWBCzSECQGHCYWO1OfOM8NcTxhfFZ208I2rsTCMohgN1pcGRL
         rldw==
X-Gm-Message-State: ANoB5pnaO1ynA6gkgM1stdufjivq4o56flnvUP1TG7VF9gpWDKtQOzYg
	cRp5IYe7bpZ/G+uwjeRE5CKVtRWovQeJkg==
X-Google-Smtp-Source: AA0mqf7ftSATB38fv13heHKOcUp6542/Jm50b7A6DtnFPV81xbFUN4xOt+SPnLjgRUPAuDSjQMY8hQ==
X-Received: by 2002:a17:906:6d7:b0:781:951:2fb with SMTP id v23-20020a17090606d700b00781095102fbmr5476471ejb.64.1668768951214;
        Fri, 18 Nov 2022 02:55:51 -0800 (PST)
Received: from ?IPV6:2a02:1812:2512:400:625a:d2a6:ba4b:1413? (ptr-gh3gmp9vcjrn10fi0wj.18120a2.ip6.access.telenet.be. [2a02:1812:2512:400:625a:d2a6:ba4b:1413])
        by smtp.gmail.com with ESMTPSA id en17-20020a056402529100b00467960d7b62sm1666721edb.35.2022.11.18.02.55.49
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:55:50 -0800 (PST)
Message-ID: <dda7ee12-1176-6eaf-4f84-a599bfbadee8@gmail.com>
Date: Fri, 18 Nov 2022 11:55:49 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: connman@lists.linux.dev
From: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>
Subject: autoip address set/reset loop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: autoip address set/reset loop

Hi,

I'm testing with a very recent version of connman (1.41 hash:19789ae039b) and I'm noticing issues with the autoIp not working properly.
What I see is that the 169.254.x.x address is gets set but is than deleted again immedeately.
Here is the log output:

Jan  1 00:06:29.676 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() NEWLINK len 756 type 16 flags 0x0000 seq 0 pid 0
Jan  1 00:06:29.676 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_newlink() index 3
Jan  1 00:06:29.676 hostname connmand[2454]: eth0 {RX} 2 packets 430 bytes
Jan  1 00:06:29.676 hostname connmand[2454]: eth0 {TX} 0 packets 0 bytes
Jan  1 00:06:29.676 hostname connmand[2454]: eth0 {update} flags 102467 <UP,RUNNING,LOWER_UP>
Jan  1 00:06:29.676 hostname connmand[2454]: eth0 {newlink} index 3 address xx:xx:xx:xx:xx:xx mtu 1500
Jan  1 00:06:29.676 hostname connmand[2454]: eth0 {newlink} index 3 operstate 6 <UP>
Jan  1 00:06:29.676 hostname connmand[2454]: ../git/src/detect.c:detect_newlink() type 1 index 3
Jan  1 00:06:29.676 hostname connmand[2454]: ../git/plugins/ethernet.c:ethernet_newlink() index 3 flags 102467 change 0
Jan  1 00:06:29.676 hostname connmand[2454]: ../git/plugins/ethernet.c:ethernet_newlink() carrier on
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/network.c:connman_network_create() network 0xc3dc40 identifier carrier type ethernet
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/network.c:connman_network_set_name() network 0xc3dc40 name Wired
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/device.c:connman_device_add_network() device 0xc41120 network 0xc3dc40
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/network.c:connman_network_ref_debug() 0xc3dc40 name Wired ref 2 by ../git/src/device.c:872:connman_device_add_network()
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/network.c:network_probe() network 0xc3dc40 name Wired
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/src/network.c:network_probe() driver 0x56b0a8 name cable
Jan  1 00:06:29.684 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_probe() network 0xc3dc40
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/network.c:network_probe() network 0xc3dc40 name Wired
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/network.c:network_probe() driver 0x56b0a8 name cable
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_probe() network 0xc3dc40
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/service.c:__connman_service_create_from_network() network 0xc3dc40
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/service.c:connman_service_create() service 0xc3c4f8
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/service.c:service_initialize() service 0xc3c4f8
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/service.c:service_get() service 0xc3c4f8
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/service.c:update_from_network() service 0xc3c4f8 network 0xc3dc40
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/network.c:connman_network_ref_debug() 0xc3dc40 name Wired ref 3 by ../git/src/service.c:7411:update_from_network()
Jan  1 00:06:29.708 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_create() ipconfig 0xc3c900 index 3
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/ipconfig.c:create_ipv6config() ipconfig 0xc3c830 index 3 method off
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/service.c:service_register() service 0xc3c4f8
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/service.c:service_register() path /net/connman/service/ethernet_xxxxxxxxxxxx_p01_cable
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/config.c:__connman_config_provision_service() service 0xc3c4f8 type 2
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/service.c:service_load() service 0xc3c4f8
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_load() ipconfig 0xc3c900 identifier ethernet_xxxxxxxxxxxx_p01_cable
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_load() ipconfig 0xc3c830 identifier ethernet_xxxxxxxxxxxx_p01_cable
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_update_gateway() default (nil)
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/service.c:service_schedule_added() service 0xc3c4f8
Jan  1 00:06:29.712 hostname connmand[2454]: ../git/src/service.c:__connman_service_connect() service 0xc3c4f8 state idle connect reason none -> auto
Jan  1 00:06:29.717 hostname connmand[2454]: ../git/src/service.c:__connman_service_clear_error() service 0xc3c4f8
Jan  1 00:06:29.717 hostname connmand[2454]: ../git/src/stats.c:__connman_stats_service_register() service 0xc3c4f8
Jan  1 00:06:29.717 hostname connmand[2454]: ../git/src/stats.c:stats_open() file 0xc3dce8 name /var/lib/connman/ethernet_xxxxxxxxxxxx_p01_cable/data
Jan  1 00:06:29.717 hostname connmand[2454]: ../git/src/stats.c:stats_file_setup() file 0xc3dce8 fd 14 name /var/lib/connman/ethernet_xxxxxxxxxxxx_p01_cable/data
Jan  1 00:06:29.717 hostname connmand[2454]: ../git/src/stats.c:stats_file_remap() file 0xc3dce8 size 4096 addr (nil) len 0
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/network.c:__connman_network_connect() network 0xc3dc40
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_connect() network 0xc3dc40
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/network.c:connman_network_set_connected() network 0xc3dc40 connected 0/1 connecting 1 associating 0
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/network.c:set_connected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/network.c:set_configuration() network 0xc3dc40
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/service.c:__connman_service_ipconfig_indicate_state() service 0xc3c4f8 (ethernet_xxxxxxxxxxxx_p01_cable) old state 1 (idle) new state 3 (configuration) type 1 (IPv4)
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/service.c:service_indicate_state() service 0xc3c4f8 old idle - new configuration/idle => configuration
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/session.c:service_state_changed() service 0xc3c4f8 state 3
Jan  1 00:06:29.725 hostname connmand[2454]: ../git/src/notifier.c:notify_idle_state() idle 0
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/manager.c:idle_state() idle 0
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/stats.c:__connman_stats_service_register() service 0xc3c4f8
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_update_gateway() default (nil)
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/network.c:__connman_network_enable_ipconfig() ipv4 ipconfig method 4
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/network.c:set_connected_dhcp() network 0xc3dc40
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_enable() ipconfig 0xc3c900
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_ref_debug() 0xc3c900 ref 2 by ../git/src/ipconfig.c:1731:__connman_ipconfig_enable()
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/service.c:service_up() eth0 up
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/service.c:service_lower_up() eth0 lower up
Jan  1 00:06:29.729 hostname connmand[2454]: ../git/src/service.c:stats_start() service 0xc3c4f8
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/dhcp.c:__connman_dhcp_start()
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_ref_debug() 0xc3c900 ref 3 by ../git/src/dhcp.c:701:__connman_dhcp_start()
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/network.c:connman_network_ref_debug() 0xc3dc40 name Wired ref 4 by ../git/src/dhcp.c:705:__connman_dhcp_start()
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_initialize() dhcp 0xc36400
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname()
Jan  1 00:06:29.733 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname() driver 0x56b050 name loopback
Jan  1 00:06:29.760 hostname connmand[2454]: ../git/src/network.c:set_configuration() network 0xc3dc40
Jan  1 00:06:29.760 hostname connmand[2454]: ipconfig state 3 ipconfig method 1
Jan  1 00:06:29.760 hostname connmand[2454]: ../git/src/network.c:__connman_network_enable_ipconfig() ipv6 ipconfig method 1
Jan  1 00:06:29.760 hostname connmand[2454]: ../git/src/ipconfig.c:disable_ipv6()
Jan  1 00:06:29.760 hostname connmand[2454]: ../git/src/ipconfig.c:set_ipv6_state() eth0 1
Jan  1 00:06:29.760 hostname connmand[2454]: failed to set /proc/sys/net/ipv6/conf/eth0/disable_ipv6 value 1
Jan  1 00:06:29.760 hostname connmand[2454]: ../git/src/service.c:__connman_service_connect() service 0xc3c4f8 err 0
Jan  1 00:06:29.814 hostname connmand[2454]: ../git/src/service.c:service_send_changed()
Jan  1 00:06:29.814 hostname connmand[2454]: ../git/src/service.c:service_append_added_foreach() new /net/connman/service/ethernet_xxxxxxxxxxxx_p01_cable

Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname()
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname() driver 0x56b050 name loopback
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_invalidate() dhcp 0xc36400 callback 0
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/6to4.c:__connman_6to4_remove() tunnel ip address (null)
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_invalidate() last address (null)
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/inet.c:connman_inet_clear_address() index 3 address (null) prefix_len 0 peer (null) broadcast (null)
Jan  1 00:07:05.008 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_set_gateway()
Jan  1 00:07:15.006 hostname connmand[2454]: ../git/src/dhcp.c:ipv4ll_available_cb() IPV4LL available
Jan  1 00:07:15.010 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_set_gateway()
Jan  1 00:07:15.010 hostname connmand[2454]: ../git/src/network.c:dhcp_success() lease acquired for ipconfig 0xc3c900

=> CONNMAN SET ADDRESS
Jan  1 00:07:15.010 hostname connmand[2454]: ../git/src/inet.c:connman_inet_set_address() index 3 address 169.254.132.185 prefix_len 16
Jan  1 00:07:15.010 hostname connmand[2454]: ../git/src/inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 3 family 2 address 169.254.132.185 peer (null) prefixlen 16 broadcast (null) p2p false
Jan  1 00:07:15.010 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_gateway_add()
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/network.c:connman_network_set_error() network 0xc3dc40 error 2
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/service.c:__connman_service_indicate_error() service 0xc3c4f8 error 4
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/service.c:__connman_service_ipconfig_indicate_state() service 0xc3c4f8 (ethernet_xxxxxxxxxxxx_p01_cable) old state 3 (configuration) new state 7 (failure) type 1 (IPv4)
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_disable() ipconfig 0xc3c900
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_unref_debug() 0xc3c900 ref 2 by ../git/src/ipconfig.c:1788:__connman_ipconfig_disable()
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/service.c:service_indicate_state() service 0xc3c4f8 old configuration - new failure/idle => failure
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/session.c:service_state_changed() service 0xc3c4f8 state 7
Jan  1 00:07:15.022 hostname connmand[2454]: ../git/src/provider.c:provider_service_changed() service 0xc3c4f8 ethernet_xxxxxxxxxxxx_p01_cable state 7 index 3/-1
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/notifier.c:notify_idle_state() idle 1
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/manager.c:idle_state() idle 1
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/service.c:__connman_service_auto_connect()
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/service.c:service_save() service 0xc3c4f8 new 0
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_save() ipconfig 0xc3c900 identifier ethernet_xxxxxxxxxxxx_p01_cable method auto
Jan  1 00:07:15.029 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_save() ipconfig 0xc3c830 identifier ethernet_xxxxxxxxxxxx_p01_cable method off
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_update_gateway() default (nil)
Jan  1 00:07:15.069 hostname connmand[2454]: ipconfig state 7 ipconfig method 1
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/network.c:__connman_network_disconnect() network 0xc3dc40
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_disconnect() network 0xc3dc40
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/network.c:connman_network_set_connected() network 0xc3dc40 connected 1/0 connecting 0 associating 0
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/network.c:set_disconnected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/network.c:set_disconnected() method ipv4 5 ipv6 1
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/dhcp.c:__connman_dhcp_stop() ipconfig_table 0xc3b0c8 ipconfig 0xc3c900
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_unref_debug() 0xc3c900 ref 1 by ../git/src/dhcp.c:738:__connman_dhcp_stop()
Jan  1 00:07:15.069 hostname connmand[2454]: ../git/src/network.c:connman_network_unref_debug() 0xc3dc40 name Wired ref 3 by ../git/src/dhcp.c:740:__connman_dhcp_stop()
Jan  1 00:07:15.076 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_release() dhcp 0xc36400
Jan  1 00:07:15.146 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_invalidate() dhcp 0xc36400 callback 0
Jan  1 00:07:15.146 hostname connmand[2454]: ../git/src/6to4.c:__connman_6to4_remove() tunnel ip address (null)
Jan  1 00:07:15.157 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_invalidate() last address 169.254.132.185

=> CONNMAN RESET ADDRESS
Jan  1 00:07:15.157 hostname connmand[2454]: ../git/src/inet.c:connman_inet_clear_address() index 3 address 169.254.132.185 prefix_len 16 peer (null) broadcast (null)
Jan  1 00:07:15.157 hostname connmand[2454]: ../git/src/inet.c:__connman_inet_modify_address() cmd 0x15 flags 0 index 3 family 2 address 169.254.132.185 peer (null) prefixlen 16 broadcast (null) p2p false
Jan  1 00:07:15.157 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_set_gateway()
Jan  1 00:07:15.157 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_gateway_remove() service 0xc3c4f8 type 3
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/inet.c:connman_inet_clear_address() index 3 address (null) prefix_len 0 peer (null) broadcast (null)
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/service.c:__connman_service_ipconfig_indicate_state() service 0xc3c4f8 (ethernet_xxxxxxxxxxxx_p01_cable) old state 7 (failure) new state 1 (idle) type 1 (IPv4)
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_disable() ipconfig 0xc3c900
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/service.c:service_indicate_state() service 0xc3c4f8 old failure - new idle/idle => idle
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/session.c:service_state_changed() service 0xc3c4f8 state 1
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/service.c:__connman_service_disconnect() service 0xc3c4f8
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/agent.c:connman_agent_cancel() context 0xc3c4f8
Jan  1 00:07:15.165 hostname connmand[2454]: ../git/src/stats.c:__connman_stats_service_unregister() service 0xc3c4f8
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/network.c:__connman_network_disconnect() network 0xc3dc40
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_disconnect() network 0xc3dc40
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/network.c:connman_network_set_connected() network 0xc3dc40 connected 1/0 connecting 0 associating 0
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/network.c:set_disconnected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/network.c:set_disconnected() method ipv4 4 ipv6 1
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/dhcp.c:__connman_dhcp_stop() ipconfig_table 0xc3b0c8 ipconfig 0xc3c900
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_gateway_remove() service 0xc3c4f8 type 3
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/inet.c:connman_inet_clear_address() index 3 address (null) prefix_len 0 peer (null) broadcast (null)
Jan  1 00:07:15.169 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/network.c:set_disconnected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/network.c:set_disconnected() method ipv4 4 ipv6 1
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/6to4.c:__connman_6to4_remove() tunnel ip address (null)
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/inet.c:connman_inet_clear_address() index 3 address (null) prefix_len 0 peer (null) broadcast (null)
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/session.c:ipconfig_changed() service 0xc3c4f8 ipconfig 0xc3c900
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/session.c:ipconfig_changed() service 0xc3c4f8 ipconfig 0xc3c830
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_disable() ipconfig 0xc3c900
Jan  1 00:07:15.175 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_disable() ipconfig 0xc3c830
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_update_gateway() default (nil)
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/network.c:set_disconnected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/network.c:set_disconnected() method ipv4 4 ipv6 1
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0

=> IPCONFIG SET ADDRESS
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() NEWADDR len 88 type 20 flags 0x0000 seq 1 pid 4023293199
Jan  1 00:07:15.180 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_newaddr() index 3
Jan  1 00:07:15.184 hostname connmand[2454]: eth0 {add} address 169.254.132.185/16 label eth0 family 2
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags 0x0600 seq 0 pid 0
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags 0x0600 seq 0 pid 0
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags 0x0600 seq 0 pid 0
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_newroute() index 3
Jan  1 00:07:15.184 hostname connmand[2454]: eth0 {add} route 169.254.0.0 gw 0.0.0.0 scope 253 <LINK>

=> IPCONFIG RESET ADDRESS
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() DELADDR len 88 type 21 flags 0x0000 seq 1 pid 2432986928
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_deladdr() index 3
Jan  1 00:07:15.184 hostname connmand[2454]: eth0 {del} address 169.254.132.185/16 label eth0
Jan  1 00:07:15.184 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags 0x0000 seq 0 pid 0
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_delroute() index 3
Jan  1 00:07:15.188 hostname connmand[2454]: eth0 {del} route 169.254.0.0 gw 0.0.0.0 scope 253 <LINK>
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags 0x0000 seq 0 pid 0
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags 0x0000 seq 0 pid 0
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:run_auto_connect()
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:preferred_tech_add_by_type() type 2 service 0xc3c4f8 Wired
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:auto_connect_service() preferred 1 sessions 0 reason auto
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:auto_connect_service() service 0xc3c4f8 Wired preferred
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:__connman_service_connect() service 0xc3c4f8 state idle connect reason none -> auto
Jan  1 00:07:15.188 hostname connmand[2454]: ../git/src/service.c:__connman_service_clear_error() service 0xc3c4f8
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/stats.c:__connman_stats_service_register() service 0xc3c4f8
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/stats.c:stats_open() file 0xc40558 name /var/lib/connman/ethernet_xxxxxxxxxxxx_p01_cable/data
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/stats.c:stats_file_setup() file 0xc40558 fd 14 name /var/lib/connman/ethernet_xxxxxxxxxxxx_p01_cable/data
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/stats.c:stats_file_remap() file 0xc40558 size 4096 addr (nil) len 0
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/network.c:__connman_network_connect() network 0xc3dc40
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/plugins/ethernet.c:eth_network_connect() network 0xc3dc40
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/network.c:connman_network_set_connected() network 0xc3dc40 connected 0/1 connecting 1 associating 0
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/network.c:connman_network_set_associating() network 0xc3dc40 associating 0
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/network.c:set_connected() service 0xc3c4f8 ipv4 0xc3c900 ipv6 0xc3c830
Jan  1 00:07:15.192 hostname connmand[2454]: ../git/src/network.c:set_configuration() network 0xc3dc40
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/service.c:__connman_service_ipconfig_indicate_state() service 0xc3c4f8 (ethernet_xxxxxxxxxxxx_p01_cable) old state 1 (idle) new state 3 (configuration) type 1 (IPv4)
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/service.c:service_indicate_state() service 0xc3c4f8 old idle - new configuration/idle => configuration
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/session.c:service_state_changed() service 0xc3c4f8 state 3
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/notifier.c:notify_idle_state() idle 0
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/manager.c:idle_state() idle 0
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/stats.c:__connman_stats_service_register() service 0xc3c4f8
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/connection.c:__connman_connection_update_gateway() default (nil)
Jan  1 00:07:15.197 hostname connmand[2454]: ../git/src/network.c:__connman_network_enable_ipconfig() ipv4 ipconfig method 4
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/network.c:set_connected_dhcp() network 0xc3dc40
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_enable() ipconfig 0xc3c900
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_ref_debug() 0xc3c900 ref 2 by ../git/src/ipconfig.c:1731:__connman_ipconfig_enable()
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/service.c:service_up() eth0 up
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/service.c:service_lower_up() eth0 lower up
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/service.c:stats_start() service 0xc3c4f8
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/dhcp.c:__connman_dhcp_start()
Jan  1 00:07:15.203 hostname connmand[2454]: ../git/src/ipconfig.c:__connman_ipconfig_ref_debug() 0xc3c900 ref 3 by ../git/src/dhcp.c:701:__connman_dhcp_start()
Jan  1 00:07:15.208 hostname connmand[2454]: ../git/src/network.c:connman_network_ref_debug() 0xc3dc40 name Wired ref 4 by ../git/src/dhcp.c:705:__connman_dhcp_start()
Jan  1 00:07:15.208 hostname connmand[2454]: ../git/src/dhcp.c:dhcp_initialize() dhcp 0xc36400
Jan  1 00:07:15.208 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname()
Jan  1 00:07:15.208 hostname connmand[2454]: ../git/src/utsname.c:connman_utsname_get_hostname() driver 0x56b050 name loopback
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/network.c:set_configuration() network 0xc3dc40
Jan  1 00:07:15.241 hostname connmand[2454]: ipconfig state 3 ipconfig method 1
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/network.c:__connman_network_enable_ipconfig() ipv6 ipconfig method 1
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/ipconfig.c:disable_ipv6()
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/ipconfig.c:set_ipv6_state() eth0 1
Jan  1 00:07:15.241 hostname connmand[2454]: failed to set /proc/sys/net/ipv6/conf/eth0/disable_ipv6 value 1
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/service.c:__connman_service_connect() service 0xc3c4f8 err 0
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/service.c:service_indicate_state() service 0xc3c4f8 old configuration - new configuration/idle => configuration
Jan  1 00:07:15.241 hostname connmand[2454]: ../git/src/service.c:run_vpn_auto_connect() stopped, default service NULL connected -1

Any ideas what I can do to resolve those issues?


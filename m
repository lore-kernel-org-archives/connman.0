Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45A4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 17:33:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67C5A5E01E;
	Sun, 28 Aug 2022 19:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661708021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RdiZko2ERoZ5mkSm+dp+3ZtnwZWnLVSj7A14/7VHqhw=;
	b=vt3FUiwgRoY2CedTeTuKUicYe293gxfSn7phvoX2gMKPWBfxayMminEqxlVyj7v/xT+KnE
	XX99B2qUxYgxyCGSiQezU6Zvw0Hmr13ktmv+IZh8lx07AzEyWU6mgZfswvMtocyHiHaKD5
	gDEP4hfFpMWdbHfBT8qP7zkE+ZTOb9sR4J59uFE99m9phs0CL4hGz1Eoxax5P28f0H1+sx
	KOBZfNUr3dbmuobfec1RjaGeu5Q6NSuM8MxdawG+ozVC0wcG1y0O+YWhIksGoahyhOnJ6J
	WDkVGEgVBnBK9aQ3h8vbz7OgxXI1HVb1hg3XVwKzrrAc/xofJb4u9zA5XjndHQ==
Date: Sun, 28 Aug 2022 19:33:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828173340.4jzimv6seuyenffi@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

It looks like the route is added via the IPV4LL path:

connmand[29489]: src/network.c:dhcp_success() lease acquired for ipconfig 0x5575276057a0
connmand[29489]: src/inet.c:connman_inet_set_address() index 10 address 169.254.74.53 prefix_len 16
connmand[29489]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 10 family 2 address 169.254.74.53 peer (null) prefixlen 16 broadcast (null) p2p false
connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add()
connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw (null) peer (null)
connmand[29489]: src/connection.c:__connman_connection_gateway_add() service 0x557527609170 index 10 gateway 0.0.0.0 vpn ip (null) type 1
connmand[29489]: src/service.c:connman_service_ref_debug() 0x557527609170 ref 2 by src/connection.c:416:add_gateway()
connmand[29489]: src/connection.c:find_active_gateway()
connmand[29489]: src/connection.c:__connman_connection_gateway_add() active 0x5575275fd820 index 6 new 0x55752760d8f0
connmand[29489]: src/inet.c:get_interface_addresses() index 10 interface ham0
connmand[29489]: src/inet.c:connman_inet_get_dest_addr() destination 0.0.0.0
connmand[29489]: src/inet.c:connman_inet_add_network_route() index 10 host 0.0.0.0 gateway (null) netmask (null)
connmand[29489]: src/inet.c:connman_inet_add_network_route() ifname ham0

How do you configure ham0's IP address? It is supposed to be set via DHCP?

Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1D4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 17:50:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86F635E04E;
	Sun, 28 Aug 2022 19:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661709004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4w8HcFrCfBL1pd+olrgGHDHmVrix12Mj1cTRvWGpOPM=;
	b=QSvksHRm5vP151ySrVLCa3MuBrDfnvNS63YYVzOkjMvftOdjpIPqXlAT5zyQlH9uxXo1kJ
	vFkIOphb5fDe4JTHqx2dJVoaVmEFhp9dqTr1qH07hSy4IuyvfGpm0OpJ9s1liH5ulrzVWA
	hRJA1NBkSsZ+7nM/DTOgYw7TwGEQSZ3tAf/UdMl6elOreRQ6N/LYJQfOTI15WEBOYEtU/H
	UOc1B23G10TJFDxq+3WAFgIFWJu9BeLY9jZ2AOTqztL2FErqVUXUHSninO0ntID8b06Hmg
	70PqHiA0t4uk0Iuffa1TtUVHEwkz5roxPqh+hv+QKzGnQNyN1aXImQkidnqS0Q==
Date: Sun, 28 Aug 2022 19:50:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828175004.vevq62sc4ws5rffy@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828174050.ate53trz2opzyczg@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 07:40:50PM +0200, Daniel Wagner wrote:
> On Sun, Aug 28, 2022 at 07:33:40PM +0200, Daniel Wagner wrote:
> > It looks like the route is added via the IPV4LL path:
> > 
> > connmand[29489]: src/network.c:dhcp_success() lease acquired for ipconfig 0x5575276057a0
> > connmand[29489]: src/inet.c:connman_inet_set_address() index 10 address 169.254.74.53 prefix_len 16
> > connmand[29489]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 10 family 2 address 169.254.74.53 peer (null) prefixlen 16 broadcast (null) p2p false
> > connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add()
> > connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw (null) peer (null)
> > connmand[29489]: src/connection.c:__connman_connection_gateway_add() service 0x557527609170 index 10 gateway 0.0.0.0 vpn ip (null) type 1
> > connmand[29489]: src/service.c:connman_service_ref_debug() 0x557527609170 ref 2 by src/connection.c:416:add_gateway()
> > connmand[29489]: src/connection.c:find_active_gateway()
> > connmand[29489]: src/connection.c:__connman_connection_gateway_add() active 0x5575275fd820 index 6 new 0x55752760d8f0
> > connmand[29489]: src/inet.c:get_interface_addresses() index 10 interface ham0
> > connmand[29489]: src/inet.c:connman_inet_get_dest_addr() destination 0.0.0.0
> > connmand[29489]: src/inet.c:connman_inet_add_network_route() index 10 host 0.0.0.0 gateway (null) netmask (null)
> > connmand[29489]: src/inet.c:connman_inet_add_network_route() ifname ham0
> > 
> > How do you configure ham0's IP address? It is supposed to be set via DHCP?
> 
> Well, we should set a GW for IPV4LL DHCP leases:
                ^^^^
                not

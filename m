Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AF4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Twx7RT0GiGxfEZlig8cHFBWoWEDw7TH+MY2VlU7MUcI=;
	t=1661708885;x=1661798885; 
	b=AH94mysD/RZjnFjzBkdNTUYvxHRF7TrTZG73tngGMtW+7E5Hls2Min4r9BC0CgPTkpqwEMH1r1wLlqkmrAZocr1zXOTBcspxREDhYNGrI8gmOY5Gnf/7msaZMw0wGET/7vDPzX7UmtKmkeANnqG7GXePYypUxfMsv2HRBZUrOUM=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oSMOA-0003RF-90; Sun, 28 Aug 2022 20:48:02 +0300
Message-ID: <4ab804a6-883c-ba5d-f495-cc8be368cc1e@dark-templar-archives.net>
Date: Sun, 28 Aug 2022 19:48:01 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: connman HEAD regression
Content-Language: en-GB
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
From: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
In-Reply-To: <20220828173340.4jzimv6seuyenffi@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=darktemplar@dark-templar-archives.net smtp.mailfrom=darktemplar@dark-templar-archives.net
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD90FA8EB11E8F64C562B98BA7982DCFA3D7B52310EE295D2641313CFAB8367EF908E2BE116634AD74DE70FC316EFE3F723325E5BDC7F8EE405EEDA830E32323CFE7AD2C9CDF6B3E5BD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72424932217190DC2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637367CCE42412B8BE38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C71058EA7FC1A409EC0755A9D2974C0C117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC4BCA9BFFB0DD4195A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B60425ED1B70270490089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B0F56C66D0505D98343EEEE07A23441A0E68D9F308BFE5D2A8D3B740F8F66783389C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3455AC8BF8E3153BA06067159A751E844D1881FD47C10D21F28DC1C12ED4AFB232F2D107A8A6C822851D7E09C32AA3244C16AFC09327E3AE72EAA3D28959BF23A5B038C9161EF167A1729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEnGQ5SRi3NpGd/u1nNRLnw==
X-DA7885C5: BC7F45481EE3C287DEFECFCF2B29A9F94CF558C2289D95B4AD44B29D7B50B4F2262E2D401490A4A0DB037EFA58388B346E8BC1A9835FDE71
X-Mailru-Sender: 689FA8AB762F7393CC2E0F076E87284EF98F3B92D773C5709F0405B0846D24E9FC46662C07703AF85C26933BBBA7D932FB559BB5D741EB96CB0DDC60C75065A8DE84130C709110B3AEED54BB88DBBF873453F38A29522196
X-Mras: Ok

28.08.2022 19:33, Daniel Wagner пишет:
> It looks like the route is added via the IPV4LL path:
> 
> connmand[29489]: src/network.c:dhcp_success() lease acquired for ipconfig 0x5575276057a0
> connmand[29489]: src/inet.c:connman_inet_set_address() index 10 address 169.254.74.53 prefix_len 16
> connmand[29489]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 10 family 2 address 169.254.74.53 peer (null) prefixlen 16 broadcast (null) p2p false
> connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add()
> connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw (null) peer (null)
> connmand[29489]: src/connection.c:__connman_connection_gateway_add() service 0x557527609170 index 10 gateway 0.0.0.0 vpn ip (null) type 1
> connmand[29489]: src/service.c:connman_service_ref_debug() 0x557527609170 ref 2 by src/connection.c:416:add_gateway()
> connmand[29489]: src/connection.c:find_active_gateway()
> connmand[29489]: src/connection.c:__connman_connection_gateway_add() active 0x5575275fd820 index 6 new 0x55752760d8f0
> connmand[29489]: src/inet.c:get_interface_addresses() index 10 interface ham0
> connmand[29489]: src/inet.c:connman_inet_get_dest_addr() destination 0.0.0.0
> connmand[29489]: src/inet.c:connman_inet_add_network_route() index 10 host 0.0.0.0 gateway (null) netmask (null)
> connmand[29489]: src/inet.c:connman_inet_add_network_route() ifname ham0
> 
> How do you configure ham0's IP address? It is supposed to be set via DHCP?

I don't do any manual configuration. Hamachi does it on it's own as far 
as I'm aware. I.e. it connects to network and assigns an address to 
network interface on it's own after that depending on network it 
connected to. I guess it might be similar to DHCP.

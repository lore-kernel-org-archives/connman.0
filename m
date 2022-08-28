Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E64699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=d3d0XIRaCrFhsUo5NfYe9WcXpG10XLLhlWmiE4LvLeg=;
	t=1661710087;x=1661800087; 
	b=JU0CfVdlbrW6tjkgePS5vMSke4M6SnBg7SbkBR+S+6HuTY96YrxBeNcEe1ZZnOqPSPp47Y69BUgwBj5JRYIUKqeMbbIskDLcW5pM0K+ulLGi1ZSl1m7uDAzzxoCTT56JzXUEwCfSdJAZS7zxTUVtXv3LNEut++IE0trmpHqrkwo=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oSMhY-0000he-DL; Sun, 28 Aug 2022 21:08:04 +0300
Message-ID: <a18acdfc-1399-9d01-851b-7fb4ae9eeec0@dark-templar-archives.net>
Date: Sun, 28 Aug 2022 20:08:03 +0200
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
 <20220828174050.ate53trz2opzyczg@beryllium.lan>
From: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
In-Reply-To: <20220828174050.ate53trz2opzyczg@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=darktemplar@dark-templar-archives.net smtp.mailfrom=darktemplar@dark-templar-archives.net
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9BF9AC82A1D2D7237764588D9A076B23928781ED220B759C8182A05F5380850400386629464F777132E364D059BA7FC5868D66F1651D27697142FBF3CC77E61A4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9FBA884A7C9B8BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B3D52627AD81B52CEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B8859CA687ABA27BA4C8D46EE3EB6587168D5CCD452D3E475CC7F00164DA146DAFE8445B8C89999728AA50765F790063781612DB815465C93389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8EDCF5861DED71B2F389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735C8D5298E42E60C1FC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B0AB21DE2C0F4064F93EEEE07A23441A0EA6F3081A8AF32E79F62E1EEEAE6741769C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D341C998A3771F041530F692EE6C3AF7FBACD5235D7B23A0462E6D9DA6FA6D72052B6B6F3EEC87D4E061D7E09C32AA3244CDB5D2D4049117CD6B956B1F64CB0629824AF4FAF06DA24FD729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEnGQ5SRi3NrPBedN0ODxfw==
X-DA7885C5: 8D062E6827E477B7FDAAFA26F0E22D76D4CC82CEB4280DA4ED2FAA6E500AA923262E2D401490A4A0DB037EFA58388B346E8BC1A9835FDE71
X-Mailru-Sender: 689FA8AB762F7393CC2E0F076E87284E9A4025920D708A213686AD02AB9D0E23FC46662C07703AF85C26933BBBA7D932FB559BB5D741EB96CB0DDC60C75065A8DE84130C709110B3AEED54BB88DBBF873453F38A29522196
X-Mras: Ok

28.08.2022 19:40, Daniel Wagner пишет:
> On Sun, Aug 28, 2022 at 07:33:40PM +0200, Daniel Wagner wrote:
>> It looks like the route is added via the IPV4LL path:
>>
>> connmand[29489]: src/network.c:dhcp_success() lease acquired for ipconfig 0x5575276057a0
>> connmand[29489]: src/inet.c:connman_inet_set_address() index 10 address 169.254.74.53 prefix_len 16
>> connmand[29489]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags 0x104 index 10 family 2 address 169.254.74.53 peer (null) prefixlen 16 broadcast (null) p2p false
>> connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add()
>> connmand[29489]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw (null) peer (null)
>> connmand[29489]: src/connection.c:__connman_connection_gateway_add() service 0x557527609170 index 10 gateway 0.0.0.0 vpn ip (null) type 1
>> connmand[29489]: src/service.c:connman_service_ref_debug() 0x557527609170 ref 2 by src/connection.c:416:add_gateway()
>> connmand[29489]: src/connection.c:find_active_gateway()
>> connmand[29489]: src/connection.c:__connman_connection_gateway_add() active 0x5575275fd820 index 6 new 0x55752760d8f0
>> connmand[29489]: src/inet.c:get_interface_addresses() index 10 interface ham0
>> connmand[29489]: src/inet.c:connman_inet_get_dest_addr() destination 0.0.0.0
>> connmand[29489]: src/inet.c:connman_inet_add_network_route() index 10 host 0.0.0.0 gateway (null) netmask (null)
>> connmand[29489]: src/inet.c:connman_inet_add_network_route() ifname ham0
>>
>> How do you configure ham0's IP address? It is supposed to be set via DHCP?
> 
> Well, we should set a GW for IPV4LL DHCP leases:
> 
> 
> diff --git a/src/network.c b/src/network.c
> index 2090e7fe944e..68679f5939b3 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -444,9 +444,11 @@ static void dhcp_success(struct connman_network *network)
>          if (err < 0)
>                  goto err;
>   
> -       err = __connman_ipconfig_gateway_add(ipconfig_ipv4);
> -       if (err < 0)
> -               goto err;
> +       if (!__connman_ipconfig_get_local(ipconfig_ipv4)) {
> +               err = __connman_ipconfig_gateway_add(ipconfig_ipv4);
> +               if (err < 0)
> +                       goto err;
> +       }
>   
>          __connman_service_save(service);

With this patch, when I'm restarting connman, my network doesn't work. 
Not enough default routes present.

Here's my routing table without this patch and without VPNs:

$ ip route
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
192.168.1.1 dev eth0 scope link

Here it is with this patch:

$ ip route
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158

eth0 is a wired link, and it uses DHCP for address assignment.

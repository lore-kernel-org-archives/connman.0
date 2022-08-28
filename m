Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80C4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=xnJrjWjhxJIABctk3hxCS+N8qmQxnF1BUP9Lz5RjKDY=;
	t=1661710754;x=1661800754; 
	b=mTA7yUqfb45vgPr5uEqopUPbie6vwEpcziX4mH03vhlTwUwXkVEgVR5FZlto7EfcQmwOMgTI7aiWlr3O1QgXegWoNgjvMUJWmK9R3bGkPJcVh8C5qD67KHD7i8JkpivwbPxC7a4A3nUO5rDkW3Y6OvYQXIUjjVZAsVVwwaNKrg0=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oSMsJ-0003m9-Nq; Sun, 28 Aug 2022 21:19:12 +0300
Message-ID: <6016001e-b5db-a05c-0265-53eeec857e11@dark-templar-archives.net>
Date: Sun, 28 Aug 2022 20:19:10 +0200
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
 <20220828180009.xifu45ui3qa7pckn@beryllium.lan>
 <20220828180807.jqq26kcm7ev3ukdv@beryllium.lan>
From: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
In-Reply-To: <20220828180807.jqq26kcm7ev3ukdv@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=darktemplar@dark-templar-archives.net smtp.mailfrom=darktemplar@dark-templar-archives.net
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9BF9AC82A1D2D723796C00AC894E796FC85C14BEDEA5216A0182A05F53808504092DAC6E04CD3C64DF768AC3CD84BF906FB0C5081369BD83D233D52431BF36D36
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76D4A2B7BAC4DEDB8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D99F96657F58F1038638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A28740C1A7BF75051516E7080E961FAC117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC8883BAB8B32E402CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA7E827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B9EB32FE0C26A3A4C75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B014F749A5E30D975C3EEEE07A23441A0E457E0362F40280180CCB08BCCB74338A9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34E420FF71F2F0FE034AF25D12138B6EECAB420D1407FD32EC07CEA171BAD8A91E7507F9119490F5C61D7E09C32AA3244CE6CEF979F05E777F65AA8BF01721F39B435BF7150578642F729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEnGQ5SRi3NqXP3Dr110VyA==
X-DA7885C5: 5E439BBF1D4498F192BC022E0565788506C76003901EECCF4FD5354F350A5276262E2D401490A4A0DB037EFA58388B346E8BC1A9835FDE71
X-Mailru-Sender: 689FA8AB762F7393CC2E0F076E87284EE50B75B04B3B7B529CBD48CEEF8442A8FC46662C07703AF85C26933BBBA7D932FB559BB5D741EB96CB0DDC60C75065A8DE84130C709110B3AEED54BB88DBBF873453F38A29522196
X-Mras: Ok

28.08.2022 20:08, Daniel Wagner пишет:
> I suppose we could make __connman_ipconfig_gateway_add() a bit more
> restrictive:
> 
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 34b1724a22bb..9f17f4989ea8 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -1172,7 +1172,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
>   
>   	DBG("");
>   
> -	if (!ipconfig->address)
> +	if (!ipconfig->address || !ipconfig->address->gateway)
>   		return -EINVAL;
>   
>   	service = __connman_service_lookup_from_index(ipconfig->index);

This version looks working with Hamachi. Thanks a lot!

I'll check it with OpenVPN a few days later. If it doesn't work I'll 
send another email. But I expect it to work too.

Here's how routing table looks now with Hamachi:

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 eth0
25.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 ham0
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.1.1     0.0.0.0         255.255.255.255 UH    0      0        0 eth0

$ ip route
default via 192.168.1.1 dev eth0
25.0.0.0/8 dev ham0 proto kernel scope link src 25.75.105.187
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
192.168.1.1 dev eth0 scope link

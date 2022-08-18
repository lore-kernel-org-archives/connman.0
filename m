Received: from fallback22.mail.ru (fallback22.m.smailru.net [94.100.176.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB14683
	for <connman@lists.linux.dev>; Thu, 18 Aug 2022 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=4QZ8MCxcx82D2sG8BDGmP9dL9RFhXwBqjqh5Du4A7N4=;
	t=1660845612;x=1660935612; 
	b=EeWMLudLJ5tLyFKL/WMwbgDmApVZovj/5MzRHInuqSTwDZcPlSgLHLZrQLqASzEFyrDFlDFqRmKLvDfqLNe5ZZoiQVPMP82yGmy6QZrpCWcqn7HeiHXgc3u/gY2aDNe9xvt7828iU+Uk731b8uLUJoW9uLmX4iCqhS0Wo/1lb4I=;
Received: from [10.161.100.15] (port=36020 helo=smtpng3.i.mail.ru)
	by fallback22.m.smailru.net with esmtp (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oOjLH-0005rC-Cu
	for connman@lists.linux.dev; Thu, 18 Aug 2022 20:30:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=4QZ8MCxcx82D2sG8BDGmP9dL9RFhXwBqjqh5Du4A7N4=;
	t=1660843803;x=1660933803; 
	b=YbQmwSxEZt9VkL5StQCAPTxgujIBw3HJVf8Mn5rZSzlvcJq+RvUB3YcmYcFFrL1nv1blWdgbSmjAb7ilMzaSruJt9XoLM1goH1TT888eGOYWZNCD/LIhm0YmpR6nEOTTqYcDlK2xcsVzJc3yK6SxScAdklNYVRP33LYo5S2Zff8=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oOjL8-0000M5-VN
	for connman@lists.linux.dev; Thu, 18 Aug 2022 20:29:55 +0300
Message-ID: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
Date: Thu, 18 Aug 2022 19:29:54 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: connman HEAD regression
To: connman@lists.linux.dev
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD999D8F08CF16C6CA7738240E633E44B48AF332D7139557C8700894C459B0CD1B9B1496FDE74FF33701DF28AAED7373A6B8AAE64017E54B1EADC961F69A1D5625B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AB81E605F2C81F9EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370D3D68FCEFFDD9EA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FAF5773EFB81E3F14EED0384ED9CA785117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC5F22DA640E95B789A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86D618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6CF4C160FE611D475089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C41E93BD56E7067354307CAA32FF218580205367B2BCC23E5BF727681AFAA1E7B9E7E65F06B2D3BF1CAD91A466A1DEF99B6ED91DBE5ABE359ADBCB5631A0A9D21F4E9387F6EE0124019D11E9C2F33BBE4C738C0C9594C58B1F8B46A129DB5271F5B1881A6453793CE9C32612AADDFBE061EC1F8EBFB9D57540A71A35648BE338CE9510FB958DCE06DB58C12E6D310A6D5333F7A9E5587C79A693EDB24507CE13387DFF0A840B692CF8
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3468964757141B82E02C336B2779616D4273E46DFF098CBC32A8AC07D0D0FCB1BCF39BD06C08FF4F491D7E09C32AA3244C912280BB3CDF8BF4103C6FCA1B3C686969B6CAE0477E908D3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXgofL99JMat6fy2kRI1lV6z
X-Mailru-Sender: 689FA8AB762F7393CC2E0F076E87284E5EC60FB0ED9D78AF858870C76EE8FF93FC46662C07703AF85C26933BBBA7D932FB559BB5D741EB96CB0DDC60C75065A8DE84130C709110B3AEED54BB88DBBF873453F38A29522196
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48D9E7D729DD288A15A759AF26BCF910B91CEAE754601F52FB647ED114AB003AC9667FFBAC66D1817B2D0E0F6B1D171B0B9282E5F8A4318BC71E65205FE0453EE
X-7FA49CB5: 0D63561A33F958A5EA2BF8D26E50E2365FE51CB9AAB673FC7492319F15C946D78941B15DA834481FA18204E546F3947C02A3942546F0CC5EF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F8E7BBE36542B4C0389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C6B73DA677B26CA535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C41E93BD56E7067354307CAA32FF218580205367B2BCC23E5B96476B917FEC8B5BE7E65F06B2D3BF1CAD91A466A1DEF99B6ED91DBE5ABE359A11A4A8E3B7AD6EC9F3F687384632F7D29D11E9C2F33BBE4C52A4E4F838C723ED24330ADB47270E76B1881A6453793CE9C32612AADDFBE061EC1F8EBFB9D57540DC48ACC2A39D04F89CDFB48F4795C241BDAD6C7F3747799A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj7Jv35gwMd2MDiJ5kCTVW4Q==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

Good day.

I've found a regression in connman commit:

https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=416bfaff988882c553c672e5bfc2d4f648d29e8a

When VPN client is used, connman adds additional default route, bricking 
all networking.

To reproduce, use openvpn client to connect to VPN, or hamachi to 
connect to a network, or some other VPN client. Tested with both openvpn 
client and hamachi.

30-60 seconds after connection, connman adds routes, and with them, one 
additional default route.

Here are routing tables before mentioned commit:

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
0.0.0.0         0.0.0.0         255.255.255.255 UH    0      0        0 ham0
0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 eth0
25.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 ham0
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 ham0
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.1.1     0.0.0.0         255.255.255.255 UH    0      0        0 eth0

$ ip route
0.0.0.0 dev ham0 scope link
default via 192.168.1.1 dev eth0
25.0.0.0/8 dev ham0 proto kernel scope link src 25.75.105.187
169.254.0.0/16 dev ham0 proto kernel scope link src 169.254.124.73
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
192.168.1.1 dev eth0 scope link

Here are routing tables after mentioned commit:

$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
0.0.0.0         0.0.0.0         255.255.255.255 UH    0      0        0 ham0
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0        0 ham0
0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 eth0
25.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 ham0
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 ham0
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.1.1     0.0.0.0         255.255.255.255 UH    0      0        0 eth0

$ ip route
0.0.0.0 dev ham0 scope link
default dev ham0 scope link
default via 192.168.1.1 dev eth0
25.0.0.0/8 dev ham0 proto kernel scope link src 25.75.105.187
169.254.0.0/16 dev ham0 proto kernel scope link src 169.254.55.155
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.158
192.168.1.1 dev eth0 scope link

Same happens with openvpn instead of hamachi. Didn't test it with wireguard.

Distribution: Gentoo Linux amd64

Build options (if relevant):
./configure --prefix=/usr --build=x86_64-pc-linux-gnu 
--host=x86_64-pc-linux-gnu --mandir=/usr/share/man 
--infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc 
--localstatedir=/var/lib --disable-dependency-tracking 
--disable-silent-rules --docdir=/usr/share/doc/connman-1.41-r1 
--htmldir=/usr/share/doc/connman-1.41-r1/html --with-sysroot=/ 
--libdir=/usr/lib64 --localstatedir=/var --runstatedir=/run 
--with-systemdunitdir=/lib/systemd/system 
--with-tmpfilesdir=/usr/lib/tmpfiles.d --enable-client 
--enable-datafiles --enable-loopback=builtin --disable-bluetooth 
--disable-debug --enable-ethernet=builtin --disable-test --disable-iwd 
--disable-l2tp --disable-nmcompat --disable-ofono --disable-openconnect 
--disable-openvpn --enable-polkit=builtin --disable-pptp --disable-tools 
--disable-vpnc --enable-wifi=builtin --disable-wireguard --disable-wispr 
--with-firewall=nftables --disable-iospm --disable-hh2serial-gps

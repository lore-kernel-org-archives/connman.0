Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AC388E40
	for <connman@lists.linux.dev>; Tue, 12 May 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577040; cv=none; b=BdO6FEjmHHqb2vNeP4rtRwZIhELhFtGzmujADZzJkSkC49Q5EC1QVigodvENGOVkdx/TmzcRtoYqvVlAPyFC7Br7WR9utjKUpqv0nPVvI5PcxjGogP9S+1GsFUduwXF0tWIJJxBC8ZTlvRBxwRPwVUgV2bBAIouCQvrh3P7siPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577040; c=relaxed/simple;
	bh=UBd+eiuoGRVUuzj8rheOMiiEWXKjyqJgTNcBzz78MyI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OA8Blao/ZjBHp6isOf5KajeAVJjpHWMX9mqB6lkwMABojw9EbkSeBryGQ2HiVeb4KAezcDYRBCD3sDX5zG/89VunSsz+nhWuKZzxlNjFm6oQQkew9air+HqGtVLYYuZgggOr3ppAIgl70g+rXE/aSOhDOgW5mHHH58MKq1cDrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Dhaqw1vV; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Dhaqw1vV"
Received: from [IPV6:2a02:8428:e480:3f01:98de:b597:d87e:64d] (unknown [IPv6:2a02:8428:e480:3f01:98de:b597:d87e:64d])
	(Authenticated sender: fgalea@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 617A120039C;
	Tue, 12 May 2026 11:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778577036;
	bh=UBd+eiuoGRVUuzj8rheOMiiEWXKjyqJgTNcBzz78MyI=;
	h=Date:To:Cc:From:Subject:From;
	b=Dhaqw1vVJ6YPDnJm6bRNueR8FbI1Qtmj5IHOpvsZyWH5Hra980SJ59icSjgFvuRP3
	 iAfkMMZY5T7Abs36WKHZzLwP9CTc2xDPl0zBw6SnJCDlV1+0z431wToUbeNG/aYdtZ
	 W5zqZSRWCZS0JLwAYhytwU/1lpTqZqo1I7oh6HCGSwt8ly9GuKrMrrDNDrU1SatiLr
	 i1Yx3/RE6CuS49BrSc7FgWNdjuGrNdIl0vG63tFRnlH2tdKRbX7vs9pA+6taM9IWkV
	 OwJo8iQCTHMV2JMZD9BpX6b86puq2ppNhW4YTn9VuLPl4lAOy2iqWNNT4tN1FG3YZL
	 qMtLGyCyQhLtQ==
Message-ID: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
Date: Tue, 12 May 2026 11:10:35 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr
To: connman@lists.linux.dev
Cc: wbx@openadk.org
From: =?UTF-8?Q?Fran=C3=A7ois_Galea?= <fgalea@free.fr>
Subject: Connection to a WPA2 Wi-Fi router fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

This was tested on a Zynq (Cortex-A9) and a RPi4, on a 32-bit Arm 
Buildroot Linux system.

The Wi-Fi router uses WPA2 Personnal authentication.

Problem starts from buildroot releases including connman 1.45. Previous 
releases using connman 1.44 and prior are working fine. Also switching 
from 1.45 to 1.44 in a buildroot version that includes connman 1.45 works.


If a connection was previously successfully set up, for instance from 
connman 1.44 or older, `/var/log/messages` contains:

Jan  1 00:00:11 zest daemon.info connmand[141]: Adding interface wlan0 [ 
wifi ]
Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {update} flags 
36867 <UP>
Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2 
address 9A:8F:85:81:67:B4 mtu 1500
Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2 
operstate 2 <DOWN>
Jan  1 00:00:11 zest daemon.info dbus-daemon[120]: [system] Successfully 
activated service 'fi.w1.wpa_supplicant1'
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags 
36931 <UP,RUNNING>
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
address 8C:3D:16:20:0E:4A mtu 1500
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
operstate 0 <UNKNOWN>
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags 
36867 <UP>
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
address 8C:3D:16:20:0E:4A mtu 1500
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
operstate 2 <DOWN>
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
address 8C:3D:16:20:0E:4A mtu 1500
Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4 
operstate 2 <DOWN>
Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ] 
state is association
Jan  1 00:00:11 zest daemon.warn connmand[141]: Interface wlan0 [ wifi ] 
error "invalid-key"
Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ] 
state is failure


Otherwise, when creating a new connection:

# connmanctl
Error getting VPN connections: The name net.connman.vpn was not provided 
by any .service files
connmanctl> services

connmanctl> enable wifi
Enabled wifi
connmanctl> scan wifi
Scan completed for wifi
connmanctl> services
     Kamoulox             wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
     Livebox-D050 
wifi_8c3d16200e4a_4c697665626f782d44303530_managed_psk
     Freebox-3B4B3C 
wifi_8c3d16200e4a_46726565626f782d334234423343_managed_psk
     patetalex            wifi_8c3d16200e4a_7061746574616c6578_managed_psk
     DRAME                wifi_8c3d16200e4a_4452414d45_managed_psk
connmanctl> agent on
Agent registered
connmanctl> connect wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
Agent RequestInput wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
   Passphrase = [ Type=psk, Requirement=mandatory, Alternates=[ WPS ] ]
   WPS = [ Type=wpspin, Requirement=alternate ]
Passphrase? my_wifi_passphrase
Agent ReportError wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
   invalid-key
connmanctl> Retry (yes/no)? no
Error 
/net/connman/service/wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk: 
Input/output error
connmanctl>


 From both situations it appears the wifi passphrase is not accepted.

wbx (as CC of this email) noticed that reverting commit 
5e73b55e00b97e1867397258b72f0d6e5ad7d31d allows connections to work again.

Is it a known situation? Is there a patch available?

Best,

François


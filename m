Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146771BD9C9
	for <connman@lists.linux.dev>; Thu, 24 Sep 2026 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283029; cv=none; b=P5JpxBKRNWeyVPr6Co2scL2VcyE66Zr4HCmJjr+lneGYAmdddpzYyrgN0P/ZezgOOrfCJe93Xq726qVpvfs8/r2kkq5BA7Mm842Cj7oioXdgY0USb61v22AheVBkWm/dq3yCO3/uOLEjgKM388PGXpmL8xbfWHpcJL6Rxhj3Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283029; c=relaxed/simple;
	bh=ToL/LujvptJqNdWanadA2ggtUTqQBtYF0TXJ6lcbGj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on1tuwowr+wL6SaX2pGlLJl9rFfEllQ6IPXVsYsE2RcMjsR3bDzCmVpGU2M6mg6tTE0Cc15cH5GuhbpTaGYcivrwJlyh4Ao4Gm8Uth7O0KoL2ZDObhnFaOU6jpRzgQ0Hsffz+ZMG0AAIJHkWh6s4aLlQtzQJBCAhWYaxEQ4TjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT/e1eVI; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT/e1eVI"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so13189366b.1
        for <connman@lists.linux.dev>; Thu, 24 Sep 2026 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790283026; x=1790887826; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRdYX5GAbWKSPeRZEXRiFuadMNoLyisCdAF1J3LeFHI=;
        b=jT/e1eVIiePeIUAli7E+o7tlJFBNGKOpWpUAVSwSkYvroKwHA9/73FYIiB6yKC9Iso
         JxC9Xf9V8x1F5CkXiYk9WPRXPy9AWH7KVapQzfGo3Q1p1oQI1tilbAbp3ZQPmSOgGXiY
         qa+B/m9BY9hwWiKpdNWsS7R047/2so4sc61MtQWXNhu7PBfzzHz+wmNkxLhc3mY7OeOm
         RDumQgLhtBV8taaX9FmOlN7fAKpO58h3SYUqg4il9i/wmDFIW72+hhl1Wm4ZqedMrFW8
         4nD8UO0F7boZ8LHyidSRO0aqdOdk/QugpJUh1R2BSwq25cM4uJtMsiSz2w589Gt6WROK
         Y9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283026; x=1790887826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRdYX5GAbWKSPeRZEXRiFuadMNoLyisCdAF1J3LeFHI=;
        b=mN7rSpZ96F1xeKbAQbIDNo8erMKmPIoDMUC6nPGPshZcvODlNn/Lnj/yi053pw0odo
         M2qQICjWApc5gDY9ADlguMflu625dPL+SqdZDALDuswIZSo/2XtBB8KaOHXHS5ww0vqQ
         Hm9yBiaPdEnX9XPxOo3ktNbZFnwOdXAvITH5zKCWILT8PzjXdZqYvKYEb2f5Fi+U14VP
         l8GAi4w7rdV53TZi0ZMdffTJuJ5CMCZBr9zCvm3fvUAoiTIiGakrmsB3sZ5pUCu4Rlkd
         4QSSuott8PWyPQp0YXVJ1ZuWG6vhmOVc/HlmFRXMgwBHxh85EONyAkpC+x2wxZ5eqM0e
         X3wA==
X-Gm-Message-State: AFuF++lMRFhNSj0RcZhqPEkb7LVxOkCxZEnXaSXOS7nR8J04VZ1vjwn3
	ANZOkfbDBITxMSNuO6jQVqfpt5dnzlsyGZI+D/Mmdq8w2rtkcyBftjIWbmZzGeJq
X-Gm-Gg: AYBFou3mJ3gnz0HVbqios6FN4fTWzMGj1NmO06DP0j/JH6ZW4g1V+ztJ/SYS/BdfOvL
	LSuPIvRVNe3rSZkYihKITbrdyKNYWyR/K1dfNeeLbs1DjPPyN13+onnngodGNPjO+KKejA5KnGU
	NLWL2paAbLVxj75L3xDdhYVd6h0VfwjUnK4FD0tmSO2h2Xhwt1aBCpoAcV6Z+ZOwVO0cyOdw+1R
	Xv6jUqTjJYIwXhePQJO9x3/OJZa+umk8WY/cqk3BjpaOJOMU8rj6d3WYWuq3kKoPj5YoM3aqZYR
	g0aQeT3WbqRtM4gulKFjfM5W2laWO8PgiVsCuJSVkLQWTv+brHQejSCT34Keei660UMIFsw7LHQ
	OKOlVB/29TZHiN9/fjk7lw964+m7pYZ63eC3Y28IcNxUvznd+eczK44zFQzu7G4xjPtacKDW7WJ
	dDoaF2VH4HQrvzJCAc9KRn3wh+mfJkJzHvB2PtEw95VnvIN700dFHqDWiKfwlqeBKYapIdRmmaR
	M289i1VwgkWhlSCo0gb1D0t//RJZ0wDUDFQRYtxxHXhhB4ipG7ydvQWiVe+4RT9aS/cpIbwmmUR
	4GfkM6yywpMp
X-Received: by 2002:a17:906:9fce:b0:c29:d0a8:79d3 with SMTP id a640c23a62f3a-c2ac2334081mr340091366b.14.1790283025888;
        Thu, 24 Sep 2026 13:50:25 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:f9f:8b99:f50:b966? (2a02-a466-68ed-1-f9f-8b99-f50-b966.fixed6.kpn.net. [2a02:a466:68ed:1:f9f:8b99:f50:b966])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7358f29sm13144366b.20.2026.09.24.13.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 13:50:25 -0700 (PDT)
Message-ID: <a2f87a14-ebf1-4e9c-9d08-f4d58b9ed9b0@gmail.com>
Date: Thu, 24 Sep 2026 22:50:20 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection to a WPA2 Wi-Fi router fails
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Galea?= <fgalea@free.fr>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>,
 "wbx@openadk.org" <wbx@openadk.org>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 19-05-2026 om 16:16 schreef Dembianny Sven (BSH GDE-EDSD7):
> Hi Michael,
> 
> I don't think so, e.g., if AP does not support SAE but repeater does, roaming will fail.
> This will also break certification tests.
> 
> @ François do you have more info about your setup, e.g. MFP setting on AP/wpa_supplicant config/WPA-PSK-SHA256 instead of WPA-PSK?

I may have the same problem. I first detected on 1.43 now on 2.0 (Yocto) 
and no change.
But it may also be caused by my 2 different fritz boxes in a mesh. One 
is a slave (7581) of the other (7590 AX).
Can connect by pressing WPS.>
> Best regards, Sven
> 
>> -----Original Message-----
>> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
>> Sent: Dienstag, 12. Mai 2026 11:33
>> To: François Galea <fgalea@free.fr>; Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
>> Cc: connman@lists.linux.dev; wbx@openadk.org
>> Subject: Re: Connection to a WPA2 Wi-Fi router fails
>>
>> Hi
>>
>> On Tue, May 12, 2026 at 11:14 AM François Galea <fgalea@free.fr> wrote:
>>>
>>> Hello,
>>>
>>> This was tested on a Zynq (Cortex-A9) and a RPi4, on a 32-bit Arm
>>> Buildroot Linux system.
>>>
>>> The Wi-Fi router uses WPA2 Personnal authentication.
>>>
>>> Problem starts from buildroot releases including connman 1.45.
>>> Previous releases using connman 1.44 and prior are working fine. Also
>>> switching from 1.45 to 1.44 in a buildroot version that includes connman 1.45 works.
>>>
>>>
>>> If a connection was previously successfully set up, for instance from
>>> connman 1.44 or older, `/var/log/messages` contains:
>>>
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: Adding interface wlan0
>>> [ wifi ] Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {update}
>>> flags
>>> 36867 <UP>
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2
>>> address 9A:8F:85:81:67:B4 mtu 1500 Jan  1 00:00:11 zest daemon.info
>>> connmand[141]: eth0 {newlink} index 2 operstate 2 <DOWN> Jan  1
>>> 00:00:11 zest daemon.info dbus-daemon[120]: [system] Successfully
>>> activated service 'fi.w1.wpa_supplicant1'
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
>>> 36931 <UP,RUNNING>
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index
>>> 4 address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
>>> connmand[141]: wlan0 {newlink} index 4 operstate 0 <UNKNOWN> Jan  1
>>> 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
>>> 36867 <UP>
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index
>>> 4 address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
>>> connmand[141]: wlan0 {newlink} index 4 operstate 2 <DOWN> Jan  1
>>> 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
>>> address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
>>> connmand[141]: wlan0 {newlink} index 4 operstate 2 <DOWN> Jan  1
>>> 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ]
>>> state is association Jan  1 00:00:11 zest daemon.warn connmand[141]:
>>> Interface wlan0 [ wifi ] error "invalid-key"
>>> Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi
>>> ] state is failure
>>>
>>>
>>> Otherwise, when creating a new connection:
>>>
>>> # connmanctl
>>> Error getting VPN connections: The name net.connman.vpn was not
>>> provided by any .service files
>>> connmanctl> services
>>>
>>> connmanctl> enable wifi
>>> Enabled wifi
>>> connmanctl> scan wifi
>>> Scan completed for wifi
>>> connmanctl> services
>>>       Kamoulox             wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>>>       Livebox-D050
>>> wifi_8c3d16200e4a_4c697665626f782d44303530_managed_psk
>>>       Freebox-3B4B3C
>>> wifi_8c3d16200e4a_46726565626f782d334234423343_managed_psk
>>>       patetalex            wifi_8c3d16200e4a_7061746574616c6578_managed_psk
>>>       DRAME                wifi_8c3d16200e4a_4452414d45_managed_psk
>>> connmanctl> agent on
>>> Agent registered
>>> connmanctl> connect wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>>> Agent RequestInput wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>>>     Passphrase = [ Type=psk, Requirement=mandatory, Alternates=[ WPS ] ]
>>>     WPS = [ Type=wpspin, Requirement=alternate ] Passphrase?
>>> my_wifi_passphrase Agent ReportError
>>> wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
>>>     invalid-key
>>> connmanctl> Retry (yes/no)? no
>>> Error
>>> /net/connman/service/wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk:
>>> Input/output error
>>> connmanctl>
>>
>>
>> I think that change only asks the agent who established the connection to try the various method. Is
>> the patch in attach work?
>> * sven *: Does it cover your use case too?
>>
>> Michael
>>
>>
>>>
>>>
>>>
>>>   From both situations it appears the wifi passphrase is not accepted.
>>>
>>> wbx (as CC of this email) noticed that reverting commit
>>> 5e73b55e00b97e1867397258b72f0d6e5ad7d31d allows connections to work again.
>>>
>>> Is it a known situation? Is there a patch available?
>>>
>>> Best,
>>>
>>> François
>>>
>>>
>>
>>
>> --
>> Michael Nazzareno Trimarchi
>> Co-Founder & Chief Executive Officer
>> M. +39 347 913 2170
>> michael@amarulasolutions.com
>> __________________________________
>>
>> Amarula Solutions BV
>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172 info@amarulasolutions.com
>> http://www.amarulasolutions.com/
>> &data=05%7C02%7Csven.dembianny%40bshg.com%7Cf4aa618e280e45c3d76e08deb0096f57%7C0ae5
>> 1e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C639141751758647935%7CUnknown%7CTWFpbGZsb3
>> d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
>> %3D%3D%7C0%7C%7C%7C&sdata=8tD7KmAQSPxg%2BRZ0yB7MYBeWVudCjvw4T4MJhOHy3%2Fk%3D
>> &reserved=0


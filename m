Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A3156F5C
	for <connman@lists.linux.dev>; Mon, 15 Apr 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216644; cv=none; b=ZZaq09ff7j4GF3HMbhp+wrtXuEGN/3z727rBM0DJUbtXbng8pCwHSICentpWhtgJGfcmrvrJ8iYiHM5xV5TZwBGNNKDhvMhE+MxZFmmA3BcoqX3C7+fwgZ6snrcIznyHmlxm69KnhWtcXaJIVXuylkxzRoKPGLEW2brqAliwDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216644; c=relaxed/simple;
	bh=xkO1tWrRGpG+mhf5OMUxqVsB7FS8SAMYjgGhHSdNooQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PKS1Zw/DKJnFdsYCUo5DjGLj5bctVZetQF6PRY5VlVaSUWQzTB38z9V4N5nhi3jxPmsEJ+8C/AFePrH5EF5aEMfX1J3TrbnFwfvTirceDOa/WdwqT5buwYWjpWFXUheQmJsdiq/C9k2k1E5j8BzC9n4wvmHlSCrFILL2EauzJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPyv7baS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPyv7baS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5224dfa9adso591822366b.0
        for <connman@lists.linux.dev>; Mon, 15 Apr 2024 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216641; x=1713821441; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj0X85oy5HzBelqj8dYJ4Hl1NfKGHCQniuLCls6uGpM=;
        b=EPyv7baS25JHqz+SvrXrak68SguYBkvUDasl1Zt/9fdi98wPSTtFyAe3xVxR1i1eeO
         Aj1nveAXmvZ6+vt6OkRGpXr2mJczRPmmIsd6KHh5sRqr0msTHkVeW5ilTgXLNO7SaN0D
         uxDta9b/uLlJKjSd9IORfeQw+Gtje3wCfbiqXO3wKVpsStGikpsCCozHJwtDbEVDOriy
         HmVnNs+8p/t9R+lII4oEpITfpHjTRpUIbKPjc3aEtRuS5VkIBGRyBYcazrIO8jfDGarK
         ZWCYx6G0oRFno0tKuiT7LLTAsvCS3qH7oSSoO4RdWaH9l4KNiODm+BsUoyM9jg8lDgh3
         2sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216641; x=1713821441;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lj0X85oy5HzBelqj8dYJ4Hl1NfKGHCQniuLCls6uGpM=;
        b=n2fRNNkhUE8/8dIlXVXU0SkrxcaMm1kTiWeENuzFhiPqfPdYBpJSzOF2dVSempyp4N
         Hltw4MrJm7hjDMojeaGbKx3wAUZwlMIcVpPZj+dUYGRY2N1rI6RaHd17wkyOvlRpKe59
         b4mq3RISfIORTcNOcLcQfeO7ANB3UeerTLkoC7QtQFNwLI5WVSgnaBQzCc+MNF/7KdyM
         bQwXPw574p4OALtVS+rbxLi13W8mEscIIso26pjEq9h/86wRI/QIe8yBNrwSFtG6ANR0
         ZLlzU6TgkXRIiN+xZu7ClD5PDmO75afFHOwcoEg8d0CO9Hkpxw706QYDsS4NsBBVdZSP
         64UQ==
X-Gm-Message-State: AOJu0YzkZaA/PRslOF7UVTaCErzfWN8C8CCif0+G+z6ereQIT6Tfd4Hp
	ABMz4xN7SvLMT0gJp6jH/9QXRTEsz8rovTqNPTBMKirT4a7phcPPdg2hqw==
X-Google-Smtp-Source: AGHT+IFlxtcnRDgIGrOJXKlIbTELCx8KHTzCSX/llsS/z2vDcvbyjo9+CSBHnLrPh4KxGbMuH6Bd8Q==
X-Received: by 2002:a17:906:3bd8:b0:a51:c311:8199 with SMTP id v24-20020a1709063bd800b00a51c3118199mr677901ejf.31.1713216640924;
        Mon, 15 Apr 2024 14:30:40 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:69d0:6c15:85da:6652? (2a02-a466-68ed-1-69d0-6c15-85da-6652.fixed6.kpn.net. [2a02:a466:68ed:1:69d0:6c15:85da:6652])
        by smtp.gmail.com with ESMTPSA id nb17-20020a1709071c9100b00a4e6582edf8sm5853345ejc.102.2024.04.15.14.30.40
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:30:40 -0700 (PDT)
Message-ID: <6b98f4fd-c3f7-4ea3-88cc-3f8fc4f08be2@gmail.com>
Date: Mon, 15 Apr 2024 23:30:39 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: connman@lists.linux.dev
From: Ferry Toth <fntoth@gmail.com>
Subject: Create tiny ethernet router
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a device with 2 ethernet ports. Can I get connman to setup the 
network to route traffic from the one port to the other?

I guess I would need to tether one of them? Then how would I do that?

TLDR;

Actually I have 2 devices, both are Intel Edison-Arduino. These can 
setup the usb port in either host or device mode. The one in device mode 
has a eem gadget (ethernet over usb).
The other in host mode has a smsc95xx usb to eth+4p usb hub.

As it is the one in host mode has 2 eth devices:
root@edison:~# ifconfig
enp0s17u1u1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 192.168.178.70  netmask 255.255.255.0  broadcast 
192.168.178.255
         inet6 fe80::280:fff:fe95:1d4d  prefixlen 64  scopeid 0x20<link>
         inet6 2a02:a466:68ed:1:280:fff:fe95:1d4d  prefixlen 64  scopeid 
0x0<global>
         ether 00:80:0f:95:1d:4d  txqueuelen 1000  (Ethernet)
         RX packets 781536  bytes 224464657 (214.0 MiB)
         RX errors 0  dropped 184984  overruns 0  frame 0
         TX packets 17923  bytes 2037451 (1.9 MiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp0s17u1u5i1: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 
1500
         inet 169.254.45.35  netmask 255.255.0.0  broadcast 169.254.255.255
         inet6 fe80::f4dc:3cff:fe83:4503  prefixlen 64  scopeid 0x20<link>
         ether f6:dc:3c:83:45:03  txqueuelen 1000  (Ethernet)
         RX packets 6660  bytes 3459572 (3.2 MiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 7365  bytes 3973982 (3.7 MiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

The one device can ping/ssh into the other. But I'd like the device in 
host mode to setup a dhcp server and route the traffic.

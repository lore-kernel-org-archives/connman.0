Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCD3222
	for <connman@lists.linux.dev>; Thu,  8 Sep 2022 13:52:20 +0000 (UTC)
Received: from [IPV6:2803:9800:98cb:8db7:4252:e928:3623:abff] (unknown [IPv6:2803:9800:98cb:8db7:4252:e928:3623:abff])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: adalessandro)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A3DA6601F91
	for <connman@lists.linux.dev>; Thu,  8 Sep 2022 14:52:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1662645138;
	bh=wvEoHYdWa5blLssiO8hAnB331H78mqNWwEXPCasFGC8=;
	h=Date:To:From:Subject:From;
	b=V7yMd2q0xhWmLl84RH0gCa4BoAU4ONp5jNNtKwity9WnIFoeZ+cOpuTcebovK8B9W
	 s5jbb63daIjKt8rFFUIgEM1BUYKepHJ/K0DP3aM00YHSCl9o7X7XVVQSqxrmP55ex1
	 erNVo0kUCYIDnPRfPozmfMgrD9kphkpMZ8lsGTLMhf6IrSarRb0lHdcE8RrhalrzC2
	 E76sNpFJFnWH2zLYlnpwBaqcAzCJnFkXCdeRk8UICVF+cevAoyzISut1VZK7Zze2lg
	 xhFGPchzQDVxzRjQZ7FZrEDGiW8Opc76nCK7ICQTlNNSEQAB6i5qbd+VvzkFQDKUc8
	 uCzrPSo2RzYjw==
Message-ID: <ef8ef3d5-3786-6064-605b-7d668a8d92bb@collabora.com>
Date: Thu, 8 Sep 2022 10:52:11 -0300
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: No password prompt after wrong entry
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

I have a question regarding the expected behavior on connmanctl.

After trying to connect to a network using a wrong password, connman
returns `connect-failed`. Further attempts to connect won't prompt for a
new password, so it will use the same old wrong one and keep returning
`connect-failed`.

After manually removing the network, re-connecting will prompt for a new
password and the connection will succeed. Is this the expected behavior
or it should automatically prompt after a wrong password entry?

See logs:

```
connmanctl> connect wifi_42ed868596d0_415045525449535f4150_managed_psk
Agent RequestInput wifi_42ed868596d0_415045525449535f4150_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? 123456789
Agent ReportError wifi_42ed868596d0_415045525449535f4150_managed_psk
  connect-failed
Agent request cancelled by ConnMan
Error
/net/connman/service/wifi_42ed868596d0_415045525449535f4150_managed_psk:
Input/output error

connmanctl> connect wifi_42ed868596d0_415045525449535f4150_managed_psk
Agent ReportError wifi_42ed868596d0_415045525449535f4150_managed_psk
  connect-failed
Agent request cancelled by ConnMan
Error
/net/connman/service/wifi_42ed868596d0_415045525449535f4150_managed_psk:
Input/output error

connmanctl> config wifi_42ed868596d0_415045525449535f4150_managed_psk
--remove

connmanctl> connect wifi_42ed868596d0_415045525449535f4150_managed_psk
Agent RequestInput wifi_42ed868596d0_415045525449535f4150_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? 12345678
Connected wifi_42ed868596d0_415045525449535f4150_managed_psk
Agent unregistered by ConnMan

connmanctl>
```

Thanks in advance,
Ariel D'Alessandro
--
Collabora Ltd.
www.collabora.com

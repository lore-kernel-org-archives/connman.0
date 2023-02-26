Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95467649
	for <connman@lists.linux.dev>; Sun, 26 Feb 2023 10:44:35 +0000 (UTC)
Date: Sun, 26 Feb 2023 10:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1677408260; x=1677667460;
	bh=E42795e31yE64IiPh/OlBkWHlKUhOLKQ3LpF+WGcYNA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=l81PNjpnTu0LyWDIeYLVMSRefmKHgN1P31hqroQ9uvmcZTxnWCqNlLbZMsswaBFez
	 q+O+YSxHxWmu5D1nBDipqAWiRYl1mcLW9mSu43vp/x0lCGElzVGPzBLoMPCM1bN3IO
	 E9iP1ZNo1AZMOvcCpNCebJO0t4pdiASbHxsixc31w3/JManRRuTx4BAfLmtNcE0F3D
	 gxLjcXBukc2KH6sGVxKF0gcqZhon0je/IcVEaM8lmBkev/r1Xc/g7s4D/MWW9u5vz5
	 QCcE3+F+koqwIM9uROpk0FvILhcAF/jdExJsYXJsV5OdwwSAejZZv0xr2EyO9V/fuy
	 hh8TeNQci/vog==
To: connman@lists.linux.dev
From: Piotr Karbowski <piotr.karbowski@protonmail.ch>
Subject: No 6GHz networks found if connman does the scan, but connman see them if 'iw DEV scan' used instead.
Message-ID: <2712e513-6def-4ed1-d88a-68c961f995e3@protonmail.ch>
Feedback-ID: 7579861:user:proton
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It seems like whenever connman does scan for the networks it will never
see the 6 GHz one (wifi 6e) in the list of services. However if I use
'iw' to scan, then the connmanctl services does see them and even allow
me to connect to them.

It looks like this with connman's scan:

     # connmanctl scan wifi && connmanctl services |grep 6G
     Scan completed for wifi
     #

And when i use iw to scan:

     # iw wlan0 scan >/dev/null && connmanctl services |grep 6G
     redacted_6G_1     wifi_redacted_redacted_managed_psk
     #

The related software and hardware:

- connman: net-misc/connman-1.42_pre20221103 (git
82ce08135a14ef4ab5b5b60f1e426a26b9fc72fc 2022-10-27)
- net-wireless/wpa_supplicant-2.10-r1
- wireless network card: Intel AX210 with firmware
iwlwifi-ty-a0-gf-a0-68.ucode (newer firmware were very unstable so I
forced kernel to use this one)
- kernel: 6.1.13
- 6 GHz radio AP: Asus axe16000 (Firmware 388.1 Merlin)

Let me know if there's any other information that might be helpful.

-- Piotr.





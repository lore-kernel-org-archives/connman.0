Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8328CF4A
	for <connman@lists.linux.dev>; Tue, 11 Aug 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469411; cv=none; b=UuPeZ/uA/oRn3IWFY0S0Kw39LtAoqwLQ1uJNIaQfuku+6VcQ7XIA8gUnbxyVbSRjw4fULIpdxVTovFJ+gl1tzoDJtHN1H5kxCP6au1e/1M8QwSzQhX4IyRWB4eceQGZ3mL4RO5QfK+WS/y67aagZfXqb7c6EluJOVoBOup6RezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469411; c=relaxed/simple;
	bh=YVn3G9yQ84FXubCUrQ4OcEbkFPnGjCjB0Sg+a2l4aw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnqzDYdo1HRepR26vG0NF7K19E0zv0y5CMWcEC2YaYbR7Ql0bUfkKRBWCx6HE25myw5wELPhxvGgFVm7PULtjYKudDDnvjYGiLRtsXL1HJ8BxxNTZZiOt94tEV/CvPOUo2w6lf87DMQ67RF5PrdEXeVashBdHpIMbDAMdgIMRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=DpHIojte reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="DpHIojte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1786469401; bh=YVn3G9yQ84FXubCUrQ4OcEbkFPnGjCjB0Sg+a2l4aw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpHIojtejDwUJbEgjIf2qdLeBeT6I4i1udtoz/zuQPKwKW4FxwwNoY8AJX2U0gPTs
	 aKtBwCBI5WQW3/JKldPJ+eSwUmI7eHC3KclrPNgjuo7i/JqtLXHcaNQJUiQ5yLaAi+
	 dybP0TXmBzNtxbqeH7kUy45KCPwnbZJBPtkqeVGASwNYi9lPGKUuAxTs+5ydd78bXp
	 DXypPt1qi97LgUP4UbFlYI58Z6eJLB5qlxS0ADCEK48+9V/1rd1xGxXA2AVEY5TjAR
	 0v1okCnQLVF1IbCGspMHoisL1btvMwf3xfs9pwmDIs5cmnDXuOhcz+Byw2KBvnhyoL
	 q8GHnPFijUI0w==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id BC49931E0C1E; Tue, 11 Aug 2026 19:30:01 +0200 (CEST)
Date: Tue, 11 Aug 2026 19:30:01 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Galea <fgalea@free.fr>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>,
	"wbx@openadk.org" <wbx@openadk.org>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
Message-ID: <antcGRBvImhKFSyu@waldemar-brodkorb.de>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64

Hi Sven,
Dembianny Sven (BSH GDE-EDSD7) wrote,

> Hi Waldemar,
> > 
> > Hi Sven,
> > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > 
> > > Hi Michael,
> > >
> > > I don't think so, e.g., if AP does not support SAE but repeater does, roaming will fail.
> > > This will also break certification tests.
> > >
> > > @ François do you have more info about your setup, e.g. MFP setting on AP/wpa_supplicant
> > config/WPA-PSK-SHA256 instead of WPA-PSK?
> > 
> > Sorry for the late reply. Francois seems not to answered your question and I see no fixes for this
> > problem in GIT master either.
> > 
> > My AP is a standard Vodafone AP with WPA2.
> > How can I give you better information about the details of this AP?
> What model is being used?

Vodafone Wifi 6.
It is this one:
https://www.vodafone.de/downloadarea/CGA6444VF-DMS3-CTC-25-593_v2.0_German_public_20210511.pdf

> It is possible that MFP is additionally configured as optional. Could you please check the AP settings or the beacon frames?

It seems not.
See:
sudo iw dev wlan0 scan | grep -A20 -B2 'Vodafone-C30C'
	last seen: 84 ms ago
	Information elements from Probe Response frame:
	SSID: Vodafone-C30C
	Supported rates: 1.0* 2.0* 5.5* 11.0* 18.0 24.0 36.0 54.0
	DS Parameter set: channel 11
	Country: DE	Environment: Indoor/Outdoor
		Channels [1 - 13] @ 20 dBm
	TPC report: TX power: 18 dBm
	ERP: Barker_Preamble_Mode
	Extended supported rates: 6.0 9.0 12.0 48.0
	RSN:	 * Version: 1
		 * Group cipher: CCMP
		 * Pairwise ciphers: CCMP
		 * Authentication suites: PSK
		 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
	BSS Load:
		 * station count: 2
		 * channel utilisation: 31/255
		 * available admission capacity: 0 [*32us]
	RM enabled capabilities:
		Capabilities: 0x72 0x00 0x00 0x00 0x00
			Neighbor Report
			Beacon Passive Measurement
--
	signal: -72.00 dBm
	last seen: 3208 ms ago
	SSID: Vodafone-C30C
	Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
	TIM: DTIM Count 0 DTIM Period 1 Bitmap Control 0x0 Bitmap[0] 0x0
	Country: DE	Environment: Indoor/Outdoor
		Channels [36 - 64] @ 23 dBm
		Channels [100 - 140] @ 30 dBm
	Power constraint: 0 dB
	TPC report: TX power: 23 dBm
	RSN:	 * Version: 1
		 * Group cipher: CCMP
		 * Pairwise ciphers: CCMP
		 * Authentication suites: PSK
		 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
	BSS Load:
		 * station count: 6
		 * channel utilisation: 6/255
		 * available admission capacity: 0 [*32us]
	RM enabled capabilities:
		Capabilities: 0x72 0x00 0x00 0x00 0x00
			Neighbor Report
			Beacon Passive Measurement

 
> Also, what firmware version is running on the Raspberry Pi 4? The firmware files should be located under:
> /lib/firmware/

That is the dmesg output after loading the Wifi driver in Buildroot:
[  249.369934] brcmfmac: F1 signature read @0x18000000=0x15264345
[  249.373427] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[  249.382449] usbcore: registered new interface driver brcmfmac
[  249.618723] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob available (err=-2)
[  249.626771] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID 01-b677b91b

But at the moment I am fighting with connmanctl, it seems I cannot
scan wifi anymore:
# connmanctl scan wifi
Error /net/connman/technology/wifi: Not supported
# connmanctl enable wifi
wifi is already enabled
# connmanctl scan wifi
Error /net/connman/technology/wifi: Not supported
# connmanctl technologies
/net/connman/technology/ethernet
  Name = Wired
  Type = ethernet
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 2412
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
  TetheringFreq = 2412

I can scan wifi with iw on the RPI4.

best regards
 Waldemar



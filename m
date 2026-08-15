Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1535C68A
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774388; cv=none; b=BqnXV6uepg9aG3QJEu1dLW4HJLkU0IxV1DMIIHFceB5pqIDbDIs79ASUs4GY3Z77cG8PPExbq/KMOOblppYivq+huJ/KEP3kcsSc8fzCWPs6W6xEtwQz7s9wRPzBWmasuEfP6FbGSrGok9P13FjmJ7Er4MEuEfR0jahq+aM5LOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774388; c=relaxed/simple;
	bh=SEzKY8R5H+RvKE49WK5pGACtOudhMUJI/dXCW4Svb2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY+Yu7oSJvKEQzZeL4RzQssovIiKHp6dxk3ayMgdb/SWyO4HaX8o3mr8WEUbDDrvjERpcYwiys60/2xla8Jgp1e5vDQ7cBlo1SREsGwQDjH3O0u5Ef0mDasW4R2K6uGlKFvpCktQ3vVHlKwwj7X5PW1TVinjaZFabwp8avI+Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=naWjTo73 reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="naWjTo73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1786774378; bh=SEzKY8R5H+RvKE49WK5pGACtOudhMUJI/dXCW4Svb2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naWjTo73Ogbh5M7ngzGRWttm2L7Y26gaqPOusESIfix+4ckczTc4EWk9/VUAuCjD/
	 uwfvLn2QHMEtSmWtdeP2kjMBxVuoeTz7dOfEn2mq7mYY3znjnOazEfhRRkKyS2Ijbm
	 xLhv+9znwzPZ6mIHfjj50HAAYp/Og9E01DNhtDUFLic1XprpWJD2QGMTMLwon9h1K+
	 /WqeHbdVAR8q5S2x8NKhM3Fb+DvRUohkmqjlMHFA6UbIqrtmJoS816P0ip6aM4NoVm
	 GragjU9ZKDekxUg1q5Js1vmjQUP5L8ecocRPFhMpg30wDJdhBbjBTToq1kmEnn8VRk
	 SQm5lUhA9A11Q==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id E22DA31E0C1E; Sat, 15 Aug 2026 08:12:58 +0200 (CEST)
Date: Sat, 15 Aug 2026 08:12:58 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Galea <fgalea@free.fr>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
Message-ID: <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64

Hi Sven,

but without even the possibility to scan I am not able to reproduce
the initial bug anymore. Do you have an idea why connmanctl scan
wifi fails for me?

I use Buildroot master (tried arm and aarch64), enable the wifi
firmware and connman. After booting with the SD card I stop connmand
/etc/init.d/S45connman stop
modprobe brcmfmac
/etc/init.d/S45connman start
connmanctl enable wifi
connmanctl scan wifi

Error /net/connman/technology/wifi: Not supported

When I add -d for debug information before I start connmand, I see
in the log that wlan0 is recognized:
Jan  1 00:01:11 buildroot daemon.info connmand[232]: Adding interface eth0 [ ethernet ]
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/technology.c:technology_find() type 2
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/rtnl.c:rtnl_message() NEWLINK len 1476 type 16 flags 0x0002 seq 0 pid 232
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/ipconfig.c:__connman_ipconfig_newlink() index 3
Jan  1 00:01:11 buildroot daemon.info connmand[232]: wlan0 {create} index 3 type 1 <ETHER>
Jan  1 00:01:11 buildroot daemon.info connmand[232]: wlan0 {update} flags 4098 <DOWN>
Jan  1 00:01:11 buildroot daemon.info connmand[232]: wlan0 {newlink} index 3 address E4:5F:01:16:5A:26 mtu 1500
Jan  1 00:01:11 buildroot daemon.info connmand[232]: wlan0 {newlink} index 3 operstate 2 <DOWN>
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/detect.c:detect_newlink() type 1 index 3
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connman_device_create() node e45f01165a26 type 2
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connman_device_create() device 0x5599d3a8f0
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connman_device_set_string() device 0x5599d3a8f0 key Address value E4:5F:01:16:5A:26
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/device.c:connman_device_register() device 0x5599d3a8f0 name Wireless
Jan  1 00:01:11 buildroot daemon.info connmand[232]: Adding interface wlan0 [ wifi ]
Jan  1 00:01:11 buildroot daemon.debug connmand[232]: src/technology.c:technology_find() type 3


Any idea?

best regards
 Waldemar

Dembianny Sven (BSH GDE-EDSD7) wrote,

> Hi Waldemar,
> 
> yes, that seems reasonable. We need additional information to better understand what is happening.
> Could you please provide a wpa_supplicant log with debug logging enabled?
> 
> Best regards, Sven
> > -----Original Message-----
> > From: Waldemar Brodkorb <wbx@openadk.org>
> > Sent: Dienstag, 11. August 2026 19:30
> > To: Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> > Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>; François Galea <fgalea@free.fr>;
> > connman@lists.linux.dev; wbx@openadk.org
> > Subject: Re: Connection to a WPA2 Wi-Fi router fails
> >
> > Hi Sven,
> > Dembianny Sven (BSH GDE-EDSD7) wrote,
> >
> > > Hi Waldemar,
> > > >
> > > > Hi Sven,
> > > > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > > >
> > > > > Hi Michael,
> > > > >
> > > > > I don't think so, e.g., if AP does not support SAE but repeater does, roaming will fail.
> > > > > This will also break certification tests.
> > > > >
> > > > > @ François do you have more info about your setup, e.g. MFP
> > > > > setting on AP/wpa_supplicant
> > > > config/WPA-PSK-SHA256 instead of WPA-PSK?
> > > >
> > > > Sorry for the late reply. Francois seems not to answered your
> > > > question and I see no fixes for this problem in GIT master either.
> > > >
> > > > My AP is a standard Vodafone AP with WPA2.
> > > > How can I give you better information about the details of this AP?
> > > What model is being used?
> >
> > Vodafone Wifi 6.
> > It is this one:
> > https://www.vodafone.de/download
> > area%2FCGA6444VF-DMS3-CTC-25-
> > 593_v2.0_German_public_20210511.pdf&data=05%7C02%7Csven.dembianny%40bshg.com%7C59663c
> > 7c2d2d49ac217508def7ce2d13%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63922066219
> > 4440574%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ
> > XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ycBjQxmEPcxuLgXBXIMrjCg
> > OsU9mHQ%2B%2B%2B%2BOcVwvkfTg%3D&reserved=0
> >
> > > It is possible that MFP is additionally configured as optional. Could you please check the AP settings
> > or the beacon frames?
> >
> > It seems not.
> > See:
> > sudo iw dev wlan0 scan | grep -A20 -B2 'Vodafone-C30C'
> >       last seen: 84 ms ago
> >       Information elements from Probe Response frame:
> >       SSID: Vodafone-C30C
> >       Supported rates: 1.0* 2.0* 5.5* 11.0* 18.0 24.0 36.0 54.0
> >       DS Parameter set: channel 11
> >       Country: DE     Environment: Indoor/Outdoor
> >               Channels [1 - 13] @ 20 dBm
> >       TPC report: TX power: 18 dBm
> >       ERP: Barker_Preamble_Mode
> >       Extended supported rates: 6.0 9.0 12.0 48.0
> >       RSN:     * Version: 1
> >                * Group cipher: CCMP
> >                * Pairwise ciphers: CCMP
> >                * Authentication suites: PSK
> >                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
> >       BSS Load:
> >                * station count: 2
> >                * channel utilisation: 31/255
> >                * available admission capacity: 0 [*32us]
> >       RM enabled capabilities:
> >               Capabilities: 0x72 0x00 0x00 0x00 0x00
> >                       Neighbor Report
> >                       Beacon Passive Measurement
> > --
> >       signal: -72.00 dBm
> >       last seen: 3208 ms ago
> >       SSID: Vodafone-C30C
> >       Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
> >       TIM: DTIM Count 0 DTIM Period 1 Bitmap Control 0x0 Bitmap[0] 0x0
> >       Country: DE     Environment: Indoor/Outdoor
> >               Channels [36 - 64] @ 23 dBm
> >               Channels [100 - 140] @ 30 dBm
> >       Power constraint: 0 dB
> >       TPC report: TX power: 23 dBm
> >       RSN:     * Version: 1
> >                * Group cipher: CCMP
> >                * Pairwise ciphers: CCMP
> >                * Authentication suites: PSK
> >                * Capabilities: 16-PTKSA-RC 1-GTKSA-RC (0x000c)
> >       BSS Load:
> >                * station count: 6
> >                * channel utilisation: 6/255
> >                * available admission capacity: 0 [*32us]
> >       RM enabled capabilities:
> >               Capabilities: 0x72 0x00 0x00 0x00 0x00
> >                       Neighbor Report
> >                       Beacon Passive Measurement
> >
> >
> > > Also, what firmware version is running on the Raspberry Pi 4? The firmware files should be located
> > under:
> > > /lib/firmware/
> >
> > That is the dmesg output after loading the Wifi driver in Buildroot:
> > [  249.369934] brcmfmac: F1 signature read @0x18000000=0x15264345 [  249.373427] brcmfmac:
> > brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6 [  249.382449] usbcore:
> > registered new interface driver brcmfmac [  249.618723] brcmfmac: brcmf_c_process_txcap_blob: no
> > txcap_blob available (err=-2) [  249.626771] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID 01-b677b91b
> >
> > But at the moment I am fighting with connmanctl, it seems I cannot scan wifi anymore:
> > # connmanctl scan wifi
> > Error /net/connman/technology/wifi: Not supported # connmanctl enable wifi wifi is already enabled #
> > connmanctl scan wifi Error /net/connman/technology/wifi: Not supported # connmanctl technologies
> > /net/connman/technology/ethernet
> >   Name = Wired
> >   Type = ethernet
> >   Powered = True
> >   Connected = False
> >   Tethering = False
> >   TetheringFreq = 2412
> > /net/connman/technology/wifi
> >   Name = WiFi
> >   Type = wifi
> >   Powered = True
> >   Connected = False
> >   Tethering = False
> >   TetheringFreq = 2412
> >
> > I can scan wifi with iw on the RPI4.
> >
> > best regards
> >  Waldemar
> >
> 

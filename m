Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1832B989
	for <connman@lists.linux.dev>; Mon, 17 Aug 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951130; cv=none; b=p1uG2MlVPSJh3CdOPndFKqSCctfUA0cOoxuGKiDvP51Ot4CZBuh/AQocACmbvqNbYLf4ikVsgMRpoqZPyAFxVzu9iU3fTMK3M9PRPH+nPFWR3Z48HsfEnrpK5ni5JNn6FToSArhE2PMRLsZhwOuJDQcyfJiKkOEA3609RAuEftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951130; c=relaxed/simple;
	bh=1VBw8l3U6bVc1aGKzwEzA5hA1p7gGEQAmwcpGd8w4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm6bmcZWV9XBJ+uE1cm7cXpo+DMTUKKAbedN5NJEmkr59kCsfuvVpbFz1gSDgi7gk2WpZIrm/0jC6U0RiUpyQelSVk7/QBFuBS+tauY7s9skjbl614jOx2/qSX7iitA87tFKoI7c7LG9UMfHoBe8JGV4Q6nOI+YxPNgB6QNt8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=l1OMNNLs reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="l1OMNNLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1786951116; bh=1VBw8l3U6bVc1aGKzwEzA5hA1p7gGEQAmwcpGd8w4xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1OMNNLsx6d/jiJDsrcoEUA4vWh2ArwknXNxVH0YPj/vdToQZ7y7y5OPbDv2QGRIF
	 VTZqSNw/V9UIRTeANOV/9oPdKqJ1nMP2+butNkxn2g1ZckaPwLAt37FmN3x99PQKda
	 eu42GQ1y7fAIwuO0ApsealBnYWxe4Dg401Xx1bwJj+pb0ogbWZqfjRIle0Fz69iYAN
	 6S+mTBo06kPcFZRn8Vzd605hI9xA24JMJlYXGzx8WrousAlCb0av5QKA67eTWtAEn/
	 5lJ88556N3VgEDNb8wfUilPIExJjkNI5/KZ0raNIoJS2hdk3GxQ/LuCGSgOiqKQQqR
	 PNGPGX+IwJTXg==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 6705C31E0AFD; Mon, 17 Aug 2026 09:18:36 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:18:36 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Galea <fgalea@free.fr>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
Message-ID: <aoK1zI10OTh5TX7r@waldemar-brodkorb.de>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
 <VI0PR10MB89081958F1C9D72759AEEC8DF4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Jvn6ICSDNBtJcp7x"
Content-Disposition: inline
In-Reply-To: <VI0PR10MB89081958F1C9D72759AEEC8DF4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64


--Jvn6ICSDNBtJcp7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sven,

Dembianny Sven (BSH GDE-EDSD7) wrote,

> Hi Waldemar,
> 
> no idea at the moment, but this looks like a different issue, potentially an initialization-related topic.

Fair enough. In the meanwhile I switched from Buildroot to OpenADK
(my own embedded system buildsystem) and with that I can reproduce
the original failure. I will investigate the Buildroot error later.

Attached is the output of wpa_supplicant on the console, when I try to
connect to my WPA2 WLAN router. wlan0 is the interface.

Any idea for the original issue?

The only error I see is:
Line 0: invalid key_mgmt 'SAE'

best regards
 Waldemar


--Jvn6ICSDNBtJcp7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="wpa.log"

root@openadk:~ # wpa_supplicant -d -u                                                                                                                               
wpa_supplicant v2.12
random: Trying to read entropy from /dev/random
dbus: Register D-Bus object '/fi/w1/wpa_supplicant1'
Providing DBus service 'fi.w1.wpa_supplicant1'.
Successfully initialized wpa_supplicant
random: Got 20/20 bytes from /dev/random
Initializing interface 'wlan0' conf 'N/A' driver 'nl80211,wext' ctrl_interface 'N/A' bridge 'N/A'
nl80211: Kernel version: Linux 6.18.38-1 (#1 SMP PREEMPT Thu Aug 13 20:32:40 CEST 2026; aarch64)
nl80211: Maximum supported attribute ID: 345
nl80211: Initialize interface wlan0 (driver: brcmfmac)
nl80211: wlan0 wdev_id=0x1
nl80211: Using driver-based roaming
nl80211: TDLS supported
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:6
nl80211: Using driver-based off-channel TX
nl80211: Supported vendor command: vendor_id=0x1018 subcmd=1
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: Enable multi-channel concurrent (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x40d0f enc=0x10f auth=0x7 flags=0x2000000380cfacc flags2=0x20000 rrm_flags=0x0 probe_resp_offloads=0x0 max_stations=0 max_remain_on_chan=5000 max_scan_ssids=10
nl80211: interface wlan0 in phy phy0
nl80211: Set mode ifindex 35 iftype 2 (STATION)
nl80211: Subscribe to mgmt frames with non-AP handle 0x6c5ade0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5ade0 match=7e506f9a1a multicast=0
rfkill: initial event: idx=0 type=1 op=0 soft=0 hard=0
netlink: Operstate: ifindex=35 linkmode=1 (userspace-control), operstate=5 (IF_OPER_DORMANT)
Add interface wlan0 to a new radio phy0
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484
nl80211: Mode IEEE 802.11a: 5170 5180 5190 5200 5210 5220 5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484
Device country code set to '00' from hw feature data at init
wlan0: Own MAC address: e4:5f:01:16:5a:26
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=2 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=3 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=4 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=35 (wlan0) alg=0 addr=(nil) key_idx=5 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wlan0: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
wlan0: State: DISCONNECTED -> INACTIVE
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
PR: Driver does not support Proximity Ranging - PR disabled
dbus: Register interface object '/fi/w1/wpa_supplicant1/Interfaces/0'
wlan0: Added interface wlan0
wlan0: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=35 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Initializing interface 'wlan1' conf 'N/A' driver 'nl80211,wext' ctrl_interface 'N/A' bridge 'N/A'
nl80211: Initialize interface wlan1 (driver: mac80211_hwsim)
nl80211: wlan1 wdev_id=0x100000001
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:10
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:13
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) - hexdump(len=8): 04 00 40 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) - hexdump(len=8): 04 00 40 00 00 00 00 40
nl80211: Supported vendor command: vendor_id=0x1374 subcmd=1
nl80211: Supported vendor event: vendor_id=0x1374 subcmd=1
mbssid: max interfaces 8, max profile periodicity 3
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x105ff0f enc=0xfef auth=0x7 flags=0xe5000d31fb5bfbe0 flags2=0x8f008103 rrm_flags=0x10 probe_resp_offloads=0x0 max_stations=0 max_remain_on_chan=5000 max_scan_ssids=4
nl80211: interface wlan1 in phy phy1
nl80211: Set mode ifindex 44 iftype 2 (STATION)
nl80211: Subscribe to mgmt frames with non-AP handle 0x6c5dfb0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c5dfb0 match=7e506f9a1a multicast=0
rfkill: initial event: idx=1 type=1 op=0 soft=0 hard=0
netlink: Operstate: ifindex=44 linkmode=1 (userspace-control), operstate=5 (IF_OPER_DORMANT)
Add interface wlan1 to a new radio phy1
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[NO_IR][RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
Device country code set to '00' from hw feature data at init
wlan1: Own MAC address: 02:00:00:00:00:00
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=2 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=3 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=4 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=44 (wlan1) alg=0 addr=(nil) key_idx=5 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wlan1: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
wlan1: State: DISCONNECTED -> INACTIVE
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
PR: Driver does not support Proximity Ranging - PR disabled
dbus: Register interface object '/fi/w1/wpa_supplicant1/Interfaces/1'
wlan1: Added interface wlan1
wlan1: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan1 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=44 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Initializing interface 'wlan2' conf 'N/A' driver 'nl80211,wext' ctrl_interface 'N/A' bridge 'N/A'
nl80211: Initialize interface wlan2 (driver: mac80211_hwsim)
nl80211: wlan2 wdev_id=0x200000001
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:10
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:13
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) - hexdump(len=8): 04 00 40 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) - hexdump(len=8): 04 00 40 00 00 00 00 40
nl80211: Supported vendor command: vendor_id=0x1374 subcmd=1
nl80211: Supported vendor event: vendor_id=0x1374 subcmd=1
mbssid: max interfaces 8, max profile periodicity 3
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x105ff0f enc=0xfef auth=0x7 flags=0xe5000d31fb5bfbe0 flags2=0x8f008103 rrm_flags=0x10 probe_resp_offloads=0x0 max_stations=0 max_remain_on_chan=5000 max_scan_ssids=4
nl80211: interface wlan2 in phy phy2
nl80211: Set mode ifindex 45 iftype 2 (STATION)
nl80211: Subscribe to mgmt frames with non-AP handle 0x6c623c0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x6c623c0 match=7e506f9a1a multicast=0
rfkill: initial event: idx=2 type=1 op=0 soft=0 hard=0
netlink: Operstate: ifindex=45 linkmode=1 (userspace-control), operstate=5 (IF_OPER_DORMANT)
Add interface wlan2 to a new radio phy2
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[NO_IR][RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
Device country code set to '00' from hw feature data at init
wlan2: Own MAC address: 02:00:00:00:01:00
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=2 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=3 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=4 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=45 (wlan2) alg=0 addr=(nil) key_idx=5 set_tx=0 seq_len=0 key_len=0 key_flag=0x10 link_id=-1
nl80211: DEL_KEY
   broadcast key
wlan2: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
wlan2: State: DISCONNECTED -> INACTIVE
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
PR: Driver does not support Proximity Ranging - PR disabled
dbus: Register interface object '/fi/w1/wpa_supplicant1/Interfaces/2'
wlan2: Added interface wlan2
wlan2: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan2 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=45 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
RTM_NEWLINK: ifi_index=35 ifname=wlan0 operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=44 ifname=wlan1 operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=45 ifname=wlan2 operstate=5 linkmode=0 ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=45 ifname=wlan2 operstate=5 linkmode=1 ifi_family=0 ifi_flags=0x9003 ([UP])
wlan0: Setting scan request: 0.000000 sec
wlan0: State: DISCONNECTED -> SCANNING
wlan0: Starting AP scan for wildcard SSID
wlan0: Add radio work 'scan'@0x6c53d60
wlan0: First radio work item in the queue - schedule start immediately
wlan0: Setting bss expiration age: 310 sec
wlan0: Starting radio work 'scan'@0x6c53d60 after 0.000272 second wait
wlan0: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 10 seconds
no property handler for fi.w1.wpa_supplicant1.Interface.P2PDevice.P2PDeviceConfig on /fi/w1/wpa_supplicant1/Interfaces/0
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan0
wlan0: nl80211: Scan trigger
wlan0: Event SCAN_STARTED (47) received
wlan0: Own scan request started a scan in 0.000675 seconds
wlan1: Setting scan request: 0.000000 sec
wlan1: Setting bss expiration age: 310 sec
no property handler for fi.w1.wpa_supplicant1.Interface.P2PDevice.P2PDeviceConfig on /fi/w1/wpa_supplicant1/Interfaces/1
wlan1: State: DISCONNECTED -> SCANNING
wlan1: Starting AP scan for wildcard SSID
wlan1: Add radio work 'scan'@0x6c76130
wlan1: First radio work item in the queue - schedule start immediately
wlan1: Starting radio work 'scan'@0x6c76130 after 0.000027 second wait
wlan1: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 20 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan1
wlan1: nl80211: Scan trigger
wlan1: Event SCAN_STARTED (47) received
wlan1: Own scan request started a scan in 0.000090 seconds
wlan2: Setting scan request: 0.000000 sec
wlan2: Setting bss expiration age: 310 sec
no property handler for fi.w1.wpa_supplicant1.Interface.P2PDevice.P2PDeviceConfig on /fi/w1/wpa_supplicant1/Interfaces/2
wlan2: State: DISCONNECTED -> SCANNING
wlan2: Starting AP scan for wildcard SSID
wlan2: Add radio work 'scan'@0x6c53d00
wlan2: First radio work item in the queue - schedule start immediately
wlan2: Starting radio work 'scan'@0x6c53d00 after 0.000309 second wait
wlan2: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 20 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan2
wlan2: nl80211: Scan trigger
wlan2: Event SCAN_STARTED (47) received
wlan2: Own scan request started a scan in 0.000149 seconds
RTM_NEWLINK: ifi_index=45 ifname=wlan2 operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x9003 ([UP])
EAPOL: disable timer tick
EAPOL: disable timer tick
EAPOL: disable timer tick
nl80211: Drv Event 42 (NL80211_CMD_REG_BEACON_HINT) received for wlan2
nl80211: Regulatory beacon hint
nl80211: Channel (before): freq=5500 max_tx_power=2000 no-IR radar
nl80211: Channel (after): freq=5500 max_tx_power=2000 radar
wlan2: Event CHANNEL_LIST_CHANGED (27) received
wlan2: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan2: CTRL-EVENT-REGDOM-BEACON-HINT before freq=5500 max_tx_power=2000 no_ir=1 radar=1
wlan2: CTRL-EVENT-REGDOM-BEACON-HINT after freq=5500 max_tx_power=2000 radar=1
wlan2: Updating hw mode
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
RTM_NEWLINK: ifi_index=35 ifname=wlan0 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 42 (NL80211_CMD_REG_BEACON_HINT) received for wlan1
nl80211: Regulatory beacon hint
nl80211: Channel (before): freq=5500 max_tx_power=2000 no-IR radar
nl80211: Channel (after): freq=5500 max_tx_power=2000 radar
wlan1: Event CHANNEL_LIST_CHANGED (27) received
wlan1: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan1: CTRL-EVENT-REGDOM-BEACON-HINT before freq=5500 max_tx_power=2000 no_ir=1 radar=1
wlan1: CTRL-EVENT-REGDOM-BEACON-HINT after freq=5500 max_tx_power=2000 radar=1
wlan1: Updating hw mode
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan0
wlan0: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5170 5180 5190 5200 5210 5220 5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825
wlan0: Event SCAN_RESULTS (3) received
wlan0: Scan completed in 2.736258 seconds
nl80211: Received scan results (9 BSSes)
wlan0: BSS: Start scan result update 1
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 0 BSSID 3c:82:c0:79:c3:10 SSID 'Vodafone-C30C' freq 2437
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/0'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 1 BSSID 3c:82:c0:79:c3:18 SSID 'Vodafone-C30C' freq 5500
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/1'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 2 BSSID 1c:9e:cc:c1:be:a0 SSID 'Vodafone-BE9C' freq 2462
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/2'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 3 BSSID 90:93:5a:0d:b3:b3 SSID 'Vodafone-5152' freq 2437
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/3'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 4 BSSID 20:4e:7f:c6:f7:f0 SSID 'NETGEAR' freq 2437
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/4'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 5 BSSID f0:4b:8a:8b:18:f6 SSID 'Vodafone-AEFE' freq 2437
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/5'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 6 BSSID 1c:9e:cc:c1:be:a8 SSID 'Vodafone-BE9C' freq 5500
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/6'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 7 BSSID 60:a4:b7:fe:2e:0f SSID 'Vodafone-AEFE_EXT' freq 2437
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/7'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 8 BSSID fa:8f:ca:3f:2e:d3 SSID '' freq 5500
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/8'
BSS: last_scan_res_used=9/32
wlan0: New scan results available (own=1 ext=0)
wlan0: Radio work 'scan'@0x6c53d60 done in 6.353031 seconds
wlan0: radio_work_free('scan'@0x6c53d60): num_active_works --> 0
wlan0: No suitable network found
wlan0: Use normal scan instead of sched_scan for initial scans (normal_scans=1)
wlan0: Short-circuit new scan request since there are no enabled networks
wlan0: State: SCANNING -> INACTIVE
RTM_NEWLINK: ifi_index=45 ifname=wlan2 wext ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=44 ifname=wlan1 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan2
wlan2: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan2: Event SCAN_RESULTS (3) received
wlan2: Scan completed in 6.349989 seconds
nl80211: Received scan results (0 BSSes)
wlan2: BSS: Start scan result update 1
BSS: last_scan_res_used=0/0
wlan2: New scan results available (own=1 ext=0)
wlan2: Radio work 'scan'@0x6c53d00 done in 6.351105 seconds
wlan2: radio_work_free('scan'@0x6c53d00): num_active_works --> 0
wlan2: No suitable network found
wlan2: Short-circuit new scan request since there are no enabled networks
wlan2: State: SCANNING -> INACTIVE
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan1
wlan1: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan1: Event SCAN_RESULTS (3) received
wlan1: Scan completed in 6.352661 seconds
nl80211: Received scan results (0 BSSes)
wlan1: BSS: Start scan result update 1
BSS: last_scan_res_used=0/0
wlan1: New scan results available (own=1 ext=0)
wlan1: Radio work 'scan'@0x6c76130 done in 6.353405 seconds
wlan1: radio_work_free('scan'@0x6c76130): num_active_works --> 0
wlan1: No suitable network found
wlan1: Short-circuit new scan request since there are no enabled networks
wlan1: State: SCANNING -> INACTIVE
wlan0: Setting scan request: 0.000000 sec
wlan1: Setting scan request: 0.000000 sec
wlan2: Setting scan request: 0.000000 sec
wlan0: State: INACTIVE -> SCANNING
wlan0: Starting AP scan for wildcard SSID
wlan0: Add radio work 'scan'@0x6c552f0
wlan0: First radio work item in the queue - schedule start immediately
wlan1: State: INACTIVE -> SCANNING
wlan1: Starting AP scan for wildcard SSID
wlan1: Add radio work 'scan'@0x6c6e9f0
wlan1: First radio work item in the queue - schedule start immediately
wlan2: State: INACTIVE -> SCANNING
wlan2: Starting AP scan for wildcard SSID
wlan2: Add radio work 'scan'@0x6c76130
wlan2: First radio work item in the queue - schedule start immediately
wlan0: Starting radio work 'scan'@0x6c552f0 after 0.000410 second wait
wlan0: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
wlan1: Starting radio work 'scan'@0x6c6e9f0 after 0.023581 second wait
wlan1: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan0
wlan0: nl80211: Scan trigger
wlan0: Event SCAN_STARTED (47) received
wlan0: Own scan request started a scan in 0.000443 seconds
wlan2: Starting radio work 'scan'@0x6c76130 after 0.023883 second wait
wlan2: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan1
wlan1: nl80211: Scan trigger
wlan1: Event SCAN_STARTED (47) received
wlan1: Own scan request started a scan in 0.000577 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan2
wlan2: nl80211: Scan trigger
wlan2: Event SCAN_STARTED (47) received
wlan2: Own scan request started a scan in 0.000593 seconds
nl80211: Drv Event 42 (NL80211_CMD_REG_BEACON_HINT) received for wlan2
nl80211: Regulatory beacon hint
nl80211: Channel (before): freq=5200 max_tx_power=2000 no-IR
nl80211: Channel (after): freq=5200 max_tx_power=2000
wlan2: Event CHANNEL_LIST_CHANGED (27) received
wlan2: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan2: CTRL-EVENT-REGDOM-BEACON-HINT before freq=5200 max_tx_power=2000 no_ir=1
wlan2: CTRL-EVENT-REGDOM-BEACON-HINT after freq=5200 max_tx_power=2000
wlan2: Updating hw mode
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
RTM_NEWLINK: ifi_index=35 ifname=wlan0 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 42 (NL80211_CMD_REG_BEACON_HINT) received for wlan1
nl80211: Regulatory beacon hint
nl80211: Channel (before): freq=5200 max_tx_power=2000 no-IR
nl80211: Channel (after): freq=5200 max_tx_power=2000
wlan1: Event CHANNEL_LIST_CHANGED (27) received
wlan1: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan1: CTRL-EVENT-REGDOM-BEACON-HINT before freq=5200 max_tx_power=2000 no_ir=1
wlan1: CTRL-EVENT-REGDOM-BEACON-HINT after freq=5200 max_tx_power=2000
wlan1: Updating hw mode
nl80211: No channel number found for frequency 5900 MHz
nl80211: No channel number found for frequency 5905 MHz
nl80211: No channel number found for frequency 5910 MHz
nl80211: No channel number found for frequency 5915 MHz
nl80211: No channel number found for frequency 5920 MHz
nl80211: No channel number found for frequency 5925 MHz
nl80211: No channel number found for frequency 902 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 903 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 904 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 905 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 906 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 907 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 908 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 909 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 910 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 911 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 912 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 913 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 914 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 915 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 916 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 917 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 918 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 919 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 920 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 921 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 922 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 923 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 924 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 925 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 926 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: No channel number found for frequency 927 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2472 @ 40 MHz 20 mBm
nl80211: 2457-2482 @ 20 MHz 20 mBm (no IR)
nl80211: 2474-2494 @ 20 MHz 20 mBm (no OFDM) (no IR)
nl80211: 5170-5250 @ 80 MHz 20 mBm (no IR)
nl80211: 5250-5330 @ 80 MHz 20 mBm (DFS) (no IR)
nl80211: 5490-5730 @ 160 MHz 20 mBm (DFS) (no IR)
nl80211: 5735-5835 @ 80 MHz 20 mBm (no IR)
nl80211: 57240-63720 @ 2160 MHz 0 mBm
nl80211: Remove unsupported mode
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5500[RADAR] 5520[NO_IR][RADAR] 5540[NO_IR][RADAR] 5560[NO_IR][RADAR] 5580[NO_IR][RADAR] 5600[NO_IR][RADAR] 5620[NO_IR][RADAR] 5640[NO_IR][RADAR] 5660[NO_IR][RADAR] 5680[NO_IR][RADAR] 5700[NO_IR][RADAR] 5745[NO_IR] 5765[NO_IR] 5785[NO_IR] 5805[NO_IR] 5825[NO_IR] 5845[DISABLED] 5855[DISABLED] 5860[DISABLED] 5865[DISABLED] 5870[DISABLED] 5875[DISABLED] 5880[DISABLED] 5885[DISABLED] 5890[DISABLED] 5895[DISABLED] 5900[DISABLED] 5905[DISABLED] 5910[DISABLED] 5915[DISABLED] 5920[DISABLED] 5925[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED] 5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED] 6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED] 6155[DISABLED] 6175[DISABLED] 6195[DISABLED] 6215[DISABLED] 6235[DISABLED] 6255[DISABLED] 6275[DISABLED] 6295[DISABLED] 6315[DISABLED] 6335[DISABLED] 6355[DISABLED] 6375[DISABLED] 6395[DISABLED] 6415[DISABLED] 6435[DISABLED] 6455[DISABLED] 6475[DISABLED] 6495[DISABLED] 6515[DISABLED] 6535[DISABLED] 6555[DISABLED] 6575[DISABLED] 6595[DISABLED] 6615[DISABLED] 6635[DISABLED] 6655[DISABLED] 6675[DISABLED] 6695[DISABLED] 6715[DISABLED] 6735[DISABLED] 6755[DISABLED] 6775[DISABLED] 6795[DISABLED] 6815[DISABLED] 6835[DISABLED] 6855[DISABLED] 6875[DISABLED] 6895[DISABLED] 6915[DISABLED] 6935[DISABLED] 6955[DISABLED] 6975[DISABLED] 6995[DISABLED] 7015[DISABLED] 7035[DISABLED] 7055[DISABLED] 7075[DISABLED] 7095[DISABLED] 7115[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467[NO_IR] 2472[NO_IR] 2484[NO_IR]
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan0
wlan0: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5170 5180 5190 5200 5210 5220 5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825
wlan0: Event SCAN_RESULTS (3) received
wlan0: Scan completed in 2.769238 seconds
nl80211: Received scan results (12 BSSes)
wlan0: BSS: Start scan result update 2
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 9 BSSID 90:93:5a:0d:b3:b4 SSID 'Vodafone-5152' freq 5200
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/9'
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 10 BSSID 24:99:00:b6:d4:65 SSID 'FRITZ!Box 6670 UC' freq 2462
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/10'
wlan0: MLD: No Multi-Link element
wlan0: BSS: Add new id 11 BSSID f0:4b:8a:f3:83:16 SSID 'Vodafone-6D9F' freq 2462
dbus: Register BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/11'
BSS: last_scan_res_used=12/32
wlan0: New scan results available (own=1 ext=0)
wlan0: Radio work 'scan'@0x6c552f0 done in 6.442236 seconds
wlan0: radio_work_free('scan'@0x6c552f0): num_active_works --> 0
wlan0: No suitable network found
wlan0: Use normal scan instead of sched_scan for initial scans (normal_scans=2)
wlan0: Short-circuit new scan request since there are no enabled networks
wlan0: State: SCANNING -> INACTIVE
RTM_NEWLINK: ifi_index=45 ifname=wlan2 wext ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=44 ifname=wlan1 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan1
wlan1: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan1: Event SCAN_RESULTS (3) received
wlan1: Scan completed in 6.419524 seconds
nl80211: Received scan results (0 BSSes)
wlan1: BSS: Start scan result update 2
BSS: last_scan_res_used=0/0
wlan1: New scan results available (own=1 ext=0)
wlan1: Radio work 'scan'@0x6c6e9f0 done in 6.421109 seconds
wlan1: radio_work_free('scan'@0x6c6e9f0): num_active_works --> 0
wlan1: No suitable network found
wlan1: Short-circuit new scan request since there are no enabled networks
wlan1: State: SCANNING -> INACTIVE
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan2
wlan2: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan2: Event SCAN_RESULTS (3) received
wlan2: Scan completed in 6.420879 seconds
nl80211: Received scan results (0 BSSes)
wlan2: BSS: Start scan result update 2
BSS: last_scan_res_used=0/0
wlan2: New scan results available (own=1 ext=0)
wlan2: Radio work 'scan'@0x6c76130 done in 6.422422 seconds
wlan2: radio_work_free('scan'@0x6c76130): num_active_works --> 0
wlan2: No suitable network found
wlan2: Short-circuit new scan request since there are no enabled networks
wlan2: State: SCANNING -> INACTIVE
wlan0: Setting scan request: 0.000000 sec
wlan0: State: INACTIVE -> SCANNING
wlan0: Starting AP scan for wildcard SSID
wlan0: Add radio work 'scan'@0x6c76130
wlan0: First radio work item in the queue - schedule start immediately
wlan1: Setting scan request: 0.000000 sec
wlan2: Setting scan request: 0.000000 sec
wlan0: Starting radio work 'scan'@0x6c76130 after 0.001351 second wait
wlan0: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
wlan1: State: INACTIVE -> SCANNING
wlan1: Starting AP scan for wildcard SSID
wlan1: Add radio work 'scan'@0x6c6ac90
wlan1: First radio work item in the queue - schedule start immediately
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan0
wlan0: nl80211: Scan trigger
wlan0: Event SCAN_STARTED (47) received
wlan0: Own scan request started a scan in 0.000382 seconds
wlan2: State: INACTIVE -> SCANNING
wlan2: Starting AP scan for wildcard SSID
wlan2: Add radio work 'scan'@0x6c6e510
wlan2: First radio work item in the queue - schedule start immediately
wlan1: Starting radio work 'scan'@0x6c6ac90 after 0.000722 second wait
wlan1: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
wlan2: Starting radio work 'scan'@0x6c6e510 after 0.000684 second wait
wlan2: nl80211: scan request
nl80211: Scan co-located APs on 6 GHz
Scan requested (ret=0) - scan timeout 30 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan1
wlan1: nl80211: Scan trigger
wlan1: Event SCAN_STARTED (47) received
wlan1: Own scan request started a scan in 0.000503 seconds
nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan2
wlan2: nl80211: Scan trigger
wlan2: Event SCAN_STARTED (47) received
wlan2: Own scan request started a scan in 0.000419 seconds
RTM_NEWLINK: ifi_index=35 ifname=wlan0 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan0
wlan0: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5170 5180 5190 5200 5210 5220 5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825
wlan0: Event SCAN_RESULTS (3) received
wlan0: Scan completed in 2.783517 seconds
nl80211: Received scan results (11 BSSes)
wlan0: BSS: Start scan result update 3
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
wlan0: MLD: No Multi-Link element
BSS: last_scan_res_used=11/32
wlan0: New scan results available (own=1 ext=0)
wlan0: Radio work 'scan'@0x6c76130 done in 6.428612 seconds
wlan0: radio_work_free('scan'@0x6c76130): num_active_works --> 0
wlan0: No suitable network found
wlan0: Beginning of SSID list
wlan0: Starting sched scan after 0 seconds (no timeout)
wlan0: nl80211: sched_scan request
nl80211: Passive scan requested
nl80211: Sched scan start failed: ret=-22 (Invalid argument)
wlan0: Failed to initiate sched scan
wlan0: Short-circuit new scan request since there are no enabled networks
wlan0: State: SCANNING -> INACTIVE
RTM_NEWLINK: ifi_index=44 ifname=wlan1 wext ifi_family=0 ifi_flags=0x9003 ([UP])
RTM_NEWLINK: ifi_index=45 ifname=wlan2 wext ifi_family=0 ifi_flags=0x9003 ([UP])
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan2
wlan2: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan2: Event SCAN_RESULTS (3) received
wlan2: Scan completed in 6.404854 seconds
nl80211: Received scan results (0 BSSes)
wlan2: BSS: Start scan result update 3
BSS: last_scan_res_used=0/0
wlan2: New scan results available (own=1 ext=0)
wlan2: Radio work 'scan'@0x6c6e510 done in 6.406259 seconds
wlan2: radio_work_free('scan'@0x6c6e510): num_active_works --> 0
wlan2: No suitable network found
wlan2: Short-circuit new scan request since there are no enabled networks
wlan2: State: SCANNING -> INACTIVE
nl80211: Drv Event 34 (NL80211_CMD_NEW_SCAN_RESULTS) received for wlan1
wlan1: nl80211: New scan results available
nl80211: Scan probed for SSID ''
nl80211: Scan included frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
wlan1: Event SCAN_RESULTS (3) received
wlan1: Scan completed in 6.410232 seconds
nl80211: Received scan results (0 BSSes)
wlan1: BSS: Start scan result update 3
BSS: last_scan_res_used=0/0
wlan1: New scan results available (own=1 ext=0)
wlan1: Radio work 'scan'@0x6c6ac90 done in 6.411778 seconds
wlan1: radio_work_free('scan'@0x6c6ac90): num_active_works --> 0
wlan1: No suitable network found
wlan1: Short-circuit new scan request since there are no enabled networks
wlan1: State: SCANNING -> INACTIVE
dbus: Register network object '/fi/w1/wpa_supplicant1/Interfaces/0/Networks/0'
Line 0: invalid key_mgmt 'SAE'
wpas_dbus_handler_add_network[dbus]: control interface couldn't set network properties
dbus: Unregister network object '/fi/w1/wpa_supplicant1/Interfaces/0/Networks/0'
^Cwlan2: Removing interface wlan2
nl80211: Getting wowlan status
nl80211: Getting wowlan status failed
wlan2: Request to deauthenticate - bssid=00:00:00:00:00:00 pending_bssid=00:00:00:00:00:00 reason=3 (DEAUTH_LEAVING) state=INACTIVE valid_links=0x0 ap_mld_addr=00:00:00:00:00:00
wlan2: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan2 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=45 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
EAPOL: External notification - portEnabled=0
EAPOL: External notification - portValid=0
QM: Clear all active DSCP policies
wlan2: CTRL-EVENT-DSCP-POLICY clear_all
wlan2: WPA: Clear old PMK and PTK
wlan2: Cancelling scan request
wlan2: Cancelling authentication timeout
nl80211: Data frame filter flags=0x0
QM: Clear all active DSCP policies
wlan2: CTRL-EVENT-DSCP-POLICY clear_all
Remove interface wlan2 from radio phy2
Remove radio phy2
nl80211: deinit ifname=wlan2 disabled_11b_rates=0
netlink: Operstate: ifindex=45 linkmode=0 (kernel-control), operstate=6 (IF_OPER_UP)
nl80211: Set mode ifindex 45 iftype 2 (STATION)
nl80211: Unsubscribe mgmt frames handle 0x888888888e4eab49 (mode change)
dbus: Unregister interface object '/fi/w1/wpa_supplicant1/Interfaces/2'
wlan2: CTRL-EVENT-TERMINATING 
wlan1: Removing interface wlan1
nl80211: Getting wowlan status
nl80211: Getting wowlan status failed
wlan1: Request to deauthenticate - bssid=00:00:00:00:00:00 pending_bssid=00:00:00:00:00:00 reason=3 (DEAUTH_LEAVING) state=INACTIVE valid_links=0x0 ap_mld_addr=00:00:00:00:00:00
wlan1: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan1 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=44 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
EAPOL: External notification - portEnabled=0
EAPOL: External notification - portValid=0
QM: Clear all active DSCP policies
wlan1: CTRL-EVENT-DSCP-POLICY clear_all
wlan1: WPA: Clear old PMK and PTK
wlan1: Cancelling scan request
wlan1: Cancelling authentication timeout
nl80211: Data frame filter flags=0x0
QM: Clear all active DSCP policies
wlan1: CTRL-EVENT-DSCP-POLICY clear_all
Remove interface wlan1 from radio phy1
Remove radio phy1
nl80211: deinit ifname=wlan1 disabled_11b_rates=0
netlink: Operstate: ifindex=44 linkmode=0 (kernel-control), operstate=6 (IF_OPER_UP)
nl80211: Set mode ifindex 44 iftype 2 (STATION)
nl80211: Unsubscribe mgmt frames handle 0x888888888e4d5739 (mode change)
dbus: Unregister interface object '/fi/w1/wpa_supplicant1/Interfaces/1'
wlan1: CTRL-EVENT-TERMINATING 
wlan0: Removing interface wlan0
nl80211: Getting wowlan status
nl80211: Getting wowlan status failed
wlan0: Request to deauthenticate - bssid=00:00:00:00:00:00 pending_bssid=00:00:00:00:00:00 reason=3 (DEAUTH_LEAVING) state=INACTIVE valid_links=0x0 ap_mld_addr=00:00:00:00:00:00
wlan0: State: INACTIVE -> DISCONNECTED
nl80211: Set wlan0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=35 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
EAPOL: External notification - portEnabled=0
EAPOL: External notification - portValid=0
QM: Clear all active DSCP policies
wlan0: CTRL-EVENT-DSCP-POLICY clear_all
wlan0: WPA: Clear old PMK and PTK
wlan0: BSS: Remove id 7 BSSID 60:a4:b7:fe:2e:0f SSID 'Vodafone-AEFE_EXT' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/7'
wlan0: BSS: Remove id 9 BSSID 90:93:5a:0d:b3:b4 SSID 'Vodafone-5152' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/9'
wlan0: BSS: Remove id 0 BSSID 3c:82:c0:79:c3:10 SSID 'Vodafone-C30C' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/0'
wlan0: BSS: Remove id 1 BSSID 3c:82:c0:79:c3:18 SSID 'Vodafone-C30C' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/1'
wlan0: BSS: Remove id 2 BSSID 1c:9e:cc:c1:be:a0 SSID 'Vodafone-BE9C' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/2'
wlan0: BSS: Remove id 3 BSSID 90:93:5a:0d:b3:b3 SSID 'Vodafone-5152' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/3'
wlan0: BSS: Remove id 4 BSSID 20:4e:7f:c6:f7:f0 SSID 'NETGEAR' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/4'
wlan0: BSS: Remove id 6 BSSID 1c:9e:cc:c1:be:a8 SSID 'Vodafone-BE9C' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/6'
wlan0: BSS: Remove id 5 BSSID f0:4b:8a:8b:18:f6 SSID 'Vodafone-AEFE' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/5'
wlan0: BSS: Remove id 11 BSSID f0:4b:8a:f3:83:16 SSID 'Vodafone-6D9F' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/11'
wlan0: BSS: Remove id 10 BSSID 24:99:00:b6:d4:65 SSID 'FRITZ!Box 6670 UC' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/10'
wlan0: BSS: Remove id 8 BSSID fa:8f:ca:3f:2e:d3 SSID '' due to wpa_bss_flush
dbus: Unregister BSS object '/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/8'
wlan0: Cancelling delayed sched scan
wlan0: Cancelling scan request
wlan0: Cancelling authentication timeout
nl80211: Data frame filter flags=0x0
QM: Clear all active DSCP policies
wlan0: CTRL-EVENT-DSCP-POLICY clear_all
Remove interface wlan0 from radio phy0
Remove radio phy0
nl80211: deinit ifname=wlan0 disabled_11b_rates=0
netlink: Operstate: ifindex=35 linkmode=0 (kernel-control), operstate=6 (IF_OPER_UP)
nl80211: Set mode ifindex 35 iftype 2 (STATION)
nl80211: Unsubscribe mgmt frames handle 0x888888888e4d2569 (mode change)
dbus: Unregister interface object '/fi/w1/wpa_supplicant1/Interfaces/0'
wlan0: CTRL-EVENT-TERMINATING 
dbus: Unregister D-Bus object '/fi/w1/wpa_supplicant1'


--Jvn6ICSDNBtJcp7x--

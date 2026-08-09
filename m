Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0A35836E
	for <connman@lists.linux.dev>; Sun,  9 Aug 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786257686; cv=none; b=i9Awk7EMr6J+dkabwjl8mLz2GDF1ivw9lm9Y9r6qDxQyjrSeT9t39+ZiCy57lU5PHgN91aB0AYUYoGJbQ1Q8LpLgjQUiKoI1CEK08Ed9/SoV9vQ6ya58MiRd9HJSzEoDT/jKz2QoM5TyJTW+Xsga6az0+IZYBbQD1iEsUxV4s/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786257686; c=relaxed/simple;
	bh=AdzP3ApDfFAuLr0mcl8c5sc/ZDeVtV9Mg67tsL83PHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrvWZGz0maOKeLCJy6TZqLaTo2PKDE8ypX5towiomlKZVaBnmxESmMaWfJYCxjekMmSV/8r9Q/blZRX/R1w8gd423wnJRQqz1Ejd0g635jA2m82Q7ksYNsZxOa2YdxIEs9pyP6J/sswZtxqG4keeA3Wy4Zmdb8Eb6fdBsBIWYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=w4YRfVbG reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="w4YRfVbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1786257682; bh=AdzP3ApDfFAuLr0mcl8c5sc/ZDeVtV9Mg67tsL83PHQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=w4YRfVbGshlakbZhKHDMEeZxenDvsqJ830RIBYvGTNW2IRFlAAnBRmZDUEMONqVTb
	 das+W54+Ppf2BEs7SLHDzmBHYi6U2zwxw2KqMPCoJ1fmIYrovEW6/S/d1RrIZS6qqE
	 LNrGeU3dtcEk91iGCnfRS2LnJb7ikqPyO1sWglGATDJYTlPz3bzQS5yRGghPkGbWtt
	 3T7ZVyda3URWqnScXjrWfleEmnaLKtLRqz4O948Pl3hWoiM8QDk1NKiyfIv1apuQT5
	 JR1aIMl3GWQMXwOoHNt7x+Dij23wZKFhAfIb1YV7Oa9mANxXGAsq4dnpVh0JPqXLro
	 iQN00d16g9Mew==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 65E3B31E08DA; Sun, 09 Aug 2026 08:41:21 +0200 (CEST)
Date: Sun, 9 Aug 2026 08:41:21 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Galea <fgalea@free.fr>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>,
	"wbx@openadk.org" <wbx@openadk.org>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
Message-ID: <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
Reply-To: Waldemar Brodkorb <mail@waldemar-brodkorb.de>
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr>
 <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64

Hi Sven,
Dembianny Sven (BSH GDE-EDSD7) wrote,

> Hi Michael,
> 
> I don't think so, e.g., if AP does not support SAE but repeater does, roaming will fail.
> This will also break certification tests.
> 
> @ François do you have more info about your setup, e.g. MFP setting on AP/wpa_supplicant config/WPA-PSK-SHA256 instead of WPA-PSK?

Sorry for the late reply. Francois seems not to answered your
question and I see no fixes for this problem in GIT master either.

My AP is a standard Vodafone AP with WPA2.
How can I give you better information about the details of this AP?

best regards
 Waldemar
 
> Best regards, Sven
> 
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Dienstag, 12. Mai 2026 11:33
> > To: François Galea <fgalea@free.fr>; Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> > Cc: connman@lists.linux.dev; wbx@openadk.org
> > Subject: Re: Connection to a WPA2 Wi-Fi router fails
> >
> > Hi
> >
> > On Tue, May 12, 2026 at 11:14 AM François Galea <fgalea@free.fr> wrote:
> > >
> > > Hello,
> > >
> > > This was tested on a Zynq (Cortex-A9) and a RPi4, on a 32-bit Arm
> > > Buildroot Linux system.
> > >
> > > The Wi-Fi router uses WPA2 Personnal authentication.
> > >
> > > Problem starts from buildroot releases including connman 1.45.
> > > Previous releases using connman 1.44 and prior are working fine. Also
> > > switching from 1.45 to 1.44 in a buildroot version that includes connman 1.45 works.
> > >
> > >
> > > If a connection was previously successfully set up, for instance from
> > > connman 1.44 or older, `/var/log/messages` contains:
> > >
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: Adding interface wlan0
> > > [ wifi ] Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {update}
> > > flags
> > > 36867 <UP>
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index 2
> > > address 9A:8F:85:81:67:B4 mtu 1500 Jan  1 00:00:11 zest daemon.info
> > > connmand[141]: eth0 {newlink} index 2 operstate 2 <DOWN> Jan  1
> > > 00:00:11 zest daemon.info dbus-daemon[120]: [system] Successfully
> > > activated service 'fi.w1.wpa_supplicant1'
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
> > > 36931 <UP,RUNNING>
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index
> > > 4 address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
> > > connmand[141]: wlan0 {newlink} index 4 operstate 0 <UNKNOWN> Jan  1
> > > 00:00:11 zest daemon.info connmand[141]: wlan0 {update} flags
> > > 36867 <UP>
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index
> > > 4 address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
> > > connmand[141]: wlan0 {newlink} index 4 operstate 2 <DOWN> Jan  1
> > > 00:00:11 zest daemon.info connmand[141]: wlan0 {newlink} index 4
> > > address 8C:3D:16:20:0E:4A mtu 1500 Jan  1 00:00:11 zest daemon.info
> > > connmand[141]: wlan0 {newlink} index 4 operstate 2 <DOWN> Jan  1
> > > 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi ]
> > > state is association Jan  1 00:00:11 zest daemon.warn connmand[141]:
> > > Interface wlan0 [ wifi ] error "invalid-key"
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wifi
> > > ] state is failure
> > >
> > >
> > > Otherwise, when creating a new connection:
> > >
> > > # connmanctl
> > > Error getting VPN connections: The name net.connman.vpn was not
> > > provided by any .service files
> > > connmanctl> services
> > >
> > > connmanctl> enable wifi
> > > Enabled wifi
> > > connmanctl> scan wifi
> > > Scan completed for wifi
> > > connmanctl> services
> > >      Kamoulox             wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > >      Livebox-D050
> > > wifi_8c3d16200e4a_4c697665626f782d44303530_managed_psk
> > >      Freebox-3B4B3C
> > > wifi_8c3d16200e4a_46726565626f782d334234423343_managed_psk
> > >      patetalex            wifi_8c3d16200e4a_7061746574616c6578_managed_psk
> > >      DRAME                wifi_8c3d16200e4a_4452414d45_managed_psk
> > > connmanctl> agent on
> > > Agent registered
> > > connmanctl> connect wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > > Agent RequestInput wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > >    Passphrase = [ Type=psk, Requirement=mandatory, Alternates=[ WPS ] ]
> > >    WPS = [ Type=wpspin, Requirement=alternate ] Passphrase?
> > > my_wifi_passphrase Agent ReportError
> > > wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > >    invalid-key
> > > connmanctl> Retry (yes/no)? no
> > > Error
> > > /net/connman/service/wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk:
> > > Input/output error
> > > connmanctl>
> >
> >
> > I think that change only asks the agent who established the connection to try the various method. Is
> > the patch in attach work?
> > * sven *: Does it cover your use case too?
> >
> > Michael
> >
> >
> > >
> > >
> > >
> > >  From both situations it appears the wifi passphrase is not accepted.
> > >
> > > wbx (as CC of this email) noticed that reverting commit
> > > 5e73b55e00b97e1867397258b72f0d6e5ad7d31d allows connections to work again.
> > >
> > > Is it a known situation? Is there a patch available?
> > >
> > > Best,
> > >
> > > François
> > >
> > >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172 info@amarulasolutions.com
> > http://www.amarulasolutions.com/
> > &data=05%7C02%7Csven.dembianny%40bshg.com%7Cf4aa618e280e45c3d76e08deb0096f57%7C0ae5
> > 1e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C639141751758647935%7CUnknown%7CTWFpbGZsb3
> > d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> > %3D%3D%7C0%7C%7C%7C&sdata=8tD7KmAQSPxg%2BRZ0yB7MYBeWVudCjvw4T4MJhOHy3%2Fk%3D
> > &reserved=0

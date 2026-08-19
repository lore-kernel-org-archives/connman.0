Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B63C10A8
	for <connman@lists.linux.dev>; Wed, 19 Aug 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787111996; cv=none; b=F3F6Y4W8u4aqn/vKVaKGp8vJWseIleSCeIg558JxEbNCa/fjPg0Xmcbk7TtXlwhSA19+t9+AdD0GdRIqCmE+AETYn+MvXbLWvGVtSNpf+HVvJI7oeUnIBcIr+QHnaJSPhumK/eRFwyrhEX0Moc85qtZIe4GNUTHvhpmTA0C2eX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787111996; c=relaxed/simple;
	bh=zlqWOZTWFsQZDmpZpeQE2jOYiynr4eg4b3xP82uZ+10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URTVxO517PEKqwMLyczQr6FC7+WliNUeeVaq8gAIU9ZjFRCspqARGMTdtszV/dUuIduaPmGGtXsNxX9Bplh8+5r8V2B9Dv3EOnMcFNou1qDeYU04LdlxcMbO3kVl55Vndlaq7i5Mg6i3RF1iLYlff1h1f6091Gujf1fjd6VoYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=pelKzZEN reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="pelKzZEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1787111987; bh=zlqWOZTWFsQZDmpZpeQE2jOYiynr4eg4b3xP82uZ+10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pelKzZENmocC3KyOdjCJRgv0TjCFxI12G7cJ1ynTQNS5mZJetiIOwmXfKFDEZY6xO
	 LOadxSPzU8HvCf8PbeTXHlL+0fZf4AXh2mCHlhJdIVJNHBzYuDnyXkcuMTZqxHSry9
	 0mCyOhS40bs/PkL1dWKeI9kmLDJ3F449kOhLSQCyhHrl0fCUQCT2mcgAXmKBSczcnu
	 Zo9T+fBEk1ybXKJtDGO2HmHorHql/Y11+7YpHjLcY4wJytx8SUqpgaM7vbV4hZc3Rz
	 h3mvi81y2+9VdhTAyjXlXCybYxvTIhwXvu7+0BY46qTJ4yYa/xuo1XgpAMwDbGlvtk
	 aP6WXKKBQas/A==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 4910C31E0A0D; Wed, 19 Aug 2026 05:59:47 +0200 (CEST)
Date: Wed, 19 Aug 2026 05:59:47 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Galea <fgalea@free.fr>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
Message-ID: <aoUqM2cPH8fjKM4t@waldemar-brodkorb.de>
References: <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <anghETbH2WzsZIJ9@waldemar-brodkorb.de>
 <VI0PR10MB8908D439894A87FDC9341D6EF4DE2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <antcGRBvImhKFSyu@waldemar-brodkorb.de>
 <VI0PR10MB8908254CA2980FEFA0F4A905F4DB2@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoADapzQ-roTDzSP@waldemar-brodkorb.de>
 <VI0PR10MB89081958F1C9D72759AEEC8DF4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
 <aoK1zI10OTh5TX7r@waldemar-brodkorb.de>
 <VI0PR10MB8908036D7C21997D37011694F4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR10MB8908036D7C21997D37011694F4A72@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64

Hi Sven,

for OpenADK I have now a working setup with connman 2.0 without
patching. I had to enable CONFIG_SAE in wpa_supplicant (even if no
WPA3 is involved) and updated
the cypress firmware files to the version you linked to.

Now I try Buildroot again.

Thanks
 Waldemar

Dembianny Sven (BSH GDE-EDSD7) wrote,

> Hi Waldemar,
> 
> yes, now there is an idea:
> 
> Your device is running kernel 6.18.38, but the official Infineon
> release for CYW43455 supports only up to kernel 6.6.23, as far as I can
> see here:
> 
> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/
> Cypress-Linux-WiFi-Driver-Release-FMAC-2025-06-30/td-p/1046940
> 
> That means you are missing some patches required for proper Wi-Fi
> functionality. In particular, WPA3-related patches could cause the issue,
> for example:
> 
> 0056-brcmfmac-support-external-SAE-authentication-in-stat.patch
> 0067-brcmfmac-Revise-channel-info-for-WPA3-external-SAE.patch
> 0068-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.patch
> 0073-brcmfmac-enable-pmk-caching-for-ext-sae-wpa3-ap.patch
> 
> Best regards, Sven
> > -----Original Message-----
> > From: Waldemar Brodkorb <wbx@openadk.org>
> > Sent: Montag, 17. August 2026 09:19
> > To: Dembianny Sven (BSH GDE-EDSD7) <sven.dembianny@bshg.com>
> > Cc: Waldemar Brodkorb <wbx@openadk.org>; Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com>; François Galea <fgalea@free.fr>; connman@lists.linux.dev
> > Subject: Re: Connection to a WPA2 Wi-Fi router fails
> > 
> > Hi Sven,
> > 
> > Dembianny Sven (BSH GDE-EDSD7) wrote,
> > 
> > > Hi Waldemar,
> > >
> > > no idea at the moment, but this looks like a different issue, potentially an initialization-related topic.
> > 
> > Fair enough. In the meanwhile I switched from Buildroot to OpenADK (my own embedded system
> > buildsystem) and with that I can reproduce the original failure. I will investigate the Buildroot error later.
> > 
> > Attached is the output of wpa_supplicant on the console, when I try to connect to my WPA2 WLAN
> > router. wlan0 is the interface.
> > 
> > Any idea for the original issue?
> > 
> > The only error I see is:
> > Line 0: invalid key_mgmt 'SAE'
> > 
> > best regards
> >  Waldemar
> 

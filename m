Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985223ED3D7
	for <connman@lists.linux.dev>; Tue, 19 May 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200450; cv=pass; b=BBuG1lpHEBb3PU9suKLY1cxoYKlUkw/V38I/GZ4+jTxKvKGB+z/qYqDWaIRBDxwq2B2voEWvKUqHvM5g12LIV+9uG1Z643iJj7VtY6nMNsbgwNzxaWTKwMCNSo9OfnT+ct/sFczPx9R78x91s8bpI96ILjNoR66iPJvdo95KiAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200450; c=relaxed/simple;
	bh=vsmrjXekYc/a25jEfmPG+BVCoqfEblJ38rpZ/+Qktcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvdlF02XrLl4b67sMs5499Lww6TWjDYpzj+eFLuQsCRebak55dYd1Wr7gw5VplCYQydyHcSGeq/uyjviSUr33b/h5BpjobJ1TYjjgAKFv4iOGc0NqLAIjeYcdufF9u47KfLpWCdb6V6FC8QOYa+dnHkzBeaAET8XsOUkjhftBMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=XLMYh2xF; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XLMYh2xF"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f68f3b075fso12999699eec.0
        for <connman@lists.linux.dev>; Tue, 19 May 2026 07:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779200448; cv=none;
        d=google.com; s=arc-20240605;
        b=jcBRGmhdc+fELtI9nKAz5x+4LZYmTH700jYA1CfioxtwDG1Pf7ECA789XF+Ja50xCx
         9sAUZ4yMY1Wu+3ooDGZslbB7GH6LHFtSo9W+c1AiT/xyp/FQ7WM+uCqGE6UcU/H1JDB/
         HJ0sthOUSuLgX6zUgYDuaC5pNfzC9YFlHmmV9vxA/TT5LFnFy4w5EAECnOb40Ti00Z7P
         +Y4wGamxXsfgah9L7+Z7kiMJy0p7fGw4WJvLiv5BV2FeMGCBjbVRUPjHanyEevtlzP+y
         2g2A1/GnX7eLe04iINVCWU6cAHdMR7WISYXshIcYCqpopxqjD7noRygW+6K1XUKwZSc/
         R20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gsva1EEMt/o2x/L6+xa/dK4fmYC76yYidFVbGTbRTWQ=;
        fh=5FSF13PSDtv/j5g7WJv7RLjJEjnhZyIqOJsmA2gH2js=;
        b=aECrwGUa/nSS2I6eZcYQc19ceEvWy6UPnxvmwNJLkxB6GQK5W23usQJQweH5mPCpgs
         rJpLIfg5j/ewlswO6jk3M0lFVvHjWdLxIi67jCum76C2DQDo0634IhsExInDSk/whQKY
         61U4ecuEriPCnlk8w/A+/2K9+v5PjgLbX+sYZYyyT1gHj8FOG+tvxpfychXZMxYvQtJP
         pS+5/Pge6v7Sp4K/wY1nGEo47w/mxn6XTVMFpise7sAW9XMkUQndDJDt/cckiQEnET+7
         EsqVpO16+/oQDwjvW/6fA9KrPGdxjmFmkcXOTd/xyiwvPNZwCbMKQ63bfdXFNZ4ngJBW
         ZUkg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1779200448; x=1779805248; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsva1EEMt/o2x/L6+xa/dK4fmYC76yYidFVbGTbRTWQ=;
        b=XLMYh2xFYwzTGpu6H+0lhi07po0zwsmNms3JDIcw3dHmHeB/pqs45yZV3uLVa0JZsv
         IjyFH6ihgWVTPW3TVpxR3SKWLVEZ3MOe6U5T0I3o2qpFEGIANwegE0x4fh0GarqFvW0x
         jKgv3aFC9xyR8MOc7/o4mItheQyGbPHI9zsWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200448; x=1779805248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsva1EEMt/o2x/L6+xa/dK4fmYC76yYidFVbGTbRTWQ=;
        b=OiKd2KsNIWLdL9wfE2OoAzPOBI/nG+wiRwhd2rLk4oYlyMQB3We53KvTZ9GqZvCNPT
         4asnf7qMhxaGCs5twYCp84tzvKHBKiU8P4CSLatxybIN62275jBkwh7Dtf5pmbXCVhD3
         k91qN46h+P2a4/aCL8cmVeLYwMO19YuQOh1sWDvuMleje0FcKhcALFW0FQVTbd6/eKp1
         gJJlIEc5+KwscXv97ronxiMs6XVa6TiVlKoDkL/wvCdHkjQFhjj2HH8npeQ93lJGhN7H
         ZQMw5soWwsfpPkG0TZpz+7vD9ntiECcvVBIL2VBOTX/7kwO0YuD/35EIQQZmzrZDIrkh
         IgTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PSCxxxkrb7bZ3EYyYiFVFHiIlQ4a0ACG+HvI4/dIWKETtd28Q85dHcGb+b8rHQ5jg6RjEr9AD@lists.linux.dev
X-Gm-Message-State: AOJu0YzPa8+GBrRHthcDPp9by9wFp9KuR1OA/NmYi7U3RB3kUgOiax+2
	YfkbbavAyB/YxKnTvUh0Isn2n4CINcjlFAR+tKsAQ388qAWc34QeHCEFKFGSVD0toh6iel/8RIG
	GhZz8c5sCj/V2zdT2Uui0Vj8g9r0H6MjwAL4MiCO1kg==
X-Gm-Gg: Acq92OEqsVEUUXXxGU0EvyNLnkYjLHLiymW1dktsKlSbFYOBARw0e6Vav9W/Axn0rTT
	ZpU2NGt4AeRNvEyUT9EmUvqsAoBdPFtIJyLM9s6bR/QWj3RKClRY9qsYvrG5It1PZ5EqcQ2lX/J
	f5Gzz+WczdS1lt/aLKIGT0HnXP6fFPRX1BrvULffZcO8L5oFkj20Tw3OAUBs8+e2Ket2J4ItYtS
	grKPNwQP+wcRcGceBWCnCK6K+d4ToFOFBf83rxI6MLy0+oySkStu2LbPUThY+zKeqmr/o89dTBO
	c3uAypFqBQs+f8flg9+yDrMqi9iuv/5GJJs=
X-Received: by 2002:a05:693c:3009:b0:2f2:5c68:5075 with SMTP id
 5a478bee46e88-30398183994mr9589047eec.14.1779200447644; Tue, 19 May 2026
 07:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9ad68361-98cd-42d1-80b0-7f7cbe6b73cf@free.fr> <CAOf5uwm2wBF=rLBus_epmRg+MgXVrHQzFAq8Y3bGWmJPPiDUnw@mail.gmail.com>
 <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI0PR10MB8908DC25598F38832175F6D6F4002@VI0PR10MB8908.EURPRD10.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 19 May 2026 16:20:36 +0200
X-Gm-Features: AVHnY4KSeyU5JSPO9lhmSHuQXN1vp66V--LmMAeUdgtFjH2THJlpsGyaFORnTb4
Message-ID: <CAOf5uwkXQpASagj=-E8qau1kk7YvBUquwgKqwUybzCkQa2s-Rw@mail.gmail.com>
Subject: Re: Connection to a WPA2 Wi-Fi router fails
To: "Dembianny Sven (BSH GDE-EDSD7)" <sven.dembianny@bshg.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Galea?= <fgalea@free.fr>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>, "wbx@openadk.org" <wbx@openadk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven

On Tue, May 19, 2026 at 4:16=E2=80=AFPM Dembianny Sven (BSH GDE-EDSD7)
<sven.dembianny@bshg.com> wrote:
>
> Hi Michael,
>
> I don't think so, e.g., if AP does not support SAE but repeater does, roa=
ming will fail.
> This will also break certification tests.
>

Ok I was thinking about it but at the same time we should have access
point / wifi driver that fails in this connection case.  This patch
was only ment to understand where the problem sit

> @ Fran=C3=A7ois do you have more info about your setup, e.g. MFP setting =
on AP/wpa_supplicant config/WPA-PSK-SHA256 instead of WPA-PSK?
>

Michael

> Best regards, Sven
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Dienstag, 12. Mai 2026 11:33
> > To: Fran=C3=A7ois Galea <fgalea@free.fr>; Dembianny Sven (BSH GDE-EDSD7=
) <sven.dembianny@bshg.com>
> > Cc: connman@lists.linux.dev; wbx@openadk.org
> > Subject: Re: Connection to a WPA2 Wi-Fi router fails
> >
> > Hi
> >
> > On Tue, May 12, 2026 at 11:14=E2=80=AFAM Fran=C3=A7ois Galea <fgalea@fr=
ee.fr> wrote:
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
> > > switching from 1.45 to 1.44 in a buildroot version that includes conn=
man 1.45 works.
> > >
> > >
> > > If a connection was previously successfully set up, for instance from
> > > connman 1.44 or older, `/var/log/messages` contains:
> > >
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: Adding interface wlan=
0
> > > [ wifi ] Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {update=
}
> > > flags
> > > 36867 <UP>
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: eth0 {newlink} index =
2
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
> > > Jan  1 00:00:11 zest daemon.info connmand[141]: Interface wlan0 [ wif=
i
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
> > >      Kamoulox             wifi_8c3d16200e4a_4b616d6f756c6f78_managed_=
psk
> > >      Livebox-D050
> > > wifi_8c3d16200e4a_4c697665626f782d44303530_managed_psk
> > >      Freebox-3B4B3C
> > > wifi_8c3d16200e4a_46726565626f782d334234423343_managed_psk
> > >      patetalex            wifi_8c3d16200e4a_7061746574616c6578_manage=
d_psk
> > >      DRAME                wifi_8c3d16200e4a_4452414d45_managed_psk
> > > connmanctl> agent on
> > > Agent registered
> > > connmanctl> connect wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > > Agent RequestInput wifi_8c3d16200e4a_4b616d6f756c6f78_managed_psk
> > >    Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory, Alternates=
=3D[ WPS ] ]
> > >    WPS =3D [ Type=3Dwpspin, Requirement=3Dalternate ] Passphrase?
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
> > I think that change only asks the agent who established the connection =
to try the various method. Is
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
> > > 5e73b55e00b97e1867397258b72f0d6e5ad7d31d allows connections to work a=
gain.
> > >
> > > Is it a known situation?=E2=80=AFIs there a patch available?
> > >
> > > Best,
> > >
> > > Fran=C3=A7ois
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
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172 info@=
amarulasolutions.com
> > http://www.amarulasolutions.com/
> > &data=3D05%7C02%7Csven.dembianny%40bshg.com%7Cf4aa618e280e45c3d76e08deb=
0096f57%7C0ae5
> > 1e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C639141751758647935%7CUnknown%7CT=
WFpbGZsb3
> > d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT=
WFpbCIsIldUIjoyfQ
> > %3D%3D%7C0%7C%7C%7C&sdata=3D8tD7KmAQSPxg%2BRZ0yB7MYBeWVudCjvw4T4MJhOHy3=
%2Fk%3D
> > &reserved=3D0



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0E2375B
	for <connman@lists.linux.dev>; Sun,  7 Apr 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489028; cv=none; b=nAtqO7P3f/COVmRycoNQvryYrBng+GB0v7qwtd3suF4CuRAEdZ7iYa6uRBFw5YfeNlIqdGFsEeuHlUCgOf6cvAloZlCCH84UAdHW98g9lZvRnHKhUkhdQhvVhdWptjb6ob22f4DYPA9e4xJnjol3ot+mtZvqmzsF6B/KWhkILeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489028; c=relaxed/simple;
	bh=xvAkj2XmS7/KxQRzpZ+XylB/7eF2ZZzt4YlObaDo+Ts=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jABqwrg4Ro4JVxv793BxtGUBZ+moJcb984KzjL712YVpSfr+/t4CrNu3tjkDzECWna8VOak0LvLa1OgCAZ3OLPq7rSJ3udAjVpVI7iNUYyFW3hippcP1aE+ezE05YtQFPojMOtmm5rdhIWKFqxLVby1bdCEAPh9Pjh5VC4nmL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5So6Pu9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5So6Pu9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46a7208eedso515358666b.0
        for <connman@lists.linux.dev>; Sun, 07 Apr 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712489025; x=1713093825; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCsDjcsKznMknoTRKCqpEMiVz9dd3FMCbksQySoDeNE=;
        b=i5So6Pu98fhkoJ6lrDsIsGv6B32GLyydduwM4e/Bz0mcOQfvKPtsk+z3Sqjt/3QYDm
         gdrgyKlV33mjgT6QvXTs8/B7ZPGMRDOZLxwKZ1YNBfyy9hu17HthhxrRX+6JSJoXBxVA
         SW/RpyJq6bwYqf017X8fja3tf1AqxQRIEmL+cgejJ9ZQGiBPHUR4qngeOU8H2vME6/V0
         JRnnAGTqgWfVfmOfiOXqHZMBM4nEJBkd4eyhEhF/hNBy9jWPW1IJDW4tMBWU5lqdVhVC
         B5kgNo9xSNseJLo1YrNIdXCXYMuYN1tHxUBSWuMCugxsGuY7EYkxvE8WbSy8QecCw5Kq
         tfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712489025; x=1713093825;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCsDjcsKznMknoTRKCqpEMiVz9dd3FMCbksQySoDeNE=;
        b=GXxZGe7IczDPRS855MmyvP3+e7E3eVpPPqVfCqIbeA/1Y9V+mFCLCct3WBu0eQJ3vg
         dgocHSbZPSRh/E6oxeY7m8SKmmiGaCZVzSUo2qBFn+QMC2bvjtZZZEjRzOOgEPWCVi1q
         p/VTIjBdDAl3B6UdELnqGiALbJviofbzRzLWn685rx8w5o97p2IAJ4Ca3msPOgjSapqz
         dsKOAEr+Kzeny4NGztV+BAABF0ZHDk+wfi+BTkcJMNEQ2sRi0sHPNgmpbab2UP+nWg3J
         Fl36RfH+82iMskOJLOeJi1bX3QBmUDPx0KDqcxtnv+jMmj/CgN+vqNJqflOzxhBRQ8oM
         0zEA==
X-Gm-Message-State: AOJu0YzpsJ/WxPuy0NPb6LS95J4BzKugGgT4aVdJbPaE8X/SFgWCZo9J
	RkMFn+SyjHeeEAtseqwoSTVIsK2fol3ZGfN1m9FcXhiCVgFnT4/qMcm6DvGHckklrLAFbvybhPg
	TYu8GMsVn/4zWrZjqpyJ96Palr1XCF1qiRw==
X-Google-Smtp-Source: AGHT+IEaZ4xZWgo0tdBoxbKdwibmAg9LRuBgDSNJtmxFFg/4DA/GqnbILg3aJ/256Jh/XXc+VyAGTp1NjSScFmRsTYU=
X-Received: by 2002:a17:907:96a8:b0:a51:904a:e3ca with SMTP id
 hd40-20020a17090796a800b00a51904ae3camr5314735ejc.30.1712489024426; Sun, 07
 Apr 2024 04:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?Q?Benjamin_R=C3=A9veill=C3=A9?= <benjamin.reveille@gmail.com>
Date: Sun, 7 Apr 2024 13:23:33 +0200
Message-ID: <CAKFSxTcZWGXUo0bWu_vPaXxx6k7dyM4c6svcWyMq_A7dTbLCmA@mail.gmail.com>
Subject: Connman on my rpis sending changing DUIDs to dnsmasq dhcp server
 thereby progessively eating up all its dhcpv6 leases
To: connman@lists.linux.dev, email@samnazarko.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

My raspberry pis running OSMC which use connman 1.41 are displaying a
weird behavior leading to multiple dhcpv6 leases being "consumed" by
the same network service/interface
After discussing this on the osmc forum (same/more information can be
found here : https://discourse.osmc.tv/t/rpis-and-connman-are-providing-mul=
tiple-duids-to-dhcpv6-server/97135
it seems soliciting the connman) with the lead osmc developer
sam_nazarko we decided I should push this to this mailing list.

I'll take the example of my pi4

My environment :
* dnsmasq (on my ddwrt router) with the following ipv6 configuration
for slaac (required by android) and dhcpv6 (for my
desktops/laptops/printer/...) and a static lease for the pi4:
  dhcp-hosts=3DDC:A6:32:1D:C9:0F,pi4,192.168.2.9,[::9],24h
  dhcp-range=3D::2,::106,constructor:br0,slaac,ra-names,64,24h
* fddd:: is the ULA prefix I'm using on my network (alongside my
public prefix) behavior with both is the same so I'm illustrating with
the ULA prefix.
* pi4 MAC address is dc:a6:32:1d:c9:0f for its interface eth0
* pi4 has a cron job checking its connectivity and restarting connman
(via: systemd restart connman) if the dns server loses track of it

After some time dnsmasq.leases file shows that pi4 has grabbed
multiple dhcpv6 leases (due to multiple DUIDs) from dnsmasq (and at
some point in the day dnsmasq has no more to hand out causing
connection issues to led me to identifying the issue)
> 1712252648 T840812815 fddd::f * 00:01:00:01:2d:a0:51:e8:dc:a6:32:1d:c9:0f
> 1712252533 T840812815 fddd::e2 * 00:01:00:01:2d:a0:51:74:dc:a6:32:1d:c9:0=
f
> 1712252414 T840812815 fddd::4d * 00:01:00:01:2d:a0:50:fd:dc:a6:32:1d:c9:0=
f
> 1712252289 T840812815 fddd::c5 * 00:01:00:01:2d:a0:50:80:dc:a6:32:1d:c9:0=
f
> 1712252169 T840812815 fddd::d9 * 00:01:00:01:2d:a0:50:09:dc:a6:32:1d:c9:0=
f
> 1712252052 T840812815 fddd::49 * 00:01:00:01:2d:a0:4f:95:dc:a6:32:1d:c9:0=
f
> 1712251932 T840812815 fddd::85 * 00:01:00:01:2d:a0:4f:1c:dc:a6:32:1d:c9:0=
f
> 1712251813 T840812815 fddd::3 * 00:01:00:01:2d:a0:4e:a5:dc:a6:32:1d:c9:0f
> 1712251689 T840812815 fddd::78 * 00:01:00:01:2d:a0:4e:28:dc:a6:32:1d:c9:0=
f
> 1712251568 T840812815 fddd::7a * 00:01:00:01:2d:a0:4d:af:dc:a6:32:1d:c9:0=
f
> 1712251452 T840812815 fddd::64 * 00:01:00:01:2d:a0:4d:3c:dc:a6:32:1d:c9:0=
f
> 1712251333 T840812815 fddd::4b * 00:01:00:01:2d:a0:4c:c5:dc:a6:32:1d:c9:0=
f
> 1712251213 T840812815 fddd::d4 * 00:01:00:01:2d:a0:4c:4c:dc:a6:32:1d:c9:0=
f
> 1712251094 T840812815 fddd::38 * 00:01:00:01:2d:a0:4b:d6:dc:a6:32:1d:c9:0=
f
> 1712251032 T840812815 fddd::9 * 00:01:00:01:2d:a0:4b:97:dc:a6:32:1d:c9:0f

After some tests I identified and another user identified some of the
underlying issues:
* When I look at service's settings file it does not contain a
"IPV6.DHCP.DUID=3D" line (as it should according to src/dhcpv6.c)
>  >cat settings
> [ethernet_dca6321dc90f_cable]
> Name=3DWired
> AutoConnect=3Dtrue
> Modified=3D2024-04-04T19:44:08Z
> IPv4.method=3Ddhcp
> IPv4.DHCP.LastAddress=3D192.168.2.9
> IPv6.method=3Dauto
> IPv6.privacy=3Denabled
> IPv6.DHCP.LastAddress=3Dfddd::f
> Domains=3Dmydomain.fr;

* a simple test with the following command shows an interesting result
: a settings file is written with DUID (upon writing dhcpv6 ipv6
ipconfig ?) and then overwritten (upon writing slaac ipv6 ipconfig ?)
without the DUID
> >connmanctl config ethernet_dca6321dc90f_cable --ipv6 auto enable && cat =
settings && sleep 1 && cat settings && sleep 1 && cat settings
> [ethernet_dca6321dc90f_cable]
> Name=3DWired
> AutoConnect=3Dtrue
> Modified=3D2024-04-04T21:02:33Z
> IPv4.method=3Ddhcp
> IPv4.DHCP.LastAddress=3D192.168.2.9
> IPv6.method=3Dauto
> IPv6.privacy=3Denabled
> Domains=3Dmydomain.fr;
>
> [ethernet_dca6321dc90f_cable]
> Name=3DWired
> AutoConnect=3Dtrue
> Modified=3D2024-04-04T21:02:33Z
> IPv4.method=3Ddhcp
> IPv4.DHCP.LastAddress=3D192.168.2.9
> IPv6.method=3Dauto
> IPv6.privacy=3Denabled
> Domains=3Dmydomain.fr;
> IPv6.DHCP.DUID=3D000100012da1b8eddca6321dc90f
>
> [ethernet_dca6321dc90f_cable]
> Name=3DWired
> AutoConnect=3Dtrue
> Modified=3D2024-04-04T21:02:33Z
> IPv4.method=3Ddhcp
> IPv4.DHCP.LastAddress=3D192.168.2.9
> IPv6.method=3Dauto
> IPv6.privacy=3Denabled
> IPv6.DHCP.LastAddress=3Dfddd::6f
> Domains=3Dmydomain.fr;

One could think here the issue is just that the DUID is "overwritten"
to the settings file but alas no
--> Question: why is it being overwritten (but not the "Modified=3D"
line) ? and how to avoid it ?

* Indeed another user (JImKnopf) who uses a frtizbox's dhcpv6 server
(for Router advertisement of prefix for SLAAC + dhcpv6 for DNS or
=E2=80=9CDNS, assign IA_PD prefix=E2=80=9D or =E2=80=9CDNS, assign IA_PD an=
d IA_NA=E2=80=9D) has a
DUID in the settings file but notices that it changes on every reboot,
suggesting the issue is that the DUID in the settings file is not
reused (although it seems it should be from src/dhcpv6.c)
--> Question: why is the DUID not being reused but a new one generated
? Bug or underlying reason we don't understand ?

As a workaround for now we applied the following patch to src/dhcpv6.c
to use an G_DHCPV6_DUID_LL (which should always be the same according
to src/client.c instead of the default G_DHCPV6_DUID_LLT)
> >cat test.patch
> --- src/dhcpv6.c 2024-04-05 22:08:13.180517921 +0200
> +++ src/dhcpv6.c 2024-04-05 22:08:35.943982173 +0200
> @@ -225,7 +225,7 @@
>                int ret;
>                int type =3D __connman_ipconfig_get_type_from_index(index)=
;
>
> -               ret =3D g_dhcpv6_create_duid(G_DHCPV6_DUID_LLT, index, ty=
pe,
> +               ret =3D g_dhcpv6_create_duid(G_DHCPV6_DUID_LL, index, typ=
e,
>                                        &duid, &duid_len);
>                if (ret < 0) {
>                        g_key_file_free(keyfile);

Using the workaround patched connman our DUID changes and multiple
leases issues disappear, however this is just a workaround and the
original issues might need to be addressed.
I'm willing to help debug this if necessary.

Thanks in advance for any answers/feedback/help/instructions

Regards

Benjamin

P.S. : Is there a way to have connman disregard SLAAC ? (As part of my
testing I tried 'sysctl net.ipv6.conf.eth0.autoconf=3D0' as suggested by
the kernel documentation but that led to no ipv6 at all which was not
expected)

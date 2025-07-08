Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738CA2550D2
	for <connman@lists.linux.dev>; Tue,  8 Jul 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974693; cv=none; b=id1cFA7sRWp8ft/qWSyilUE9X3EfFsiBv6aNZDzIi8hFmh3IS3uWFlXO3TKAjl90uovEfUOmK7YG6SPDSD5pknglrTRUpniqukowEzGgt/653MZRI87NZL64MHJ3A1gledjKBnysY5oF2mwqQdJkC9BbpG2n6kxndaz/kRjdU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974693; c=relaxed/simple;
	bh=JyryBVG98anoIYxGnuShe3thKyYtkqW9TfyGCP8WRAw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gjmk7TmuMsCurq6smrEzI2xki7qZgRrra5b4qGYhW1I0dzHd3CFJqbQ/IEyCz8Sv+sV5Pll8nWEosZcTn5iebTnzmbxBCqJztT7KjMGdqajoYxJwf/iXagE2Wl7BZVxfi5fLsSr6nkU/wn1VSEBL5xuWez3XMVey/2aVus2uzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZyX8UDZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZyX8UDZ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b10594812so5151755e87.1
        for <connman@lists.linux.dev>; Tue, 08 Jul 2025 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751974689; x=1752579489; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jany/yTA90+F16EHw1abjdD6VeiNxl0/1NziWCKshh0=;
        b=GZyX8UDZ4OolMBARD3LXIquels2s+szaO6C8oFpd/wSAaXtQzJWPW41KC2LEcXv9wa
         JSRUyQmZbrS+kn19M3QIeSQ9mFxpbVO9mBpxfTG+n8cJAO6JQWrJFoDU+1hQSIjaM457
         Bq45Ymew3YJyPt8Df5neUyRxXwHKqrE8XUlK5mWCMRWxkY2FGwbU/UyiX33LgO10aMAi
         00jh5lGWPM70yCUN257J/WbfGs8x2tpk5S4z347YviWOhXN6fm5s2Ncdq3UAbC0r+q8P
         Oi5w7+ErmgS/vehY/ZojoJ0h84//qmmHPSeS50pA0AzKQfUNhbJz0pRRw8AysTsxolxh
         gM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974689; x=1752579489;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jany/yTA90+F16EHw1abjdD6VeiNxl0/1NziWCKshh0=;
        b=RzDNJ7qiAB6Tb59ZBerlUxKnt93VZg28r5/V4XOAQtNpumS9owHA7C+WNr5SVH5oQx
         Rs20S+WFqgkeOqHnsp5BfR1iPXSPbE74lY5OhziU2GTiwF52SJZ22WFsFwbaYRmUrVDN
         AuY1NBCpg0TmQ4PjoUKVt42jTPY1PfZle/swb1M6yx6bkQt7DwnoSP39O4IMmuifVJFd
         lfTy+guss3y0rNmYrbOmJ4zjpDbmuAmbooodoSEzM7XRptzFYe5SjXCatbV5WNKlWj27
         abFzx+apQEd3qzO9n/iMzDlGa56xTVP/F/SNNEaQtaikJZhhDRv74c0EjZbpJMEGshW/
         6Azg==
X-Gm-Message-State: AOJu0YxTWMjeE0itueW8juABJcxuEd8PHKkS8nz6XzmqvXdaJSnlizuo
	BSTKv6SncoF9GQ/LNOwjEA8066QRQGuZVSijRJB7uN/mtqF4dJqq1ngpvbTXBaal
X-Gm-Gg: ASbGncuvYBolFVcbILmrJLm5APPp13bq2RimVqpIrP/DqLrE8olhBkXdjLVPT08BMwa
	pWG0mP+kA2N97dPyQH2520BLrD7EnJcLWe8q6Ts/i1wvCBMyFq2jeLo4q8AkUmjEa6YwRpYExGt
	iHiZRAubMPAOF5/kICR73GDCR2bvND5U0DHjHDAFjFDdnM3cThESGSx/96qdmvvXYJ5TdTTxdD0
	lS2NSWGyqinFsbRysAzrwG1qtboFPx/B3UfYIGVNrrIGwTrbxR0H22wMp8QQ1/RI7mRN0SBwO8b
	Qlfl4+iLr9+2cB/Kx8WojkyaKDntjceqRY8E/5b7D24zy+Wgh4xhV69QAyUujq5fT7YsrSRoX25
	M44STWLOPIoE=
X-Google-Smtp-Source: AGHT+IGqx8sAf28RN39SwmVD/nTYzRoodwolMH3bcdes9T7fSyiQbpBfXq0l4UtGgdXMW2iRDHXKbQ==
X-Received: by 2002:a05:6512:a94:b0:553:2927:985f with SMTP id 2adb3069b0e04-557a132c260mr4152722e87.5.1751974689078;
        Tue, 08 Jul 2025 04:38:09 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c18d3sm1625724e87.212.2025.07.08.04.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:38:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7c6dddcc-6b90-4df1-a9a2-cabd2483f728@jolla.com>
Date: Tue, 8 Jul 2025 15:37:55 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <303D17B9-998B-4487-8CCD-24A3F0A10B1C@gmail.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
 <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
 <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
 <07d1c218-be94-4b63-bb98-f57679844148@jolla.com>
 <5950C2C2-37F5-440F-9E5F-25CD9D896A7A@gmail.com>
 <673eaec4-a289-4b97-8572-b1398e8aa869@jolla.com>
 <7c6dddcc-6b90-4df1-a9a2-cabd2483f728@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hello Jussi,

I=E2=80=99ve been submerged in some work activities and replying dropped =
off my radar. Apologies.

The =E2=80=9Cwireguard_and_vpn_association=E2=80=9D patchset (with =
reverts) has been used in the dev/test images that I share for a while =
now and so far there are no negative user reports, so all seems fine. LE =
users generally have the rather simple use-case of making a connection =
to home (on a dynamic IP) so it=E2=80=99s not advanced configuration.

The re-resolve option name is long but I=E2=80=99m not able to come up =
with anything better/shorter :)

Christian

> On 10 Apr 2025, at 4:26=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Hi Christian and others,
>=20
> I noticed that the testing thread has been quite silent for a while. =
So I've done some internal testing here, and made changes to the git =
repo
> =
https://github.com/LaakkonenJussi/connman_upstream/commits/wireguard_and_v=
pn_association/ - mostly reverts, as in my tests it seemed to be enough =
to fix the FQDN -> IP use in routing. But can you, and others, tell if =
this works for you too? I'm trying to minimize the changes.
>=20
> But on the other hand I thought also that the feature to use the =
transport service's DNSs for the DNS reresolve in WireGuard might be =
something someone would want to enable for their WireGuard. Like in a =
scenario where the user has no power to change anything on the server =
side if the resolving of the server's IP is not possible via WireGuard =
connection due to broken DNS configuration on the server. And if this =
would be a good idea to have as an option for WireGuard, I'm taking in =
suggestions on option name, "ReresolveUseTransportDNS" is, well, long.
>=20
> But let me know if the version with reverts works. Easy to return to =
the later version if this change causes any regressions.
>=20
> Cheers,
> Jussi
>=20
>=20
>=20
> On 3/25/25 19:18, Jussi Laakkonen wrote:
>> Hi Christian,
>> I'm happy to hear this. And very grateful of that publicity and =
possibility to get even more testing on this.
>> I pushed only one cleanup commit today, as it seems that the route =
setup that is done when endpoint resolves to an different IP should be =
enough. In ideal case the gateway (endpoint IP) changes would be =
propagated to connmand but I need to write another internal task for it =
and work on it later.
>> But lets see what testing reveals.
>> - Jussi
>> On 3/25/25 15:02, Christian Hewitt wrote:
>>> Hello Jussi,
>>>=20
>>> The updated branch compiles fine now and I=E2=80=99m able to connect =
with =E2=80=98Host=E2=80=99 configured with an FQDN instead of an IP =
address, which is awesome to see!
>>>=20
>>> I=E2=80=99ve posted a thread to our user forum with an experimental =
image to crowdsource further feedback:
>>>=20
>>> https://forum.libreelec.tv/thread/29601-wireguard-experimental- =
support-for-connecting-via-fqdn-not-ip/
>>>=20
>>> Let=E2=80=99s see what issues come up :)
>>>=20
>>> Christian
>>>=20
>>>> On 25 Mar 2025, at 1:58=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>=20
>>>> Hi Christian and all,
>>>>=20
>>>> On 3/24/25 21:30, Jussi Laakkonen wrote:
>>>>> Hi Christian,
>>>>> On 3/22/25 06:45, Christian Hewitt wrote:
>>>>>>> On 21 Mar 2025, at 11:31=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>>>>=20
>>>>>>> Hi Christian and all,
>>>>>>>=20
>>>>>>>> I=E2=80=99ve been using this series combined with the following =
series and patch for several weeks:
>>>>>>>> https://patchwork.kernel.org/project/connman/ =
cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>>>>>> https://patchwork.kernel.org/project/connman/patch/ =
DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK=
.COM/
>>>>>>>> Plus a revert of this commit which I=E2=80=99ve previously =
flagged as breaking the default =E2=80=9Croute all traffic down =
tunnel=E2=80=9D with WireGuard (the main use-case for LibreELEC users):
>>>>>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/ =
commit/? id=3D9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>>>>>> For easier testing all patches are in this branch: https:// =
github.com/chewitt/connman/commits/wireguard
>>>>>>>> No issues observed, so:
>>>>>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>>>>=20
>>>>>>> I'm happy to hear. I have been fixing other issues related to WG =
in the past weeks a lot and considering to push all of the changes into =
one big WG patch set, as this has been left dangling.
>>>>>>>=20
>>>>>>> I haven't fully tested this on top of upstream ConnMan, but if =
you or someone else is interested to see if the issues that were =
previously encountering are fixed or not.
>>>>>>>=20
>>>>>>> All changes are available here, on top of latest upstream =
ConnMan: https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>>>>>=20
>>>>>>> It is a PR to the internal repository so anyone can comment =
there too. Decided to put this into public as Mullvad seems to give only =
IP addresses and cannot really rely on demo.wireguard.com alone on this. =
So, feel free to test, if it works I'll setup a patch set, maybe combine =
some of the changes to make fewer patches.
>>>>>>>=20
>>>>>>> Have a nice weekend you all!
>>>>>>=20
>>>>>> Thanks for sharing Jussi. Minor compile error fixed with:
>>>>>>=20
>>>>>> diff --git a/src/shared/util.h b/src/shared/util.h
>>>>>> index 44e07b84..9af0303d 100644
>>>>>> --- a/src/shared/util.h
>>>>>> +++ b/src/shared/util.h
>>>>>> @@ -25,7 +25,7 @@
>>>>>>      #include <glib.h>
>>>>>>    #include <stdbool.h>
>>>>>> -#include <inet.h>
>>>>>> +#include <connman/inet.h>
>>>>>>      #define AF_INET_POS 0
>>>>>>    #define AF_INET6_POS 1
>>>>> Oops, thanks for spotting this. I wonder how my build on Debian =
did not warn about this. I think only <arpa/inet.h> is needed at this =
point, but that works too. Added a commit to that branch.
>>>>>>=20
>>>>>> An existing WireGuard configuration on the family daily-driver =
RPi5 running LibreELEC shows no obvious regressions with a private VPN =
server (not a commercial service). Lots more testing required :)
>>>>>>=20
>>>>>> Christian
>>>>>>=20
>>>>> Glad to hear this. I keep wondering if something is still needed =
from our fork... as at least with Mullvad WG I got dual IP support =
working, and data gets routed from both IP families to the host with an =
IP. But this is a quite a big change, so yes, lost more testing is =
required and thanks for helping with this.
>>>>> Few things I want to point out, that now sure yet if it is correct =
way to do this but the transport services' DNS servers are sent to vpnd =
from connmand when a VPN reaches ready state. It could be earlier, at =
configuration state too, any opinnions? This is because then the =
reresolving of the FQDN hostname seems to start working well.
>>>>> But, as I now did some more digging I noticed that the FQDN was =
also propagated "as is" to connmand resulting it ending up in the =
routing table, which may be cause for this not working in the first =
place. And I'm talking about DNS reresolve broken in such case as well =
as the traffic getting blocked. I pushed a WIP change to the PR/branch =
which I need to continue tomorrow (as we want this to be working in =
Sailfish OS too) so this can be tested that how it works. The TODO part =
is about making DNS reresolve to work in the similar way too.
>>>>> Have fun testing!
>>>>> Cheers,
>>>>>   Jussi
>>>>=20
>>>>=20
>>>> Forgot to push the commits there late at night, now they're =
available and will update today as well.
>>>>=20
>>>> - Jussi
>>>=20
>=20


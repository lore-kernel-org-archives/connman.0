Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4325A62C
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907746; cv=none; b=Fi/syzft5X8jmfLn9Mr/mquRD2THs93UxOYivsKjNEU0YZZbsxe1tzMJ6Bwz3Tco6KQ6dRnABgG3RYKiQuHH100PwbTIPd4lgWPfq2Rj57tl1o8LSqxNVLEB4bAIOf4cJT2WfUvZx92uouEAQfmYdVIu8LRjouwEo7GaQExwTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907746; c=relaxed/simple;
	bh=w4EC/V11AeTSqAKfu+UegyLMXdGlN80RpJS2woR2+ac=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MRxn1YQoFDn6pYWItC+wVuWWIuTUYO8YpPRNm2pYmG7tmMu19j6hHJqAGaNBhLeKTMKvbsXCjym6UBZSgfygH2goCstuuAle7fL+/OSq1WXobVoFLvx4vVwmdEsSnfkIGiDo6BorM6GQyVQmE9z1odITkSpMGb1wkeMK7beDHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQWu2vRN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQWu2vRN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso35154775e9.2
        for <connman@lists.linux.dev>; Tue, 25 Mar 2025 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742907743; x=1743512543; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnrPpEi1AYCCXK71BNfxlv8ksFMRnr6hE0Rdo+tEB0I=;
        b=YQWu2vRNJvAyOFrk9oYQK8+Zals0sMLrx73aRNY8SbY9spqZR0nCaHJr323hmsjWfM
         BOTTrzlKL+vEhnO1BLAIsX6A1iCWtIJii8RiJThG8gAu0D8P5eI01zX6+TOWnQDG/mM5
         zYWWJ52aq5llY/BonOosQTjHLv03OUFsGyZOUhk3HcMWG1TwS/Drj9+no20Lf1ifQoY+
         sIOS4pSvfiSVHf7vWmPr8Cc9To0kMqXWDH9fTpoN1YQVDz2dq+vsRy9eMVqrHiVWSCSb
         +L7scE0v1QHxXl+jLrVdPGkdLDOVijTAd2Zgg17GqYSFzC5+2TO698XGQcZjdP/WSOm9
         Bi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907743; x=1743512543;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnrPpEi1AYCCXK71BNfxlv8ksFMRnr6hE0Rdo+tEB0I=;
        b=QZyNfZRZzPhm7CTpZ52Un4gcJ8/ZinBHBqIK1PeGHbabDYWvNeoKbuPt/pMolWvYjg
         ZCapjm2+I/Xmw7nm7RUD7BRdCPddGeFVoi/1vts9rxmBYIaTeqWXyF62Qe1PZFqW8pAF
         XmJgBi9mqQg+jrFeRuN0ZTyOKb7pPI+0uEVkAZVkJvI5CQnsd4EuSlzi2x+Dt5R43lTL
         sfJArM1VcfYQPcxbR6gObprbMoRW71Gdyj4N1WWxJy2N+bqyi0fqGaeBOH3j51JMA1sX
         KKXYAqT+se4CfO7Y/g5kKXemCju3rxPw9xJLuYD9EOK9dEbzbx8hmM+Hq/YBvhCxgRuu
         Zj+w==
X-Gm-Message-State: AOJu0YyRMB6qVR3ftfU3hY2hgkwYbpdF6RCT63VUd6aNcaM/Ue48nVGs
	wgr8hD/AJ7EVf5OLWzESQHzpdOJA6YtzDpuJca38RmYjlM2Pi0E8Di70r5bWuQg=
X-Gm-Gg: ASbGncuBoZjEPqMDb3gLXH2wGl6Kw2sYTlEYNQvSRVmybzjJMNfJvMlmCISv08+uzc1
	eo2Asj+s/0hV5iXMQfYWHYTLONNGt0GBineG3zAo2bpnUZb26DRg7B9/F1D9sz+uuJekvpB0w9J
	WOCkLKkaE4kVKgiNxhE8yVDqfPJN/IK0z37VSOrFl+BkjnFfk5UDJEq7zIcwJAnOi6lheCiDHqm
	PCmy8pekv87seZSmnl19hTLdMA0UGWSrw5diOuJ3sjtk1YoSLy26zt/RtGByTcXu3sF19eWwjhP
	YKKxgEDtEqRfnOX3AO/NQfRJclQrHRvveYi6pWHOobVfMBx0EkgEYOb/jMR99V1vinEAm9WFxBG
	gUucP
X-Google-Smtp-Source: AGHT+IGlvo83oE9GoAAwOp9gqudBa43rWvTOrCwEOjvwFisSG8kpR2pvPyFrPGO4Sdrq5sd0PpoMag==
X-Received: by 2002:a05:6000:188f:b0:391:304f:34e7 with SMTP id ffacd0b85a97d-3997f932ea8mr17141618f8f.44.1742907741826;
        Tue, 25 Mar 2025 06:02:21 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm150872055e9.24.2025.03.25.06.02.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 06:02:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname
 lookup
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <07d1c218-be94-4b63-bb98-f57679844148@jolla.com>
Date: Tue, 25 Mar 2025 17:02:08 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5950C2C2-37F5-440F-9E5F-25CD9D896A7A@gmail.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
 <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
 <c6ae8a9c-df3f-4170-951b-a8a049bf9676@jolla.com>
 <07d1c218-be94-4b63-bb98-f57679844148@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hello Jussi,

The updated branch compiles fine now and I=E2=80=99m able to connect =
with =E2=80=98Host=E2=80=99 configured with an FQDN instead of an IP =
address, which is awesome to see!

I=E2=80=99ve posted a thread to our user forum with an experimental =
image to crowdsource further feedback:

=
https://forum.libreelec.tv/thread/29601-wireguard-experimental-support-for=
-connecting-via-fqdn-not-ip/

Let=E2=80=99s see what issues come up :)

Christian

> On 25 Mar 2025, at 1:58=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Hi Christian and all,
>=20
> On 3/24/25 21:30, Jussi Laakkonen wrote:
>> Hi Christian,
>> On 3/22/25 06:45, Christian Hewitt wrote:
>>>> On 21 Mar 2025, at 11:31=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>=20
>>>> Hi Christian and all,
>>>>=20
>>>>> I=E2=80=99ve been using this series combined with the following =
series and patch for several weeks:
>>>>> https://patchwork.kernel.org/project/connman/ =
cover/20250124185845.1546384-1-jussi.laakkonen@jolla.com/
>>>>> https://patchwork.kernel.org/project/connman/patch/ =
DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK=
.COM/
>>>>> Plus a revert of this commit which I=E2=80=99ve previously flagged =
as breaking the default =E2=80=9Croute all traffic down tunnel=E2=80=9D =
with WireGuard (the main use-case for LibreELEC users):
>>>>> =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/? =
id=3D9eb1772d31b6fcf78e8711976696491aec9ff5df
>>>>> For easier testing all patches are in this branch: https:// =
github.com/chewitt/connman/commits/wireguard
>>>>> No issues observed, so:
>>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>=20
>>>> I'm happy to hear. I have been fixing other issues related to WG in =
the past weeks a lot and considering to push all of the changes into one =
big WG patch set, as this has been left dangling.
>>>>=20
>>>> I haven't fully tested this on top of upstream ConnMan, but if you =
or someone else is interested to see if the issues that were previously =
encountering are fixed or not.
>>>>=20
>>>> All changes are available here, on top of latest upstream ConnMan: =
https://github.com/LaakkonenJussi/connman_upstream/pull/9
>>>>=20
>>>> It is a PR to the internal repository so anyone can comment there =
too. Decided to put this into public as Mullvad seems to give only IP =
addresses and cannot really rely on demo.wireguard.com alone on this. =
So, feel free to test, if it works I'll setup a patch set, maybe combine =
some of the changes to make fewer patches.
>>>>=20
>>>> Have a nice weekend you all!
>>>=20
>>> Thanks for sharing Jussi. Minor compile error fixed with:
>>>=20
>>> diff --git a/src/shared/util.h b/src/shared/util.h
>>> index 44e07b84..9af0303d 100644
>>> --- a/src/shared/util.h
>>> +++ b/src/shared/util.h
>>> @@ -25,7 +25,7 @@
>>>     #include <glib.h>
>>>   #include <stdbool.h>
>>> -#include <inet.h>
>>> +#include <connman/inet.h>
>>>     #define AF_INET_POS 0
>>>   #define AF_INET6_POS 1
>> Oops, thanks for spotting this. I wonder how my build on Debian did =
not warn about this. I think only <arpa/inet.h> is needed at this point, =
but that works too. Added a commit to that branch.
>>>=20
>>> An existing WireGuard configuration on the family daily-driver RPi5 =
running LibreELEC shows no obvious regressions with a private VPN server =
(not a commercial service). Lots more testing required :)
>>>=20
>>> Christian
>>>=20
>> Glad to hear this. I keep wondering if something is still needed from =
our fork... as at least with Mullvad WG I got dual IP support working, =
and data gets routed from both IP families to the host with an IP. But =
this is a quite a big change, so yes, lost more testing is required and =
thanks for helping with this.
>> Few things I want to point out, that now sure yet if it is correct =
way to do this but the transport services' DNS servers are sent to vpnd =
from connmand when a VPN reaches ready state. It could be earlier, at =
configuration state too, any opinnions? This is because then the =
reresolving of the FQDN hostname seems to start working well.
>> But, as I now did some more digging I noticed that the FQDN was also =
propagated "as is" to connmand resulting it ending up in the routing =
table, which may be cause for this not working in the first place. And =
I'm talking about DNS reresolve broken in such case as well as the =
traffic getting blocked. I pushed a WIP change to the PR/branch which I =
need to continue tomorrow (as we want this to be working in Sailfish OS =
too) so this can be tested that how it works. The TODO part is about =
making DNS reresolve to work in the similar way too.
>> Have fun testing!
>> Cheers,
>>  Jussi
>=20
>=20
> Forgot to push the commits there late at night, now they're available =
and will update today as well.
>=20
> - Jussi


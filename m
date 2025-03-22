Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE92E339B
	for <connman@lists.linux.dev>; Sat, 22 Mar 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742618752; cv=none; b=s9AHL2toDuPFd7IAOld2SOK3A042ujmthPj2n48WxmxfF+roNQTKfqgfoIrMSJZnLgIXEaIKp8WhkIBfs4dbUXbhntaMjkINhdPwHRncJVNWpTLgisJ/b+2dzN3vyDIddQGrAS1o7dErP5tqPOurFKccpx4T88328S6068DPx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742618752; c=relaxed/simple;
	bh=gHERQX5IAhpYT+Z9VCJXex8jCmpZ/JAh9N2jotFs0pM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dWSUJBnkk3AKhSnaWV4NG5SNzBNrRQhW057QqHfH1u191aHwiggNbklql7fCiC72358YDCsDIg21WqC/uJEtdYwmmbX/4XKjAOKU3lNxU3bHNLUdHo/lurCbIiHHK2IJP0awsN2SbRk+odGBoVnI/Q+1BmxPFoBGDoAWBpxgeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8wldzVo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8wldzVo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948021a45so20536135e9.1
        for <connman@lists.linux.dev>; Fri, 21 Mar 2025 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742618748; x=1743223548; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2J/VR87oLsFgIoSh9kxGlSgqTEQY0BcqDzbSdI7/ew=;
        b=e8wldzVoNtLq2OfbXitoyOlkFWj2wDgA38U7yn8UwIo6owTRb+3Spjcqc1sDhjk1VO
         f5ZEPQZZLkVugZs5eFED4kBWZJqBMH8PQLdfV3hWhO+xYP7h6G/c3qLSzg4tkjTFPcto
         gpfl/kW5iqfnCZa6WFR6CQR/zgt/vzrKCqK1M7fqnpRQXKdS9UtknusXmUfrnqVAgb15
         w3/pqYfWDpJqnSfRHwXa2G8Ko5os3j5hj/6uXiEKsvu7C8VtepqRGx65EfREZ6bjrpqJ
         9kyZ5XHE5OQbZgHcaiWBO54F+iZGM6nBbHwxLbngz70vetKKZvqIXHBnO8+j+5poZeKB
         3kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742618748; x=1743223548;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2J/VR87oLsFgIoSh9kxGlSgqTEQY0BcqDzbSdI7/ew=;
        b=B1Xv8v3QjI8h985+xmi/7QP22ZQuRbZzTSIERlf8EFz+UkQ64hojCe/zhXNuojOF/3
         QlMrsX7TVKYfj9m+NMTXPXUfVNz4hg59gWkkUBJ/1OCMzsagNGxEPNiJTE/tNRQX99Do
         kEim+32ZqH3eJlwQZqUgDIm0iccizOY3/vnH66MuwZliahLtkZBEaglA732BqV5+g/PG
         Cmp3P4JFpK/Y05tlH4GvEoIGFYGzsfABmhXPWQcG8SgTzg6rcJ29Z+5qVVT9jtqTl7aC
         O2B9LCghu4YH+VZh4qpxTeDLECD1Ll5MB2pnwxODXXIIarEzfxXcHP3vH4Y5yMgcoX8x
         LCgA==
X-Gm-Message-State: AOJu0YyYGnRFrD4naMCegvNSLzefZ35vZJ+e4WWlBsxpDLwXFG01ApFf
	croa2Z14HWK+BCJhAfrYvPYHUPx63xZnct5q6w/mw9Tjx4OnN9zYfsuU4SG1A8g=
X-Gm-Gg: ASbGnctA2R+3TWtAYzW7ciczsS/qKEVQZvsQ6uKzGzTs4WNijQAlF6gqudzHmZd8Wbf
	qepXdSjr+LSy7VQL2wRVfbecmyaOgnu4TxHLUlREUUIraexyRSeSGctfKfQkuYwkCyEZTnT9E9C
	FKirbQv+ewfzhD6Ai7uTEQ9PhTY4gj7LlCm684THmVObON/k/KKWr8nS0jPQFnsCEvGKj7L03HK
	g97PmNBM+JkZDAqbyRnBAGqipGBaUtUXtEieRXTWY4QHdySpHY/UGUbQc4PPLrAP8f0IqWfTt1R
	A0I7n7JmNo4fnXnSx7/iVbPCsfpwHsLH5kfwaClywzxfKwcGHZKCluHRCluj9TAiNRE=
X-Google-Smtp-Source: AGHT+IFTwfOYcdsOh7oZHcYJ5HCgaxFesXRxA66NIu2Ize6h+hWEj06QDIVVj4x5TfPfT70hnrKNDg==
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43d5a36f0d4mr4631785e9.5.1742618748133;
        Fri, 21 Mar 2025 21:45:48 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f332cfsm98099285e9.6.2025.03.21.21.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Mar 2025 21:45:47 -0700 (PDT)
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
In-Reply-To: <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
Date: Sat, 22 Mar 2025 08:45:31 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E23C544B-4E82-49A6-B72E-2279D1BAFC67@gmail.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
 <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
 <3438fe24-9c02-4c45-aaaf-cfbe260902b1@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

> On 21 Mar 2025, at 11:31=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Hi Christian and all,
>=20
>> I=E2=80=99ve been using this series combined with the following =
series and patch for several weeks:
>> =
https://patchwork.kernel.org/project/connman/cover/20250124185845.1546384-=
1-jussi.laakkonen@jolla.com/
>> =
https://patchwork.kernel.org/project/connman/patch/DB6PR10MB1845EBB07DB785=
B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/
>> Plus a revert of this commit which I=E2=80=99ve previously flagged as =
breaking the default =E2=80=9Croute all traffic down tunnel=E2=80=9D =
with WireGuard (the main use-case for LibreELEC users):
>> =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D9e=
b1772d31b6fcf78e8711976696491aec9ff5df
>> For easier testing all patches are in this branch: =
https://github.com/chewitt/connman/commits/wireguard
>> No issues observed, so:
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>=20
> I'm happy to hear. I have been fixing other issues related to WG in =
the past weeks a lot and considering to push all of the changes into one =
big WG patch set, as this has been left dangling.
>=20
> I haven't fully tested this on top of upstream ConnMan, but if you or =
someone else is interested to see if the issues that were previously =
encountering are fixed or not.
>=20
> All changes are available here, on top of latest upstream ConnMan: =
https://github.com/LaakkonenJussi/connman_upstream/pull/9
>=20
> It is a PR to the internal repository so anyone can comment there too. =
Decided to put this into public as Mullvad seems to give only IP =
addresses and cannot really rely on demo.wireguard.com alone on this. =
So, feel free to test, if it works I'll setup a patch set, maybe combine =
some of the changes to make fewer patches.
>=20
> Have a nice weekend you all!

Thanks for sharing Jussi. Minor compile error fixed with:

diff --git a/src/shared/util.h b/src/shared/util.h
index 44e07b84..9af0303d 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -25,7 +25,7 @@
   #include <glib.h>
 #include <stdbool.h>
-#include <inet.h>
+#include <connman/inet.h>
   #define AF_INET_POS 0
 #define AF_INET6_POS 1

An existing WireGuard configuration on the family daily-driver RPi5 =
running LibreELEC shows no obvious regressions with a private VPN server =
(not a commercial service). Lots more testing required :)

Christian


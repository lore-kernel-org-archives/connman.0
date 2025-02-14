Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41F1487DC
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514699; cv=none; b=HAiY2tkTS4xPm++D1hSPxPKefVc4oG2XxKdBP+/PL1ahgsTdhMGwn5Bmj7DM948knOx6vHHB2gWcqTR8YmXUrV6BsUBWK9dS3xf9Eb4OxUHnoyneteRAgmHdk8oUGr6y+PcVwGuxV5HSjf0FWBrHsXqeVEHzrgyR77di/SEPX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514699; c=relaxed/simple;
	bh=87ZloqGAp+N+wuhhCuWJB5vZ2GSUIr9m4dIEiSAZp2k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mPQ3d4wGBf0aLxRIWQieI8tDPoxCa2vcAdsriXZgrrYnNfK4YWtVWAl1oWkPExpQxJnmmeZw699CLTTZXX8Rcq9qYE2Uqc/SD1aXBWoKEMKiNzyuHz0hm3JWYQSae1q/QqV2llmWi/cbGPJ3c1RStgL1wjFV2Twf93swcOvA2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COCdS94+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COCdS94+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43961c966a8so10068365e9.1
        for <connman@lists.linux.dev>; Thu, 13 Feb 2025 22:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514695; x=1740119495; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWTV+tPpIKHuFGBKywD5PnjE5UceXl5H7RT8d36SzYA=;
        b=COCdS94+NdY/R209VNQ3GrvNC1W51JWO0aUbuwa3Oz4rCZ2AaG9OFLerSL3xkQ07dK
         7qJCrTPY9EskY+aMRh0WvonqLHwKOG7mOQq2QNS7LhJGEVnSVb0o8ErepKZt1AM6NPC1
         v62nPJZQlhwQlFy8g3X19NHCAw/ga77zA6Tg6sTCAsgAVCiKGmyUCV8kFZV6mDTXDjK7
         MhnWqHwhQ9KXQzNeJmYDeheXPQUC/9CWv4QJKHUtg3z4xBCeOH1AunZymGpqhgzxmrOG
         CCGTHj741DXtHDrwyzVWDvYFlhvNLQqSUdrGsSLyuvyuSV5V2BqNbpx0MjaFkqNS+4q0
         jOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514695; x=1740119495;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWTV+tPpIKHuFGBKywD5PnjE5UceXl5H7RT8d36SzYA=;
        b=Ge6RnZAUI4WQbKZanZhEYBaj8NTfEDG7s92w35EfU4n5eYO/6wKf4tfp5A3Ctweh3j
         9iHWr6Cwi8D4etfTKSoOAPUHY4yrMaVjxvqT8WzfVRhsXABHYsDNe74TPnhVD/pwat17
         1IQiSokUDrvUDypvauJp28EONYFGZuiARND13/ELa3qU4AAChknrTipzd7ALTW9zfgZ1
         8PjMmxYWzTKOI7matNwvmxpuoAln2s418GrYAXGTJxBw/3kIUMwPMNWRS+8Gc0wohvGC
         nlW8wSPHc0J9hOMW8+4HvbGDGQfN6BkmuPx+dJV4L9C4dTF/z5vPlYrwH0y46i3rsdyL
         q0iA==
X-Gm-Message-State: AOJu0YzkfLK5rTxSjKc4jOqqcQU/AnfptVh9Uum0Krmvf2MdwRuQGd34
	R3CgAgFip5Ky9UuQ+mraHSk9z1Dxo41vc0LUGOxr69RRUvfUHPHbA68rfvf6bJQ=
X-Gm-Gg: ASbGncu0dfT1S6VQRI4ilBM+huizFBFvgdNhel3SBcz53m8U1sCXFSV5YsjaiwxTXID
	y9DTM9ebCsY6t+wKb+6W9NzKF551UU4bLm25j02ARf/ew9Fg0cSobqKsJa7JUA8K9hO1FUAJgzN
	JkiZu768JqZ7N7H4WWxXk/uOTFVivlAfhQSnibJReC56ttgIz3xg3NMXoFOwg5RibkfZb3Wc0tU
	+m/BVt5eMqR6RPkarS5fcMnxnDCDYkCUsa2vMvrrrHZOjU5+oYtoXPWsi7XzzWh+Cu7+0Ml3raa
	4TFbUCiFPk2yncCOx7uQIlCQ2w9V0AKPvtgHsQ==
X-Google-Smtp-Source: AGHT+IFP/Pr5hMOS060D422JE/DB2A0u6fUgCiypDXANPMiNU0CQAjbN7Pf3QS5kabnIB+jZtLcszw==
X-Received: by 2002:a05:6000:381:b0:38f:2e26:331f with SMTP id ffacd0b85a97d-38f2e2633fbmr857020f8f.44.1739514695123;
        Thu, 13 Feb 2025 22:31:35 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm3677530f8f.44.2025.02.13.22.31.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:31:34 -0800 (PST)
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
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
Date: Fri, 14 Feb 2025 10:31:23 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A173154A-88D0-4CB2-AFED-B94FBC9D8ED0@gmail.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

> On 24 Jan 2025, at 10:59=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> This set of patches improves the WireGuard plugin and adds better =
error case
> support for the vpn/plugins/vpn.c. This allows also to propagate the =
errors
> upward and with other changes, allows the shutdown to follow the same =
process
> as the other VPNs. Alsom fix the PrefixLength use in connmand and in =
the
> WireGuard plugin by tokenizing the host before getaddrinfo() check.
>=20
> First, the basic saving of the WireGuard configuration is done =
similarly to
> other plugins, as well as to what wg-quick is utilizing.
>=20
> Second, the handling of errors is improved within the plugin and vpn.c =
as well.
> This will make it possible to pass the errors upwards from the plugin  =
In
> addition to this there is a limit for reresolve errors (5 by default) =
after
> which WireGuard plugin dies in case the configuration is wrong, or =
network is
> broken.
>=20
> Third, the use of getaddrinfo() will block with invalid configuration =
when
> doing the reresolve for the endpoint. This is now replaced with =
GResolv by
> adding a wrapper for it in vpn-util.c so it can be used within VPN =
plugins as
> well. This avoids the blocking of the non-existent address resolve =
that made
> vpnd unresponsive for the time being, for example, disconnects did not =
work.
>=20
> Fourth, the shutdown is now simulated in a same way other daemon =
utilizing VPNs
> do, by calling the vpn_died() with a slight delay. This makes =
daemonless VPNs
> work in the same way as the rest of the plugins to do the same cleanup =
steps.
>=20
> Fifth, the host given in the configuration as an IP-address should =
contain=20
> CIDR notation but as getaddrinfo() uses inet_pton(), which is relying =
on the
> address to not to have the notation, the host is tokenized first for =
this use.
>=20
>=20
> Jussi Laakkonen (12):
>  wireguard: Add saving of provider properties
>  wireguard: Use positive errors for VPN provider connect_cb
>  vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
>  wireguard: Handle disconnect, error and network errors better
>  gresolv: Add generic error for GResolv struct with getter
>  vpn-util: Add wrappers for GResolv hostname lookup use
>  wireguard: Use GResolv for DNS reresolve to avoid blocking
>  vpn: Drop state changes from update_provider_state()
>  wireguard: Fix shutdown, ensure one exit and set no agent is used
>  vpn: Check if disconnect is implemented before calling in stop_vpn()
>  vpn: Fix extracting of PrefixLength D-Bus value
>  wireguard: Tokenize host for getaddrinfo()
>=20
> gweb/gresolv.c          |  15 +-
> gweb/gresolv.h          |   2 +
> plugins/vpn.c           |   5 +-
> vpn/plugins/vpn.c       |  63 +++---
> vpn/plugins/wireguard.c | 430 +++++++++++++++++++++++++++++++++++-----
> vpn/vpn-util.c          |  30 +++
> vpn/vpn.h               |  10 +
> 7 files changed, 476 insertions(+), 79 deletions(-)

I=E2=80=99ve been using this series combined with the following series =
and patch for several weeks:

=
https://patchwork.kernel.org/project/connman/cover/20250124185845.1546384-=
1-jussi.laakkonen@jolla.com/
=
https://patchwork.kernel.org/project/connman/patch/DB6PR10MB1845EBB07DB785=
B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM/

Plus a revert of this commit which I=E2=80=99ve previously flagged as =
breaking the default =E2=80=9Croute all traffic down tunnel=E2=80=9D =
with WireGuard (the main use-case for LibreELEC users):

=
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D9e=
b1772d31b6fcf78e8711976696491aec9ff5df

For easier testing all patches are in this branch: =
https://github.com/chewitt/connman/commits/wireguard

No issues observed, so:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>


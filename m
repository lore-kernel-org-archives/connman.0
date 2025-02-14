Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DC201032
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514640; cv=none; b=ByevzXYl7rUoPQjxjAIAql6O4n6ZLyjUPNU0QmuodDCEyjEMf8KzyPGMIhfA7ao82MuG/sKIghNBxNSqwNR9f6PtYtqI5gvCPlKJagvQuZemM6BQyMhCfK7m1I9AGNG6Fr3t2T++CoPz5glLJJc/eIk7hwewVmy4YiTRBdNknjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514640; c=relaxed/simple;
	bh=9m4RpQVjPBnG+p+UzJI1Brk48oZQoTtIkhbarQU6RqQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L7DaN/iwTScSlcKJWDwsBXkpE6U4D+uVNUZe3KN6mBwxDRnS84w716eHuILGM5oJT7uOElIqtfKmeitnq28HQYxLWqq/uasBXRMLTjvurRags4+GkQ2++sxje10r2JLS9mOEPdo67SwcyfBRZLimZ3L0Jx/qzy5xdpDd0Mga+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU2MAdU9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU2MAdU9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so1915254f8f.0
        for <connman@lists.linux.dev>; Thu, 13 Feb 2025 22:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514637; x=1740119437; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dEY43/5SGLzQGgd+ealzf1uAx6oS0BZS7TVQ5Bd5O8=;
        b=EU2MAdU9VWSIRqX9gY5O4tv5AycoqzoLlKGH/QMog7O+KkV69ZGWWmxt10LBRUtHsh
         HargfMwXIgKlw9gM1THO9kGvrC1SjuTCIXRf8liaEeYS5y/br5eCcJG8+mggyMknNgWn
         67aRSEeZfulZ7yYW2RxGJKqzIIzXN1DkGgPg4ytT6JmOOgygR4q38+dLBLdSEgmPWmN9
         zu4Iz453X5ECC9sAf4GIGcBOUEMz4Rm+/BzJCTvvg2sJ9AHzY+ag048OtpBLK3rWB6BE
         VOF0OU66jg0hs3tnZ2lkzKOjPq0Dx1K53UDDhUeJMLFCJ02xQgUTFyk+AOk1IVq7+c/i
         l+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514637; x=1740119437;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dEY43/5SGLzQGgd+ealzf1uAx6oS0BZS7TVQ5Bd5O8=;
        b=QUMjE4ra+fSBn1Bs0lVf/IEBMeOS+fkDOSGpZvKzy6F4cWdy7phMvHlqoZZWpOaS36
         pcwZbEwyT0kOHIzW+fDYFeLHfSjVzmprbFNdmzqxCGTrUKSrXHTTq2M1oEKmYSK4iLT/
         3JwG8vRUr+JhADCMIPEQPnmI9+WJfP/EknuxIQCdCNBYVmWu7FUzwZo4PLmnpsO7XR32
         YmufIrwt+ldblbpS5nawLAimYRyr7PFZEf1QU/1daasqaHtXjajlC9BSXQjHE/m7KDCQ
         HoVGlOPBkdEZnmavF19RtogI1FYb/xMdgUOpK1Gh+OFfXu8LKQ26uNaGihIAf2D+WocG
         tYnQ==
X-Gm-Message-State: AOJu0YzUUDo9vEHk5YZgOAbveIFX1VkXAISNQKzBPVr8FCBZ+pJ7h1li
	WvyK8C5y8lCEvsJtrT+5fzqHSg31xYG2QatrdxpIMpniQkpMapHcwtyjJnbATcE=
X-Gm-Gg: ASbGnctFMv0K7iURAwDm+NPiZpgT1zVesfObZkWOT32CXzr6HkD4ZtYTaEyHIJmEiO3
	0K1PJYA+jaQQoARItJ3HKRRhAu0H9v67zXaMIwR13+0Bh+XHFYjzcwJwd09wP8ZiFJ9sHEKBNqb
	Ahh4V5jLrr8rM0pzokiQox1I/TrYFRhYRSTAgnb3f1XY7WT/kjCP7t/L08tm8fqhfmaHr7cvYLV
	yZ+woUWZe7He3OlCccdVvd+sLhuS+r9+bl0qgoC9D9wLzeNHvsQJYZJYHpaHrwIors1PLnNM/50
	dgdwDIM0Au1koK50pzCdLCzeigI7vGWYsJT8fQ==
X-Google-Smtp-Source: AGHT+IFPZ8QeES+T/84TfVIslsU7t6WpSQ4RYYeMU1+w5f0RfpI/IeFzmcI730WMklqBA6Q798SUEA==
X-Received: by 2002:a5d:64a1:0:b0:38f:2856:7dc4 with SMTP id ffacd0b85a97d-38f28568124mr5344007f8f.55.1739514636812;
        Thu, 13 Feb 2025 22:30:36 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm3677530f8f.44.2025.02.13.22.30.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:30:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 00/11] Add association state for VPNs
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
Date: Fri, 14 Feb 2025 10:30:23 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <00708344-6372-45AF-BA3E-AA45DC298373@gmail.com>
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

> On 24 Jan 2025, at 10:58=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> This patch set adds the association state also for the VPNs. This =
state is to
> indicate that the VPN is waiting for VPN agent to provide input given =
by user.
> In this state service.c must not do connect timeout checks as the =
timers for
> both differ in length, default being 120s for connect timeout and 300s =
for VPN
> agent dialog timeout.
>=20
> In order to facilitate this change the association state had to be =
implemented
> also for VPNs. It is common state for services and like with services =
the
> association state for VPNs preceeds the configuration state (on VPN =
side
> connect state). Both vpn.c plugins on connmand and vpnd side require =
changes
> to accommodate this state. When the VPN agent succeeds in getting the =
input
> from the user the state transitions from association to connect =
(configuration)
> state and, thus, requires no specific changes to VPN plugins.
>=20
> On connmand side the association state is the initial state when VPN =
is getting
> connected and the state needs to be accounted as a connecting state in
> plugins/vpn.c to not to lose transport ident for it and in provider.c =
as a
> pre-configuration state to not to start the connect timeout for the =
VPN before
> the VPN is in configuration state. The reason for the latter is that =
the
> connect timeout should be exact and start from the point when
> connect/configuration state is entered.
>=20
> On vpnd side association state is, like on connmand side, the initial =
state for
> the VPN getting connected. After the VPN agent succeeds getting the =
information
> from the user (credentials) the state transitions to connect =
(configuratioin).
> There may be a possibility for a VPN plugin to run without VPN agent =
and thus
> in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() =
does
> the state transition in such cases. It is allowed go back to =
association state
> from connect state but not from other states.
>=20
> Jussi Laakkonen (11):
>  agent: Cancel agent request on NoReply D-Bus error
>  vpn-provider: Use association state for VPN agent input wait
>  vpn: Add association state before connect state
>  vpn-agent: Do connect state transition after input dialog check
>  service: Explicit VPN connect timeout, ignore in VPN agent wait
>  provider: Handle VPN configuration and association states
>  vpn: Add support for association state, add state getter
>  vpn: Check if connecting when setting state or disconnecting
>  vpn: Add VPN agent use callback for plugins
>  vpn-provider: Transition to CONNECT state with agentless VPNs
>  doc: Update VPN documentation for association state
>=20
> doc/vpn-connection-api.txt |  4 +--
> doc/vpn-overview.txt       |  7 ++++-
> include/provider.h         |  9 +++---
> plugins/vpn.c              | 23 ++++++++++++---
> src/agent.c                |  4 ++-
> src/connman.h              |  2 ++
> src/provider.c             | 22 ++++++++++++++-
> src/service.c              | 52 ++++++++++++++++++++++++++++++----
> vpn/plugins/vpn.c          | 44 ++++++++++++++++++++++++++++-
> vpn/plugins/vpn.h          | 12 ++++----
> vpn/vpn-agent.c            |  6 +++-
> vpn/vpn-provider.c         | 58 ++++++++++++++++++++++++++++++++++----
> vpn/vpn-provider.h         |  7 +++++
> 13 files changed, 220 insertions(+), 30 deletions(-)

I=E2=80=99ve been using this series combined with the following series =
and patch for several weeks:

https://patchwork.kernel.org/project/connman/list/?series=3D928220
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


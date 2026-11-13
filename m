Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584325;
	b=oiRGkEdTQF/0pkNg0o+226zGZ8g0t/Xkf3aGd8Ye/nfCc4y2AZWW+C9BUqOcJPnyahfG
	 aPsI3Nt5uzxU8dWGdgS6MRUKvZGOnXRRdfEBgPIg3tguvT5ow4H3FBX1jG9tHAqb7wW+n
	 sw5xc6L57nhnNRyc/YZiggRs9ScKD1e7NF8AQ4ADy9MA9VNGU5uR2JQ2VPw5eqGVYa6T4
	 uZgYTNCElfeQiPMrhyeXRXwYooOQRXsCcciJMocDLgxqY1KLAHunY5Y30ksxm5iTsZNjc
	 V0A1IV9UW3bXP6H8N9KpYDgDLiw21uNyI0vxtUNib1kEWJVN7kt0IzheGAqODmBnnVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584325;
	h=DMARC-Filter:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:DKIM-Signature:X-Scanned-By;
	bh=yS/rxy20VaIKWhZvK2k7HLRAmyQurgQK/R3nltr0/ac=;
	b=22V30HyjxMtn72eaFLm694pY/dIf1xl7d0rpTBsz/GPrVtwfaTWgm7SoNSn5SVIPaOSg
	 XuJi8ZaamXRe9BxS/T9DIbL7NGoZKl62u6PQ4H7zXXcU2DxdWdiDA/5efHi5U5hOC6G59
	 FCvPc4FaW/CDbeq66fpxchUJH2zpD7/W8t9m6kUWhuqfC3lHUm74cfCh1n1cHUM8i3p86
	 3guUNDn3188AU+NhS8P2afUY9NktRY87FseszDA0H7+AEI7H29vrMNEWIOeSleDAJUWRH
	 XZlzdn/Mcf0YA3A4yztmfznZ0k0VjeYGd49kOrvSm9fD+v0Oa4ZSEPRMl7CieJ5QxHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=pX3F3KKg;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A67606A331
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A67606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=pX3F3KKg
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9145F1602C3;
	Fri, 13 Nov 2026 10:38:43 -0500 (EST)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 3CDE0124C56;
	Fri, 13 Nov 2026 10:38:43 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.4\))
Subject: Re: [PATCH 0/4] Keep link-local-only services from displacing the
 default
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20261113033504.1828738-1-gerickson@nuovations.com>
Date: Fri, 13 Nov 2026 07:38:32 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E13FB26-F898-48BE-9665-76196FED9E2C@nuovations.com>
References: <20261113033504.1828738-1-gerickson@nuovations.com>
To: Johannes Emerich <johannes@dividat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=yS/rxy20VaIKWhZvK2k7HLRAmyQurgQK/R3nltr0/ac=; b=pX3F3KKg+GccQ90bs2cnvZemMPGP0BIhAQVXpUYXy2cH5d3ReIOA1CM9Fe/xTbBYZpOvbEoAcud26Lh5y3Yx7xpce7/vpcyX7kLKSo74XHdLvDKOooBLdn4EDGyLndJv/P4JUoUusx3RPzeO6MaDTadyT7Yu21ESc54HUd7bCQEGfP7ZnOjF33OOTuNwxW54bMzgw4zkVzFXatjdQQePh/zxuKL6SViRFD/t7tRUIEa+TK8UcS6eHaKRWioiCmkzrzikVRh5OW+QNJYDAZUBAQJhV+riAOb9+2mrLC2PyYuifl0mOF71U36+lobtO58ztWzg9Qo3IEeZl9mkzU51DQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Nov 12, 2026, at 7:35=E2=80=AFPM, Grant Erickson =
<gerickson@nuovations.com> wrote:
> When DHCP gets no lease, connman falls back to IPv4 link-local
> addressing and the service becomes "ready" with a "default dev
> <interface> scope link" route and no gateway. Ethernet cabled directly
> to a phone or laptop, or to a switch with nothing else on it, ends up
> this way. It reaches only its own link and never passes an online
> check.
>=20
> With PreferredTechnologies listing ethernet first, such a service
> outranks an "online" Wi-Fi or cellular service: 'service_compare' and
> 'service_update_preferred_order' consult PreferredTechnologies before
> online-over-ready. Ethernet takes the default route, Wi-Fi is demoted
> to "ready", and only Ethernet is online checked. The system is offline
> until Ethernet meets the online check failures threshold, every time
> such a cable is plugged in, and at every start with one plugged in.
>=20
> This series ranks a service connected only by link-local addressing
> below any connected service that can reach beyond its link, whatever
> its technology, in both places. For IPv4 that means connected with the
> "auto" (IPv4 link-local) method; for IPv6 it means not connected, =
since
> connman drops IPv6 link-local addresses as they arrive and becomes
> "ready" for IPv6 only with some other address. It also re-sorts when a
> connected service gains or loses that reach with no change in its
> state, as when a DHCP server later appears on the link of a
> link-local-only Ethernet service. A link-local-only service alone is
> still the default, as before.
>=20
> The IPv4 test keys on the method, not on the gateway address, because
> point-to-point links such as many cellular bearers have no gateway
> either but reach beyond their link.
>=20
> Note: This adds a new log entry: "Interface <name> [ <type> ] is now
> link-local only" and "... is no longer link-local only" once per
> change.
>=20
> Grant Erickson (4):
>  service: Rank link-local-only services below others in
>    'service_compare'
>  service: Rank link-local-only services below others when reordering
>  service: Re-sort when a connected service's link-local-only state
>    changes
>  doc: Describe link-local-only services under PreferredTechnologies
>=20
> doc/connman.conf.5.in |   7 +-
> src/service.c         | 276 +++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 276 insertions(+), 7 deletions(-)

Johannes:

After working on and submitting this, I was reviewing patchwork and saw =
you had a submission, https://patchwork.kernel.org/series/1081540/, that =
might be very-closely related. I=E2=80=99ll take a look at your patch. =
To the extent we have arrived at functionally-equivalent solutions, =
would you be up for collaborating on a merged/aligned approach?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/=

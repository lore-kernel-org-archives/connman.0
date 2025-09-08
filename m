Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD91946AA
	for <connman@lists.linux.dev>; Mon,  8 Sep 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348719; cv=none; b=dL612dt0SuAWZ4olbAj58GtMMOVyGul96Nklpq38sgEw+0/wqMCDAgb6NDcKbczgffPsRYxduFUfe70SGM1URkPV4dHlTMLqtaj1LytPs9gURsA87sBu8SfDOF4lw4UxQbG+WzC4YqpJa4mVregl1+cW1VV2llc4Kv/O8vaHNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348719; c=relaxed/simple;
	bh=KM9iZ1+ocpMU52goKO18MXaUofu93a7EMtR3vYiwzLQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jPJlRTvezF+fi4g+kqnfBGXfymJy4MxI4nDXwurt7z/VzN9NfrD9eB9EFsyupQVvap4QDQUUDRtZYA3YCDz1+Ha+cdX9VOvjJwdDhJte89SdqyEnXCO+kcPj0TI+81AE9yrldeUK6wAaOpN/sr9+FD1YwwWgIVL3aQin1Ry76rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=epkinr2Y; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="epkinr2Y"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DB5A9164A61;
	Mon,  8 Sep 2025 12:16:59 -0400 (EDT)
Received: from smtpclient.apple (c-73-189-96-183.hsd1.ca.comcast.net [73.189.96.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8B9A912634E;
	Mon,  8 Sep 2025 12:16:59 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Demoting IPv4 link-local services in service list sorting
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <CAKQ2e6X9BVihgY58OjzwbaqNn5HVHqHDCirsO2+qCBro91sygg@mail.gmail.com>
Date: Mon, 8 Sep 2025 09:16:48 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <678A927C-57A0-4765-B4EC-F3E1759ED553@nuovations.com>
References: <CAKQ2e6X9BVihgY58OjzwbaqNn5HVHqHDCirsO2+qCBro91sygg@mail.gmail.com>
To: Johannes Emerich <johannes@dividat.com>
X-Mailer: Apple Mail (2.3826.700.81)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=8rL30gUv9JwM63j508rdjUGk12HfJASdo32LvWtCfn0=; b=epkinr2YdpBTZ/4PEMYQH8qVJ1iW7Ef8X8YoLdGHTRl3U1f35e/zu1LZVC/EYOb7wFaM9zyKqWsriSraA7QrByVc9+s80ADu03yLpqxpj+DdEd6dauiCWeAarJcXbGte3LfocvrhKyCxVLiX7v0finP729H3VotV6HQQUxy3iJDSJe001ovoOjOE+hlqbbLCWtB+Wq1nHvRHDLU2cLPQH+1mExOqBraRpdv3mSQsBJ81cG3jFf4Xpy2JG2TZeRkYDxDzuHogXGiso6n58cnNBDY4rcVjj0pTG0+x7dbz2HtBf/Z/RQNm73232NzoghgDlgK7nEqF8JnFiIIDZOgZow==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Sep 3, 2025, at 5:50=E2=80=AFAM, Johannes Emerich =
<johannes@dividat.com> wrote:
>=20
>=20
> I am trying to teach ConnMan to give IPv4 link-local services lower
> priority than READY/ONLINE services using another ipconfig method =
(e.g.
> DHCP). This seems like a useful heuristic, given that link-local
> services are not suitable for configuring the default route.

At the look, this seems reasonable. Certainly in my =E2=80=9Cclient=E2=80=9D=
 code above my D-Bus ConnMan client, I have sorting functions that =
sub-sort services in the =E2=80=9Cready=E2=80=9D state by other =
criteria, including whether or not they are in error (such as =
=E2=80=9Conline-check-failure=E2=80=9D).

Within connman itself, in service_compare, the online check failures =
threshold is used as a comparison predicate.

That said, there remains the question, =E2=80=9CThis could be done, but =
should it?=E2=80=9D. More on that below.

> As far as I can see, two changes would be required:
>=20
> 1. Adding a condition to service_compare(), something like this:
>=20
>    /* Prefer configured IPv4 address over auto/link-local IP.
>     *
>     * This just checks for CONNMAN_IPCONFIG_METHOD_AUTO, but other
>     * checks could be done.
>     */
>    bool a_is_link_local =3D is_ipv4ll(service_a);
>    bool b_is_link_local =3D is_ipv4ll(service_b);
>    if (a_connected && !a_is_link_local && b_is_link_local)
>        return -1;
>    if (a_is_link_local && b_connected && !b_is_link_local)
>        return 1;

Seems reasonable. That would just need to be adjusted spatially in =
service_compare so it is appropriately prioritized relative to other =
=E2=80=9Cready=E2=80=9D state predicates.

That said, there remains the question, =E2=80=9CThis could be done, but =
should it?=E2=80=9D. More on that below.

> 2. Triggering re-sorting when IP/ipconfig method of a service changes
>=20
> Currently formerly link-local services are not actually promoted when
> DHCP becomes active. This is likely because a service that transitions
> from IPv4LL to DHCP just remains in READY state, and no re-sorting
> occurs.
>=20
> To address this, ConnMan would need to trigger re-sorting of the =
service
> list when a service's ipconfig method or IP address changes. I am
> currently looking into triggering sorting from service_ip_bound() or
> address_updated() and this works in a basic test by just adding:
>=20
>        SERVICE_LIST_SORT();
>        __connman_gateway_update();
>=20
>=20
> I would be grateful for any feedback on the below:
>=20
> - Is there any reason not to demote link-local services in the way I
>  described?

That said, there remains the question, =E2=80=9CThis could be done, but =
should it?=E2=80=9D. More on that below.

> Context for this change
>=20
> Our kiosk system built with ConnMan typically uses two simultaneous
> Ethernet connections, one to an input device using a link-local =
address,
> one to some network providing Internet access. In most cases ConnMan
> reliably uses the Internet-bound network as the default service, but =
if
> the network is slow to respond to DHCP requests for some reason, both
> Ethernet services end up with link-local addresses initially. In this
> case, ConnMan may choose the local-only connection as default service
> and stick with that choice even when the other service receives a good
> IP and gateway via DHCP later.


The either one-shot or continuous online reachability check should =
handle this case. The check will always fail for your LLA interface and =
it will stay in =E2=80=9Cready". When reachability is there, the other =
interface will transition from =E2=80=9Cready=E2=80=9D to =E2=80=9Conline=E2=
=80=9D when the reachability check succeeds and the priority issue =
should be resolved.

> Continuous online checks are not currently a good fit for us and =
should not be required as it is known a
> priori that link-local services are not useful as default services.

Why is this the case? The mechanism is doing exactly what it should be =
doing which is to answer the question, dynamically, =E2=80=9CCan this =
network interface and the network service associated with it reach the =
Internet?=E2=80=9D. If the answer is =E2=80=9Cno=E2=80=9D, it stays in =
=E2=80=9Cready=E2=80=9D. If the answer is =E2=80=9Cyes=E2=80=9D, it gets =
promoted to =E2=80=9Conline=E2=80=9D (subject to other configuration and =
conditions).

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


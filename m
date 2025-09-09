Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA430215E
	for <connman@lists.linux.dev>; Tue,  9 Sep 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444066; cv=none; b=OC9rrj6ClY0602Wgpjo4g4nYIOnlQUHtPba7jcxAJA1h5rD653HLcxuYA44QlmjrB+Jx+lUXZbKHfQsdx6lmEvZZsTP5zMZVaRZdB6q4lqbkood0v8rS0uaVRqKOQl7MH22yd0CBL/nUoqyG3ThsRmeiQE/d5jH51qhyOJ8VFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444066; c=relaxed/simple;
	bh=9/fpUp0q6tw0OUMVM1Vk04DCFDNKtJE5tAR1J8PWA38=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bXE+sED9Xb49Z+mDWYX+buCnnjlaKYuFQrU3P+91Up773FivXwWDrmjrDBNFOBcje8VXDHgiTWOJbaIhDhHV4cskM/zucYXqcyPP7gSRrkb7IhesPIdXuRyHnjXF/cDT4UUm6biTMJ0T6xQXHSotpY62oy4IPhpy8YuQJDBwSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=DZ1wUSJp; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="DZ1wUSJp"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E6BCA164AD2;
	Tue,  9 Sep 2025 14:54:16 -0400 (EDT)
Received: from smtpclient.apple (c-73-189-96-183.hsd1.ca.comcast.net [73.189.96.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 94D1D124EF7;
	Tue,  9 Sep 2025 14:54:16 -0400 (EDT)
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
In-Reply-To: <CAKQ2e6VrjdfxKUy89aPEL10PUOiTnMeOMDtJofXdOn6B1g-O0w@mail.gmail.com>
Date: Tue, 9 Sep 2025 11:54:05 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BDB1272-56C7-4FAB-AF79-9A56F7F75F62@nuovations.com>
References: <CAKQ2e6X9BVihgY58OjzwbaqNn5HVHqHDCirsO2+qCBro91sygg@mail.gmail.com>
 <678A927C-57A0-4765-B4EC-F3E1759ED553@nuovations.com>
 <CAKQ2e6VrjdfxKUy89aPEL10PUOiTnMeOMDtJofXdOn6B1g-O0w@mail.gmail.com>
To: Johannes Emerich <johannes@dividat.com>
X-Mailer: Apple Mail (2.3826.700.81)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=JeGYxGYn2cdxGM5rnXljxDzEvdBNW6UVyW0CL3T9TeM=; b=DZ1wUSJpmkbDy3HQKXtr36fzdZN77WgCCA5Ob2EvKlopKDysaKJ1SGWpphn1S2hkZ6MrsfhDcOfQR0fRJFTlpTRsPEs7Gy/YrrKpQqpZ0JgI0wARphe1N0LekPWqPvxbyKQuK3WqxmznlIp2I/7RCRainjyU8+vEcy0WXFcZYJ4wbJo695lR8DjIpB2swUQihBwc2xq9SS6iie0HHg/o9VdWdw/i1t0eVsZLAihw6e4lCSn7BR8qLxsrvxMHhmLac0HCn6fJWds6s5QpeKO5LO+CI5XmTrUlJ+Qu6zBgZNcS2YEx9jmwV57WBzfDzjr6IU2p2DlNAxdW8rbK+jdwNg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Sep 9, 2025, at 11:38=E2=80=AFAM, Johannes Emerich =
<johannes@dividat.com> wrote:
>>> Continuous online checks are not currently a good fit for us and =
should not be required as it is known a
>>> priori that link-local services are not useful as default services.
>>=20
>> Why is this the case? The mechanism is doing exactly what it should =
be doing which is to answer the question, dynamically, =E2=80=9CCan this =
network interface and the network service associated with it reach the =
Internet?=E2=80=9D. If the answer is =E2=80=9Cno=E2=80=9D, it stays in =
=E2=80=9Cready=E2=80=9D. If the answer is =E2=80=9Cyes=E2=80=9D, it gets =
promoted to =E2=80=9Conline=E2=80=9D (subject to other configuration and =
conditions).
>=20
> Yes, we have confirmed that the continuous online check successfully
> recovers from accidental use of the LLA service as default service.

Excellent; that is great to hear that this works as-intended.

> The issue for us is that ConnMan's online checks make specific, hard =
to
> meet assumptions about the probe host.

I was able to stand up an nginx instance with very little configuration =
that easily and statically satisfies the connman online check header =
requirements. Let me know if you would like me to share that =
configuration.

> Our systems frequently run in networks with firewall restrictions, and =
each additional host to
> whitelist is a possible source of failure and friction. We could
> configure ConnMan to use an HTTPS check URL on our application host, =
but
> the online check does a case-sensitive string comparison when checking
> for the marker header X-ConnMan-Status. (As far as we understand RFC
> 9112, it should be case insensitive.)

Agreed that this case sensitivity should be relaxed in connman to comply =
with RFCs. Unfortunately, the change is somewhat involved since it =
involves customizing the g_hash functions used for handling web headers.

That said, I have a client that uses Envoy for the online check endpoint =
(rather than nguni) and there was a setting in Envoy they found they =
could flip that does the right case for that custom header:

% curl --verbose http://<host>/api/v2/status
*   Trying <address>:80...
* TCP_NODELAY set
* Connected to <host> (<address>) port 80 (#0)
> GET /api/v2/status HTTP/1.1
> Host: <host>
> User-Agent: curl/7.68.0
> Accept: */*
>=20
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< cache-control: max-age=3D0, private, must-revalidate
< content-length: 0
< date: Tue, 09 Sep 2025 18:48:10 GMT
< server: envoy
< x-request-id: 07307f81-5144-493d-9c8e-c8d23f1b3174
< x-envoy-upstream-service-time: 1
< X-ConnMan-Status: online
<=20
* Connection #0 to host <host> left intact

> This means we would need to
> decorate an application server with a ConnMan specific response, and
> also have to ensure that our servers preserve the capitalization of =
the
> header field that ConnMan checks for.

Again, for both nginx and Envoy, this is a fairly trivial exercise to =
return the desired static content.

> Also, if we were to use the online check to demote LLA services, we
> would need to balance quick detection of this scenario with low chance
> of false positives on regular network services (tuning timing and
> failure threshold parameters).

Agreed. Between the two algorithms (geometric and fibonacci), the min =
and max intervals, and the success and failure thresholds, there are an =
abundance of =E2=80=9Cdials=E2=80=9D to get a behavior that should work =
well for your application.

> If we compare this with the heuristic to demote link-local services, =
it
> seems generally applicable, leads to immediate resolution without risk
> of false positives and does not require us to configure our server
> infrastructure in specific ways.

Seems reasonable.

> So the heuristic seems to make dual Ethernet (and other) scenarios =
more
> robust out of the box, while being compatible with all online check
> modes (none/one-shot/continuous).

Seems like a win-win!

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


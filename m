Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE439FD6
	for <connman@lists.linux.dev>; Sun, 16 Jun 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560275; cv=none; b=pMuGQQJ+eE6Cw6cyBlcur6Dysa/WqvIbkoJIskfiSvY54NOGNbktAC9jQqMFYnDSlTgg5rBSquO+nyyiWcEvshKYnbtvjFayl0hkkTOsFetHMWw0CZV6uJPZOic93hAHWDR/xccT6IOnG9JZ92aVdWBHGgEwNmmdb7hRDq/f8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560275; c=relaxed/simple;
	bh=uWO2jsltGQXK+pqqcn47LX2yCEb/mvI4xCQMAbCvg8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dRnddfN7tmnr43vT+zJAeN4dMPPBLE5QHee3PsfPMhbPm4TrpO9N7bsTNcmhi9KKzHq7Q4RMrxk5gAQaN+tPgQDCruAtwMZMijcBh4BaqTCBXi6krcEcmYClqyVgxBhTFYbe+tim6UKvURSDWo9NYgS1cH4F/eNh1hsqZyDc+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=HobdnwmG; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="HobdnwmG"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 146191649BB;
	Sun, 16 Jun 2024 13:45:47 -0400 (EDT)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B1197124EF4;
	Sun, 16 Jun 2024 13:45:46 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: Global nameservers or alternative to / change in
 FallbackNameservers
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <87o780anzf.fsf@freakingpenguin.com>
Date: Sun, 16 Jun 2024 10:45:35 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8027244E-47BE-4AAE-AC2F-E7EFDBFED4CD@nuovations.com>
References: <87o780anzf.fsf@freakingpenguin.com>
To: Richard Sent <richard@freakingpenguin.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=loBCpe062tJ7DS+aYAjwkxjjB1TCjBJUI6/Juk2fKso=; b=HobdnwmG1my923CaIGzn2HWvfHDanXfEHyCcXNNh6HBBMBU3T0ypqWqogPfCmXvEmf9PPZ1Rcve1FM8oyl326tHz2saRNPX9zZu5/TXGDLKCsQByXfZDBzwPNVhoh53sLKAwk8d2toHjW5AY3VyEfipCg+9Wptox6papb1MaFMJhju8NcpxCLQWCxzftu+ABi2/N/AC783+gvGQljevFO2IqNvKtrPBjQKSr/Jl1yWq9ozhiU42mYGw9+eMrI6dhnMhmdzgiOZU/M1aiLMOMKHVSzJ8CWFL19owyNAB0Mo2mNUbkwYYz2nnxklcxsVe0CiIIjWw8SpFORcHWfy3SrQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jun 16, 2024, at 8:47=E2=80=AFAM, Richard Sent =
<richard@freakingpenguin.com> wrote:
> I'm using Connman with --nodnsproxy on a virtual private server where
> the DNS servers discovered via DHCP have inconsistent availability. I
> thought I could resolve this by setting FallbackNameservers. However,
> this setting is only used when DHCP does not provide DNS at all, as
> opposed to my initial thinking of using it as a fallback in case the
> DHCP discovered DNS servers fail.
>=20
>> # List of fallback nameservers separated by "," used if no
>> # nameservers are otherwise provided by the service. The
>> # nameserver entries must be in numeric format, host
>> # names are ignored.
>> # FallbackNameservers =3D
>=20
> This results in a resolv.conf containing only the nonfunctional DHCP
> discovered DNS servers and not my fallback DNS. I could configure
> nameservers on a per-connection basis, but this is frustrating to have
> to do on a system that could be deployed to different hosters that may
> enumerate the network interfaces differently.
>=20
> There does seem to be some demand for a way to set global nameservers,
> as opposed to per-connection [1]. This case is even worse to do =
manually
> because it discusses a laptop which roams between connections
> constantly.
>=20
> If breaking backwards compatibility with the old FallbackNameservers
> behavior is considered unacceptable, I propose a GlobalNameservers
> setting in connman.conf.
>=20
> I do see a line in service-api.txt that implies global nameservers are
> in fact already a thing, but can't find any other references to them.
> This comment was added back in 2010, before FallbackNameservers was
> added.
>=20
>> Global nameservers are automatically added to this
>> list. The array represents a sorted list of the
>> current nameservers. The first one has the highest
>> priority and is used by default.

Richard,

I agree with your conclusion; in running down a similar issue, I=E2=80=99d=
 wrote a note to myself in an internal tracking issue to the effect of:

    In the process of working on <redacted>, I=E2=80=99ve discovered =
that this is by design.

    =E2=80=9CFallback Name Servers=E2=80=9D are only used if there are =
no automatic (assigned by DHCP or
    per-service configured name servers).

    What would be required here would be a new setting, =
=E2=80=98PreferredNameServers', that would
    take precedence over assigned by DHCP or per-service configured name =
servers and effectively
    would override per-service configured name servers.

The same applies to time servers. So I can see a general configuration =
pattern where:

    Fallback{Name,Time}servers
        Use these {name,time} servers if the DHCP server does not =
provide one.

    {Global,Preferred}{Name,Time}servers
        Always use these {name,time} servers, prepending them to the =
front of
        their respective lists, even if the DHCP server does provide =
one.

I=E2=80=99m partial to =E2=80=98Preferred=E2=80=99 but could see where =
=E2=80=98Global=E2=80=99 might also be a good description.

Best,

Grant=20

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


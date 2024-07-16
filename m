Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2F1A01A7
	for <connman@lists.linux.dev>; Tue, 16 Jul 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152816; cv=none; b=OLiFJd7ysTCK4k8pUzYrTyAU6R48MOs7aE94dcFtJOAIbr92pQODI10eAepjGKdoKL8De7KNCxE69+L/A/kjGlo8pfQ06Vxq97saIU0zArJRCD+/sQ44TvXtIOF9TQWULGes8IVoOfPvgnCwuV2ExbXJhs+ORDAHprso6/lV/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152816; c=relaxed/simple;
	bh=hFghOJPiKM86XhtuTwd+zS+z//JtM5iP7ca1vsP9MGM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G+evtB5KifpQNte3PYYFBO2XUdl7uCv8++27889/rXxi7Jb3TIo8aRw8/OQX92GyXnSo3ahmR4WoLzlqYKRQuc3WHizKanuPC5vbxtR9kr2nz9vE9lQVY//kvW/FzZ0dnZGhLg3v027pt/gl9Uzb8FwhCbSTwJf1/FBW7pJdywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=cXaeRCMm; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="cXaeRCMm"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8020E164A89;
	Tue, 16 Jul 2024 13:51:01 -0400 (EDT)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1CA44125165;
	Tue, 16 Jul 2024 13:51:01 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: DNS vs. Route preference
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <goegsIQSUITE01C8wSA00000006@goegsIQSUITE01>
Date: Tue, 16 Jul 2024 10:50:49 -0700
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <53240F35-0BE5-43FF-B53D-7684858514AE@nuovations.com>
References: <goegsIQSUITE01C8wSA00000006@goegsIQSUITE01>
To: Thomas Bartosik <Thomas.Bartosik@goeg.at>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=8NTqiJiywuyM3g8+MCmN+rERO4TGfx5jsGOlt9R8vDM=; b=cXaeRCMmqDY1V56nBAKV2sFeXhE0kNIuqZfzIc2l2R6ibzxFXPERw1Bc/RFn9IV1iaaLNvDgIIQgw/lr3nYmkaVlTV3NgnDJs0BNZVIA2spxHpsvonGzIRm6ETDS3oW+DGJxW+Bzq6gePwCbPzh+dlrk5wvBWgizAeod0gVNOWKltp1LOTyQFIMNIEiPDShs9cFo1aZUNqAucsWUdD6zCiC60ptwAgpPONH2GttNGV1Y+JbI3yrHwbZo7BntktJLwEE0BTJNmDeThII9Z76syIFkJd/+edLtAPDP97XMDIlX+t7jIavwx9hKXRbYYvsLpJ2obJctLpJH3EoUG9ZY6g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jul 15, 2024, at 11:09=E2=80=AFAM, Thomas Bartosik =
<Thomas.Bartosik@goeg.at> wrote:
> I am using Debian's connman 1.41 and openVPN.
>=20
> I have to set a route preference ("move-before") for my local =
connection before the VPN, as otherwise packets don't get routed via the =
default gateway.
>=20
> However, that also makes my local connection's DNS server the =
preferred one over the one that gets pushed via VPN.
>=20
> I do get correct DNS responses for internal domains that only exist =
internally.
>=20
> But there are services which have an internal and an external IP (for =
their publicly visible A record), and when connected via VPN, I want to =
get a response for (and connect to) the internal IP.
>=20
> Is this achievable/which configuration options do I have to set?

I=E2=80=99ll defer to others that have far more experience with VPNs in =
ConnMan than I have.

> Or is this already improved in 1.42 and/or current git versions and =
should I test the current master?

There are a large number of fixes and improvements between 1.41 and =
top-of-tree. However, please note that per this thread, there are issues =
with VPNs and later versions:

    =
https://lore.kernel.org/connman/FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail=
.com/
    =
https://github.com/LibreELEC/LibreELEC.tv/commit/998f2bcfd5849e3eecda6f753=
ff5bab68a847aea

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


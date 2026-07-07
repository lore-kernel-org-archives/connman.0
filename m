Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C63F5BF5
	for <connman@lists.linux.dev>; Tue,  7 Jul 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438670; cv=none; b=SsdtlQXOQEVlPU/6mdQcg12F07FwaP0ww4xCLe+ziosEW39FW9OJBWTxKTl2B4kJ44VWwyY28TdIEHcOA9+bJApnOLHMWhj3AFFodUIaW86umUzt/b56Jwr7EU4p/jovRFSe7Pd/76o6KeyEBhYE2pIQah1vKpFI5AHTTOcuv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438670; c=relaxed/simple;
	bh=quBPVdXE0JBZYhxBJ02P9KefRRkNp41jM5FEm9Aif1Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i7ymMN5Xo7ZlSjbei40fxeClJLH2Ctf7gjIIAxf4cLQEpa5iJ3/PBWl3nNr8PooClFPOVtKh32j3A0tXRkqfQ2RNb0T+ZV09tn9dAeLBPJV6VDrjrabiadx4ApThDv7WjuAB0HA4U3AHqvZE2UuDlNRwzx+LSB/IptMeD4vbma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=LiYpcxF0; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="LiYpcxF0"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 660BB1603E6;
	Tue,  7 Jul 2026 11:37:45 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2151C123933;
	Tue,  7 Jul 2026 11:37:45 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 0/2] gweb/wispr: Normalize received HTTP header field
 names
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
Date: Tue, 7 Jul 2026 08:37:34 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DDD66FE-33C7-4F70-831D-418C5DA3E131@nuovations.com>
References: <20260707091645.90508-1-giuseppe.eletto98@gmail.com>
To: Giuseppe Eletto <giuseppe.eletto98@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=keIfbGsXDU6U8BVZ+v+FXaBkcV+VJcbwHdyl4I/I4us=; b=LiYpcxF0W5f0xnFsQ3C7yIfd9Qz2GqR854mB6CU5nSwC001lZiqZZQu+QZ1rwVEQ4+9f5qXgx/WABHmYcGTyr5yqgbrMEAZCsIOZUyclpuTZUIweKZjIMyfCVifsp6fToh50J+optOP9lcyj0HFNfM7P6G4XbYGhp2K3w1kiociz4jNEUAtPPXtJdy7oDvjsboQGAr+X65iE1TtReM7rB0L0HErXfEpc9bYuTMhucxMkydpg+37eRm08/mjVZApmLnkBMEVfi1dq8pQw2+d6WPuyJQbtvP46AOGJ19jgHKtNW/NXnQSo7kMcm9fJwGI4CLPdJOIGJnKtIycBH3unSQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jul 7, 2026, at 2:16=E2=80=AFAM, Giuseppe Eletto =
<giuseppe.eletto98@gmail.com> wrote:
>=20
>=20
> This series makes connman correctly handle HTTP response headers
> from modern servers that send field names in lowercase, as
> permitted by RFC 9110 Section 5.1.
>=20
> The first patch normalizes incoming header field names to lowercase
> at parse time in gweb and updates the lookup path accordingly.
> The latter updates wispr call sites to pass lowercase names,
> consistent with the normalized store.
>=20
> Giuseppe Eletto (2):
>  gweb: Normalize received HTTP header field names to lowercase
>  wispr: Use lowercase header field names in g_web_result_get_header
>    calls
>=20
> gweb/gweb.c   | 19 ++++++++++++++++---
> src/wispr.c   | 12 ++++++------
> tools/wispr.c |  4 ++--
> 3 files changed, 24 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.50.1

Thank you for doing this; long overdue. The approach seems reasonable to =
me.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


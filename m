Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A318488
	for <connman@lists.linux.dev>; Mon, 28 Jul 2025 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742295; cv=none; b=vEazHTotoiorf93D6QnaoB2A2izuG3XhNcJKiyP1u48TrzVCPVqkIj1KoAyj964/pvaPLeKWDlIk5k98yKFMZWjUEO3/6X5v0rLRTZmcfcna9bMcaQoOy7DEGk3zLnMCQGKl7+JPF0Dl/YRqhglFEDcEmcTgrqMBFB0jusoqiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742295; c=relaxed/simple;
	bh=k7NQdfPEFn3/SVDnE/INaRqr5YOPjH6ujnvBcH+MkGk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d93kU38e1fbm7x4rG0BecJRgNClOUOd7OCmw7urT98p2aDwqN8RP1NzOhMhVpv5qNiw7XgBHaI/c6csTy72tk7zZznwtYdO6qKD9gd3ooRpJkMQ36U8j3wEI1P/OAQ1MN7vx+FgMuy9L9PhQY7MSzFlwXCQgv41ODA2bI11zZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=UcxcBPpC; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="UcxcBPpC"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C414D164A38;
	Mon, 28 Jul 2025 18:38:10 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4E77D124E6D;
	Mon, 28 Jul 2025 18:38:10 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Adjust printf(3) formats for 32-bit platforms
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20250721141712.796989-1-l.stelmach@samsung.com>
Date: Mon, 28 Jul 2025 15:37:59 -0700
Cc: connman@lists.linux.dev,
 m.szyprowski@samsung.com,
 k.lewandowsk@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3717461C-D785-4074-B43B-6297BCBE0EED@nuovations.com>
References: <CGME20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a@eucas1p2.samsung.com>
 <20250721141712.796989-1-l.stelmach@samsung.com>
To: =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=iamwVNQUMoysTzSwEYAzA3tIrIRj/o9CJ1tthz2BI/U=; b=UcxcBPpCCJe+6CVJmS/1REUvqa7Jkg5HWVt8m6GIuKtH0Z1qAPh0xl+rCE9Yx7VoY6e4Gaj3tevbCe69mmkz+oTc3yY1rSyIKxEpJ4s8ir0htdyMWsQRu+iPjzX8YuHYLICHltEKW+R/FGh2JEnK+JAmfu5ooTZijBHYPLa66xtmiQOjhitOoxToqfFtlApdkBBmPP4cNUD+1jZso6X9RUtXAhOlBxDsPTJPG0G8AzDHUGO/YFRDyVRL83405rr09ODKgDAanHIYqHBMzLiZb5dtRZbnYp+hvPzqOwCaeFdF6CQ8b9ac8JKxOxHeMh10FJ6aPiA38bEqYRunA79/5Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jul 21, 2025, at 7:17=E2=80=AFAM, =C5=81ukasz Stelmach =
<l.stelmach@samsung.com> wrote
> On 32-bit platforms time_t may be defined as long long int to make it
> 64-bit wide and y2038 compatible. On 64-bit platform with LP64 data =
model
> ABI long long is also 64-bit, so it is convenient and safe to always
> cast time_t to long long and use %lld/%llu format on all platforms.

=C5=81ukasz:

Had you considered using the mnemonics in inttypes.h to avoid the cast =
such as:

	selection_str =3D g_strdup_printf("%s:%=E2=80=9D PRId64 "",
	device->last_user_selection_ident, =
device->last_user_selection_time)

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


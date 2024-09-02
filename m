Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D9D186E51
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266144; cv=none; b=VwnkpqNui6yQrJp8V+YJ7Ywh5GeGOiNIkgGBUT6zxCYW3OJ3h64poHa9TLiANXhDYHrzH5qyfNodvXzbSHK5S+56aTcWXmLPz6TaEYZzEYcLBr2aegdEZAkjqkhdiAnxdHJ3SvEQ7v8i89uivfLFuK5CKbj5HPRIsZiwYNjoAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266144; c=relaxed/simple;
	bh=WHwpTvykIe82obSttARvmwPJ1xX+ZIcfZIJoLwfpIYM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=csfC9aQB8C1qmx5LtqXJHgzRaEg+pwYw6h8ANpLg4rUoUhETfRiaol/mC/ae2OeJmppD+k0bSXq0Ckgc6DGCDGqqV3uE3YUC3T3WczA16b07gxTBsvkOzDougOpw7/qogDoE6uqJL2/lINp0KDxIPIjyg483mpFNBEo/sw7GbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f372.dip0.t-ipconnect.de [79.249.243.114])
	by mail.holtmann.org (Postfix) with ESMTPSA id AA720CECDC;
	Mon,  2 Sep 2024 10:35:41 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 0/4] Fixes for memory leaks and corruptions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
Date: Mon, 2 Sep 2024 10:35:31 +0200
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB7562C0-CF73-48B2-ADB5-47EAA3F020EF@holtmann.org>
References: <ef1f6257-b613-4685-bd4c-e60f35003b8f@gmx.de>
To: Robert Tiemann <rtie@gmx.de>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Robert,

> I've noticed that the settings file gets corrupted when disabling wifi
> tethering. Wrong strings and/or binary junk are written to the file,
> preventing Connman from starting up the next time it is run.
>=20
> I have tracked down the breaking commit (481d08f108) and was able to
> patch the problem. While at it, I found and patched two more memory
> leaks.
>=20
> Robert Tiemann (4):
>  wifi: Fix use-after-free when tethering is disabled.
>  wifi: Fix memory leak.
>  wifi: Fix indentation.
>  technology: Fix memory leak.
>=20
> plugins/wifi.c   | 66 +++++++++++++++++++++++-------------------------
> src/technology.c |  4 ++-
> 2 files changed, 34 insertions(+), 36 deletions(-)

can you respin the series against HEAD since it doesn=E2=80=99t apply =
cleanly.

Regards

Marcel


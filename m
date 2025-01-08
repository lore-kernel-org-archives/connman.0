Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB780604
	for <connman@lists.linux.dev>; Wed,  8 Jan 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356142; cv=none; b=hmt7CO+sVMDDFXQLwIubZ9XBU4ovZEYyz7UMChYl2seKaPyFPp6mdQsGeM++BQhPAnvuk6nejQ5VLYVNjIbAFNu49CLfmMCYMk/sCcdobRKkC/HVxM7cV0PWUYsA94tsH4glEv5gOLI/pTUKpVAo4X0a4j4XDsblkI9bUbPR+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356142; c=relaxed/simple;
	bh=Sh6v1jJMdGQ7nNgAuelChLqAS2D2QFBrIMGwn+397x0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WyGIXWDVtP/TffOCtHDPeDq5PeMdLn8/pQDwjrOhzW+mGxcyMFevLRtosofeyiTN4X5++9avWdfMckkhG2jJf1WCbBqn/89nfiHZO46PTEkrBUHl4I3faf5p3ukZpJI8hjZZ5wIzrcXPYfdtGMzqjZGJkQ8OJqmRwXHKLxBzPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Zf74u4nU; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Zf74u4nU"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id EEAFD164AD4;
	Wed,  8 Jan 2025 12:08:52 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 769AA126099;
	Wed,  8 Jan 2025 12:08:52 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: Query about ipv4 connman url
From: Grant Erickson <gerickson@nuovations.com>
X-Priority: 3
In-Reply-To: <20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5@epcms1p3>
Date: Wed, 8 Jan 2025 09:08:41 -0800
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 =?utf-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E46B341-DE6F-4EA8-8ABE-BB224D40EC83@nuovations.com>
References: <CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p3>
 <20250108082148epcms1p3c2f9e51604f13c4658d34d7419f81ae5@epcms1p3>
To: =?utf-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=ee5kSi6zhfiuj2UPby6ZE+BYR4gykEA2W9NyuQKf49U=; b=Zf74u4nU4ikvOIb/r6XlmJbNdg6wMZqS3ifcEfuSBc7AcU0waM2wo+PQw2B0AM7IHs3UbQ5T6xBPMtRWKRRRmzc4VYkfysCzbJXEiKdHmNQQloiNDhFFO6eUuum+7Oy4hPP5aKsJiv80viqIatZ7an6VqHqtwnPrD+DV323LKHF+X15XAaEXHZn+WBVpfBq5EOgKOLVblnEqnNBeejmBAwPNkOUtEi2u8UuuxYinHlnGpg9+OBAPYbFP9wD5QWrCGxLTzmAalz4eMj3AsxHL4qb3uMpBmHGapwWAxsnylvk97FNwte1rzCK9fLy5aDVVeHy06T27kzR7zuoy7u7CrQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jan 8, 2025, at 12:21=E2=80=AFAM, =EC=9D=B4=EC=9B=90=EC=98=81 =
<wy1115.lee@samsung.com> wrote:
> I am testing connman on Tizen platform with the following URLs =
"http://ipv4.connman.net/online/status.html"
> However, I often get the curl error when calling above URL like below.
>=20
> 01-08 14:17:39.029+0900 curlRequest(1299) > =1B[0;33mcURL RESULT [7] =
with URL [http://ipv4.connman.net/online/status.html]
>=20
> 01-08 14:20:07.949+0900 curlRequest(1299) > =1B[0;33mcURL RESULT [7] =
with URL [http://ipv4.connman.net/online/status.html]
>=20
> 01-08 14:20:34.189+0900 curlRequest(1299) > =1B[0;33mcURL RESULT [7] =
with URL [http://ipv4.connman.net/online/status.html]
>=20
> 01-08 14:20:59.639+0900 curlRequest(1299) > =1B[0;33mcURL RESULT [7] =
with URL [http://ipv4.connman.net/online/status.html]

=46rom the 'curl' man page, shell status code =E2=80=987' seems to be:

       7      Failed to connect to host.

and would indicate that the v4.connman.net host may be unreachable. Can =
you confirm that is the case when you see status code '7'?

Historically, Marcel has need to provision more capacity or make other =
tweaks to the servers to accomodate shifts in load or usage. That may or =
may not be the issue here.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


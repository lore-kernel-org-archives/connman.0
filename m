Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7691E04B5
	for <connman@lists.linux.dev>; Mon, 13 Jan 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807579; cv=none; b=lO7DbcvwzgyPmt7qeIZBFOWRue8YNjvDAWKmhqhtx60wQ5m1sMHgmBF/LZswlB4V2dDUQFjgB9XkeRsmkSCHyoEW4HU2JdXr8YsyJWiTho+B5qVmzPQNN6ty6DA67egeMc5v8MQD0Jd17hpYNtrfZTKhqOiey7cDejcsYjQ6OJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807579; c=relaxed/simple;
	bh=I5ltU8YgRYaUWMxU98sVcOlFz5ZJs0146836bW1ep78=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pIK4v2sDol1zsEdQD42tN7aLLJ5tTXoUddpbP5JUQGAG0aNFWGUrcwYfeyKNfShVIWcffIPGUHG0j+Vk2IuqM940sLvGslIhUCiiAxzI3Waee7mEvfhXzBE0hAozgI9xFXOQcc/2Us9sNSD3MrauyDmuTFPApC2q/Hnki9avAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=gbw10c6o; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="gbw10c6o"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 716AB1648A1;
	Mon, 13 Jan 2025 17:32:55 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EE529124EE0;
	Mon, 13 Jan 2025 17:32:54 -0500 (EST)
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
In-Reply-To: <20250113022533epcms1p528f3b6b01aadaf75e214c2769dca6c95@epcms1p5>
Date: Mon, 13 Jan 2025 14:32:44 -0800
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 =?utf-8?B?6rmA7ZiE7KSR?= <hj0430.kim@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A14F323-D214-48D5-AA9E-952E739AB1EB@nuovations.com>
References: <CGME20250106015409epcms1p57aaac1d7705a9ebac4a0f93a6b0d3b10@epcms1p5>
 <20250113022533epcms1p528f3b6b01aadaf75e214c2769dca6c95@epcms1p5>
To: =?utf-8?B?7J207JuQ7JiB?= <wy1115.lee@samsung.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=Sq8orzPbxgPbWDwg7RQdnVblIEyf6570lai92F9WNYY=; b=gbw10c6o6LF6ouqN+MWqFQrvKMI8D8SlGFTdYSQrye74FYzs1BKKzKK5bwYwICMf+CXwhchoRKYa11LOkfEX2bhOfrC6rFm+cv18TWYnXtGWj4wTIdDbiGESp/cPF1lJbHwVYI/mWJkLkuTUUGCbSXn/jDYf25kobm7xKJG7WlZfnxaqoPHz1eBjD2aYfyf8ou78wBXg2QeSwHjXhAGg0gKdypxfVL7k48IkHr1LfYDDlMg/rfLrhQHZAKz41Nq5c1/ZL5Xm9kmVPuGgM92DvmZfeeUxVfm4pCuSn7U+R0qhkeE1nM3eL79SevosGceNkNv7fpggqZDH/9fUJcVqmw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Wonyoung Lee:

Regrettably, I have no further visibility into the =
=E2=80=98ipv{4,6}.connman.net=E2=80=99 servers. To the best of my =
knowledge, these are completely and exclusively administered by Marcel =
(on CC).

For what it is worth, I have been noticing similar availability issues =
with =E2=80=98ipv{4,6}.connman.net=E2=80=99 on my end.

Best regards,

Grant

> On Jan 12, 2025, at 6:25=E2=80=AFPM, =EC=9D=B4=EC=9B=90=EC=98=81 =
<wy1115.lee@samsung.com> wrote:
>=20
> Dear Grant Erickson,
>=20
> Kindly remind for this topic.
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dear Grant Erickson,
>=20
> As you said, cURL RESULT [7] in the debug log is status code 7 of =
curl.
> This issue had not happened before 7th Jan(KST) with the same version =
of my software and the same network env.
> And it is experienced not only by me but also by others.
> So I am wondering the reason why it surddenly starts to response =
status code 7
> Is it possible to check the reason on the server side?
>=20
> BR
> Wonyoung Lee
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> On Jan 8, 2025, at 12:21=E2=80=AFAM, =EC=9D=B4=EC=9B=90=EC=98=81 =
<wy1115.lee@samsung.com> wrote:
>> I am testing connman on Tizenplatform with the following URLs =
"https://protect2.fireeye.com/v1/url?k=3D4ccfcac0-2d44dff9-4cce418f-000bab=
ffae10-994c06701b573d69&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&u=3D=
http%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html"
>> However, I often get the curl errorwhen calling above URL like below.
>>=20
>> 01-08 14:17:39.029+0900curlRequest(1299) > [0;33mcURL RESULT [7] with =
URL[https://protect2.fireeye.com/v1/url?k=3D7ffd22e2-1e7637db-7ffca9ad-000=
babffae10-eee25d3176242b54&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&=
u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html]
>>=20
>> 01-08 14:20:07.949+0900curlRequest(1299) > [0;33mcURL RESULT [7] with =
URL[https://protect2.fireeye.com/v1/url?k=3D48f1bda2-297aa89b-48f036ed-000=
babffae10-3fee45b801578822&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&=
u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html]
>>=20
>> 01-08 14:20:34.189+0900curlRequest(1299) > [0;33mcURL RESULT [7] with =
URL[https://protect2.fireeye.com/v1/url?k=3D5bde5bcd-3a554ef4-5bdfd082-000=
babffae10-5851179a5d5da000&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&=
u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html]
>>=20
>> 01-08 14:20:59.639+0900curlRequest(1299) > [0;33mcURL RESULT [7] with =
URL[https://protect2.fireeye.com/v1/url?k=3D586e64ab-39e57192-586fefe4-000=
babffae10-47741276e19feaa4&q=3D1&e=3Dbee29355-a62c-420a-8105-9855865ea6d0&=
u=3Dhttp%3A%2F%2Fipv4.connman.net%2Fonline%2Fstatus.html]
>=20
> =46rom the 'curl' man page, shell statuscode =E2=80=987' seems to be:
>=20
>         7      Failed to connect to host.
>=20
> and would indicate that thev4.connman.net host may be unreachable. Can =
you confirm that is the case whenyou see status code '7'?
>=20
> Historically, Marcel has need toprovision more capacity or make other =
tweaks to the servers to accomodateshifts in load or usage. That may or =
may not be the issue here.
>=20
> Best,
>=20
> Grant
>=20
> --
> Principal
> Nuovations
> =20
> --------- Original Message ---------
> Sender : =EC=9D=B4=EC=9B=90=EC=98=81 =
<wy1115.lee@samsung.com>SmartThings=EA=B0=9C=EB=B0=9C=EA=B7=B8=EB=A3=B9(DP=
C)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
> Date : 2025-01-08 17:21 (GMT+9)
> Title : Query about ipv4 connman url
> =20
> Dear Connman maintainer,
>=20
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
>=20
> In 5th trial, its response was normal
> 01-08 14:21:19.969+0900 curlRequest(1299) > =1B[0;33mcURL RESULT [0] =
with URL [http://ipv4.connman.net/online/status.html]
>=20
>=20
> May I know the reason and how to avoid CURL error 7?
>=20
> BR
> Wonyoung Lee

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


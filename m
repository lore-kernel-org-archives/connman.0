Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2341EF0B4
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154550; cv=none; b=hUkMyA/cK3wXZVzN6HcsbBsLpxhD16BoaSuGQ7DLPJY1N503J/YGYOQ21+Kfbq9wQeTKVD7GgoOYMBXRA+MNJdQMuXRq08jLxsIq7GXrzlSeqyuN3kXu3CJ2qC4T8EuqobSNepUaKCzxHmGB/AWEePo7twMxq287t5Y3dXIo3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154550; c=relaxed/simple;
	bh=AQI1AMpDk5p49fF2qfUOrXRywiVeOPFEEYp4nPhhCMU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=csxkdkjHPuAPjG1zL0BEfZKpyJoNr1LLdXewYKqPCVbegf1QW2GZQLw+jZE2n9sqonDS+Ve8RDwlgkLnCgVB6S4+NG0x+FD9IkxJQP4FB2ds48cYXXfu75FEhKKkzRyOWJMaF/jt6qR/muxGCIKchotX9aKvcLCAX6bwphh+FqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=CmncCKc1; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="CmncCKc1"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0BACA1649B8;
	Fri, 21 Feb 2025 11:15:48 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 88F1B124FD3;
	Fri, 21 Feb 2025 11:15:47 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] gateway: fix calculation of is_vpn6
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <37feab56-a21b-4c51-b826-6f3690b9ea81@gmail.com>
Date: Fri, 21 Feb 2025 08:15:36 -0800
Cc: Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>,
 Christian Hewitt <christianshewitt@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <866CEADA-8CBE-46E0-A5EE-7D6EFCCD58FA@nuovations.com>
References: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <37feab56-a21b-4c51-b826-6f3690b9ea81@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=P+LnOs042fkHH58YoiPi7CXKMriASpyWymTp+bGgKcE=; b=CmncCKc1mkNBPdR0S3RwCgzhCL7fC+pSmsk/cXlsDvyHqicfbi9PL+jYNAd/8nvEpBOg+8gOaDZ3xzC2nm2yTLry5NNyi965DLSOCvnzuCOSf/+dYu21q3M6hqsAKEVlTXBkRuAvj8hb4pUr4TO6oWHouULkXMemmwx5DCFUcCnijZFUWSenC+wYkUkVLhxLqaM2YfAaTOxmeWNVPytsfRe4pwKOAjuKLCgz+rZGgBWRxIIaSbhu/DoVOPpaw2GxOkE2D7b51V0G+ezWsp9G9R7//mLNjVCKYlfZXou0DjDRXHvcHgOI9M7OYNXTfD/islQ0nCxUqrXMUm7kislSIQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 14, 2025, at 8:02=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 1/23/25 5:38 AM, Gabriel Sanches wrote:
>> Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
>> the WireGuard plugin from faulting on startup.
>> Fixes: commit 823d5a2a8cc4 ("connection: Refactor =
=E2=80=98__connman_connection_gateway_add=E2=80=99=E2=80=9D)=E2=80=9D
>> Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  src/gateway.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> This patch does not apply cleanly to upstream.  Anyone care to =
re-send?

Denis,

On it; stand by.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


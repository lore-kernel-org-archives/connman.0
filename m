Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6B24CED2
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158046; cv=none; b=hW5lqnR9Vc40K4c7Qht0zijjj7bKnBNiFcvt/pQBDBHsFepoXuBrUhzAhfhH3MANLISCZ+ijChA1AU6h3iJuS0qWG4Ew5Ffd+NUdI2KxMNqOTXnSl6G61AsqfiXLTiyD972NNaXK1iSmUC8XvsVZHeU83WgPI/cq5SxP392Tnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158046; c=relaxed/simple;
	bh=Eyy/MSKzGOuytfYwSLKwQpfijLNR4UcoSZeZxAcG2pQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gS2L1M4D3ITFCxDDmxHPF2IMRUfTx/jXLT4lsT0DCikE30c1T/b6bkneoscW+AxCjvJlpC1L7EdK61BNyifkk4tZvU1VZy5A71IPXJyRkBTlpXD1qEJkABGF5a2y42e5P+nkzNxqHd5mooiLruTQOnTYIjLPiHAuu3K8X4hYQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=k6k/R+KI; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="k6k/R+KI"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 557B7164A44;
	Fri, 21 Feb 2025 12:14:03 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CFCBD124EDF;
	Fri, 21 Feb 2025 12:14:02 -0500 (EST)
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
In-Reply-To: <866CEADA-8CBE-46E0-A5EE-7D6EFCCD58FA@nuovations.com>
Date: Fri, 21 Feb 2025 09:13:51 -0800
Cc: Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>,
 Christian Hewitt <christianshewitt@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35084853-3A43-4EA6-B615-A6FE3A49FDB6@nuovations.com>
References: <DB6PR10MB1845EBB07DB785B580B3F6ECE1E02@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <37feab56-a21b-4c51-b826-6f3690b9ea81@gmail.com>
 <866CEADA-8CBE-46E0-A5EE-7D6EFCCD58FA@nuovations.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=AnYXlDTFiUu43mCAOjZUTsFj/irNKy3xhIvdRTmaq0k=; b=k6k/R+KIqDSmHE+EBUwPso95Rp08rlkOLxfn/qG1uemjyKnshAaQ4ACjwJGu+ePHz4qQbw9u3Y7e/FowpBX3F8LWlW807+T+YPxUGups3/auc4sqw6Rt3p3OlzX9YZnUUNuslGdPI+Tbvxu3oxb0u6erUwtwBqzVAgOKObJ2k53Pri/3y8EsvIEosHlXW7+B/hQwu6gemzr+r/fkAQQJXO/zNsJSBvDNwLW6v8orhigI/vFBknnSSJd+nkroPVC/rb/gxTcOny30OX5I1J0EuxqYhJBKiR2bIyNxKmpSVWS7jmYdIRPxXr1TNpN20Sl3JmWPMWVB8hZ3h3lgtOCmSw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 21, 2025, at 8:15=E2=80=AFAM, Grant Erickson =
<gerickson@nuovations.com> wrote:
> On Feb 14, 2025, at 8:02=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
>> On 1/23/25 5:38 AM, Gabriel Sanches wrote:
>>> Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
>>> the WireGuard plugin from faulting on startup.
>>> Fixes: commit 823d5a2a8cc4 ("connection: Refactor =
=E2=80=98__connman_connection_gateway_add=E2=80=99=E2=80=9D)=E2=80=9D
>>> Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> src/gateway.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> This patch does not apply cleanly to upstream.  Anyone care to =
re-send?
>=20
> Denis,
>=20
> On it; stand by.

Resubmitted:

    =
https://lore.kernel.org/connman/5e1a105eda4ae36e7a9132140949c569cd02fe02.1=
740157858.git.gerickson@nuovations.com/T/#u
   =20
Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


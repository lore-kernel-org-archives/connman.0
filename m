Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AD2E3385
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115819; cv=none; b=Dea47t6iglEOYzPotr6/pRI68d+OuJOOsuSGi+obsRSAlAAZk0ep+dA8jyagRj5XsRrgHOfIn3k0MfC5htkWLowmBUIcPkFmBICTgLp4aZq/ubF624EBpg0UvpFkpTnSnjVqVMx8pRTIPzxTKm3FcRsbR/Ex1q5ZqLPf/6os8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115819; c=relaxed/simple;
	bh=C3N3f7J84Qngq1jeOkuZn0Ib2Vuu4BdCFo9YDh1SVrk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UA5DDJTSdSw9D8e/r44olGU69sX6WeuNqa2JBd8MK86AhkgEe4nBYP3ponzPTeU4Jv+cKgRIF1l68001rlhC9mmoKSy4KtjBkrPg73cpcqhzqxZWz3UZJK/CoDy+PPOlueN8ioLlEUzIPaNOEm8cE33JcVw1q5GLE3qcLaUuc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=BouIYfmw; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="BouIYfmw"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 26C9E164AEB;
	Tue,  4 Mar 2025 14:16:55 -0500 (EST)
Received: from smtpclient.apple (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A3E3E125164;
	Tue,  4 Mar 2025 14:16:54 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 08/15] service: Leverage 'service_set_proxy_method'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <f835fe52-3ae5-45ea-afca-f39c02cca08a@gmail.com>
Date: Tue, 4 Mar 2025 11:16:43 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8F3B30C-6937-402D-9629-F4F306FC3EE5@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-9-gerickson@nuovations.com>
 <f835fe52-3ae5-45ea-afca-f39c02cca08a@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=ER+WFlWFTv5EUt2Lq0CbAa6aTwJj8Mz/++xJQgCQr8M=; b=BouIYfmwo/IovmPs0s4CcQfKseUwk8oWb1gZX3+XA3ScpJJr+stIMYFDsnttbWZ0UAc40Q+b2OpM/iCDvM44hwkHvAEcdEj75i/BKxcGigpB9mVzwfCEqF+cQJRJJSrkcl80nVT6Y9mELz9gj7M0QCnppVas4Fq7Ns8bqRXRiKr5AcaVj+YnEJ/92E2ms1+NV+NOa4EXjxc6izECDfdyCZVbH8L+pPtyECLghLx20cIauc+ZIdrMaQZOSHNP31H2gIixhgnKot+z+d1JxvCPhKoAI+i0l2IAuVFP1ngO4jH+AXXzTrjVZtjubt4sDIG4kRKHhSE8wisadL1Osk3++Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 4, 2025, at 9:09=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/21/25 9:56 AM, Grant Erickson wrote:
>> Leverage 'service_set_proxy_method' for
>> 'connman_service_set_proxy_method', the first of two call sites.
>=20
> Could this commit description be clearer?  E.g. mention =
connman_service_set_proxy_method() instead of 'first of two call sites'?

Will revise.

>> ---
>>  src/service.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>> diff --git a/src/service.c b/src/service.c
>> index e58958635992..5c94c2962de8 100644
>> --- a/src/service.c
>> +++ b/src/service.c
>> @@ -5617,19 +5617,14 @@ static void service_set_proxy_method(struct =
connman_service *service,
>>  void connman_service_set_proxy_method(struct connman_service =
*service,
>>   enum connman_service_proxy_method method)
>>  {
>> - DBG("service %p (%s) method %d (%s)",
>> - service, connman_service_get_identifier(service),
>> - method, proxymethod2string(method));
>> -
>> - if (!service || service->hidden)
>> - return;
>> -
>> - service->proxy =3D method;
>> + const bool donotifier =3D method !=3D =
CONNMAN_SERVICE_PROXY_METHOD_AUTO;
>> + void * const context =3D NULL;
>=20
> What's the point to this variable?

As always, I have a preference / habit of making code self-documenting =
wherever possible. So, rather than seeing =E2=80=9Ctrue, NULL=E2=80=9D =
in the parameter list and then having to run through the code to figure =
out what those are / mean, it=E2=80=99s self-documented.

>>  - proxy_changed(service);
>> -
>> - if (method !=3D CONNMAN_SERVICE_PROXY_METHOD_AUTO)
>> - __connman_notifier_proxy_changed(service);
>> + service_set_proxy_method(service,
>> + method,
>> + donotifier,
>> + NULL,
>> + context);
>=20
> Just use NULL here which is clearer?

Will do.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


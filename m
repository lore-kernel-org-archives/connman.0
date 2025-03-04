Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1281255244
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116290; cv=none; b=Q/mSlKJwchHq4MkwCYeSThW2cEev51PfuhxBE8z5Xi9SzzH6PwRo/sNKj0wEDqNL2JIIMmeju8ymXLnR/kNXApl860Dhy8tHEN1CabeOln0QhlBjPcrZSE+X+HId5bZGSJiK7BoTpiqb+VgBqEbNidBv8ZMOrJBnAG1E3azoKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116290; c=relaxed/simple;
	bh=vOdmb/TCnLcqKM1VEL+uB9UGLw4GHPdhN2wcZUdb/vw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ai0gLaCEKF/6xdQLRqVUj1Y4fvsVMeCc/LU0ng6GROrMMU+YtYBxmEirgsDpID10i2dS/T2QQu35GuggkTwalZyjtY6Y23/P+k6jt05Eenv96UPwGJJgKKL1i3/suO1E8wKk0EA9FF0G+//ou15OUkYGn6+/HYOzMdHoWu8HcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=h/e/53Jv; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="h/e/53Jv"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 17F99164B5C;
	Tue,  4 Mar 2025 14:24:47 -0500 (EST)
Received: from smtpclient.apple (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BD7C1124FE6;
	Tue,  4 Mar 2025 14:24:46 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 03/15] service: Leverage 'service_set_pac' function.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <f11d323b-a1f6-41c2-af92-bc08ee08ec49@gmail.com>
Date: Tue, 4 Mar 2025 11:24:35 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <683EB080-8A98-4446-875C-1EE92845AA30@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-4-gerickson@nuovations.com>
 <f11d323b-a1f6-41c2-af92-bc08ee08ec49@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=8KHfp+LLxSlgsnx/Ug9OJ7CNdkQsj86I2hjfCORaZN0=; b=h/e/53Jve7VA3nmY2seEZGURM03QcMJWpRHUMy5IosBjXTxq3WTLdHkz8RScmUDTl9fikEGs4a3y0bEde4IBBt0PmZG9jQJr0ls/d78tKDBrFvNyITLH7O2SK+AQBrqcgA6Xcr23/MPhF2zO2t9yWZh+G3OoMyk4hIuPo2R47JZE9cJCi77PpMY2W0mMpTM5JZ2NRGplJVU1rQcrY2cIy/NqZeeyUxx8PWuYOojlY7AfM7clfC2tFJg3YaWAcVrRNBgp4Sa668acfJeIzL/Eg9gIbAdgOIUnAyX2GRdiVtfd48oHEbuY41tF1z44JyTQ1ObSGMZXeMG1Z2DILNFIIQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 4, 2025, at 9:06=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/21/25 9:56 AM, Grant Erickson wrote:
>> Leverage 'service_set_pac' at the three call sites the proxy
>> auto-configuration (PAC) URL is currently set or cleared for a =
network
>> service.
>> Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
>> is the source of connectivity problems, particularly for online
>> reachability checks. Consequently, being able to log all such
>> mutations can be helpful in triaging such problems.
>> ---
>>  src/service.c | 17 ++++-------------
>>  1 file changed, 4 insertions(+), 13 deletions(-)
>> diff --git a/src/service.c b/src/service.c
>> index c48959a7940f..da851d681bc7 100644
>> --- a/src/service.c
>> +++ b/src/service.c
>> @@ -770,8 +770,7 @@ static int service_load(struct connman_service =
*service)
>>   str =3D g_key_file_get_string(keyfile,
>>   service->identifier, "Proxy.URL", NULL);
>>   if (str) {
>> - g_free(service->pac);
>> - service->pac =3D str;
>> + service_set_pac(service, str, false);
>=20
> Does this leak str?

I do not believe so, no. service_set_pac now handles the same:

    g_free(service->pac);

    if (pac && strlen(pac) > 0)
        service->pac =3D g_strstrip(g_strdup(pac));
    else
        service->pac =3D NULL;

except now instead of being individually duplicated and scattered around =
to several call sites, it is all handled in one with service_set_pac.

> Also, Kernel Coding Style prefers that braces are not used for single =
statement blocks.  Quoting:
> "Do not unnecessarily use braces where a single statement will do.
>=20
> if (condition)
>        action();
> "
>=20
> See https://www.kernel.org/doc/html/latest/process/coding-style.html

I will address this.

Thanks,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


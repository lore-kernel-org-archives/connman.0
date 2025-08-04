Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0031DF258
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333295; cv=none; b=Cbeg4uIQysHEEGl7vJb6F5Jm349SoEzZ/WgKbNjGuXyGumXIJxK5N7SSimAGZI4PaKkIY2qEekeGBKMzVpavuOzuUUjuuvhcOcyyQgbu3AE9ZowPDH/iZuzEC/C2QxqTzGUK4XyAYiAgPNNjvQexUTLRk01Rv4zzCtpUgg7qLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333295; c=relaxed/simple;
	bh=P8GLEzhCm/ci2q1wMsRZQSLabqQ/hiCSRRsMgxNBuTo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hKLuMVC//QiL+F3jNSOtOozWTIelen5vWVRpg1i565s2kBny7mpf2vStY3B6bORszDUIl+S5H7Vo1ere35+cASdYEXdADDzS5p4o/9++6QhzgmrENy8Irr+wc/R2ZZhzejSG/aL9xuekKb3A0s4TvYTicTBLi0kDRnlmZNlMPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ehKBGp//; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ehKBGp//"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 14D1D164A6C;
	Mon,  4 Aug 2025 14:48:04 -0400 (EDT)
Received: from smtpclient.apple (c-73-189-96-183.hsd1.ca.comcast.net [73.189.96.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C0EFB124B1A;
	Mon,  4 Aug 2025 14:48:03 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/3] technology: Leverage 'DefaultEnabledTechnologies'
 setting.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <34d2345c-58a0-4e1c-9943-549863b7b060@gmail.com>
Date: Mon, 4 Aug 2025 11:47:52 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <509FC512-C600-4AD7-9640-B8C1FE7AEB0B@nuovations.com>
References: <20250728223217.3991877-1-gerickson@nuovations.com>
 <20250728223217.3991877-3-gerickson@nuovations.com>
 <34d2345c-58a0-4e1c-9943-549863b7b060@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=f5YgQHyiPfm9ECNfA+PaNs2h/tuiSz8OvczDWyiDh4s=; b=ehKBGp//Rkr2C8gHm7YV3xX43yiT+vHIbkOg80b0clHXj0t6GbfR44OtIz8fctJWZ7WIpZPnZMC7a8THIo2OKgwGOodXRTat8U09QtKxoHfecMausOZ3DPgYffGKVKjw1F0/4044OWwe3FCRfc+/nReuGzCTrBhnDc0+7gGOWpN58hjzZpuHepIu3H4DQDi4pqTJ8kUbDh8e+GCOjzg0NfCNYIdjynKXPMgiPRw7EqjOaA9Twc8oSY061HMQkBxRSvvcgKKvHI5uXFPLlgQGO6sLmtYTLC9k7JM/NYTrjU/zbYu9PsK/t8aAyNnIMRmpcOWosSp0/ugn6rJ/CkuyUg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Aug 4, 2025, at 11:27=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 7/28/25 5:32 PM, Grant Erickson wrote:
>> This leverages the new 'DefaultEnabledTechnologies' configuration
>> setting.
>> ---
>>  src/technology.c | 25 +++++++++++++++----------
>>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> <snip>
>=20
>> @@ -429,19 +429,27 @@ static void technology_load(struct =
connman_technology *technology)
>>   GKeyFile *keyfile;
>>   gchar *identifier;
>>   GError *error =3D NULL;
>> - bool enable, need_saving =3D false;
>> + bool enable, need_saving =3D false, enable_persistent =3D false;
>>   char *enc;
>> + int i;
>> + unsigned int *enabled_types;
>>     DBG("technology %p", technology);
>>  + /* Determine which technology types are enabled by default */
>> +
>> + enabled_types =3D =
connman_setting_get_uint_list("DefaultEnabledTechnologies");
>=20
> I amended this patch slightly to avoid > 80 character line.  I moved =
this initializer to the variable declaration block.

Thank you.

> Perhaps instead of duplicating these strings everywhere, the CONF_* =
defines should move somewhere as public API?

Fully agreed. Do you have any preferences on where?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


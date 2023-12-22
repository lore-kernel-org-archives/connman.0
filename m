Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C5BA30
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 19A7473106;
	Fri, 22 Dec 2023 13:31:17 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138] (unknown [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CE5EE7312C;
	Fri, 22 Dec 2023 13:31:16 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/2] service: Make log output of
 'online_check_is_enabled_check' consistent.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <22f2e328-ee23-4086-bc78-d2ce6c52303c@gmail.com>
Date: Fri, 22 Dec 2023 10:31:15 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <66532F49-1D68-4333-8F50-9EDE845E7AA4@nuovations.com>
References: <20231221073307.2361429-1-gerickson@nuovations.com>
 <20231221073307.2361429-2-gerickson@nuovations.com>
 <22f2e328-ee23-4086-bc78-d2ce6c52303c@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 22, 2023, at 10:23 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>> @@ -2195,9 +2195,17 @@ static void cancel_online_check(struct =
connman_service *service,
>>  static bool online_check_is_enabled_check(
>>  		const struct connman_service *service)
>>  {
>> +	g_autofree char *interface =3D NULL;
>> +
>>  	if (!__connman_service_is_online_check_enabled()) {
>> -		connman_info("Online check disabled. "
>> -			"Default service remains in READY state.");
>> +		interface =3D connman_service_get_interface(service);
>> +
>> +		connman_info("Online check disabled; "
>> +			"interface %s [ %s ] remains in %s state.",
>> +			interface,
>> +			__connman_service_type2string(service->type),
>> +			state2string(CONNMAN_SERVICE_STATE_READY));
>> +
>=20
> Does it make sense to add a specific method for such informational =
prints that will enforce the desired formatting pattern instead of =
relying on human intervention?

Denis,

It=E2=80=99s a great point and one I=E2=80=99d considered. The scope of =
my changes seemed to small / narrow at that / this juncture. As we =
review logging across modules and the project at large and there=E2=80=99s=
 an emergent pattern, I=E2=80=99m all for such a function / method.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


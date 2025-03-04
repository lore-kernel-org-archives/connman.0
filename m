Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8E20468F
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115380; cv=none; b=hYmquQNKxPGo7IYRGA/g7DCOdtQF2fE00adbidcZtjBG/BOv+d5L2RUQE1CETHMjj8ZdU5oAzGzlEIvWhz+mdomQDnQVMbeMDsyuw/BFq5e4HmXusEDZP//Pk4ub8LRVHQQIMffPybK6wr2v2SuSLwZ6T9XuNwbkohpJjfeWYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115380; c=relaxed/simple;
	bh=ko+PG23oLSj3JBWEGehLJO6tqc9IIs7Ya3MkLwI0HM8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=REi95GtvKB/W9Tz+CLduEVErO/oULBSkd56VVkDYv/6rVHVkZ2XjN4miwzWa/tty/tQdXZuiY8vrjKvpnoCdLzvjxT7eQfC0OE8JWgaGoO3sDy9GoOJGjjH3TdAlLCS+F+kjNN1SUtMiUEVb6QBKAhhs+ueIiaOHe1fI6KCt2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fio6J+yX; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fio6J+yX"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 46980164B57;
	Tue,  4 Mar 2025 14:09:36 -0500 (EST)
Received: from smtpclient.apple (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E5C971262C4;
	Tue,  4 Mar 2025 14:09:35 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 09/15] service: Leverage 'service_set_proxy_method'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <86712602-45e0-420e-80ce-cfb904702448@gmail.com>
Date: Tue, 4 Mar 2025 11:09:24 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBD48A24-2454-4BE8-ABF4-DAD680E75AAB@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
 <20250221155653.760046-10-gerickson@nuovations.com>
 <86712602-45e0-420e-80ce-cfb904702448@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=lwCCug9n2qSDnvcyjTBxdhTg6VFcHWBSyM7DFrHt+GM=; b=fio6J+yXJew4vLT4VSZL3IogiRZ31/8gE/svXxC8f11JfwZMsDMhkuijOXAQlcgnAAWjd9H+VQfBtSvYDVFhCNbU9x0QwMD8ewvegxlVVwdKGbdA7tR7anw7RDa+TXPzF440bi3ZSOKi1mK4Sl6Zyiu1Qk4NGmnkTqBU42o/weU6TCtGFHAkjx2zOYAnA7HVFve4b5dcOv0F+EWjhtMmSSKMypVXmsBAORQCoO3UOtOb8k82PQ6zlPoXddztGfLxmiVmdKrcZF140vlhSqKvjtE9UjnbB3SYd2yMb7vbHFCzeIztnhEUwd+Zeu1clQ4ERhZXXq+jo1R4TEYnHe3o7g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 4, 2025, at 9:12=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/21/25 9:56 AM, Grant Erickson wrote:
>> +void __connman_service_set_proxy_autoconfig(struct connman_service =
*service,
>> + const char *url)
>> +{
>> + const bool dochanged =3D true;
>> + const bool donotifier =3D true;
>> + const void *context =3D url;
>=20
> Why are these needed?

As always, I have a preference / habit of making code self-documenting =
wherever possible. So, rather than seeing =E2=80=9Ctrue, true=E2=80=9D =
in the parameter list and then having to run through the code to figure =
out what those are / mean, it=E2=80=99s self-documented.

The =E2=80=98url=E2=80=99 one was not strictly necessary but it was =
=E2=80=9Cparallel construction=E2=80=9D with the other two.

>>  - __connman_notifier_proxy_changed(service);
>> + DBG("service %p (%s) url %p (%s)",
>> + service,
>> + connman_service_get_identifier(service),
>> + url,
>> + url ? url : "<null>");
>> +
>> + service_set_pac(service, url, !dochanged);
>> +
>> + service_set_proxy_method(service,
>> + CONNMAN_SERVICE_PROXY_METHOD_AUTO,
>> + donotifier,
>> + service_set_proxy_method_auto_handler,
>> + context);
>=20
> Conversion from any pointer type to void * is automatic in C; using =
'url' would be just fine here?

Confirmed; see above.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/


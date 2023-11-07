Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC42D02E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E3C8F7332C;
	Tue,  7 Nov 2023 13:54:17 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 99C997333E;
	Tue,  7 Nov 2023 13:54:17 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Close three '__connman_wisp_start' failure closure holes.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <F2368B90-D59D-4457-9A42-F0543B3AD1E0@nuovations.com>
Date: Tue, 7 Nov 2023 10:54:17 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F65CF19F-A1C9-4828-B679-245F9FDA6F0C@nuovations.com>
References: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
 <2FC02AFD-5B9B-4052-B056-2C487B8041ED@holtmann.org>
 <F2368B90-D59D-4457-9A42-F0543B3AD1E0@nuovations.com>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This has been re-submitted as a v2 patch against master.

Best,

Grant

On Nov 7, 2023, at 7:43 AM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Nov 7, 2023, at 7:18 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>> There are currently three failure holes in which a request to
>>> '__connman_wispr_start' is not properly closed.
>>>=20
>>> 1. If 'g_web_request_get' fails to generate a successful gweb =
request
>>>    and returns a request identifier of zero (0) in
>>>    'wispr_portal_request_portal'.
>>>=20
>>> 2. If the service proxy is set to =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN.
>>>    This can happen in 'proxy_callback' if WISPr is started and the
>>>    service proxy method is set latently or is never set at all.
>>>=20
>>> 3. If 'wispr_portal_detect' returns non-zero error status in
>>>    '__connman_wispr_start'.
>>>=20
>>> ---
>>> src/wispr.c | 19 +++++++++++++++++--
>>> 1 file changed, 17 insertions(+), 2 deletions(-)
>>=20
>> this doesn=E2=80=99t apply cleanly.
>>=20
>>  CC       src/connmand-wispr.o
>> src/wispr.c: In function =E2=80=98wispr_portal_request_portal=E2=80=99:=

>> src/wispr.c:551:27: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
>>  551 |                 wp_context->cb(wp_context->service, =
wp_context->type, false);
>>      |                           ^~
>> src/wispr.c: In function =E2=80=98proxy_callback=E2=80=99:
>> src/wispr.c:885:27: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
>>  885 |                 wp_context->cb(wp_context->service, =
wp_context->type, false);
>>      |                           ^~
>> src/wispr.c: In function =E2=80=98__connman_wispr_start=E2=80=99:
>> src/wispr.c:1077:19: error: =E2=80=98struct =
connman_wispr_portal_context=E2=80=99 has no member named =E2=80=98cb=E2=80=
=99
>> 1077 |         wp_context->cb(wp_context->service, wp_context->type, =
false);
>>      |                   ^~


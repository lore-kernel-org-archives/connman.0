Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6630643
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 01E3C731F4;
	Tue,  7 Nov 2023 17:58:02 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9479773202;
	Tue,  7 Nov 2023 17:58:01 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/3] gweb: Refactor 'parse_request_and_proxy_urls'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <a936fc23-1af2-467b-aeb4-317314370a12@gmail.com>
Date: Tue, 7 Nov 2023 14:58:00 -0800
Cc: connman@lists.linux.dev,
 Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <235418B6-F510-4D71-8118-F9FFE915CACD@nuovations.com>
References: <88316395-8306-467E-A9D0-FD0B0F9F8387@nuovations.com>
 <E7544151-8840-4E97-A5BF-49569088E6D9@nuovations.com>
 <321bbd59-0a7b-4624-8e7f-71f94356d14e@gmail.com>
 <FD6AA3D4-E59E-47A4-BEA1-578BC55F30D7@nuovations.com>
 <a936fc23-1af2-467b-aeb4-317314370a12@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Denis,

Thank you for the feedback on this series, it has been submitted as v2 =
patches:

    * [PATCH 1/3 v2] gweb: Rename 'parse_url'.
    * [PATCH 2/3 v2] gweb: Refactor 'parse_request_and_proxy_urls'.
    * [PATCH 3/3 v2] gweb: Add documentation to URL parsing functions.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

On Nov 7, 2023, at 8:57 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> +			if (scheme) {
>>>> +				*scheme =3D g_strndup(*cursor, =
scheme_length);
>>>=20
>>> g_strndup does not fail.
>> It=E2=80=99s based on malloc and if I run rlimits (such as with =
monit) or other infrastructure, malloc will fail and consequently, =
g_strndup will fail, correct?
>=20
> No.  All glib functions that do not use g_try_ will not fail at =
runtime. Instead they will abort:
>=20
> https://github.com/GNOME/glib/blob/main/glib/gmem.c#L87
>=20
> In the case of g_strndup/g_strdup, it uses g_new.
>=20
>> I struggled with this one. There seems to be countervailing style on =
this front. In some places, malloc-backed allocators are checking for =
null and returning -ENOMEM, in other places they are checking and are =
returning -EINVAL (including the prior implementation of parse_url), and =
in other places, there are no checks.
>> Is there a preferred, go-forward style?
>=20
> So the guidance in other projects (oFono, iwd, ell, and maybe BlueZ) =
is to avoid using g_try_* for allocations less than 1 page.  Small =
allocations simply do not fail on Linux.
>=20
> For any functions that use g_new/g_malloc/etc, checking for =
out-of-memory conditions is simply wrong and shouldn't be done.
>=20
>>>> +	// Since it's the easiest to detect, first rule out an IPv6
>>>> +	// address. The only reliably way to do so is to search for the
>>>> +	// delimiting '[' and ']'. Searching for ':' may yield one of =
the
>>>> +	// other forms above (for example, (2), (5), or (7).
>>>=20
>>> This is not the preferred comment style for a multi-line comment.
>> Will update these. Should checkpatch.pl be updated to cover this =
since it did not flag it?
>=20
> I'm surprised checkpatch does flag these.  Maybe there's some command =
line option missing?
>=20
>>> Why not make a temporary to hold scheme using g_autofree and only =
assign *scheme on success?
>> I=E2=80=99m not previously-familiar with g_autofree and do not note =
any current uses of it in the code base. Happy to take a look.
>=20
> Somewhat recent addition.  Also equivalent in ell is _auto_(l_free)


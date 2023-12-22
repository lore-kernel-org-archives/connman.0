Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60272C1A0
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BDF81730F3;
	Fri, 22 Dec 2023 13:48:01 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138] (unknown [IPv6:2601:647:5a00:15c1:5920:dc28:e386:f138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7C86973100;
	Fri, 22 Dec 2023 13:48:01 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <e18f7683-5cf0-41bf-9a10-930d7a76b848@gmail.com>
Date: Fri, 22 Dec 2023 10:48:00 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6F60FC9-6B09-4258-BE67-2327604660BF@nuovations.com>
References: <20231221070523.2354507-1-gerickson@nuovations.com>
 <e18f7683-5cf0-41bf-9a10-930d7a76b848@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 22, 2023, at 10:18 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>>  +/*
>> + * This is declared as 'const char *const' to effect an immutable
>> + * pointer to an immutable null-terminated character string such =
that
>> + * it ends up in .text, not .data (which would otherwise be the case
>> + * for a 'const char *' declaration), and with the 'static'
>> + * storage/scope qualifier, the compiler can optimize its use within
>> + * this file as it sees fit.
>> + */
>=20
> I think you already had a similar comment in src/gateway.c.

Confirmed; I had added that per Marcel=E2=80=99s feedback.

>  Since this is something that makes sense to make into the accepted =
(and encouraged) pattern, would it make sense to document this in =
doc/coding-style.txt and avoid replicating this verbiage across the =
project?

I think so. I=E2=80=99d probably phrase something to the effect of:

    If there are no preprocessor requirements (such as concatenation), =
string constants should be declared at the narrowest
    possible scope as declared as 'const char *const' to effect an =
immutable pointer to an immutable null-terminated character
    string such that it ends up in .text, not .data (which would =
otherwise be the case for a 'const char *=E2=80=99 declaration).

    Unless the scope is cross-module, they should also be declared with =
the =E2=80=98static' storage/scope qualifier such that the
    compiler can locally optimize its use within the scope as it sees =
fit.

    If there are preprocessor requirements (such as concatenation), =
string constants should be declared as preprocessor
    definitions.

>> +static const char *const general_group_name =3D "General";
>=20
> Given doc/coding-style.txt, item M3, should this be 'static const char =
* const'?

Unfortunately, checkpatch.pl would be in conflict with M3 and insists =
they be declared as I did.

I run checkpatch.pl as:

    checkpatch.pl --max-line-length=3D80 --no-signoff --no-tree --ignore =
SPLIT_STRING,INITIALISED_STATIC

since that seems to embody most of the style deviations I see in connman =
relative to what checkpatch.pl expects by default for the kernel. =
Ideally, there=E2=80=99d be a local wrapper in the project for =
checkpatch that specifies the desired options that reflect the =
project=E2=80=99s preferred style. As I=E2=80=99ve mentioned previously, =
in the future, I=E2=80=99d like to see a script in the project that uses =
clang-format to both verify and enforce project syntactic style.

> Also, since you're using this somewhat like a #defined constant, =
should this be capitalized for clarity?

Personally, I like to reserve all capitalized symbol names for the =
preprocessor as a convention.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/


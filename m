Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F3446AC
	for <connman@lists.linux.dev>; Wed, 27 Dec 2023 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 8C40ACECC3;
	Wed, 27 Dec 2023 12:48:33 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231223185801.2389526-1-gerickson@nuovations.com>
Date: Wed, 27 Dec 2023 12:48:23 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <962F7450-B2D2-476D-B0D6-90751F7A8649@holtmann.org>
References: <20231223185801.2389526-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This converts a potential run time error due to a mis-spelling of the
> "General" configuration group name repeatedly used a string literal
> into a potential compile time error due to a mis-spelling of the
> static global that now references it once and only once.
> ---
> src/main.c | 85 +++++++++++++++++++++++++++++++-----------------------
> 1 file changed, 49 insertions(+), 36 deletions(-)
>=20
> diff --git a/src/main.c b/src/main.c
> index 241c713d7980..c01a9e59d11c 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -69,6 +69,16 @@
> #define MAINFILE "main.conf"
> #define CONFIGMAINFILE CONFIGDIR "/" MAINFILE
>=20
> +/*
> + * This is declared as 'const char *const' to effect an immutable
> + * pointer to an immutable null-terminated character string such that
> + * it ends up in .text, not .data (which would otherwise be the case
> + * for a 'const char *' declaration), and with the 'static'
> + * storage/scope qualifier, the compiler can optimize its use within
> + * this file as it sees fit.
> + */
> +static const char *const general_group_name =3D "General";
> +

wouldn=E2=80=99t be

	#define GENERAL_GROUP =E2=80=9CGeneral=E2=80=9D

or

	#define GROUP_GENERAL =E2=80=9CGeneral=E2=80=9D

be actually more consistent with the other constants we use here.

I do like the all upper-case to indicate a constant here (and scrapping
the =E2=80=9Cname=E2=80=9D portion).

Otherwise, yes, it is stupid from us to keep using =E2=80=9CGeneral=E2=80=9D=
 in all
places :(

Regards

Marcel


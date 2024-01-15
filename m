Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977A6ADC
	for <connman@lists.linux.dev>; Mon, 15 Jan 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 852B1CECC3;
	Mon, 15 Jan 2024 08:53:31 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] src/log.c: Include libgen.h for basename API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240102015330.3730946-1-raj.khem@gmail.com>
Date: Mon, 15 Jan 2024 08:53:20 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <31E99B2E-3284-4B12-93B5-DDE3B8935100@holtmann.org>
References: <20240102015330.3730946-1-raj.khem@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Khem,

> Use POSIX version of basename. This comes to front with latest musl
> which dropped the declaration from string.h [1] it fails to build with
> clang-17+ because it treats implicit function declaration as error.
>=20
> Fix it by applying the basename on a copy of string since posix =
version
> may modify the input string.
>=20
> [1] =
https://git.musl-libc.org/cgit/musl/commit/?id=3D725e17ed6dff4d0cd22487bb6=
4470881e86a92e7
>=20
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> src/log.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/log.c b/src/log.c
> index 554b046..941e078 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -24,6 +24,7 @@
> #endif
>=20
> #include <stdio.h>
> +#include <libgen.h>
> #include <unistd.h>
> #include <stdarg.h>
> #include <stdlib.h>
> @@ -196,6 +197,7 @@ int __connman_log_init(const char *program, const =
char *debug,
> const char *program_name, const char *program_version)
> {
> static char path[PATH_MAX];
> +  char* tmp =3D strdup(program);
> int option =3D LOG_NDELAY | LOG_PID;
>=20
> program_exec =3D program;
> @@ -212,8 +214,8 @@ int __connman_log_init(const char *program, const =
char *debug,
> if (backtrace)
> signal_setup(signal_handler);
>=20
> - openlog(basename(program), option, LOG_DAEMON);
> -
> + openlog(basename(tmp), option, LOG_DAEMON);
> +  free(tmp);

can you please follow the coding style.

Regards

Marcel


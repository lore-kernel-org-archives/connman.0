Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC0328C4
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id A21A1CECEB;
	Tue,  7 Nov 2023 16:07:43 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] resolve: musl does not implement res_ninit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230929164516.6756-1-fontaine.fabrice@gmail.com>
Date: Tue, 7 Nov 2023 16:07:33 +0100
Cc: connman@lists.linux.dev,
 Khem Raj <raj.khem@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <601E033B-9E3E-428B-A69C-03930A485BB0@holtmann.org>
References: <20230929164516.6756-1-fontaine.fabrice@gmail.com>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Fabrice,

> ported from
> =
http://git.alpinelinux.org/cgit/aports/plain/testing/connman/libresolv.pat=
ch
>=20
> Upstream-Status: Pending
>=20
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>=20
> ---
> gweb/gresolv.c | 34 +++++++++++++---------------------
> 1 file changed, 13 insertions(+), 21 deletions(-)
>=20
> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
> index 954e7cf..2a9bc51 100644
> --- a/gweb/gresolv.c
> +++ b/gweb/gresolv.c
> @@ -878,8 +879,6 @@ GResolv *g_resolv_new(int index)
> resolv->index =3D index;
> resolv->nameserver_list =3D NULL;
>=20
> - res_ninit(&resolv->res);
> -
> return resolv;
> }
>=20
> @@ -919,8 +918,6 @@ void g_resolv_unref(GResolv *resolv)
>=20
> flush_nameservers(resolv);
>=20
> - res_nclose(&resolv->res);
> -
> g_free(resolv);
> }
>=20
> @@ -1023,24 +1020,19 @@ guint g_resolv_lookup_hostname(GResolv =
*resolv, const char *hostname,
> debug(resolv, "hostname %s", hostname);
>=20
> if (!resolv->nameserver_list) {
> - int i;
> -
> - for (i =3D 0; i < resolv->res.nscount; i++) {
> - char buf[100];
> - int family =3D resolv->res.nsaddr_list[i].sin_family;
> - void *sa_addr =3D &resolv->res.nsaddr_list[i].sin_addr;
> -
> - if (family !=3D AF_INET &&
> - resolv->res._u._ext.nsaddrs[i]) {
> - family =3D AF_INET6;
> - sa_addr =3D &resolv->res._u._ext.nsaddrs[i]->sin6_addr;
> + FILE *f =3D fopen("/etc/resolv.conf", "r");
> + if (f) {
> + char line[256], *s;
> + int i;
> + while (fgets(line, sizeof(line), f)) {
> + if (strncmp(line, "nameserver", 10) || !isspace(line[10]))
> + continue;
> + for (s =3D &line[11]; isspace(s[0]); s++);
> + for (i =3D 0; s[i] && !isspace(s[i]); i++);
> + s[i] =3D 0;
> + g_resolv_add_nameserver(resolv, s, 53, 0);
> }
> -
> - if (family !=3D AF_INET && family !=3D AF_INET6)
> - continue;
> -
> - if (inet_ntop(family, sa_addr, buf, sizeof(buf)))
> - g_resolv_add_nameserver(resolv, buf, 53, 0);
> + fclose(f);
> }

I rather not hardcode /etc/resolv.conf here. Can we make this more =
flexible and only fallback on systems that don=E2=80=99t support =
res_ninit.

Regards

Marcel


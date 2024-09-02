Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54C152E12
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265871; cv=none; b=VZU3Daj5wIX4xoBVeZfNxAxbfzXDRXFjeN95PLlLRQNu8HCv9fc2vwmc0L7o3DHOw8PV1/uSphYlV1+zJCgS0yZ/Ygk4fUYdUd/yXtd9Opq+2+sOugn0mXgPfkLdXzwr/3DjcoxiuYHR7hbP5ET6yopRrs/RdQ6yNA8h9CMo+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265871; c=relaxed/simple;
	bh=mr8Ym3rNraEY0udECWtioufKNXAFHOOW6UxDPUNcAGA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=THnshiHlFUmZNpqXUd8sCGbyhe68Sqw08nyS1RDDar1DouhSi8K7Xw0DVPLeOSJEITIDO/paU6cEydAhOFuaqigRev7UNgaQYYpwVzc9YbP9v07GaUvdcNDqUsW8u4af/GsuY/D68yZs/NzhiwnUW+oeoeXeKfzI7Lxq083v75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f372.dip0.t-ipconnect.de [79.249.243.114])
	by mail.holtmann.org (Postfix) with ESMTPSA id C0C57CECDC;
	Mon,  2 Sep 2024 10:31:01 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] gweb/gresolv.c: make use of res_ninit optional and
 subject to __RES
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240311110918.1399173-1-alex@linutronix.de>
Date: Mon, 2 Sep 2024 10:30:51 +0200
Cc: connman@lists.linux.dev,
 Khem Raj <raj.khem@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C110D6BC-3B9E-4973-A1CD-5075AC52903E@holtmann.org>
References: <20240311110918.1399173-1-alex@linutronix.de>
To: Alexander Kanavin <alex@linutronix.de>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Alex,

> Not all libc implementation have those functions, and the way to =
determine
> if they do is to check __RES which is explained in resolv.h thusly:
>=20
> /*
> * Revision information.  This is the release date in YYYYMMDD format.
> * It can change every day so the right thing to do with it is use it
> * in preprocessor commands such as "#if (__RES > 19931104)".  Do not
> * compare for equality; rather, use it to determine whether your =
resolver
> * is new enough to contain a certain feature.
> */
>=20
> Indeed, it needs to be at least 19991006.
>=20
> The portion of the patch that implements a fallback is ported from
> Alpine Linux:
> =
http://git.alpinelinux.org/cgit/aports/plain/testing/connman/libresolv.pat=
ch
> ---
> gweb/gresolv.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
>=20
> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
> index 8101d718..9f1477c3 100644
> --- a/gweb/gresolv.c
> +++ b/gweb/gresolv.c
> @@ -879,7 +879,9 @@ GResolv *g_resolv_new(int index)
> resolv->index =3D index;
> resolv->nameserver_list =3D NULL;
>=20
> +#if (__RES >=3D 19991006)
> res_ninit(&resolv->res);
> +#endif
>=20
> return resolv;
> }
> @@ -920,7 +922,9 @@ void g_resolv_unref(GResolv *resolv)
>=20
> flush_nameservers(resolv);
>=20
> +#if (__RES >=3D 19991006)
> res_nclose(&resolv->res);
> +#endif
>=20
> g_free(resolv);
> }
> @@ -1024,6 +1028,7 @@ guint g_resolv_lookup_hostname(GResolv *resolv, =
const char *hostname,
> debug(resolv, "hostname %s", hostname);
>=20
> if (!resolv->nameserver_list) {
> +#if (__RES >=3D 19991006)
> int i;
>=20
> for (i =3D 0; i < resolv->res.nscount; i++) {
> @@ -1043,6 +1048,22 @@ guint g_resolv_lookup_hostname(GResolv *resolv, =
const char *hostname,
> if (inet_ntop(family, sa_addr, buf, sizeof(buf)))
> g_resolv_add_nameserver(resolv, buf, 53, 0);
> }
> +#else
> +                FILE *f =3D fopen("/etc/resolv.conf", "r");
> +                if (f) {
> +                        char line[256], *s;
> +                        int i;
> +                        while (fgets(line, sizeof(line), f)) {
> +                                if (strncmp(line, "nameserver", 10) =
|| !isspace(line[10]))
> +                                        continue;
> +                                for (s =3D &line[11]; isspace(s[0]); =
s++);
> +                                for (i =3D 0; s[i] && !isspace(s[i]); =
i++);
> +                                s[i] =3D 0;
> +                                g_resolv_add_nameserver(resolv, s, =
53, 0);
> +                        }
> +                        fclose(f);
> +                }
> +#endif

we have a bit of coding style issues here. And this should really be a =
helper function.

Regards

Marcel


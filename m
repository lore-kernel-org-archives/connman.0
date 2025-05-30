Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FE1EA7C8
	for <connman@lists.linux.dev>; Fri, 30 May 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748595830; cv=none; b=cV2NXn5OMdb62+7yBDewfsB/M3B6n8ZvJoDS4NXWom3U+T47HTWeitYThYWGksldcnfhDXo2mo5nIbtdi4ySWR0307v/7Hmfz/+208+PWP9iSQqYGQv0DuE5tG5rYNj81xv7cjwYR1LIBvfipvyTNfP8dnBL/nbhq/xn47CSBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748595830; c=relaxed/simple;
	bh=PsbTqwj4W9Y0LlyEmviFpd7urw94eW/SWdP15iYU7Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPmf5lNl6sPxaXOIjYT7rM/vFxWSvpJuv0ofCUpawUoW+RykFzwm7Zp8AAzy0zbz4/o2fCO4NlcACFCO6lPP8k5NeEei4PoME8sFDqWlFYuSkvtXjCFRhzWPqSQYr0KktjNbmwzRYECYYKx6Ai+uvX0oKp4ZrSjuVAg87+ZXq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=H20xB6dA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H20xB6dA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742caef5896so1445392b3a.3
        for <connman@lists.linux.dev>; Fri, 30 May 2025 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748595828; x=1749200628; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2BnNdUQBP6xNWQGxhBAvvKZ8Q9PdyZBO3S3p3ZsZ20=;
        b=H20xB6dA8wFYlNQyfDwzRbss61n8KkQCSq6HRiKbcuVjiPXlw03XZKpW5r3rPJ0b5p
         yhF2Rfshpv6VJuJjNmaEkJktIzqWIgOxxFERthrzJy1z8qTo9Cokef3p4cef34LMe8nw
         W75zNsXD5jr/Lm4P3Lv9Jftf6j35mPjNt5ghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748595828; x=1749200628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2BnNdUQBP6xNWQGxhBAvvKZ8Q9PdyZBO3S3p3ZsZ20=;
        b=YBT/ohkdC7OKGEAF1hN824wmmfd97JffZspV5PVI4dyB4Jnor1xs92p5M8weLVb+1m
         wCGX6rrIc7Ks76atpUbvU0Bnm1SJE7k2kA6q2gJ+8LNsSTNCASfkg+UIbxG/tJ3JQ4fG
         f5H4XEA1f+wzeqNCOKgFa/C8Eg7vlm4Ypk35obiQaYs1mGq+j8nKsaEaE+Yc7xinksx9
         v0uQD4Q+8bfvs9jIC8edWa92b5GHZ9hNfkkus8jCBelcohCOYnQ/VgkTHffcfZVt73eO
         msDRwc144XKEMjhFP/7HBLk9Vgpw2wL8pYoIW/42HrwI9jLY4j6B91CXz9nbwO4RV3Hw
         AX2g==
X-Gm-Message-State: AOJu0YydziFESKvtLQvQUdTJj+W1HM/OIwRk/TzU/Tw3gbw6BcvCLvmR
	JsAHBy+VuTw1/talSgV5n6UD8YQvzPk2Mmt/55F6pUxYupnQagvxuDtDRkgXmEzr4I4A2a1KE5o
	EuqajI6uMQtj5fuYldONIgRo4PrGKfy66A48pJHhKOg==
X-Gm-Gg: ASbGnct2MLcYsJXAgkHIzcgQ9LHew4Py656rHwK8/Wcf6MpYCmx6pmxg3xKzqWCkvLR
	5XVkYcgx6ANh9MhmGkF/9otbRnBDKpxdWPSZpz4RN8tY3vMJ9NnTdu55gV5wxfH+jeuEik4KImQ
	PbJbj/hVrK8rhDfKldruDRtVIK+ghhaLMg
X-Google-Smtp-Source: AGHT+IEdqNaVXYeT/N9Q+aIB9H0DHmyEKBoINagQFTz/ecJEocIz2Q8EKXr8zZjRzm6JDM+7tb9jd6LC04DAJAbLusM=
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-3124150cd29mr4185636a91.13.1748595827833; Fri, 30 May 2025
 02:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519071912.7682-1-andrea.ricchi@amarulasolutions.com>
In-Reply-To: <20250519071912.7682-1-andrea.ricchi@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 30 May 2025 11:03:35 +0200
X-Gm-Features: AX0GCFs01Y7bhKe08OVWzqARNpLzkXB4TTyR94nYVvp16AYtUe4w2jVIzZMdxzk
Message-ID: <CAOf5uwnB-rDKiQOdcXSyuMTB1YSU4wh0Soka+ivZndtzFvHN-w@mail.gmail.com>
Subject: Re: [PATCH] timezone: Replace Localtime file copy with symbolic link
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Cc: connman@lists.linux.dev, denkenz@gmail.com, 
	linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea

On Mon, May 19, 2025 at 9:19=E2=80=AFAM Andrea Ricchi
<andrea.ricchi@amarulasolutions.com> wrote:
>
> The `/etc/localtime` file is expected to be a symbolic link to a
> timezone file under `/usr/share/zoneinfo`, not a standalone
> regular file.
>
> This change replaces `write_file` with `write_symlink`, avoiding
> unnecessary file I/O and memory mapping. It ensures Localtime accurately
> reflects the selected timezone without duplicating data. This also
> fixes `__connman_timezone_lookup()`, which requires Localtime to be a
> symlink to function correctly.

It's better that the usage of the link is reported by the manual of localti=
me
and that distro use it

/etc/localtime -> /usr/share/zoneinfo/Europe/Rome

>
> This reverts commit f20ccd19a62bd01aa117bfc8e7c388d2a16cde05, since

This really does not revert, because you are changing the behavior. I would=
 like
to say that compare_file it's not the right thing to do because
timezone can be the same
for different zoneinfo

> `compare_file` is intended to work with symlinks, enabling full and
> accurate matching between the requested timezone and the zoneinfo databas=
e.
>

For the rest
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Michael

> ---
>  src/timezone.c | 53 ++++++++++++++------------------------------------
>  1 file changed, 15 insertions(+), 38 deletions(-)
>
> diff --git a/src/timezone.c b/src/timezone.c
> index fba8b925..9b820477 100644
> --- a/src/timezone.c
> +++ b/src/timezone.c
> @@ -124,8 +124,8 @@ static int compare_file(void *src_map, struct stat *s=
rc_st,
>
>         DBG("real path %s path name %s", real_path, pathname);
>
> -       if (real_path && !g_strcmp0(real_path, pathname))
> -               return 0;
> +       if (real_path && g_strcmp0(real_path, pathname))
> +               return -1;
>
>         fd =3D open(pathname, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
> @@ -507,28 +507,20 @@ done:
>         return zone;
>  }
>
> -static int write_file(void *src_map, struct stat *src_st, const char *pa=
thname)
> +static int write_symlink(const char *target, const char *link)
>  {
>         struct stat st;
> -       int fd;
> -       ssize_t written;
>
> -       DBG("pathname %s", pathname);
> +       DBG("pathname %s", link);
>
> -       if (lstat(pathname, &st) =3D=3D 0) {
> -               if (S_ISLNK(st.st_mode))
> -                       unlink(pathname);
> +       // Remove existing file or symlink if it exists
> +       if (lstat(link, &st) =3D=3D 0) {
> +               if (S_ISLNK(st.st_mode) || S_ISREG(st.st_mode))
> +                       unlink(link);
>         }
>
> -       fd =3D open(pathname, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0=
644);
> -       if (fd < 0)
> -               return -EIO;
> -
> -       written =3D write(fd, src_map, src_st->st_size);
> -
> -       close(fd);
> -
> -       if (written < 0)
> +       // Create the symbolic link
> +       if (symlink(target, link) < 0)
>                 return -EIO;
>
>         return 0;
> @@ -537,33 +529,18 @@ static int write_file(void *src_map, struct stat *s=
rc_st, const char *pathname)
>  int __connman_timezone_change(const char *zone)
>  {
>         struct stat st;
> -       char *map, pathname[PATH_MAX];
> -       int fd, err;
> +       char pathname[PATH_MAX];
> +       int err;
>
>         DBG("zone %s", zone);
>
>         snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
>
> -       fd =3D open(pathname, O_RDONLY | O_CLOEXEC);
> -       if (fd < 0)
> +       // Just check that the file exists and is a regular file
> +       if (stat(pathname, &st) < 0 || !S_ISREG(st.st_mode))
>                 return -EINVAL;
>
> -       if (fstat(fd, &st) < 0) {
> -               close(fd);
> -               return -EIO;
> -       }
> -
> -       map =3D mmap(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> -       if (!map || map =3D=3D MAP_FAILED) {
> -               close(fd);
> -               return -EIO;
> -       }
> -
> -       err =3D write_file(map, &st, connman_setting_get_string("Localtim=
e"));
> -
> -       munmap(map, st.st_size);
> -
> -       close(fd);
> +       err =3D write_symlink(pathname, connman_setting_get_string("Local=
time"));
>
>         return err;
>  }
> --
> 2.34.1
>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

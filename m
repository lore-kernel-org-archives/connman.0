Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309D2C324C
	for <connman@lists.linux.dev>; Mon,  2 Jun 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849922; cv=none; b=Uh3kWxVmyX98XK1V+rWVB62HGH17TuDYIKe/dR2wMJ/3wtI8ZV9/uEvCFr77F+dTGDLS72wEGS5/kvaFDUnuXBHFrPndEZP51xWWprgHMw8yKL39gfC7M4acheCfHh0BfeOGY5eV2z27dEnPyts5xP+wIhKuCFHhtHuQtBUYNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849922; c=relaxed/simple;
	bh=n9yzZSfrzsssyFRMkViM53fEnmBgveUPonjecRLl71k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVYabrsv7zqZQ8B4aSv9YqtNeKSDSsQxW4ZMOWF93+I7iU4n0suWleaHn0c61dtytGGJKJNKi6mBeNJP2G4QT69zV3CNVNSO9iqMEpLWWg9Ne9f7N6napQIfzkZObegiCBe77gXPa3MuINbztE34SI/qVrfILAqnwcXjkuqLBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=RL+SPcsm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RL+SPcsm"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso2854120a12.2
        for <connman@lists.linux.dev>; Mon, 02 Jun 2025 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748849920; x=1749454720; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NhWnfZmzlWqvEGMrndGKNaK2FJbCFpdatL/iXW1MpY=;
        b=RL+SPcsmwhXkS0T03MEzlEt1uDBXcoytb14dTVjbw12QC54ZfqeM4NNLrUQ6Jb0C5L
         L6Bb7hHL4zSzcgNxOMAZK0KyMJcDyEYvDY6QEb5pa4wps4k3PoN38FO+3rPMVOcWajKz
         0PvxkGe390otdV7dHwC018RYAA5BCBU8iTgRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748849920; x=1749454720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NhWnfZmzlWqvEGMrndGKNaK2FJbCFpdatL/iXW1MpY=;
        b=iMN6gMwbhiesvlkJP44tcY7jyivNKduMiC4JemvZrn06ZlUef2rQhjvA+2YK7Nqt1p
         bOlayY3pWXhURTtGNQiA1+Tmfs/JOZ2h8PXVXFGdKK0brvGV4Mmndv8tuP8G6d541saT
         tM8kFpmduBii1hOYz5fO345bcIPYv6JdbhWXWEgPOKV7o9paLM8G6lzlSk2V2rEHGLOF
         GJCEFm+VItED9hhELWoLFD9iRRyrkdW/bmQHOjmDWF6CJKDbOw2qR5MNH9cFurjs2VHf
         hq2b+yT73+WYa5GEhEa5NTyzdVsCzzSOQ5lx1B2IECSz8O9S5o3IWjeFVVdxcDAH74C3
         iKhQ==
X-Gm-Message-State: AOJu0YwmuBCRIsLd6KDaH6spH1TUTjUuUdgojtYiCEdDmfUAqKBkr0jB
	ylEixWDWfCcqoZl9T/x1eszRyc50Ld3Oy+xTQ9f1ZoGl9LwckPzqcPhffyUPsKRvRMhtDTPUhFb
	YBUL4jUNByY8ZQJmUkqHjGMvdTOVs9PL761SqBASD1A==
X-Gm-Gg: ASbGnct+PHXRG+6/eRBvQmDbdUClj/cENQv4ywxrWW4dEWLBb14pfG0R8r5XLZndNiM
	x4L3fU3gpEhnVtN1VOP5GMAmxK2wX3JGcJevjFo7Tdtf6RWyuZOvdu4P01Rd4Gr/2EQ34Ee/ssW
	IMUZiA9gaxMWyB+EUioZqGeP2+EbqNCeA=
X-Google-Smtp-Source: AGHT+IGoTzbQWKsHEqD1uUCJNq5TjTGZKiQ5x/xoTiq3VTOGJj4h1Q8uw+R9uHbhYiYNR9C/hDU0R6DmhDWURTO2fQg=
X-Received: by 2002:a17:90b:4f4d:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3125034a47amr15890135a91.5.1748849919778; Mon, 02 Jun 2025
 00:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SE1P216MB264701D18124CD7147BCAF1AF062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB264701D18124CD7147BCAF1AF062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 2 Jun 2025 09:38:27 +0200
X-Gm-Features: AX0GCFt35TUxszKikU-eaiSm1iNV9EzEl9_lloYD8Qba6DKUtbb5hg8mXQ4gTLU
Message-ID: <CAOf5uw=4iJ3UoeR9JTRoFY16Tao9mEi2sZHO0=ZG1f_cvA=nyQ@mail.gmail.com>
Subject: Re: [PATCH] connman : Add null check in prepare_target to avoid SIG=6
To: "Shailesh Rathod/LGSI GPOS Dev" <shailesh.rathod@lge.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Vasu Kantubukta/LGSI Connectivity Team" <vasu.kantubukta@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 2, 2025 at 8:49=E2=80=AFAM Shailesh Rathod/LGSI GPOS Dev
<shailesh.rathod@lge.com> wrote:
>
> From: Shailesh Rathod <shailesh.rathod@lge.com>
> Date: Wed, 23 Apr 2025 17:48:14 +0900
>
> Add null check in prepare_target to avoid SIG=3D6
>
> When Ethernet is connected and an attempt is made to enable the SoftAP,
> a SIGSEGV (signal 6) is observed.To prevent this, add a null check to
> avoid the segmentation fault.
>
> Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>
> ---
>  src/iptables.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/src/iptables.c b/src/iptables.c
> index a81a077..54e04d3 100644
> --- a/src/iptables.c
> +++ b/src/iptables.c
> @@ -2746,20 +2746,21 @@ static struct xtables_target *prepare_target(stru=
ct connman_iptables *table,
>
>     switch (table->type) {
>     case AF_INET:
> -       if (xt_t->x6_options)
> +       if (xt_t->x6_options && xt_t->option_offset){
>             iptables_globals.opts =3D
>                 xtables_options_xfrm(
>                     iptables_globals.orig_opts,
>                     iptables_globals.opts,
>                     xt_t->x6_options,
>                     &xt_t->option_offset);

Option offset is only an offset to the options. It's not a pointer to anyth=
ing

I think that this need a better explanation

Michael

> -       else
> +       }else if(xt_t->extra_opts && xt_t->option_offset){
>             iptables_globals.opts =3D
>                 xtables_merge_options(
>                     iptables_globals.orig_opts,
>                     iptables_globals.opts,
>                     xt_t->extra_opts,
>                     &xt_t->option_offset);
> +       }
>
>         if (!iptables_globals.opts) {
>             g_free(xt_t->t);
> @@ -2768,21 +2769,21 @@ static struct xtables_target *prepare_target(stru=
ct connman_iptables *table,
>
>         break;
>     case AF_INET6:
> -       if (xt_t->x6_options)
> +       if (xt_t->x6_options && xt_t->option_offset){
>             ip6tables_globals.opts =3D
>                 xtables_options_xfrm(
>                     ip6tables_globals.orig_opts,
>                     ip6tables_globals.opts,
>                     xt_t->x6_options,
>                     &xt_t->option_offset);
> -       else
> +       }else if(xt_t->extra_opts && xt_t->option_offset){
>             ip6tables_globals.opts =3D
>                 xtables_merge_options(
>                     ip6tables_globals.orig_opts,
>                     ip6tables_globals.opts,
>                     xt_t->extra_opts,
>                     &xt_t->option_offset);
> -
> +       }
>         if (!ip6tables_globals.opts) {
>             g_free(xt_t->t);
>             xt_t =3D NULL;
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

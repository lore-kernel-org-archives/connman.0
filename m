Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F4366
	for <connman@lists.linux.dev>; Mon, 26 Sep 2022 06:21:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 546B25E2C3;
	Mon, 26 Sep 2022 08:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1664173282; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wlGdix/gDIpOUIrPwEAXXheBYmvEiqK6Jq2VGRv76IE=;
	b=qxZ1dABQzcuzpmCTpreBIl8zNnkaVrc4gfFPXDKr+DdSAOsJXePci4DlR+KY+pxWQiG80y
	tWaREZsKrn0HEkErjV2n1jRvqx707uWO/QpvyFg7Z9zTPjTcrEirbhFJ1n4n3XPGUfrhs+
	lRURM6KH/L0LV1XU7RhA8hWVelImwRBWXJ/VMruk+W2Mj6hsDxSloOBS8PPgxkYD5qERF1
	F9v22/zSmL9naqOmKTbdpXN1qHuk5ZtwhpplKE783e94ffV7o4dOAtFMOa85bXjitTuSsF
	NTJMOfG9f7krg3KcYmwjbH1YguIJ1GdQIbtl2ieIp8ZCG8KE/A0DbZ+Ayxk0MA==
Date: Mon, 26 Sep 2022 08:21:21 +0200
From: Daniel Wagner <wagi@monom.org>
To: Ben Kohler <bkohler@gentoo.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] gresolv: add missing include to fix clang-16 build
Message-ID: <20220926062121.3pzyqaurugbfqfko@beryllium.lan>
References: <20220922154517.2326482-1-bkohler@gentoo.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922154517.2326482-1-bkohler@gentoo.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Sep 22, 2022 at 10:45:17AM -0500, Ben Kohler wrote:
> Current compilers gcc-12 and clang-15 warn about an implicit function
> declaration in gresolv.c, and this turns into a fatal error in clang-16
> and eventually in future gcc.
> ---
>  gweb/gresolv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
> index 954e7cfe..7c58e055 100644
> --- a/gweb/gresolv.c
> +++ b/gweb/gresolv.c
> @@ -36,6 +36,7 @@
>  #include <arpa/inet.h>
>  #include <arpa/nameser.h>
>  #include <net/if.h>
> +#include <cdefs.h>

I use a gcc-12 compiler locally and don't get any warning. I suppose you are
passing additional build flags.

Anyway, this gives me:

gweb/gresolv.c:39:10: fatal error: cdefs.h: No such file or directory
   39 | #include <cdefs.h>
      |          ^~~~~~~~~

Is this supposed to be

#include <sys/cdefs.h> ?

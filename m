Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F11621
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 08:50:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0955D5D44C;
	Fri,  4 Mar 2022 09:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646383833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1MyKP0S7rIN9PkrbbdEJiQ463gxTfxZpmS58QnJjlxA=;
	b=nqvhQlj0iUTSulDybjGPLvZVuP9bd7AQ/kOTHQTOgTBgSHFEhprS065nos1bIW+tK7ChCr
	/8dO9ER+0XMZx8tM1tE6kxJgKYg51d/be+Xt03346u4q8pMoegMdRhb/uxFGJ+sjznU66P
	4XogvcQxYBxz07QeqoEpJzqt6tbkAx+oxoXNzTZxxZ8RWg1lSJxekGC9HHFFbMrW7JFYIo
	AeTyS2dCY/yZEem/Mj9kdOlYmoHEqg3VZGlYTWkn6HoZFHP7uVdWVVq72SwRgvXkeWVlBd
	DnxQKxgvkZaE55IV1+6wonNMfCqglFAmj3HUlqZ1MyMk1wSrPdKfWowrz5b99A==
Date: Fri, 4 Mar 2022 09:50:32 +0100
From: Daniel Wagner <wagi@monom.org>
To: matthias.gerstner@suse.de
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] dnsproxy: add standalone test version of dnsproxy and a
 test script for it
Message-ID: <20220304085032.ye5te4lxomj7yup5@beryllium.lan>
References: <20220221084813.sk5thg5pj24ym3db@beryllium.lan>
 <20220228131921.5573-1-matthias.gerstner@suse.de>
 <20220228131921.5573-2-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228131921.5573-2-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

On Mon, Feb 28, 2022 at 02:19:21PM +0100, matthias.gerstner@suse.de wrote:
>  if TEST
>  testdir = $(pkglibdir)/test
>  test_SCRIPTS = $(test_scripts)
> +
> +tools_dnsproxy_standalone_CFLAGS = $(src_connmand_CFLAGS) -I$(srcdir)/src
> +tools_dnsproxy_standalone_SOURCES = tools/dnsproxy-standalone.c $(src_connmand_SOURCES)
> +# for EXTRA_PROGRAMS the BUILT_SOURCES aren't automatically added as
> +# dependency, so let's do it explicitly
> +tools/dnsproxy-standalone.c: $(BUILT_SOURCES)
> +tools_dnsproxy_standalone_LDADD = $(src_connmand_LDADD)
> +# pass -zmuldefs to let the linker tolerate the duplicate definition of
> +# main(), the first definition from dnsproxy-standalone should be used
> +tools_dnsproxy_standalone_LDFLAGS = $(src_connmand_LDFLAGS) -Wl,-zmuldefs
> +
> +noinst_PROGRAMS += tools/dnsproxy-standalone
> +

I wrapped this section into an addition 'if INTERNAL_DNS_BACKEND'
because it would fail to build for SYSTEMD_RESOLVED_DNS_BACKEND

> +	// we need to trick a bit to make the server entry enter "enabled"
> +	// state in dnsproxy. Appending and removing an arbitrary entry causes
> +	// "enable_fallback()" to be called which does what we want. Doesn't
> +	// make much sense but it is good enough for the standalone server at
> +	// the moment.

Changed this to /* ... */

Patch applied.

Thanks
Daniel

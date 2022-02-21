Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144F2568
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:48:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA3695D365;
	Mon, 21 Feb 2022 09:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645433293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NNB3Xmv3t6Tf8zkPGNt86Glzn8YqMGqg5gvALuEMhDc=;
	b=vld0xdA0WkLXKcUhuHrdcyiNUOhGqZSAcUVNjSzBogYlwRsdWON0PWGRvR2ZWJzL3GOr0O
	HBeuppOPreqW83myVoMQmFgi47Aih1hJb/n6B2aPnBRA8QL/pEfw4SAFmQlNa7EOqRUs9p
	NAj9TwCFn8zUG3UM0RI2KvF/mAh/sxvDRwGDpKsbBJr7T5qmExlKkxW55NL8I3bG/K2Tlp
	9zQSyoQBsex01ALfRpKVYaD4WeToXTYE71r2KmgBPYJ8co8r0R7xpeE40AzHT1EMIIkrid
	eQc6IGgknv9/KOSskj853knZXOYinfGaEbXoNKp92Gc4xWHl1EA3L5WGplsUhg==
Date: Mon, 21 Feb 2022 09:48:13 +0100
From: Daniel Wagner <wagi@monom.org>
To: matthias.gerstner@suse.de
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 7/7] dnsproxy: add standalone test version of dnsproxy
 and a test script for it
Message-ID: <20220221084813.sk5thg5pj24ym3db@beryllium.lan>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
 <20220217113113.24088-8-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113113.24088-8-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

On Thu, Feb 17, 2022 at 12:31:13PM +0100, matthias.gerstner@suse.de wrote:
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
> +EXTRA_PROGRAMS += tools/dnsproxy-standalone

I would move this part just under the other tools section. These 'tools'
are not supposed to be installed.

> --- /dev/null
> +++ b/tools/dnsproxy-simple-test
> @@ -0,0 +1,112 @@
> +#!/bin/bash
> +
> +# this script runs the dnsproxy-standalone test program and runs a couple of
> +# standard DNS queries against it, using the currently configured DNS server
> +# in the system as dnsproxy configuration.
> +
> +echoerr() {
> +	echo $@ 1>&2
> +	exit 1
> +}
> +
> +while [ $# -gt 0 ]; do
> +	case "$1" in
> +	"--valgrind")
> +		VALGRIND=`which valgrind`
> +		if [ -z "$VALGRIND" ]; then
> +			echoerr "no valgrind executable found"
> +		fi
> +		;;
> +	"-h")
> +		echo "$0 [--valgrind]"
> +		echo "--valgrind: run dnsproxy-standalone in valgrind"
> +		exit 2
> +		;;
> +	*)
> +		echoerr "Unknown argument $1"
> +		;;
> +	esac
> +	shift
> +done
> +
> +if [ -e "Makefile" ]; then
> +	BUILDROOT="$PWD"
> +else
> +	if [ ! -n "$BUILDROOT" ]; then
> +		echoerr "You need to set the BUILDROOT environment variable or run this script from the connman build tree root"
> +	fi
> +
> +	pushd "$BUILDROOT" >/dev/null || echoerr "couldn't enter $BUILDROOT"
> +fi
> +make tools/dnsproxy-standalone || echoerr "failed to build dnsproxy-standalone"

Just build this tool along with the other tools. No need for this
special casing IMO. It's also not working in my setup:

$ ./tools/dnsproxy-simple-test
gcc -Wall -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -O0 -U_FORTIFY_SOURCE -g    tools/dnsproxy-standalone.c   -o tools/dnsproxy-standalone
tools/dnsproxy-standalone.c:7:10: fatal error: glib.h: No such file or directory
    7 | #include <glib.h>
      |          ^~~~~~~~

Thanks,
Daniel

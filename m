Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A17C
	for <connman@lists.linux.dev>; Wed, 21 Sep 2022 21:39:51 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id n83so9795125oif.11
        for <connman@lists.linux.dev>; Wed, 21 Sep 2022 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gLnUSHQWL6iCL/mTNXhkPu5KzLIDsxVXnKlXjYFg3X4=;
        b=okmM1Q1ojx5fHEVGn7YdFH4O2zAZkdgM5UfvVUUnLj6q8Nbq2+HB3Sr11Rc4iCKzDG
         5dgN5BBEU5vPqubXMfH9FVs5T7RH5GvrIE9Cy9jsf//qmB2hv1A4Dct8A13bOpidhQKf
         aGiWL7/8849UyggTujXy1RO+GNBdhzfbOLpuBJylrH52dD1tpi8fiHYscNH2cEhwiTQ3
         kAJk5wB1KaHLqxgPXvaNuFJljaVZ50ZpN0v5AQA9r+HGRgqY9WR6GrYKzCpTQVqQvhSN
         wjlh/Kbuf/eFuNWWm7wK0c0QQSJ0LO8nsi7EFA9s0TjEMT++Nowb8LULcH80qGW5K5qr
         sgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gLnUSHQWL6iCL/mTNXhkPu5KzLIDsxVXnKlXjYFg3X4=;
        b=KDmMIv1oS0CMZ9YZ+9QYbJQS9IN01l13ntCp2fPP7JOsiIH3IjfGUjqXmTPxoS2QRq
         iq87l4aA9pSEYDK85WU4Qvs3k38zLBlKe8fIBJ3v93pS9je2nf1cwF0AJi1mxyLFfIXp
         KgZPwt6BJM+JF5nPRsEOFS1wsY1MfRswHbNVrf98KxSs7Y4ezNfqPKYn7Me0AIL4DBh1
         DuWd8ES572XzqHw1STBYtPBwm0zWTk1ifaTBGZf8bXbZoSagY45QnncEzZoHQMQxUaWf
         LDAuYbnFsDDylbX4SqxeYYmOiErnzgiz2wQS4zIgXDIhjAkW2zxXLy5rZCNwF7BFQXYv
         4DUg==
X-Gm-Message-State: ACrzQf3PvmtVtl/WuOJZEbD+YytEuVoDXGsq+VHuGa1p+QsyQeQ7q5f+
	ikP0JehDvYa7VqxDX3vkgzrhGoxxC9znZA7U+QgzBFSx3akW+l1A
X-Google-Smtp-Source: AMsMyM5zOQ13wE5dDa0ILOjwTufSgzfdilKHb46/a0LBRllN243qLT+TSplujceLEUOB+41bDfpxgRlUK6zZs8LZloQ=
X-Received: by 2002:aca:ebd7:0:b0:350:47c5:46c1 with SMTP id
 j206-20020acaebd7000000b0035047c546c1mr5020829oih.246.1663796390133; Wed, 21
 Sep 2022 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pawel Bogucki <pawel.bogucki@gmail.com>
Date: Wed, 21 Sep 2022 22:39:37 +0100
Message-ID: <CABR2+XVsqQKTsm_GrQJHf5s5X9LNr9tCRG_GYx_Q9MvgePfGfg@mail.gmail.com>
Subject: ConnMan SplitRouting
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm trying to work out how ConnMan does Split Routing on VPN.
When checking VPN provider status via:

connmanctl services --properties vpn_XXX

I can see a provider property "SplitRouting":
Provider = [ Host=XXX, Type=wireguard, SplitRouting=False ]

The problem I have is that I can't figure out how it works and switch
it to "True" (defaults to "False").
It looks like support for it has been added in following commits:

vpn-provider: Support SplitRouting option from connmand
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=bdaa76471c7381385e169f47bbff65fe5f4080bd
vpn: Support SplitRouting in D-Bus variables, improve route code
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=36b1bb63318c72e0e0018f0281103beb1d8fba24

However when I just add SplitRouting to the config file it doesn't
seem to be doing anything.
I'm guessing it's because I didn't define any routes (based on the
commits description) however I don't see how to do it.
There is also no mention about SplitRouting option in current docs:

vpn-config-format.txt
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/vpn-config-format.txt

It mentions the "Networks" parameter however in my testing I didn't
see any difference with it being present or not.
I have also found the "UserRoutes" parameter mentioned in:

vpn-connection-api.txt
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/vpn-connection-api.txt

but details and/or examples are missing.

Can someone explain how it should be done so SplitRouting works? Or
update the docs (I know no one likes that part)?
My Internet search brought me pretty much here as I was unable to find
any further answers.

Regards,
Pawel

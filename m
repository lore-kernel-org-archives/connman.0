Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CD27739
	for <connman@lists.linux.dev>; Fri,  6 Jan 2023 19:04:26 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so1417582otk.8
        for <connman@lists.linux.dev>; Fri, 06 Jan 2023 11:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07Rv1prEYi+cIu251/P/T7bFZGWCVLpovC/DA4ZwCVU=;
        b=8KShiCJQ7zNPI6VGlWWFL0n2J1y1BaLbwoiB/qIFKNurpo1Ni2Muc/vrFAb7P8O66G
         wThPdbpTyR6gTJAqQM6VcN9a7A5Ru4ZDNSaV6CDN8Wr/Vogx3o6FRepta6VTYO5Jqciy
         vXzW4YtG4UQjzVjyws2oEPkboz9ljV4QFEs51qMn3O3+N24IFrP8EkOh3wsJOAVPIWUR
         1IBywL7d7qyLLgkmdO4KVsKEJBekQ3Y1sDodJ+OKoTMXx6vln4K5BiB/0ofA1f8IKrZ4
         7ORDoW9b1+CixBMQQvjFTIljLfkST48wEpy20990p68zdijZMnZiR4SFMIdjwtDAce4P
         UeJw==
X-Gm-Message-State: AFqh2krWlEjK7R2Nwu0DcjIqIPozs298IfRVuBaP4s7BB1LpwpppE/Vq
	1zdThY/nYGowudbArPo3wIjgZ4RVb5YHdoWQLpEFkw==
X-Google-Smtp-Source: AMrXdXuDyS0rwSxlAgIQfFGQIlbH1wyNdb4Rc9tD0Dskz76nVxqt8yQ3X/7PbCLK92CZxrgK064i09+RNmtH2dtGidM=
X-Received: by 2002:a05:6830:1313:b0:675:b95e:9e44 with SMTP id
 p19-20020a056830131300b00675b95e9e44mr3111635otq.266.1673031865735; Fri, 06
 Jan 2023 11:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFA9we9QrpTmyzBewdiL4gKP52_G_j25NvR2pjpqzBXb2xPnzQ@mail.gmail.com>
 <20230102083554.nindhbg3b4edrgfo@beryllium.lan>
In-Reply-To: <20230102083554.nindhbg3b4edrgfo@beryllium.lan>
From: Jade Lovelace <lists@jade.fyi>
Date: Fri, 6 Jan 2023 14:04:14 -0500
Message-ID: <CAFA9we9hh9gORA9EB4Sm7opJi_Rfb6c9L8KJz2rC_1zXnUShfA@mail.gmail.com>
Subject: Re: bug: iwd KnownNetworks AutoConnect setting desynchronizes with
 connman's, breaking auto connect
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> ConnMan completle relies on iwd to do the right thing, so this question is more
> for the iwd developers. I don't think ConnMan should start fiddling with the
> AutoConnect settings after the initial configuration.

Ah, I see. Based on my look through the iwd code, I also don't see any
evidence for why it's changing, absent someone telling it to do so
over D-Bus, so I wonder what's going on there. If I have it happen
again I'll try to poke around on the iwd side some more to try to get
further information.


Jade

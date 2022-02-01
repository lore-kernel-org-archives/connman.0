Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6972C82
	for <connman@lists.linux.dev>; Tue,  1 Feb 2022 15:42:36 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id me13so55567052ejb.12
        for <connman@lists.linux.dev>; Tue, 01 Feb 2022 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Wg3oTZlSv57EjOc5jXSQjjIgbK+Pc/h5i91+surTRSs=;
        b=FjBL5DAsztR7N35a89e22aPv8mtlhjDuWHUXZkQ18gN9/mgASXxDaPwGEaS9ZS40oa
         CFm+XtrLdWFIrCo36npto/gNLuLp6pjURPWs7kDiVvdp22pcqOlP+q5c9Q1tJgDhzoLO
         Hapw4YQYY73I1CP9uTfO5xKuhWnWL+dNgSmQr2PWRhs7n67mKBiGWD/zIkgawORYMVzP
         tI0e56lkfSLgsj857xqeuXQgilklvLssiCqPn3NAF8g5CVh3YWxSdqjcwMcDjodvFRkg
         eB/ixjUhBGyBT7Awcl91jihCc1a9QQJvCDhPvCrW6Ej4QyKyBUO3hYLzmIkPN8viUNfC
         m29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Wg3oTZlSv57EjOc5jXSQjjIgbK+Pc/h5i91+surTRSs=;
        b=24Vc1zu0y6u4nJW7dblWCsDWq7KQR3No90MYycFqzPsCxG1l3fEkk+ugm/qGZGLo8A
         Vjd90F03kgIAFCnj7ILeyUaAK33rYk3kdOlkNObnOePnhwFO9mkHvDKPiEEC7jgnVwOM
         ej9MooaeOnBr/TufrrwflWrUaWKCC9m7lLgJaN1w3arROeUXPdS9H5WdSXOh6p9Xn6ul
         Ra44JhvOC84jfiiHFoWLZvPhxUNjLj57BY5GUjeHrH3Jl64JdruxupRkr7DpezaHUlup
         gDuGzw7J4SSrSz0i0hfjDXdF6eg8hba1H40JN3XnBYxOz5yIxN+ogPU8nVK7WSPnCfiW
         PI3Q==
X-Gm-Message-State: AOAM533q54fdhnK6E12rlq7sfjHZXpoGhDbowGDMgdEARd24/JLIrxig
	jJvXHZ2rxVUSyPoIj0TdZqEPewG40YKJsomBuH59Q2eUfV+AuWzwg+E=
X-Google-Smtp-Source: ABdhPJz7/PUClRnk6iUkP4hxeVrJ+9hjw9gX62DKQrX1YsoSckgY+jg0cDdl0YjoM8CacpZhVb+spmYs/iqA1T40ees=
X-Received: by 2002:a17:907:72d6:: with SMTP id du22mr21707203ejc.179.1643730154206;
 Tue, 01 Feb 2022 07:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Tue, 1 Feb 2022 16:42:23 +0100
Message-ID: <CA+iibzBMv_oyq3KYhRhsaBYFi998QuK0tp0CdLV0eX82Y36zmQ@mail.gmail.com>
Subject: connman issues with enlightenment since last upgrade to version 1.41
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi gentlemen


I used a linux distribution with enlightenment and conman as
communication manager. Since the last upgrade at 1.14 I have observed
two things:

First, the econnman icons (wifi or ethernet) are not blue anymore and
remain grey. When I look at the parameters wifi or ethernet are READY
and not ONLINE . I notice that in the journal records that there is no
more unknown route 82.165.8.211 as in the archlinux wiki.

The connection itself is still functional.


Second, My laptop is connected via a wifi connection and I use virtual
machines (virt-manager). When I start one of the VM, on the host an
ethernet connection
is opened and connected despite there is no ethernet cable connected.
The side effect of this is that there is no dns resolution in the
virtual machine until I
disconnect the ethernet connection on the host. I suppose that It has
something to do with the fact that the host connections are READY and
not ONLINE .
Best Regards
Dania

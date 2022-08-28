Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262472F45
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 16:42:16 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id w129so2787074vkg.10
        for <connman@lists.linux.dev>; Sun, 28 Aug 2022 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1OjknJdMCTXPXijCs67z8g2PWpp+EyvJzEGx2mq4FGo=;
        b=aFnnAfWE6b3OYtR60IWdTvG4R6aJa2oV28Eta6eqU1TgeBevSuoQtPA6zaHausIzRL
         m4QbHXnPJ6pFtxkUXxyRnXqDZ+xckH0TIOIRidNNb/Un30PptuZb7471B+1HcQo1NNLL
         e+u2ti0Fb6E9o3sH3TL/amb21X7HMjEfIJsAYojS6Lnt2uhmwTAIG9hkSlQLDp3YSE6a
         sH2S5OqDKVGHjNQcRSy9J+NaZUEsaH08LCwZnve7bKEVd+b+3pPup/Lyjv501/bk33C6
         dTdEPp1MYTndP8kILXddYZOcztPdSn7Msd7ASBrmUAqLhkpFGvwuLkBOzFGgjjyUzIv8
         bExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1OjknJdMCTXPXijCs67z8g2PWpp+EyvJzEGx2mq4FGo=;
        b=O/KzUt3o7AuyhkfGON5qBdQks5x0lguEpVp/jpuw/yzXq4hzV7ntphQIBsC9m7A/hl
         y84yoBQpJUlWoloFze59Iyd54iEmRVYtcewDvdy1zeKc9Q8TBG/sAl27yPbVP5UY3MLu
         zw+htGpEGJKgiRDUBHW8M9d6gvAwL1AlZ6/TI5J8q8Fhbx3GsJ+uY+t8LicrRJ3uR4Hz
         ulZEocWOgsf+AU05ykm5ycHIxpoGIQk9CLei7t5NdcSdeFY68+I/0JRwhcmKGJr5Leht
         k3panrY8lPy1yK57GMkFeKGtaCj/FYUtMd2zIiIE5RWcAA0i3LmPNbsdyBaWXwu0cpty
         NqOQ==
X-Gm-Message-State: ACgBeo2Hs++1ObYnLuqzaUxaoqiq7V652JdHoXrrSlMqgNxACorpbw0c
	u9Qxr+A1Cr4IVr5g8g/FGPoh15wYvsao2KhObt8/qYtK9pTIoyYb
X-Google-Smtp-Source: AA6agR5lYOJw9ljlLspYV7wvLUaR4DFaVXr5ioKVW9+ay/40tS1KdxNw211VZvE/V81EIt5jR4HNgVGNeySaXmuVMS8=
X-Received: by 2002:a05:6122:50a:b0:38c:ebd0:9fb with SMTP id
 x10-20020a056122050a00b0038cebd009fbmr2145850vko.36.1661704934966; Sun, 28
 Aug 2022 09:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFT6v_b-nE0TkTRDNcEPgb6wDue0NAwWPBEDevVfA=VBDD-rqg@mail.gmail.com>
 <20220828140621.fs5vy55x2g2minl6@beryllium.lan>
In-Reply-To: <20220828140621.fs5vy55x2g2minl6@beryllium.lan>
From: Quen Jankosky <quen.jankosky@gmail.com>
Date: Sun, 28 Aug 2022 16:42:04 +0000
Message-ID: <CAFT6v_YpO1EC3wxaovLnNN=nF9wg4i_543rm39RLW6Ewg5Xp9Q@mail.gmail.com>
Subject: Re: Default Routing Issues, And Potential Solution
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thank you for the insight, but I'm still not really sure about much here.

On Sun, Aug 28, 2022 at 2:06 PM EST5EDT Daniel Wagner <wagi@monom.org>
wrote:> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/overview-api.txt#n116

I viewed this doc, it was certainly helpful to gaining me more insight
to what I'm trying to figure out here, but some things it describes
are still unclear. In all honesty, I am left more confused. For
example, here: https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc/overview-api.txt#n130

Within overview-api.txt:
>To change the default connection to your access point, the user needs to
>manually drag the access point service to the top of the list. Connection
>Manager will not take down default routes if there is no reason to do so.
>A working connection is considered top priority.

... I don't really know whats being described here. The documentation
doesn't go over any specific way to do this "dragging," and as a
result I'm just kind of lost on how you really are supposed to
prioritize a specific service for the default route. It's also
explicitly stated that the order number is an internally handled
value, which means (at least from how I can interpret it), there's no
real way to determine the order of the services on a daemon startup.
Is there a way to set the order number for a specific service in their
configuration file, or at least through the d-bus or connmanctl
interface?

> Does it still happen if you disable the auto connect and wispr feature?

I am aware of the auto connect feature, but I haven't seen anything
about wispr in the man pages. Is it for the latest connman version? I
did see your commit from yesterday involving it. I am not willing to
change the autoconnect feature, however, since the solution to
manually change the default route is mostly a hack when connman should
allow me easily configure which service has it.

* * *

I apologize if I'm not understanding any of this, but this all seems
unclear even in documentation.

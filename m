Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91710FF
	for <connman@lists.linux.dev>; Wed, 22 Jun 2022 06:24:50 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id s124so20002774oia.0
        for <connman@lists.linux.dev>; Tue, 21 Jun 2022 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQU/ov85GWTS9XlKxMiC6QzFxE2H5RxX/WsCFW4YMsg=;
        b=VxG0hlF11fsgDCA6SeZcy51lfAiWbxmY5xAlHAoti6t+TMORcCYtzU3LPz28nnBiv7
         uq4NAi9i2UvZO8IPBamh3SuSZRvRygnGYrdbcugezpxyd06yIKsUBlji8/EHa0HttyPd
         74c4qoF3QdStHnDul7lT4233Pe1MrHZn4rN5CGUQ1JZIug94TjNwKTTgWH1/A6KLCQuo
         /sMhaNXNnaqqBBcOfmbsXCp1cxC0/brW5eJ1Epq1EC7WpRk1NYZNlfDvKlH8COL469B3
         EQM0UXz9yJJrA1Ijf7RnDVa+ZE+xlXTMs/sHNf2QBRh8/vbyhAgs0TYKEfF8mEa9Vyau
         B5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQU/ov85GWTS9XlKxMiC6QzFxE2H5RxX/WsCFW4YMsg=;
        b=55cDlughkeiivbAedhzPtLI/L25InzIkUARDe5F6DjCwQWVpaRjwwo7S0A6TLo2jb3
         kzdxYoD5y8x9giBv36xRf5bBB10THar7kDgDYikYKQkUhpOYtKqxl5FQS+3Mo11HNep/
         q32F8qMEBzrGsyfZimYgXoZiBUDhSS+4QrQuQFDM2elpfb0nPc9mqPZSs6CoDw2NmJaD
         +riGfKqQp4cpW3uzRc3rH2nhmA3Na1nLitTLTceGr/NnzLrcwC0k1d578kzi3hHflbPI
         JgSuB90jk0HEScYJTG8vls4+MqxadJOHEXDMAczCMY22rliLRS5jwGFcKoUNOJgbcHgM
         XdPA==
X-Gm-Message-State: AJIora/VmoH4Kv62ht///k5LDGs7EmE/QPMk5Kg6GgqNUn0APdfRHXqA
	l4KLu/xyKj4cH3bytx2Nrd75HP5fRQuKXtXdsqEqF+fK
X-Google-Smtp-Source: AGRyM1sMcl1tiXiiCTYMc+JAXb7wmWLM+d/TLj9UrH4tyHC5z4rg5Euht2sc4tURHA3bmrvUOVFxHT7xhTOg3U/xLn4=
X-Received: by 2002:a05:6808:103:b0:334:f9b1:ede2 with SMTP id
 b3-20020a056808010300b00334f9b1ede2mr962006oie.54.1655879089974; Tue, 21 Jun
 2022 23:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAA=hcWTmGCSQFEMABzUU742ZE-2LJNR38+B55Kzr3HrLjcOO-g@mail.gmail.com>
 <CAG17S_P6OaYseePAe_f9TZa6Q-DcC+T-Tmk9QSRsA8DOqPYgOg@mail.gmail.com> <CAA=hcWSj5TFgisTA8qM=y+C7-ckEMSHXYprgAU2KkDkPsU8qMg@mail.gmail.com>
In-Reply-To: <CAA=hcWSj5TFgisTA8qM=y+C7-ckEMSHXYprgAU2KkDkPsU8qMg@mail.gmail.com>
From: Jupiter <jupiter.hce@gmail.com>
Date: Wed, 22 Jun 2022 16:24:13 +1000
Message-ID: <CAA=hcWQbsLZQASJ-F3DeM2CxZBTtd-q2WExCUKEcP5FLnmbHbA@mail.gmail.com>
Subject: Re: iwd + connman
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, iwd <iwd@lists.01.org>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Any comments about the connman working with iwd to support
EnableNetworkConfiguration=false configuration?

Let me clarify it again:

I can run connman version 1.41 with wpa_supplicant to switch between
WiFi and 4G LTE interfaces where WiFi is set to high priority, so
connman is configured well and works fine when wpa_supplicant was
used.

After replacing wpa_supplicant by iwd, connman could not detect WiFi
connection any more, you and Denis both confirmed that using
EnableNetworkConfiguration=false should let connman to take over dhcpc
and to manage WiFi connection, what could I be missing?

Is it true that someone told me for wifi connection, it does not need
connman, running iwd alone should be fine? If so, what is the
advantage to running both connman and iwd for WiFi connection?

BTW, thanks Keith for your configuration, but you are using
UseDefaultInterface=true, it is the iwd managing the wifi connection
not the connman.

Thank you very much.

Kind regards,

Jupiter

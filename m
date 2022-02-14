Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A317C
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 11:31:15 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id g20so6182027vsb.9
        for <connman@lists.linux.dev>; Mon, 14 Feb 2022 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zVBfOak9pmLt7GKAempUcZ0kd2YyZPGkEZJ1du6Y4M=;
        b=MtOkMSYaXLVYZZnmo9o01x15nCvvpbtugmR03Zg6tGII3A18Xul3BS7EYh1eJ4jE6F
         zFzBH4B0AJVedpE+vJuAVYlITDIoYnSVgmQouRR5ej3+9z52YYVOMmg8ut4oLw5RgLuy
         +t6ZZ5XmlXq7Db6o3PsilN1lIjP6aTynV0ZXCioOfoctZ8urKEOW15PghL2SWVS+MqV8
         hwiqrXW+8ypZ73LNFa0k8YokAxDANXfH36tz37O2EjZ5xlQYtifv0rJsDcSbFIrzp1q1
         l1OAHvstrG/GDDe5qCmoPWJXQeuDRBzOwuCfzIY/DmFehIrfpgBWBVl6KoHXQwGCG4w5
         PUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zVBfOak9pmLt7GKAempUcZ0kd2YyZPGkEZJ1du6Y4M=;
        b=jqS+NWsq1OyqZtYtPjKfYlba21xd9bkSMpUAVVajcddIvksqqNgBEOpNiDMOJ220Pl
         X2Aztn7rLdsKissngjxo6r5uygxaJD8SX6GwNDKPVF0SwGCruZEWTCPrtqnCpLqOHPQy
         pJKv0ZhajlV6qklxngPvm8+ZYuZzVbJpgQdJ7uXcOklumYIKdK/8UYsKmklrLVtpt4Bl
         2l1NBeaQ0uxvLJBCpDynVQ0uR1zT/V6qPKRsZUiQ3qOeggtflT5KZZ3el5H7k55UPz0x
         fHB3na5WlxFDeE8XagIioZsDejFNR7nD/wd8l0g+qXL5Mmt7+PCWaM0ujrCVXuQgFrSA
         Zs6Q==
X-Gm-Message-State: AOAM533NpF2dA3g3AXSDPAR1ppNGzDbAe1eZXmqlWi06BHckx1nENxgV
	mFbabpeBfLb2pKmES8kPCAX/Nq3pWrW9YzOYC4nuGGLW5c4t1A==
X-Google-Smtp-Source: ABdhPJx9BRhjZaEVoMG4/5OGwAZy3alCBeZL3L28Xi9CiXeeiTlH0jiSsDAm3JleYhVX8h8uaXlOfkS+dVJFeYKEAqI=
X-Received: by 2002:a05:6102:418c:: with SMTP id cd12mr4150639vsb.83.1644838274331;
 Mon, 14 Feb 2022 03:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220214021357.522946-1-net147@gmail.com> <20220214073654.5wwvht6ntswylci5@carbon.lan>
In-Reply-To: <20220214073654.5wwvht6ntswylci5@carbon.lan>
From: Jonathan Liu <net147@gmail.com>
Date: Mon, 14 Feb 2022 22:31:03 +1100
Message-ID: <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
Subject: Re: [PATCH] iwd: Use same signal strength calculation as wpa_supplicant
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

It is the same mapping of dBm to 0-100 range as
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wifi.c#n2805
For wpa_supplicant,
g_supplicant_network_get_signal(supplicant_network) returns the dBm
value.
For iwd, you need to divide the number by 100 to get dBm value.

Regards,
Jonathan

On Mon, 14 Feb 2022 at 18:36, Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Jonathan,
>
> On Mon, Feb 14, 2022 at 01:13:57PM +1100, Jonathan Liu wrote:
> > Fixes the signal strength reported by connman being lower when using iwd
> > compared to wpa_supplicant.
> > ---
> >  plugins/iwd.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/plugins/iwd.c b/plugins/iwd.c
> > index ac3d1e17..2a245fe2 100644
> > --- a/plugins/iwd.c
> > +++ b/plugins/iwd.c
> > @@ -1128,7 +1128,9 @@ static unsigned char calculate_strength(int strength)
> >        * ConnMan expects it in the range from 100 (strongest) to 0
> >        * (weakest).
> >        */
> > -     res = (unsigned char)((strength + 10000) / 100);
> > +     res = (unsigned char)(120 + strength / 100);
> > +     if (res > 100)
> > +             res = 100;
>
> Can you explain your math here? The original code maps the reported
> signal strength linearly to the ConnMan's range.
>
> Daniel
>

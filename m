Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E74C8A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 21:41:48 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id g20so8285015vsb.9
        for <connman@lists.linux.dev>; Mon, 14 Feb 2022 13:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tELz8cHbbDY5RhC0X939jJMYLf6pD4vQ0bdYjzAltGw=;
        b=bkdd+NhaiuZdr9WTeFcftsA4yRReVhZGPSPzp6dimwM1u5bLdVF3HVl/PYvWgKKpRA
         Z4ROHN5bWro21cm2nHG1jCKqbcfNyjQVnAn/dUnioPHNaR5PIFPXg0eiDqTfQpQCE4mN
         PHOSfp/pg4OGd0PNldqpz47YBE8TzzIxK7K73skD9mEqv629196kvXWOSyXgbw1fB+s9
         bGvabQghlVsLCMCn2Qc7ke4ZbgWc5fbTeNugj0IN0kLtNrb+hYi+wyv0n4ipltXAerq2
         ZfnyP5y/QflV76MfdnSLrBoRLdlHH8fixpyiUqOpm+BwF+ObaX6apuPEDbTFRqtsoB+9
         8sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tELz8cHbbDY5RhC0X939jJMYLf6pD4vQ0bdYjzAltGw=;
        b=cH56oWIqUo+tMICORuA/XR1ccGTqu1CrH/xzzDU42zja2zgf9s51jPkmkJZDrBXsvw
         O4MDjNXDh58bZHw736Grnjapb1815peVcbsYGFAXc6KK3tHesCw1xsAvqe40qvIGj8hM
         UnNKOK17Ui36kE+r6FgT+Xva3InyE2ILrgOIUbH44JXBWjEg+MBWt/gUD5ZFYeo4Dc6G
         sQAXoIU7GsH+VwAni1UAsc091QtZso9DTOP0mLtuk38hNs0QihavnilomxVz1JtvF9SX
         mIx3ZFqhjGfiI70UGI42uVVRB8NRi7EFIA0Ds/ag+pkfCDmhY+UsR7jqgDTe2OAqEjMo
         xunQ==
X-Gm-Message-State: AOAM531MXSyYxeqZlgbu9PfhUW8wmyvnz0GHIuqXsOFtTE0/n0YGtGUM
	Zsirq+qosk4SpUnnxm5H5rp4IyTWtjkUMIxAKA8wwYWRc2g=
X-Google-Smtp-Source: ABdhPJzxQQd7wA1yo0QWWomBXCwiBYNEJIq1kbThPNPHWvWVtVRqtv7KyCfBl2OOGLLZNIbaCMSSJhzfi2ij3nxoi+o=
X-Received: by 2002:a05:6102:e06:: with SMTP id o6mr332129vst.72.1644874906998;
 Mon, 14 Feb 2022 13:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220214021357.522946-1-net147@gmail.com> <20220214073654.5wwvht6ntswylci5@carbon.lan>
 <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com> <20220214152329.g27nz7ennzsj5ked@carbon.lan>
In-Reply-To: <20220214152329.g27nz7ennzsj5ked@carbon.lan>
From: Jonathan Liu <net147@gmail.com>
Date: Tue, 15 Feb 2022 08:41:35 +1100
Message-ID: <CANwerB1uBPi4fXfECCwxuAgDsPQHfBW8=aXbwqbmUQNicothOw@mail.gmail.com>
Subject: Re: [PATCH] iwd: Use same signal strength calculation as wpa_supplicant
To: Daniel Wagner <wagi@monom.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel and Marcel,

On Tue, 15 Feb 2022 at 02:23, Daniel Wagner <wagi@monom.org> wrote:
>
> On Mon, Feb 14, 2022 at 10:31:03PM +1100, Jonathan Liu wrote:
> > It is the same mapping of dBm to 0-100 range as
> > https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wifi.c#n2805
> > For wpa_supplicant,
> > g_supplicant_network_get_signal(supplicant_network) returns the dBm
> > value.
> > For iwd, you need to divide the number by 100 to get dBm value.
>
> Please add this information to the commit message.

Can we first reach a consensus about whether to
1. Change the iwd signal calculation to match wpa_supplicant
2. Change the wpa_supplicant signal calculation to match iwd
3. Do nothing to either plugin to avoid changing behavior of existing
devices/applications or Linux distributions using connman

If we change the wpa_supplicant calculation then I imagine people
would complain about reduced signal strength after updating (e.g. in
OSMC and many other devices/applications or Linux distributions using
connman).

The wpa_supplicant calculation regards a signal level of -20 dBm or
higher as 100%.
The iwd calculation regards a signal level of -20 dBm as 80% and 0 dBm as 100%.

Thanks.

Regards,
Jonathan

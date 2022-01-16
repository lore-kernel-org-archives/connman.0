Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4C173
	for <connman@lists.linux.dev>; Sun, 16 Jan 2022 08:43:15 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id c3so17155350pls.5
        for <connman@lists.linux.dev>; Sun, 16 Jan 2022 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lp1aPFgrKVpitHF85oY/WXIGh/20cgz67lCfPNL0mZQ=;
        b=ipoFuzx0RvDVFYIGDXeWtTOnDiluWAmt93WENAHnBQr/F3YUByahEYxEcGgiAizhs4
         wxPEnccf7CSUltyfn57SHcEKzRRczKzXBGYefnPtJxU1UdyAoDAAxkWCNMKsvlV/EOZY
         pyXIfgwVxpbFmvvGu6GmfeqffUZZ5htNPUCds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lp1aPFgrKVpitHF85oY/WXIGh/20cgz67lCfPNL0mZQ=;
        b=gP9W0VmNxMZikdg+donf0wfy6ZC8xOSOkQOAKB11ND6PEdpxGtWQInzPNbvGmM5oDP
         YROVpGPUo6JD+dxkoIE0vgA+IF7LJqvxJq0UuIiRT7tbEDB7TzHGxbBuQvEPDlBDyWbc
         dor3dJ9D5wjs+6zw7KPGDmDAMCkGNu86EW901oc5iF6GrJD2lOFeU3LDf9EMPtTxDIZ5
         +94MduX1t8Ja5/srN7jlg3sesMUoN7IJ3IbQNyV+ShlZMykaQwYIZNzK8pSw+qXK6aOB
         WuXZSzjqRxKY5Vs/uVbcqfCog5S3M9v5Ie8FVykfe83RZB5i5I3ZDipZP5a27JODCp0T
         a/rA==
X-Gm-Message-State: AOAM533woRAYC56UxxVlhk0v1yOK7gBwIr899pIdguyVKoyE+1fNEBBu
	nO9TMZqY6W1mJhTJ6ywm2Uk2kD1gEFlOcm/HiNAZDBHcGfjx5g==
X-Google-Smtp-Source: ABdhPJx2fmCxJ9fxjXMhlzZ+V9Ck/xZ+g7+3KnDkFgMEhL10u2MAJgh+jCRLt6ux4dOV9nNm/xO/fzQEaMGv6h2jIWU=
X-Received: by 2002:a17:90a:630c:: with SMTP id e12mr19326837pjj.59.1642322594701;
 Sun, 16 Jan 2022 00:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org> <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
 <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com>
 <03304641-cc5c-4150-277e-3ac77732f9f1@monom.org> <CAOf5uwn3TyX_mKLRmSy1Hk98esi-AbKV9rqjo3-oh0-hngKAHg@mail.gmail.com>
 <8AF20224-E145-48EE-9484-D1527448A3CA@holtmann.org>
In-Reply-To: <8AF20224-E145-48EE-9484-D1527448A3CA@holtmann.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 16 Jan 2022 09:43:03 +0100
Message-ID: <CAOf5uwkrmCystgz9E4327HAdYvF7UMJNW4_oEdPxe4iFZeLStw@mail.gmail.com>
Subject: Re: Network with same ssid question
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daniel Wagner <wagi@monom.org>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On Sun, Jan 16, 2022 at 9:29 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Michael,
>
> >>> suppose you have 3 access point with different signal strength on a
> >>> network, the best will be connman select access point in the area
> >>
> >> This selection is done by the wpa_supplicant/iwd, not by ConnMan.
> >
> > the wpa_supplicatan using wpa_cli show all the network so connman
> > can create several services with the same ssid name. The logic to what
> > service to connect is can not be done even in connman
>
> actually iwd does select the best possible AP and will also roam between =
them in case one AP tells iwd that a different AP is preferable or even if =
it gets asks to move bands. That is all done inside iwd. It is impossible t=
o do sitting on top of wpa_supplicant.
>
This depends on the tsf of the latest scan and how cache is managed
and on hardware too.

> Keep in mind that one physical AP broadcasting on 2.4 GHz and 5 GHz is al=
ready two BSSIDs with the same SSID. The client (like iwd) has to roam betw=
een the two bands.
>

That was already clear but this is a different use case because you
know that both are part of the same access point.

> >>>>> IIRC, ConnMan merges those together and only exposes it one Service=
.
> >>>>
> >>>> is_duplicated the one that merges them? I think that in scenario whe=
n
> >>>> multiple access point
> >>>> are present we should not do it. I have seen that even iwd does not
> >>>> show duplicated. Is that correct?
> >>
> >> wpa_supplicant or iwd? I can't remember the wpa_supplicant details her=
e.
> >> For iwd, all these stuff is done in iwd. Not ConnMan.
> >
> > I have tested iwctl and wpa_cli. The first one show only one ssid the s=
econd one
> > all the access point. iw scan show all of them
>
> The wpa_cli shows BSSIDs and so does iw. You see every single BSSID broad=
casting. iwd works on networks. Every BSSID with the same SSID and matching=
 security settings gets merged into a network. As it is meant to be done by=
 the WiFi spec.
>

Ok, now it's clear. So iwd re-use the same password. Do you know if
wpa_supplicant does the same?

Michael

> Regards
>
> Marcel
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

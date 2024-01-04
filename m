Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B828E02
	for <connman@lists.linux.dev>; Thu,  4 Jan 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="hizOzWk5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-427f5cc49afso4006891cf.2
        for <connman@lists.linux.dev>; Thu, 04 Jan 2024 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704392154; x=1704996954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEg40idPZkPCbvs+9rljkh/1hISFpbpFmQBgGuH+8kc=;
        b=hizOzWk56s1w+vCV8FNhpMhVJILYOPJaGu9UNmSrcufgPDavW5zWpTJifkpcPlugw6
         XF3YCFLjtGpu/DTtFYH2mbCsx/VTiLjxYamSBnJ3PDxaTTXjFI1Lq+IorTNGWDThEn8p
         kBz5LcZuDhPdia9W+b+UGHyA1oxGNE7sbAK1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392154; x=1704996954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEg40idPZkPCbvs+9rljkh/1hISFpbpFmQBgGuH+8kc=;
        b=eQ8u8nyyhHg45geBOEy3Ty3SLqet6nRWZBhWicrXelxPahfWisBSlvO/sDIpFITVIu
         1SsZpvnWsWKnbRxutqdCAm1T9UKZgYWLSCSrplOTzOtFsfINKXA2q2fopISxVxXGVvEH
         x1F1sbSGAVftZ5Woa/+GhmMIfq5ZsygbHsx0Ddk8yC3zlFOHE8S3ah7rpbMZ/fPHrBaV
         KJBbp9qF+f2I5bvGAY6GsaxuJSpqVzoKDaPzCUIWHGciyY7nQKlf5/MOtCG7T2NXe8Nq
         FGmn/j1f2y0NybATDxeIxuNTnDyso7DQw/jQNi6w4ukF6KrnJoc1Ls0/8kMH+4zQnGGK
         Fovw==
X-Gm-Message-State: AOJu0YyqI9nUtvMOf0gOxatUVCqhFua0JLM9aaRc3VFzgo647FHnOdhC
	eh/VDpSi90Pq0lCPzsiQMySddjteujRzeSU0ttitnNIyr+4E0jw/3RVXiTck
X-Google-Smtp-Source: AGHT+IHNwFVa6h7oJHXOi4hjZhf1019iM2zMWL+xB5BgdU+yOMIvYgDCupM7YcZwFSDCk5Bc88KdtK17LKtQJkKj5x8=
X-Received: by 2002:a05:622a:b:b0:427:9036:425f with SMTP id
 x11-20020a05622a000b00b004279036425fmr1050554qtw.11.1704392154707; Thu, 04
 Jan 2024 10:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com>
 <47B181A7-0A76-45D8-8E0B-3183A4177FB9@nuovations.com> <5F5F2F14-2D51-46E1-9D2C-50FA16749271@holtmann.org>
In-Reply-To: <5F5F2F14-2D51-46E1-9D2C-50FA16749271@holtmann.org>
From: =?UTF-8?Q?Ant=C3=B3nio_Oliveira?= <antonio.oliveira@konsulko.com>
Date: Thu, 4 Jan 2024 18:15:43 +0000
Message-ID: <CAB0iYDYTB22J0rQZ0eAbiyqCi0xXNsc0ER+qhSSAaZEzOKA_7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add option to omit DHCP Client Identifier
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 22:18, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Grant,
>
> >> While recently working a customer project, I ran into an issue after
> >> upgrading the OS to a newer version which uses connman for network
> >> management.
> >>
> >> The DHCP client in the old OS didn't include option 61 (Client
> >> Identifier) but connman does. In this scenario, when the system
> >> reboots after an upgrade, it changes IP address, which can get very
> >> confusing, especially if a UI is waiting for the device to come back
> >> alive to signal completion of the update.
> >>
> >> This proposed change adds an option to main.conf - OmitClientIdentifie=
r,
> >> which, if set to true causes that option to not be added to DHCP
> >> packets.
> >>
> >> The default behaviour is retained in case no option is set in main.con=
f.
> >>
> >> The change is relatively small, and I'm posting it here in case it is
> >> helpful for connman users facing the same issue.
> >>
> >> Please feel free to consider or exclude it. If there's anything that I
> >> can do to improve it to match upstream requirements, please let me kno=
w
> >> and I'll do what I can to help.
> >
> > Ant=C3=B3nio,
> >
> > It=E2=80=99s slightly different than the client identifier; however, di=
d you experiment with the existing AllowHostnameUpdates configuration optio=
n?
> >
> > Also, connman should request the last-issued DHCP address to the DHCP s=
erver. Assuming another client hasn=E2=80=99t reserved it first, the client=
 should get a semi-stable IP address. Did you chase that down as well?
> >
> > Finally, if the DHCP server is configured to serve a different IPv4 add=
ress for the specified client ID rather than the one the client has, might =
this be better addressed at the DHCP server? Though, I can see that you mig=
ht not have access to the server.
>
> I think that Denis already mentioned this. We need to kill the ConnMan DH=
CP client in favor of the one from ELL.

Sorry, a combination of holiday season and spam filter made me miss
this message.
If this is a pointless change given the short term plans for connman,
that's fine, sure.

FWIW, it'd be nice to consider some option to not fill the Client
Identifier in DHCP packets in the future. It seems legitimate to
upgrade a system that didn't use that option to a new version running
connman, and the likelyhood of it changing IP in the process is high.

Cheers,
Ant=C3=B3nio


>
> Regards
>
> Marcel
>

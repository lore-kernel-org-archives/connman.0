Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC72482C2
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="RSseHSYw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42782692142so10915691cf.3
        for <connman@lists.linux.dev>; Wed, 20 Dec 2023 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703096408; x=1703701208; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h++Cq+RAj2v9ftkx8n93teZhNZ7uxgYdq2nNWVsl5KA=;
        b=RSseHSYw754SXwf+Zbq4AbWDRgpLhjZF1TIxuwdLoApUJaroRplVz2X0J/LA0DaByy
         Cd0VnYbBwWNHovTXLZV1WTgUPdrPHs8H120QX0XjrH4i7ZYIxrHtpSOWSg7xqofCt38J
         nmuBdQgbsRAt8ym3gQlSVtPMj642vbCkf7iTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703096408; x=1703701208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h++Cq+RAj2v9ftkx8n93teZhNZ7uxgYdq2nNWVsl5KA=;
        b=J8mm6xlLIJUWTC2PoXh+zuHKUHbqlaqIF2ch/DQHlxBv6QlWs5GSNV0hQ13tJqrv1T
         DL22Ou9O/92o2EHeZlh6/st+pJs3x72VSNbLfkqxiM7SqYdmeY1pS3mKZQYWwsxthb/n
         6e9pS4Qh2tosdMlfqHJ562rwaeFyU070uiclIPyev0459ihoZIyEXdWUyucsviZxS0l7
         u0y6RYDn3dsAcuJ12oGIGbOAAQvSoFvK3SaU5WqP/uI67mOvEgami46fKB10g4BVX3YZ
         U6JHwG3/KgVJZqtcEaynO74yiv9zTqKs8zDl9SJcKXbVNVYz8hfYsQNTrOCTwuh7oCM9
         fbPQ==
X-Gm-Message-State: AOJu0Yx31TJ+jeFnejXKBDx+q7w2/Hj480OC6zuLcsPXG1dHE/0KCYO9
	bm5AX2kvOvp3wsK5qTxi4Pgiy1EqTGzQIzoc62u6NVW1x9LuBlRVxD0=
X-Google-Smtp-Source: AGHT+IFr5leoD/61/qugcQaABWKH5MkYdxvU/gTJRN+CR2/G+iEtgByQqMUInWrqB9Y4XrNPr8ip+oEFs2mkU6ol0PI=
X-Received: by 2002:ac8:5e48:0:b0:425:a374:83b4 with SMTP id
 i8-20020ac85e48000000b00425a37483b4mr29220833qtx.136.1703096407932; Wed, 20
 Dec 2023 10:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220154248.91773-1-antonio.oliveira@konsulko.com> <28688EAC-F7EA-4130-847F-E34C8AFBFED2@nuovations.com>
In-Reply-To: <28688EAC-F7EA-4130-847F-E34C8AFBFED2@nuovations.com>
From: =?UTF-8?Q?Ant=C3=B3nio_Oliveira?= <antonio.oliveira@konsulko.com>
Date: Wed, 20 Dec 2023 18:19:56 +0000
Message-ID: <CAB0iYDbBkSN-_J6pMPy-kmL0eswSedpM=bvfbF1wv2w-8++EHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add option to omit DHCP Client Identifier
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, 20 Dec 2023 at 16:19, Grant Erickson <gerickson@nuovations.com> wro=
te:
>
> On Dec 20, 2023, at 7:42 AM, Ant=C3=B3nio Oliveira <antonio.oliveira@kons=
ulko.com> wrote:
>
> While recently working a customer project, I ran into an issue after
> upgrading the OS to a newer version which uses connman for network
> management.
>
> The DHCP client in the old OS didn't include option 61 (Client
> Identifier) but connman does. In this scenario, when the system
> reboots after an upgrade, it changes IP address, which can get very
> confusing, especially if a UI is waiting for the device to come back
> alive to signal completion of the update.
>
> This proposed change adds an option to main.conf - OmitClientIdentifier,
> which, if set to true causes that option to not be added to DHCP
> packets.
>
> The default behaviour is retained in case no option is set in main.conf.
>
> The change is relatively small, and I'm posting it here in case it is
> helpful for connman users facing the same issue.
>
> Please feel free to consider or exclude it. If there's anything that I
> can do to improve it to match upstream requirements, please let me know
> and I'll do what I can to help.
>
>
> Antonio,
>
> It=E2=80=99s slightly different than the client identifier; however, did =
you experiment with the existing AllowHostnameUpdates configuration option?

We have it set to false. I'm not sure of how it'd help, though.

>
> Also, connman should request the last-issued DHCP address to the DHCP ser=
ver. Assuming another client hasn=E2=80=99t reserved it first, the client s=
hould get a semi-stable IP address. Did you chase that down as well?

Well, this is a full rootfs update so, sadly, the previous state is lost.
Also please note that in the old image it's not connman handling the
network so any previous state wouldn't be available anyway.

>
> Finally, if the DHCP server is configured to serve a different IPv4 addre=
ss for the specified client ID rather than the one the client has, might th=
is be better addressed at the DHCP server? Though, I can see that you might=
 not have access to the server.

In virtually all networks we connect these devices to, the IP address
change is triggered. This can go from my ISP's home gateway to a
server in the office's test network.

 From RFC2132  https://datatracker.ietf.org/doc/html/rfc2132#section-9.14:

=C2=AB DHCP servers use this value to index their database of address
bindings. This value is expected to be unique for all clients in an
administrative domain.=C2=BB

So the change of IP address seems pretty much correct from the
server's point of view.

This isn't also any kind of problem on connman's side. The inclusion
of Client Identifier in DHCP packets seems correct. My only goal here
is to create some ability to exclude that option in case it helps a
particular use case, while retaining the default.

Cheers,
Ant=C3=B3nio

>
> Best,
>
> Grant
>
> --
> Principal
> Nuovations
>
> gerickson@nuovations.com
> http://www.nuovations.com/
>

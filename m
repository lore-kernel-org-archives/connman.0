Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C322258C
	for <connman@lists.linux.dev>; Tue,  9 Sep 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443125; cv=none; b=SLPT1Jl/dNZbSAXEv4U0MW1nnHKro2cUzAO9bTto2wGbDuC8P0diIHssRxoNKLxmvXfpMYA+qkHjzXh1LCtv133qlz0+L1b7QyBQTjXU/JDPedae1PSkz2KhuQLBmF/iJEkRNFkrkcQLYYnQD3GlfY44B06NzFqL+nX4ir7FM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443125; c=relaxed/simple;
	bh=pKLQScbjfIfcK+hOPY6dNoH6KHoY77OVSpiVIC1lCfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRLnILlSAH5AdgtqrqKEbvIyGI/qj1ESRrNExwMnvMeiqRdzjHuvgQh1FvyVUGLEoJcTAwILW1y+GNyM8YlYNf5LzGY4zPDlBMOXo3+5R/AfTHtof6QxrAy2FwfwVe8FEwb9FHhfZP3RgqecCv3fPWHGcrr+HcB8SbXU/bS8vEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b=dSdkc1Sk; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b="dSdkc1Sk"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea1679ba47eso1902871276.1
        for <connman@lists.linux.dev>; Tue, 09 Sep 2025 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20230601.gappssmtp.com; s=20230601; t=1757443123; x=1758047923; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKLQScbjfIfcK+hOPY6dNoH6KHoY77OVSpiVIC1lCfQ=;
        b=dSdkc1SkgaAiWT4Ghzz1g6qmJx+R7VY+IrWFinh2+dEXpNjHSbSXVkI6mAUjetOICF
         zKtTKvw6IzgMTLIVJ9ge+6K1QtGLGLrnSIUylsz1oF2obkYC4Pju4RM0YrrzUbifRTK4
         DmZG/kC5m3xAje9lwhuMzDlYWB07yUgVwHIcusX3yn5pif4WbT8dfVUp7sY5I/gb2Pmi
         JNjCFKDb2XgjdBHhYJt8QobPqMwY2v2t68t+7VT7jDtKKuuu18PPkgtSgOxNOiqb+pZt
         GWkjasymGA97+vdALHQIUiRNqwhMDgF4ZI9/irNzAUDJqLQU7gaKAnhySvDoIeq7Ma2d
         ijlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443123; x=1758047923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKLQScbjfIfcK+hOPY6dNoH6KHoY77OVSpiVIC1lCfQ=;
        b=qhSFY/YKXmzufz/0e/00EY3vfChg3lLd0rdKmFBA82vQ4OWWj7r21CU7+NDyhtAo/p
         IByKJtGn5vYQZquyxL0ShpFgvF209IBUE7i2A/2aZCcfV+wO+v8lj98xwGWDVfrun+ic
         9n9blXY6croKPtqEr1iwwJRohivM1F9WjfY+SXbEZhYIMAYzaRsOul7vKLzzCkDwoudB
         fOI17MaTqXmvqW3MVDMH9vRhwu0MQPRcdueLu8x2v2wFZV0xG5lY9AZr7cZkCI1sCCdw
         NeqYFDC/+42bGEgtHGA+meDSNpa7M0M6wwHbXfNJW1U3mUY2hpoFx/ZRoUiXUMe2Szqd
         LOOg==
X-Gm-Message-State: AOJu0YwGc2orKJ+J+90PpP+xEcHBaFd6rFB9iYeLNNua45lQFikPjOHp
	w3vfNneHYTotdlWC9duAx/sjwG7b74fxWrpQR5pUpUpkZqwlUG7LYAcWzW9VzS6aYh0RtWfchnG
	1EWmLII4dcT8G9HmBI29JNDmBFo1HuPutgFeoxy9cf+KtGwt/gVbSNhk=
X-Gm-Gg: ASbGnctsUbGvczjafUuFR5rjPM7rEkMZr+QkSXQ0E6CAGSOUa/R4qPILZJnPPcDRDVZ
	8Q0IgsAp1yuFiC0bCN8+fJ7rTVxsSA4o52fITnB4u7hAV8r7pLwM+H+NJrhf1QuSzNyF129TOio
	HaBcjFkAuG9zgs1EQchK9sSyIFZEUvzTgMnsNf66bR1tEmXAUTkeiGYEGmpYFydU+ruOPMTeodk
	5keMRVqvExqtFXX3pjECwWpsrPKQmfLi0Yruao=
X-Google-Smtp-Source: AGHT+IEqCgvFDUN0nqvnalvj7EsUA3FVRjZQ03MF9c/mKo5Db/yU8Ii36YR/8meT9SrBvgHKpvMT69lDlqZ8TXyJJ8w=
X-Received: by 2002:a05:6902:6209:b0:e98:95f6:5ec5 with SMTP id
 3f1490d57ef6-e9f687aa4f9mr10790825276.47.1757443122535; Tue, 09 Sep 2025
 11:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKQ2e6X9BVihgY58OjzwbaqNn5HVHqHDCirsO2+qCBro91sygg@mail.gmail.com>
 <678A927C-57A0-4765-B4EC-F3E1759ED553@nuovations.com>
In-Reply-To: <678A927C-57A0-4765-B4EC-F3E1759ED553@nuovations.com>
From: Johannes Emerich <johannes@dividat.com>
Date: Tue, 9 Sep 2025 20:38:30 +0200
X-Gm-Features: Ac12FXzGpsk4KSkhVq-U5AhKbpTsenx8dmZTVBVgITF0Jz-IeA3zVwB6_1md91A
Message-ID: <CAKQ2e6VrjdfxKUy89aPEL10PUOiTnMeOMDtJofXdOn6B1g-O0w@mail.gmail.com>
Subject: Re: Demoting IPv4 link-local services in service list sorting
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Grant,

thanks for sharing your insights!

On Mon, 8 Sept 2025 at 18:17, Grant Erickson <gerickson@nuovations.com> wro=
te:

> That said, there remains the question, =E2=80=9CThis could be done, but s=
hould it?=E2=80=9D.

This is a good question. We understand that service_compare() is already
complicated and can only factor in a limited number of criteria, so
added criteria really do need to provide value.

We initially aimed to do just what you hint at, patching up ConnMan's
sorting by applying application-level rules via D-Bus. But we then
started to wonder whether these should really be application-level
concerns.

> > As far as I can see, two changes would be required:
> > 1. Adding a condition to service_compare(), something like this:
>
> Seems reasonable. That would just need to be adjusted spatially in servic=
e_compare so it is appropriately prioritized relative to other =E2=80=9Crea=
dy=E2=80=9D state predicates.

Yes. I have placed it after the `state_a !=3D state_b` block, the
online-check-failure and preferred technologies criteria (among others)
would be applied earlier. The limitation to READY services could also be
made more explicit, in case code is moved around later.

> > In most cases ConnMan
> > reliably uses the Internet-bound network as the default service, but if
> > the network is slow to respond to DHCP requests for some reason, both
> > Ethernet services end up with link-local addresses initially. In this
> > case, ConnMan may choose the local-only connection as default service
> > and stick with that choice even when the other service receives a good
> > IP and gateway via DHCP later.
>
>
> The either one-shot or continuous online reachability check should handle=
 this case. The check will always fail for your LLA interface and it will s=
tay in =E2=80=9Cready". When reachability is there, the other interface wil=
l transition from =E2=80=9Cready=E2=80=9D to =E2=80=9Conline=E2=80=9D when =
the reachability check succeeds and the priority issue should be resolved.

According to my understanding one-shot mode does not handle this case
(though we initially thought it would). The check will fail for the LLA
service and it will stay in READY. But this does not cause the service
to be demoted in one-shot mode and so it may remain default service. The
other, good service never gets the chance to run an online check and
"prove" itself to be ONLINE. (As mentioned in original email, the
service remains in READY as it transitions bottom-up from AUTO to DHCP
mode, so there is no state change.)

We ran practical tests to confirm that in the described scenario the LLA
service remains default service even with one-shot online checking
enabled.

This means that in the current default configuration, ConnMan is less
robust in operating dual Ethernet than it could be, and may get stuck in
what is very obviously a dead-end. We observed that no default route is
even installed when ConnMan chooses an LLA service as default.

> > Continuous online checks are not currently a good fit for us and should=
 not be required as it is known a
> > priori that link-local services are not useful as default services.
>
> Why is this the case? The mechanism is doing exactly what it should be do=
ing which is to answer the question, dynamically, =E2=80=9CCan this network=
 interface and the network service associated with it reach the Internet?=
=E2=80=9D. If the answer is =E2=80=9Cno=E2=80=9D, it stays in =E2=80=9Cread=
y=E2=80=9D. If the answer is =E2=80=9Cyes=E2=80=9D, it gets promoted to =E2=
=80=9Conline=E2=80=9D (subject to other configuration and conditions).

Yes, we have confirmed that the continuous online check successfully
recovers from accidental use of the LLA service as default service.

The issue for us is that ConnMan's online checks make specific, hard to
meet assumptions about the probe host. Our systems frequently run in
networks with firewall restrictions, and each additional host to
whitelist is a possible source of failure and friction. We could
configure ConnMan to use an HTTPS check URL on our application host, but
the online check does a case-sensitive string comparison when checking
for the marker header X-ConnMan-Status. (As far as we understand RFC
9112, it should be case insensitive.) This means we would need to
decorate an application server with a ConnMan specific response, and
also have to ensure that our servers preserve the capitalization of the
header field that ConnMan checks for.

Also, if we were to use the online check to demote LLA services, we
would need to balance quick detection of this scenario with low chance
of false positives on regular network services (tuning timing and
failure threshold parameters).

If we compare this with the heuristic to demote link-local services, it
seems generally applicable, leads to immediate resolution without risk
of false positives and does not require us to configure our server
infrastructure in specific ways.

So the heuristic seems to make dual Ethernet (and other) scenarios more
robust out of the box, while being compatible with all online check
modes (none/one-shot/continuous).

Thanks and best regards,
Johannes

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794840112;
	b=S9dUrlv3ViJgfohnh6ov+dy3O/PNQ3+K6LafFnX/oHJEvv1Ghn2Brh09XT7mGqsW7KUZ
	 Ky7oGKCnUnFThfJhYGzETxifpmqolqxxYeYiMtE1HZPK4p4FG2aNtpwaa9DpQAuw6UuWH
	 FuzBXuoLUw+39uV7z2kbJl8hz73KwKKUTlUUuEwnYoU6rJ7W2ED4f6RtdPdLGkrRACn7s
	 mVYX04amI6/hyYZRRgmQVxfZCHNX2qIgWZiepjtTOHXoN175RlHDEhAhRnNG+kL+ywSYa
	 Ng3oUqzqCmqz6/Asy/hhNy1HDnJcVzE3YKa6xLBJMKmxHrt8/A6JxqjZJ3WHw5JriBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UYi4EV3VnNDxBPRFolBDXakboue8gCprn3/QTmk0jtE=;
	b=d78AR7DmCudRQfs3etcSvic8zG4O6P29QSMoHriCU4coXrmF40jt4OWVJ4FJVFT8MDMd
	 I24FRqWUsaI9RPmVJ/bLjTJbW/Xxi+bs/cu7Go6RdLOGZpgP3g14uqJgJalKfSKTezR4E
	 pbekZDOK+FulExDME128XR0Zkf/A8YTHbgKbBbfsB4j0JfjWYhlATvzogsi7/5SMrDKsv
	 f3Mmo7MfbsMGP7+LiA8U2ajBXD1MErqjcikbbc5OT9WNE0Ly15DFRAd7zqqU+lGmxXE7F
	 fd/GQ8+voq6ieD+SjQ1YMRAZFdCzxX89XGMk6QlNHhudzl2eb55iTQFDqCZd5bAfl7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dividat.com;
	spf=pass smtp.mailfrom=dividat.ch;
	dkim=pass header.d=dividat.com header.i=@dividat.com header.a=rsa-sha256 header.s=google header.b=S+yfKw3j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B2606A32A
	for <connman@lists.linux.dev>; Mon, 16 Nov 2026 14:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1B2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dividat.com header.i=@dividat.com header.a=rsa-sha256 header.s=google header.b=S+yfKw3j
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae22dcfdc3so31887911fa.1
        for <connman@lists.linux.dev>; Mon, 16 Nov 2026 06:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794840110; cv=none;
        d=google.com; s=arc-20260327;
        b=BpQMSD9pczKx5nanGIdWebpyRqlRv4Tccb/232McxTz5CfwnkB3IUYCC0JsEV0k8vp
         OUiKSdmO+m7UUbGGrPP7/xGDENQDvtgozSu4UZDSKMMeMDu+MtuOx/Pl5IEfipsY+C1m
         xUrpbnrJNYFA82l4uZVsiz90jqVZc4oRGrXeS/ighVe8RWyLjR3VLFvxgtZG8o9xLiEY
         OV58MOdk9Xa8wiilTw7Acj8PMTFlm2dSM3rEqf3ZWzB3DJgLMTrnPBxoQ1bxbkdxVm62
         K6GutjBEYB5o4YESJKSR2o0006B0lg5PuSl/DdNAOfCpIrtNmtPUBF8O8mJNRf4UvZuw
         xwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYi4EV3VnNDxBPRFolBDXakboue8gCprn3/QTmk0jtE=;
        fh=UhJKuTKeJTm92QYit7S2YIUtB6MnKRevgJnOzbq4HNo=;
        b=eFWYwJmpZ7MQobp7sUyqxtZInqsCGOEcBA2xhWWrgHOO4x56VbKuufiJKeY+FI6bhZ
         fNKVIXVZuCKkxCHK6XLYjH+7CR35WxkLExyDBgvmIICXB6wo71a/oJBb5gOuOEXHS9Kq
         mYfvnz3gNdu5JjAynicpnQuIaFKA+TX70bMjZ08+KXfUjPC+bpoiwuV4+RPnTePrDSJZ
         0j4XHClABtTsfoeTRRmp35tRLHihya5RT0Max8qA2op0+TmYmJVd8A54Nbp8W8YiMylG
         190lpSC1LKQ0oGgx0KHR9v3oQCpoZ4nP9ZUYAxpQtOgaAfAaZUzG+7c+x3rAjminrImV
         IBvg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat.com; s=google; t=1794840110; x=1795444910; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYi4EV3VnNDxBPRFolBDXakboue8gCprn3/QTmk0jtE=;
        b=S+yfKw3jYvcYgOKMjJbECb8pGB2RwYhmX3F/I4sQrWZ/UNFPbRpTEfq7DfjesnWPjf
         4yglDkXGHAvgCfNuDTBXFQfGEkRKNYZut4FCvWVes295FsuihTxyMzT9w+wXQz1UeoGl
         yyKQmk4FOofsqB/JPKUWAiPx8lbCrbfvUhbSzjPMrRQAkzLSrOwjyG2111SnckygqNCR
         wyfkhrh2+9rUPk+2NYOArsYuVx2qj1SmocYkRUkpUQ3UzoquUR971KJOeGrrySrgesCf
         CVB9vS1eLhv7BCoBLaobeoYYtBbOLdqlgvedZMGOV+C6HolIJLIdrXEmyqtgc3+No9rQ
         X6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840110; x=1795444910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYi4EV3VnNDxBPRFolBDXakboue8gCprn3/QTmk0jtE=;
        b=z3Uq90Sp+a9BrhtRhjL9WMhBipTk+wJRXh82aAmLQs7SKMvRPFVwkbqziq0xdzj25u
         GfkXVc1TLVeqZldlH1ZXFHM9tDJQJ2CTj2jN57XgSdWYpjxSXxqp5p/XTOc/UxiEd5Fg
         q7cUHdgf5upN26dVCobcdtLqQM/WsTcvv8X/9QWNFCYcGn7KoXJNov9iwkMw0yfzt5ge
         oE4ib4Cm7byfLbUD2ySyvGGXA4UeTfIZHWDNQ3eJZtvYrQUmqtJSHMM9cilmDOeUjqxM
         Un7QCchtSp6r+Itt2tWzlR3Gy8XuZHcBKuTxQruNKdq3cVoNcnnjpCSK3V0gl8n2twGN
         Dq5Q==
X-Gm-Message-State: APuU4Z+pc8D6Q/sICVT3DiteG7zBYGW3b+C1Py1FC5HS2AgF3DTN6WFA
	Su0Zi/vj/xlYuPd8rYSQmUeouMaQG15P3Bg1n9h6NXf2+Rnjnj0M20QWpXPqNkYluFtUTZ6n1cm
	0Xpyt3FcVM4jtS2rI8aFY7zBni0V2MjNkNpICxXuYI3jYFd41PsMGYfo=
X-Gm-Gg: AYBFou3XXNOc4wNniAyVEjqhDWKTm87//P3tZ8Zrk+nAUtk8UE7BAGY4VH/RozhvySu
	DDnXKtltN5b3ZS/QhU24OaaSjFz5Wo+sMzPn0L7naifICN42n7H2XWlmXzvcuqbyqyXCx6xpwh2
	u/ERGIw1w7Rsbu41lEHeFdzlSRH7xtxcbECI6813nsM2rqyL4rmEcutndNOqJATSKfgoRLabwHe
	GT5JpkSFsWs5SztyvLO0YiF4hNLdBElJOxX8NBLGlh8JBAIAIEQ+OF5bY2kYVFib1WeVUEbHZJJ
	c/mrAMCD3ryDL+xLwpvm2mJLXVMz5dBKtx7Jfv2OaY8nAMwTOEifm7CfcTM+F+bHYPtS5PcjzOh
	H00H3oX2vb0kdvKdHNbajGnjhVTfibflheeYCksX7tjDbwmSrh62PPu2ZrVel1y7gg11awLcUln
	2P2npunqywKwFuuafWBVCVwIB+STLFbWtF8UalOGW/SnQIWL/e2cMtc36z3MgkkkOuC4+v7ezWi
	9MbpQ==
X-Received: by 2002:a05:651c:a168:b0:3ac:8ce3:c477 with SMTP id
 38308e7fff4ca-3ae2b521e10mr7960351fa.21.1794840110270; Mon, 16 Nov 2026
 06:41:50 -0800 (PST)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261113033504.1828738-1-gerickson@nuovations.com> <7E13FB26-F898-48BE-9665-76196FED9E2C@nuovations.com>
In-Reply-To: <7E13FB26-F898-48BE-9665-76196FED9E2C@nuovations.com>
From: Johannes Emerich <johannes@dividat.com>
Date: Mon, 16 Nov 2026 15:41:38 +0100
X-Gm-Features: AclHuK9sGszM2AxHAtnbgfcAGCmqVRrrWNP5miT63jG0p7LkbWNdofEnO8eOLHY
Message-ID: <CAKQ2e6WrF5OUE+e3w=6E6Qecf3QiQs=zURJ5ucNocpn1jg_SSQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Keep link-local-only services from displacing the default
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, thank you, very closely related and I support your submission.

Looking through your series, it seems like a more general treatment that
mostly subsumes my patch. We have been running my patch for close to a
year now, and a previously cumbersome problem in some institutiognal
networks has gone away. So I would be very happy to see it in upstream
ConnMan, and happy to collaborate on it.

What your series adds:

- IPv6 support (and more robust v4/v6 dual stack handling)
- hooking into more paths and invoking DEFAULT_CHANGED()
- better observability

The main functional difference with respect to my patch is that yours
applies the link-local criterion earlier in service_compare(), so that a
link-local service no longer wins out just because it uses a preferred
technology. I actually prefer this and as implied in my submission was
simply being conservative when I applied the link-local criterion
later/with less weight.

Our VM-based test for a dual-Ethernet delayed-DHCP scenario passes with
your patch applied to ConnMan 2.0.

Let me know if there's particular angles you'd like more input on.

Tested-by: Johannes Emerich <johannes@dividat.com>


On Fri, 13 Nov 2026 at 16:38, Grant Erickson <gerickson@nuovations.com> wro=
te:
>
> On Nov 12, 2026, at 7:35=E2=80=AFPM, Grant Erickson <gerickson@nuovations=
.com> wrote:
> > When DHCP gets no lease, connman falls back to IPv4 link-local
> > addressing and the service becomes "ready" with a "default dev
> > <interface> scope link" route and no gateway. Ethernet cabled directly
> > to a phone or laptop, or to a switch with nothing else on it, ends up
> > this way. It reaches only its own link and never passes an online
> > check.
> >
> > With PreferredTechnologies listing ethernet first, such a service
> > outranks an "online" Wi-Fi or cellular service: 'service_compare' and
> > 'service_update_preferred_order' consult PreferredTechnologies before
> > online-over-ready. Ethernet takes the default route, Wi-Fi is demoted
> > to "ready", and only Ethernet is online checked. The system is offline
> > until Ethernet meets the online check failures threshold, every time
> > such a cable is plugged in, and at every start with one plugged in.
> >
> > This series ranks a service connected only by link-local addressing
> > below any connected service that can reach beyond its link, whatever
> > its technology, in both places. For IPv4 that means connected with the
> > "auto" (IPv4 link-local) method; for IPv6 it means not connected, since
> > connman drops IPv6 link-local addresses as they arrive and becomes
> > "ready" for IPv6 only with some other address. It also re-sorts when a
> > connected service gains or loses that reach with no change in its
> > state, as when a DHCP server later appears on the link of a
> > link-local-only Ethernet service. A link-local-only service alone is
> > still the default, as before.
> >
> > The IPv4 test keys on the method, not on the gateway address, because
> > point-to-point links such as many cellular bearers have no gateway
> > either but reach beyond their link.
> >
> > Note: This adds a new log entry: "Interface <name> [ <type> ] is now
> > link-local only" and "... is no longer link-local only" once per
> > change.
> >
> > Grant Erickson (4):
> >  service: Rank link-local-only services below others in
> >    'service_compare'
> >  service: Rank link-local-only services below others when reordering
> >  service: Re-sort when a connected service's link-local-only state
> >    changes
> >  doc: Describe link-local-only services under PreferredTechnologies
> >
> > doc/connman.conf.5.in |   7 +-
> > src/service.c         | 276 +++++++++++++++++++++++++++++++++++++++++-
> > 2 files changed, 276 insertions(+), 7 deletions(-)
>
> Johannes:
>
> After working on and submitting this, I was reviewing patchwork and saw y=
ou had a submission, https://patchwork.kernel.org/series/1081540/, that mig=
ht be very-closely related. I=E2=80=99ll take a look at your patch. To the =
extent we have arrived at functionally-equivalent solutions, would you be u=
p for collaborating on a merged/aligned approach?
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
> https://www.nuovations.com/

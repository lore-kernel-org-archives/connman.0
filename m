Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794918985;
	b=k3qDE+3ExfJ2nyR/kade9xxYSPcgLCO7E10TGxytmGyeLcz3fpPcgmwxQWMKKtkfG7BM
	 NulpDzXtNq58vdcZhJbOXbcUhN6dwhtF0YnIEew8ooJDZwvg7wxskYH9iSzTZZymrC82i
	 SBLbh/y5sjUPQKZRIVzzoSop05wqAdWkFBvVUM3JprHqTmCT2U6Gvuz0NoPP6i6Zg/GiC
	 09X+iuBjUEFJhGAytaJeuvItza4zOXBfRz15yWWCrKnr27+kbEa9jpfPrSNWt2kbCDofC
	 v38bqfT6ETHxjGy5XCK1DsoGh6kBrgce4KyjJ0uEmzpRnQOrH07yORfuKz07/hQKz5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=ZukBtzzpGthagpy6C2sxrFsDuXJOdMOjLlvM9jr/zMk=;
	b=1cflUDuEQxfXktNBH1P5UZhXkHY0TquvcybvUnswwuDmoVeHLZ1cmBePUs7mGScE5S36
	 GvlYx5gt8XVsJqxgm99GhQMn+mr0YC57rrSbkAiXzQqVBhhYHirsoDJl61N/rsorjbomw
	 cbrfGVYKAECkjFTk4X8E2jRxMAy2FhBKKrQpFKhEjPGFQmkFXyAkvN4vUXdZAaeXW+yGs
	 q9Sfi2Z2zhJfr0zs8ovyMwBBL55yCyO2ZYBaM5xjGnlPSqvleELw8Aow6gBQ7/AJckOpP
	 3gzI9w8Mu2HFYiwoDZGSmR3PDzSQbmVJBcidRESvDdZ0n39yNYlmKQ3jVbbk5G80NBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dividat.com;
	spf=pass smtp.mailfrom=dividat.ch;
	dkim=pass header.d=dividat.com header.i=@dividat.com header.a=rsa-sha256 header.s=google header.b=VpcauJhV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB714606A330
	for <connman@lists.linux.dev>; Tue, 17 Nov 2026 12:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB714606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dividat.com header.i=@dividat.com header.a=rsa-sha256 header.s=google header.b=VpcauJhV
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3adfed9a887so36256681fa.3
        for <connman@lists.linux.dev>; Tue, 17 Nov 2026 04:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794918983; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTFyKzy/v40wMh5f/BkHKx6caqkouGNMb4qyjnbxhIfJOOvFNppe+UrE6jqrXR1E4v
         cMUlc+HSUA2LJzfj/TYXt2661/UFm6KQx3f1JrH3nIpBVOtlLS1avzwDLuNMxek9UVNM
         8vv2W6sfA0cl5gulituhS90/XRKOr6OICgrqsgPBwYSCEMDQNTm2/j9vbVihb2j2S2Up
         wIvVqgJdVB64s3FY2BACVpoOdjoF5B3A4du1M6/bxmrxeL880VHAtuOUpfptDXXBkQEv
         MtQEDO0wnVwau37D1KGfJDgve1Dc+6+nUFg7wwB0NR/V7bR0Ow9XcfP5eaj8N9TNfDuw
         /vQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=ZukBtzzpGthagpy6C2sxrFsDuXJOdMOjLlvM9jr/zMk=;
        fh=NK8pMim8PLvTSy+0iL3woAAiFYZD7WCyeu9GJICENbE=;
        b=HLyJhChwHiJkmoGIx/vjmGz5Y5XidPSKMCnKj7wPhKPylye8pWsyGcGz1feVQXAHqb
         L8Hk0MYEnA82cDMZ7KBpQXFkUu3bhOPDYcdpkCrnaOmgDoz4j8ZGtNVjgFQs9Rnf1irT
         5WokNnV2pxlLrInZjVNuI/Ipo5hRHHvcZHQGTzMNG8KQzzoxbBvFKuLtnnaY7XqK5nnC
         Qswb6rB5C2cPxG4fepdsI6FYIsoq7/EX1aJdD/bDa/9AoZPyRYMFWM8XDgw/OydxfMUs
         PPnI9E0GvHir9KWLcIBokN1Pud/ECw4oJqkShgGVAXFCkXmM2lOyUsvuvS0Jb8bydCWQ
         c+iA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat.com; s=google; t=1794918983; x=1795523783; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZukBtzzpGthagpy6C2sxrFsDuXJOdMOjLlvM9jr/zMk=;
        b=VpcauJhVwlPtx17ZGVMzJSdlWbBDfu0LjkI6cjlnlnZVwkSPelQX/ZtiBbyilvLz9E
         yPUZtXWKzMm259d53Jg4finTSfVXDCSnIodLapREhMP6XZwDiqmNLjgGhGtgwAsUIUJQ
         iqbACGzrtNXzZSYL3GoevWkIBc2gKy8eaykhG05VJ9IIun+XFFG2l0DOgI+2Z2gPnppp
         UT5JtotNJa9AWJuI+TNRtkN8+YDbzhezc6YiA2EYCCQEvb/UOykRCuIJVN+/Wk6xAGgc
         ne5uVfEVxCAluM+CrPIsEUcVA49ybfKBdfXALAUx2zwcNT2owWjHkjy/tlQmrGYKMUA7
         g+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794918983; x=1795523783;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZukBtzzpGthagpy6C2sxrFsDuXJOdMOjLlvM9jr/zMk=;
        b=vwz+rACgGqcOs+Vehn+lxEoaLdzqT8fgucbuPSANU2/OEeBVuOY0u/9QVf0vrLIKnQ
         Tvx/UF4253S4lE2D+QWQc/KR3/5R9NQp44E1tBU1ABtZnHMDfB1p8+ci2ZjpFE/aXs66
         FrD5d7lf6FcpH60GnJq+FCRnMtwwElQYFdCI9FlhqIMtKP1OunZqzF0BusyG5+xaDdgM
         NtvSTL09dMHUtFoC7NpJVx6A4vs0s5S1PBaYI0ZlZaeI+1E1m8eLalHZSO5OJIDZlZq3
         A6Kc/FjODs/FSDkpE8KbFLGCcwh6X7AVUbWpeeX7w/KOcAogO0FNwMlrphdSOmvzYBi5
         UAsA==
X-Gm-Message-State: APuU4Z9LlVsnSkXEokDQrPpFHh+caCUR/SfkDGZrn+PXrSElEIXp2Jez
	56jPuCyVF57fy7QW8pJy3TTZwLqx0BW6z9j35HxSKKf0lG9lGAg69UJpR31zBBEiXb/AfSV+fy1
	FVRZLOhXhoroYgPSVnjdsRPi58i0A9HBFft9pkKRBlwHSR4qh56PxQeM=
X-Gm-Gg: AYBFou3/piMLOtdh0B4O4qs5R8zvnWyzk4z1wF1s+a1L04r/LfozC6cYU1/g7VzuqSB
	e909wN7wfjzQ9SJbDOZrgeekx0hNUZwcwf1D+sVnLLNk1BgYkoNziTTaT8H7uF4Q2m+prUwN39h
	9DTvbl+uPb8ESQhLMc34oQAWRzwUsHV1MWvGwtIpOzlAv30XIfUXDlVgp0FSwKArX7dRuT1gSWS
	cULFM1fchzzZ5N6bfZ/iSt0li0kMnhs1ZrV7smHiqe41Ss1xO8PF7+V5aC4QN7HZZ2kPhDo32c2
	T2OkSQHGA4ubWOXBJjDXlP7Ft/3V8LVIb93K4rKCYPUU/DwVJmjT3kJOs4HGhoBQ4oXS3tKcBtO
	DZaoK5MNaOexQIDesRK+u2BMtrqJzxWq6cb2v3bYQWOfuusW2ujslEV9BcfPz23F+Z5j1GYbfKw
	aTqj+G1wGra39o8M1GiRjM3dd4vXuBvFKpisJRGgQan2MBtpYeUXwkUH6tbrVQhO/EbBMLyHpYc
	k7HHjEDtVBlbhQc+cCb61/n6KzDKJhxs0i8OHs=
X-Received: by 2002:a2e:be8c:0:b0:3ab:4a7c:7a65 with SMTP id
 38308e7fff4ca-3ae2b35ba4dmr41937801fa.0.1794918982906; Tue, 17 Nov 2026
 04:36:22 -0800 (PST)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260415112258.1076252-1-johannes@dividat.com>
In-Reply-To: <20260415112258.1076252-1-johannes@dividat.com>
From: Johannes Emerich <johannes@dividat.com>
Date: Tue, 17 Nov 2026 13:36:11 +0100
X-Gm-Features: AclHuK8a9AXTnh89vjC-lEy9nEeOb0XQcFx_h6WImeEmJUJVHxme69EbWBmnZ7M
Message-ID: <CAKQ2e6USMV6ynDtDK8eqqtc3Xsjkcg71pcS4YYjhK+QnrYfyJA@mail.gmail.com>
Subject: Re: [PATCH 0/1] service: Prevent link-local default routes
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Grant Erickson has submitted a similar but more general implementation
in the meantime:
https://patchwork.kernel.org/series/1210133/

His work solves our use case so it may be worth merging it instead of mine.

Best,
Johannes

On Wed, 15 Apr 2026 at 13:23, Johannes Emerich <johannes@dividat.com> wrote:
>
> Our kiosk system built with ConnMan typically uses two simultaneous
> Ethernet connections, one to an input device using a link-local address,
> one to some network providing Internet access. In most cases ConnMan
> reliably uses the Internet-bound network as the default service, but if
> the network is slow to respond to DHCP requests for some reason, both
> Ethernet services end up with link-local addresses initially. In this
> case, ConnMan may choose the local-only connection as default service
> and stick with that choice even when the other service receives a good
> IP and gateway via DHCP later. In such cases, the device will never
> configure a usable default route.
>
> We have been running a similar patch on top of ConnMan 1.42 with
> hundreds of customer installations without issue.
>
> After porting the patch to ConnMan 2.0, we ran our VM-based automated
> tests to verify that late configured services are chosen as default
> service over link-local services, and they also pass for 2.0.
>
> Johannes Emerich (1):
>   service: Demote IPv4 link-local services
>
>  src/service.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> --
> 2.51.2
>

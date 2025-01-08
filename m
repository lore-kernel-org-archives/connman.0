Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683115853B
	for <connman@lists.linux.dev>; Wed,  8 Jan 2025 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360706; cv=none; b=Z9/grpReL4p/4G/0ip3kkaChO9IFDdBomT/xgzSEoYcAKGEFvKKOOzuqftN8MCpGJAuyOE2DVoENv/qvtP5imbZR0XKp592IC9XPvzkfQQkxsP3UOcVxUPb1rXOcqFBLMjU+dh3t6szRccQZXkG96RXpO6uoNBbAM+mwb7222/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360706; c=relaxed/simple;
	bh=sBECWxLDKXyV5vsr2gNeB0T8cQMT5ZuXwX7qBLyFDkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nrS/nczVSmnZyElXKFTEy7nccxUJhiXYX5qOeQlfPUIxPWPG3pm8fUb1rKk2hscs5e8lUfUmo00HYTQjUX9WGPLmGrWt3tOBhrzzftSsLHYcGdfnceYYq2Z3FeHJ2Sy9DWPvYnX9XYZ4Jop8jbmmnAJ7vIRDOEDgFAKp1h9q7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WUOfplzr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WUOfplzr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so180589a91.0
        for <connman@lists.linux.dev>; Wed, 08 Jan 2025 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1736360703; x=1736965503; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt0F2bFRKDyFtQVX3YnFkweb2PQm+QRWVMPjM/hiGb0=;
        b=WUOfplzr2J0rhKiIpUciymxlnr9XTb9Mezl6PrdwJIzE2U+A9/GEwHp6gGGfguMscY
         tvYjsXmSKnukEncGK1/Tx2GtiGsSewYQacTITNOcU3prsmxBn9SAVk5fK5lxbT4jnb5k
         yH/b9b9cquLRuOJtNDnjnHTqNHSzDaWB7Uj7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360703; x=1736965503;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt0F2bFRKDyFtQVX3YnFkweb2PQm+QRWVMPjM/hiGb0=;
        b=iR0J6qA6d0TnGl78tHIudxMXn95O6v87NnyHGf78XT8QVkJirU3mpVfYeAaEimwe8/
         sNBl0SDbRMH/dnf9QJPi5UIDdG6zir0uYUDAihNT6hX/kfcwle6DBgjgHXZglo93C/ny
         /eL3V4qOCcfoSM1MOqIkf3oSkGMYvZiumJk6DqeIc2Hr+7z5PYVsvt1ULQzjkquzTi6T
         zpxq0ictEkYQJ8lmlJV5QRGh2wm6c5qokcOxAlZHKQTWK7AGbUX9xfpDp1iPsRlC2xP6
         /z0228/e6IAAIzuGlTXghsm8uNnt9eXSXqpQW8enEE48dkSet8jxybBXxOS8fM8RVWhg
         K3bA==
X-Gm-Message-State: AOJu0YySNbi12IdZtNuI8bMx9+mo9xowTE8micBt0UGbMuqi6cZ21v2D
	3gs30fY4NgUUqfWr6SttYxrVCxaXjtRmpSqmOw+5mvvW0sggcHpyvvl5C4u3UWqPp39P3UFChzq
	J3Po802j/L6V8P8T/hBu/2K+qI/2F2Q88027IbwrfCaEaebHQ+bc=
X-Gm-Gg: ASbGncsnPPLF2/o9jFL/alXm5r6g1MgC+h2Cmv1Fz6dDuw+RJkxhOSs6T5GY+r80hVw
	5rc1GsalrROHWsj0W0sOzViEjPAPb8YM7ewLu
X-Google-Smtp-Source: AGHT+IFbdTOekptfhakXKakKGdvj3WjLwj6+Ts+uPeEI6Sq2VJNySEes0NQwGGaDXX+b2/3/YFeTAM/0iVXvrcGsBes=
X-Received: by 2002:a17:90b:2e8b:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f548f0894dmr5847479a91.7.1736360703053; Wed, 08 Jan 2025
 10:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z30kiZZrfMQw8yI0@smrz>
In-Reply-To: <Z30kiZZrfMQw8yI0@smrz>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 8 Jan 2025 19:24:51 +0100
X-Gm-Features: AbW1kvYN7rMaX3vgHxU2Qnjg22E4ebFHoIV2keXi5ri2v1a_t6mNShhHeKfgspc
Message-ID: <CAOf5uwnN7R-3znm80TzhAPF=GgokUuBg2Zy+C0sqCETRNJy_RQ@mail.gmail.com>
Subject: Re: Manual configuration of tethering IP address
To: connman@lists.linux.dev, =?UTF-8?Q?Roman_Smr=C5=BE?= <roman@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman

On Tue, Jan 7, 2025 at 1:58=E2=80=AFPM Roman Smr=C5=BE <roman@amarulasoluti=
ons.com> wrote:
>
> Hello,
>
> we have a use case where we need to manually configure the IP address
> and network used by connman for the tethering interface. For that, I've
> added TetheringAddress property to the Technology interface.
>
> I am attaching the patch as we have it now. If this functionality and
> approach makes sense to you and you have some comments, I'll update the
> patch as necessary so it could be merged upstream.
>

It's easier to review if the patch comes inline with the email itself.
People review it using
their email client

Michael


> Best Regards
>         Roman
